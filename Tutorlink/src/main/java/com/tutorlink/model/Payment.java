package com.tutorlink.model;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
// Payment model class
@Entity
@Table(name = "payments")
public class Payment {
    public enum PaymentMethod {
        CARD,
        CASH,
        BANK_TRANSFER
    }
    // payment status types
    public enum PaymentStatus {
        PENDING,
        PAID,
        FAILED,
        REFUNDED
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "payment_id")
    private int paymentId;
    @Column(name = "booking_id", nullable = false)
    private int bookingId;
    @Column(name = "student_id", nullable = false)
    private int studentId;
    @Column(name = "tutor_id", nullable = false)
    private int tutorId;
    @Column(name = "amount", nullable = false)
    private double amount;
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method", nullable = false)
    private PaymentMethod paymentMethod;
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status", nullable = false)
    private PaymentStatus paymentStatus;
    @Column(name = "payment_date")
    private String paymentDate;
    public Payment() {
        this.paymentDate   = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        this.paymentStatus = PaymentStatus.PENDING;
    }
    // information hiding - format payment status
    public String getStatusLabel() {
        switch (paymentStatus) {
            case PAID:     return "Paid";
            case FAILED:   return "Failed";
            case REFUNDED: return "Refunded";
            default:       return "Pending";
        }
    }
    public String getMethodLabel() {
        switch (paymentMethod) {
            case CARD:          return "Card";
            case CASH:          return "Cash";
            default:            return "Bank Transfer";
        }
    }
    public String getReceiptNote() {
        switch (paymentMethod) {
            case CARD:          return "Paid by card. Session confirmed.";
            case CASH:          return "Pay cash directly to tutor on session day.";
            default:            return "Transfer to tutor bank account. Pending confirmation.";
        }
    }
    public int getPaymentId()                        { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }
    public int getBookingId()                        { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getStudentId()                        { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public int getTutorId()                          { return tutorId; }
    public void setTutorId(int tutorId) { this.tutorId = tutorId; }
    public double getAmount()                        { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public PaymentMethod getPaymentMethod()          { return paymentMethod; }
    public void setPaymentMethod(PaymentMethod paymentMethod) { this.paymentMethod = paymentMethod; }
    public PaymentStatus getPaymentStatus()          { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentDate()                   { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }
}
