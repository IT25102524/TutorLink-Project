package com.tutorlink.service;
import com.tutorlink.model.Booking;
import com.tutorlink.model.Payment;
import com.tutorlink.model.Payment.PaymentMethod;
import com.tutorlink.model.Payment.PaymentStatus;
import com.tutorlink.model.Tutor;
import com.tutorlink.repository.BookingRepository;
import com.tutorlink.repository.PaymentRepository;
import com.tutorlink.repository.TutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
// Payment service - handles payment logic
@Service
public class PaymentService {
    @Autowired private PaymentRepository paymentRepository;
    @Autowired private BookingRepository bookingRepository;
    @Autowired private TutorRepository tutorRepository;

    private String now() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
    // ── CARD ─────────────────────────────────────────────────────────
    public Payment processCardPayment(int bookingId, int studentId, int tutorId,
                                      double amount, String cardNumber, String cvv) throws Exception {
        if (amount <= 0)
            throw new Exception("Payment amount must be greater than 0.");
        Booking booking = bookingRepository.findById(bookingId).orElse(null);
        if (booking == null)
            throw new Exception("Booking not found. Cannot process payment.");
        String cleanCard = cardNumber.replaceAll("\\s+", "");
        if (cleanCard.length() != 16 || !cleanCard.matches("\\d+"))
            throw new Exception("Card number must be exactly 16 digits.");
        if (cvv == null || cvv.length() != 3 || !cvv.matches("\\d+"))
            throw new Exception("CVV must be exactly 3 digits.");
        Payment p = new Payment();
        p.setBookingId(bookingId); p.setStudentId(studentId); p.setTutorId(tutorId);
        p.setAmount(amount); p.setPaymentMethod(PaymentMethod.CARD);
        // Card payment stays PENDING until tutor confirms booking
        p.setPaymentStatus(PaymentStatus.PENDING); p.setPaymentDate(now());
        // Booking stays PENDING - tutor must confirm
        return paymentRepository.save(p);
    }
    // ── CASH ──────────────────────────────────────────────────────────
    public Payment processCashPayment(int bookingId, int studentId, int tutorId,
                                      double amount) throws Exception {
        if (amount <= 0)
            throw new Exception("Payment amount must be greater than 0.");
        if (bookingRepository.findById(bookingId).orElse(null) == null)
            throw new Exception("Booking not found. Cannot process payment.");
        Payment p = new Payment();
        p.setBookingId(bookingId); p.setStudentId(studentId); p.setTutorId(tutorId);
        p.setAmount(amount); p.setPaymentMethod(PaymentMethod.CASH);
        p.setPaymentStatus(PaymentStatus.PENDING); p.setPaymentDate(now());
        return paymentRepository.save(p);
    }
    // ── BANK TRANSFER ─────────────────────────────────────────────────
    public Payment processBankTransferPayment(int bookingId, int studentId,
                                              int tutorId, double amount) throws Exception {
        if (amount <= 0)
            throw new Exception("Payment amount must be greater than 0.");
        if (bookingRepository.findById(bookingId).orElse(null) == null)
            throw new Exception("Booking not found. Cannot process payment.");
        Tutor tutor = tutorRepository.findById(tutorId).orElse(null);
        if (tutor == null)
            throw new Exception("Tutor not found.");
        if (!tutor.hasBankDetails())
            throw new Exception("This tutor has not set up bank transfer details yet. "
                    + "Please choose another payment method.");
        Payment p = new Payment();
        p.setBookingId(bookingId); p.setStudentId(studentId); p.setTutorId(tutorId);
        p.setAmount(amount); p.setPaymentMethod(PaymentMethod.BANK_TRANSFER);
        p.setPaymentStatus(PaymentStatus.PENDING); p.setPaymentDate(now());
        return paymentRepository.save(p);
    }
    // Mark Card and Bank Transfer payments as PAID when tutor confirms
    public void confirmCardPayment(int bookingId) {
        paymentRepository.findByBookingId(bookingId).ifPresent(p -> {
            if (p.getPaymentMethod() == PaymentMethod.CARD ||
                    p.getPaymentMethod() == PaymentMethod.BANK_TRANSFER) {
                p.setPaymentStatus(PaymentStatus.PAID);
                paymentRepository.save(p);
            }
        });
    }
    // Mark Cash payment as PAID when tutor marks session complete
    public void completeCashPayment(int bookingId) {
        paymentRepository.findByBookingId(bookingId).ifPresent(p -> {
            if (p.getPaymentMethod() == PaymentMethod.CASH) {
                p.setPaymentStatus(PaymentStatus.PAID);
                paymentRepository.save(p);
            }
        });
    }
    // Mark payment as FAILED when tutor declines booking (covers all payment methods)
    public void failPayment(int bookingId) {
        paymentRepository.findByBookingId(bookingId).ifPresent(p -> {
            if (p.getPaymentStatus() == PaymentStatus.PENDING) {
                p.setPaymentStatus(PaymentStatus.FAILED);
                paymentRepository.save(p);
            }
        });
    }
    // Refund payment when booking is cancelled
    public void refundPayment(int bookingId) {
        paymentRepository.findByBookingId(bookingId).ifPresent(p -> {
            // Only refund if payment is PAID or still PENDING
            if (p.getPaymentStatus() == PaymentStatus.PAID ||
                    p.getPaymentStatus() == PaymentStatus.PENDING) {
                p.setPaymentStatus(PaymentStatus.REFUNDED);
                paymentRepository.save(p);
            }
        });
    }
    public List<Payment> getPaymentsByStudent(int id) { return paymentRepository.findByStudentIdOrderByPaymentIdDesc(id); }
    public List<Payment> getPaymentsByTutor(int id)   { return paymentRepository.findByTutorIdOrderByPaymentIdDesc(id); }
    public List<Payment> getAllPayments()               { return paymentRepository.findAll(); }
}
