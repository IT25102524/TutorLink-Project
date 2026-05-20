package com.tutorlink.service;
import com.tutorlink.model.*;
import com.tutorlink.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
// Booking service - handles booking logic
@Service
public class BookingService {
    @Autowired private BookingRepository bookingRepository;
    @Autowired private TutorRepository tutorRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private AvailabilitySlotRepository slotRepository;
    @Autowired private PaymentService paymentService;

    @Autowired private TutorSubjectRepository tutorSubjectRepository;
    @Autowired private SubjectRepository subjectRepository;
    public Student getStudentByUserId(int userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent() && userOpt.get() instanceof Student) {
            return (Student) userOpt.get();
        }
        return null;
    }
    public Tutor getTutor(int tutorId) {
        return tutorRepository.findById(tutorId).orElse(null);
    }
    public List<AvailabilitySlot> getTutorSlots(int tutorId) {
        return slotRepository.findByTutorIdOrderByDayAsc(tutorId);
    }

    // Helper: Parses time like "10:00 AM" into minutes from midnight for easy comparison
    private int parseToMinutes(String timeStr) {
        if (timeStr == null || timeStr.trim().isEmpty()) return 0;
        timeStr = timeStr.trim().toUpperCase();
        boolean isPM = timeStr.contains("PM");
        boolean isAM = timeStr.contains("AM");

        timeStr = timeStr.replace("AM", "").replace("PM", "").trim();
        String[] parts = timeStr.split(":");
        if (parts.length != 2) return 0;

        try {
            int hours = Integer.parseInt(parts[0].trim());
            int minutes = Integer.parseInt(parts[1].trim());
            if (isPM && hours != 12) hours += 12;
            else if (isAM && hours == 12) hours = 0;
            return hours * 60 + minutes;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    // Helper: Checks if the new time slot overlaps with any active booking for the same tutor on the same date
    private boolean hasTimeConflict(int tutorId, String bookingDate, String newTimeSlot) {
        if (newTimeSlot == null || !newTimeSlot.contains("-")) return false;

        String[] newTimes = newTimeSlot.split("-");
        if (newTimes.length != 2) return false;

        int newStart = parseToMinutes(newTimes[0]);
        int newEnd = parseToMinutes(newTimes[1]);

        List<Booking> existingBookings = bookingRepository.findByTutorIdOrderByBookingIdDesc(tutorId);

        for (Booking existing : existingBookings) {
            // Only check active bookings (PENDING or CONFIRMED) on the exact same date
            if (existing.isActive() && bookingDate.equals(existing.getBookingDate())) {
                String existingSlot = existing.getTimeSlot();
                if (existingSlot != null && existingSlot.contains("-")) {
                    String[] existingTimes = existingSlot.split("-");
                    if (existingTimes.length == 2) {
                        int existingStart = parseToMinutes(existingTimes[0]);
                        int existingEnd = parseToMinutes(existingTimes[1]);

                        // Overlap Rule: newStart < existingEnd AND newEnd > existingStart
                        if (newStart < existingEnd && newEnd > existingStart) {
                            return true; // Conflict detected
                        }
                    }
                }
            }
        }
        return false;
    }
    // Helper: Extracts the number of hours from a time slot string like "Monday 10:00 AM - 12:00 PM"
    private int calculateHoursFromTimeSlot(String timeSlot) {
        if (timeSlot == null || !timeSlot.contains("-")) return 1;
        // Remove day name if present (e.g., "Monday 10:00 AM - 12:00 PM")
        String slot = timeSlot;
        String[] dayNames = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"};
        for (String day : dayNames) {
            if (slot.startsWith(day)) { slot = slot.substring(day.length()).trim(); break; }
        }
        String[] parts = slot.split("-");
        if (parts.length != 2) return 1;
        int startMins = parseToMinutes(parts[0].trim());
        int endMins = parseToMinutes(parts[1].trim());
        int diff = endMins - startMins;
        return diff > 0 ? diff / 60 : 1;
    }
    public Booking createBookingWithPayment(int studentUserId, int tutorId, String subject,
                                            String bookingDate, String timeSlot, String mode,
                                            String notes, String paymentMethod, double totalAmount,
                                            String cardNumber, String cvv) throws Exception {
        Student student = getStudentByUserId(studentUserId);
        if (student == null) throw new Exception("Student not found.");

        // Check for time slot overlap before proceeding with booking or payment
        if (hasTimeConflict(tutorId, bookingDate, timeSlot)) {
            throw new Exception("Tutor is already booked during the selected time.");
        }
        Booking booking = "ONLINE".equals(mode)
                ? new OnlineBooking(student.getStudentId(), tutorId, subject, bookingDate, timeSlot, notes)
                : new HomeVisitBooking(student.getStudentId(), tutorId, subject, bookingDate, timeSlot, notes);
        bookingRepository.save(booking);
        int bookingId = booking.getBookingId();

        // Server-side cost calculation - don't trust client-provided amount
        Tutor tutor = getTutor(tutorId);
        if (tutor == null) throw new Exception("Tutor not found.");

        int hourlyRate = 0;
        boolean foundSubjectRate = false;

        int matchedSubjectId = -1;
        for (Subject s : subjectRepository.findAll()) {
            if (s.getName().equalsIgnoreCase(subject)) {
                matchedSubjectId = s.getSubjectId();
                break;
            }
        }

        if (matchedSubjectId != -1) {
            for (TutorSubject ts : tutorSubjectRepository.findByTutorIdAndStatus(tutorId, "ACTIVE")) {
                if (ts.getSubjectId() == matchedSubjectId) {
                    hourlyRate = "ONLINE".equalsIgnoreCase(mode) ? ts.getOnlineHourlyRate() : ts.getHomeVisitHourlyRate();
                    foundSubjectRate = true;
                    break;
                }
            }
        }

        if (!foundSubjectRate) {
            hourlyRate = "ONLINE".equalsIgnoreCase(mode) ? tutor.getEffectiveOnlineRate() : tutor.getEffectiveHomeVisitRate();
        }

        int hours = calculateHoursFromTimeSlot(timeSlot);
        double serverAmount = (double) hourlyRate * hours;
        // Use server-calculated amount (ignore client value to prevent tampering)
        double finalAmount = serverAmount > 0 ? serverAmount : totalAmount;

        if ("CARD".equalsIgnoreCase(paymentMethod)) {
            paymentService.processCardPayment(bookingId, student.getStudentId(), tutorId, finalAmount, cardNumber, cvv);
            // Booking stays PENDING - tutor confirms/declines like other payment methods
        } else if ("CASH".equalsIgnoreCase(paymentMethod)) {
            paymentService.processCashPayment(bookingId, student.getStudentId(), tutorId, finalAmount);
        } else if ("BANK_TRANSFER".equalsIgnoreCase(paymentMethod)) {
            paymentService.processBankTransferPayment(bookingId, student.getStudentId(), tutorId, finalAmount);
        } else {
            throw new Exception("Invalid payment method selected.");
        }

        return bookingRepository.save(booking);
    }
    public void cancelBooking(int bookingId) {
        bookingRepository.findById(bookingId).ifPresent(b -> {
            b.setStatus("CANCELLED");
            bookingRepository.save(b);
            // Refund the associated payment when booking is cancelled
            paymentService.refundPayment(bookingId);
        });
    }
    public void deleteBooking(int bookingId) {
        bookingRepository.deleteById(bookingId);
    }
    public List<Booking> getAllBookingsWithNames() {
        List<Booking> bookings = bookingRepository.findAll();
        for (Booking b : bookings) {
            userRepository.findById(b.getStudentId()).ifPresent(s -> b.setStudentName(s.getFullName()));
            userRepository.findById(b.getTutorId()).ifPresent(t -> b.setTutorName(t.getFullName()));
        }
        return bookings;
    }
}
