package com.tutorlink.model;
import jakarta.persistence.*;
// Booking abstract class - parent class for booking types
@Entity
@Table(name = "bookings")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "booking_type", discriminatorType = DiscriminatorType.STRING)
public abstract class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "booking_id")
    private int bookingId;
    @Column(name = "student_id", columnDefinition = "int default 0")
    private int studentId;
    @Column(name = "tutor_id", columnDefinition = "int default 0")
    private int tutorId;
    @Column(name = "subject")
    private String subject;
    @Column(name = "booking_date")
    private String bookingDate;
    @Column(name = "time_slot")
    private String timeSlot;
    @Column(name = "status")
    private String status;
    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
    @Transient
    private String studentName;
    @Transient
    private String tutorName;
    @Transient
    private int studentGrade;
    @Transient
    private String studentEmail;
    @Transient
    private String studentPhone;
    @Transient
    private String studentAddress;
    @Transient
    private String studentDistrict;
    public Booking() {
        this.status = "PENDING";
    }
    public Booking(int studentId, int tutorId, String subject,
                   String bookingDate, String timeSlot, String notes) {
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.subject = subject;
        this.bookingDate = bookingDate;
        this.timeSlot = timeSlot;
        this.notes = notes;
        this.status = "PENDING";
    }
    // abstraction - subclasses return booking type
    public abstract String getBookingType();
    // abstraction - subclasses calculate cost
    public abstract int calculateCost(int hourlyRate);
    // get booking mode
    public String getMode() {
        return getBookingType();
    }
    // abstraction - check booking status
    public boolean isActive() {
        return "PENDING".equals(status) || "CONFIRMED".equals(status);
    }
    // abstraction - check review eligibility
    public boolean isEligibleToReview(int studentId) {
        return "COMPLETED".equals(status) && this.studentId == studentId;
    }
    // information hiding - format status label
    public String getStatusLabel() {
        if ("PENDING".equals(status))   return "Waiting for Tutor";
        if ("CONFIRMED".equals(status)) return "Session Confirmed";
        if ("COMPLETED".equals(status)) return "Session Completed";
        if ("CANCELLED".equals(status)) return "Cancelled";
        return status;
    }
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public int getTutorId() { return tutorId; }
    public void setTutorId(int tutorId) { this.tutorId = tutorId; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getTutorName() { return tutorName; }
    public void setTutorName(String tutorName) { this.tutorName = tutorName; }
    public int getStudentGrade() { return studentGrade; }
    public void setStudentGrade(int studentGrade) { this.studentGrade = studentGrade; }
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    public String getStudentPhone() { return studentPhone; }
    public void setStudentPhone(String studentPhone) { this.studentPhone = studentPhone; }
    public String getStudentAddress() { return studentAddress; }
    public void setStudentAddress(String studentAddress) { this.studentAddress = studentAddress; }
    public String getStudentDistrict() { return studentDistrict; }
    public void setStudentDistrict(String studentDistrict) { this.studentDistrict = studentDistrict; }
}