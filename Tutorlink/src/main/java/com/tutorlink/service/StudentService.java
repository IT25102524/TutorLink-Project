package com.tutorlink.service;
import com.tutorlink.model.AvailabilitySlot;
import com.tutorlink.model.Booking;
import com.tutorlink.model.Review;
import com.tutorlink.model.Student;
import com.tutorlink.model.Tutor;
import com.tutorlink.model.User;
import com.tutorlink.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

// Student service - handles student logic
@Service
public class StudentService {
    @Autowired private StudentRepository studentRepository;
    @Autowired private TutorRepository tutorRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private BookingRepository bookingRepository;
    @Autowired private ReviewRepository reviewRepository;
    @Autowired private SubjectRepository subjectRepository;
    @Autowired private AvailabilitySlotRepository slotRepository;
    @Autowired private TutorSubjectRepository tutorSubjectRepository;

    // Finds a student by user ID, returns null if not found or not a student
    public Student getStudentByUserId(int userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent() && userOpt.get() instanceof Student) {
            return (Student) userOpt.get();
        }
        return null;
    }

    // Updates the student's profile details and saves the changes to the database
    public Student updateProfile(int userId, String fullName, String phone, int gradeLevel,
                                 String address, String district) {
        Student student = getStudentByUserId(userId);
        if (student == null) return null;
        student.setFullName(fullName);
        student.setPhone(phone);
        student.setGradeLevel(gradeLevel);
        student.setAddress(address);
        student.setDistrict(district);
        return studentRepository.save(student);
    }

    // Searches for tutors matching the given subject and district filters
    public List<Tutor> searchTutors(String subject, String district) {
        return tutorRepository.searchTutors(subject, district);
    }

    // Extended search with medium, mode, budget filters (category removed from UI)
    public List<Tutor> searchTutors(String subject, String district,
                                    String medium, String teachingMode,
                                    int minBudget, int maxBudget) {
        // Get base results from repository search
        List<Tutor> baseTutors = tutorRepository.searchTutors(subject, district);
        // If no extra filters are active, return base results immediately
        if ((medium == null || medium.isEmpty()) &&
                (teachingMode == null || teachingMode.isEmpty()) &&
                minBudget == 0 && maxBudget == 0) {
            return baseTutors;
        }
        // Apply additional filters using tutor subjects
        List<Tutor> filtered = new ArrayList<>();
        for (Tutor tutor : baseTutors) {
            List<com.tutorlink.model.TutorSubject> tutorSubjects =
                    tutorSubjectRepository.findByTutorIdAndStatus(tutor.getTutorId(), "ACTIVE");
            boolean matches = false;
            for (com.tutorlink.model.TutorSubject ts : tutorSubjects) {
                // Check medium filter
                if (medium != null && !medium.isEmpty() &&
                        !medium.equalsIgnoreCase(ts.getMedium())) continue;
                // Check teaching mode filter
                if (teachingMode != null && !teachingMode.isEmpty() &&
                        !teachingMode.equalsIgnoreCase(ts.getTeachingMode()) &&
                        !"BOTH".equalsIgnoreCase(ts.getTeachingMode())) continue;
                // Check budget filter
                if (maxBudget > 0) {
                    int rate = ts.getRateByMode(teachingMode != null ? teachingMode : "ONLINE");
                    if (rate < minBudget || rate > maxBudget) continue;
                }
                matches = true;
                break;
            }
            if (matches) filtered.add(tutor);
        }
        return filtered;
    }

    // get all bookings for a student and fills in each tutor's name for display
    public List<Booking> getStudentBookings(int studentId) {
        List<Booking> bookings = bookingRepository.findByStudentIdOrderByBookingIdDesc(studentId);
        for (Booking b : bookings) {
            tutorRepository.findById(b.getTutorId()).ifPresent(t -> b.setTutorName(t.getFullName()));
        }
        return bookings;
    }

    // Retrieves all reviews written by a student and fills in each tutor's name for display
    public List<Review> getStudentReviews(int studentId) {
        List<Review> reviews = reviewRepository.findByStudentIdOrderByReviewIdDesc(studentId);
        for (Review r : reviews) {
            tutorRepository.findById(r.getTutorId()).ifPresent(t -> r.setTutorName(t.getFullName()));
        }
        return reviews;
    }


    public Tutor getTutor(int tutorId) {
        return tutorRepository.findById(tutorId).orElse(null);
    }

    // Returns only non-reported reviews for a tutor, with each reviewer's student name filled in
    public List<Review> getPublicReviewsForTutor(int tutorId) {
        List<Review> allReviews = reviewRepository.findByTutorIdOrderByReviewIdDesc(tutorId);
        List<Review> publicReviews = new ArrayList<>();
        for (Review r : allReviews) {
            if (!"REPORTED".equals(r.getReviewType())) {
                studentRepository.findById(r.getStudentId()).ifPresent(s -> r.setStudentName(s.getFullName()));
                publicReviews.add(r);
            }
        }
        return publicReviews;
    }

    public double getAverageRatingForTutor(int tutorId) {
        Double avgRating = reviewRepository.getAverageRatingByTutorId(tutorId);
        return avgRating != null ? avgRating : 0.0;
    }

    // Retrieves a tutor's availability slots and fills in the subject name for each slot
    public List<AvailabilitySlot> getTutorAvailability(int tutorId) {
        List<AvailabilitySlot> slots = slotRepository.findByTutorIdOrderByDayAsc(tutorId);
        // Load subject name for each slot
        for (AvailabilitySlot slot : slots) {
            if (slot.getTutorSubjectId() > 0) {
                tutorSubjectRepository.findById(slot.getTutorSubjectId()).ifPresent(ts ->
                        subjectRepository.findById(ts.getSubjectId()).ifPresent(s ->
                                slot.setSubjectName(s.getName())));
            }
        }
        return slots;
    }

    // Returns a unique sorted list of all active subject names from the subject catalogue
    public List<String> getAllSubjects() {
        Set<String> subjectNames = new LinkedHashSet<>();
        subjectRepository.findAllByOrderByNameAsc().forEach(subject -> {
            if (subject.getName() != null && !subject.getName().trim().isEmpty()) {
                subjectNames.add(subject.getName().trim());
            }
        });
        return new ArrayList<>(subjectNames);
    }

    //fixed list of all 25 Sri Lankan districts
    public List<String> getAllDistricts() {
        return Arrays.asList(
                "Ampara", "Anuradhapura", "Badulla", "Batticaloa", "Colombo",
                "Galle", "Gampaha", "Hambantota", "Jaffna", "Kalutara",
                "Kandy", "Kegalle", "Kilinochchi", "Kurunegala", "Mannar",
                "Matale", "Matara", "Monaragala", "Mullaitivu", "Nuwara Eliya",
                "Polonnaruwa", "Puttalam", "Ratnapura", "Trincomalee", "Vavuniya"
        );
    }

    // Deletes the student's user record from the database by user ID
    public void deleteStudentAccount(int userId) {
        userRepository.deleteById(userId);
    }
}
