package com.tutorlink.model;
import jakarta.persistence.*;
//Review abstract class-parent class for review types
@Entity
@Table(name = "reviews")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "review_type", discriminatorType = DiscriminatorType.STRING)
public abstract class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private int reviewId;
    @Column(name = "student_id", columnDefinition = "int default 0")
    private int studentId;
    @Column(name = "tutor_id", columnDefinition = "int default 0")
    private int tutorId;
    @Column(name = "booking_id", columnDefinition = "int default 0")
    private int bookingId;
    @Column(name = "rating", columnDefinition = "int default 0")
    private int rating;
    @Column(name = "comment", columnDefinition = "TEXT")
    private String comment;
    @Column(name = "created_at", insertable = false, updatable = false)
    private String createdAt;
    @Transient
    private String studentName;
    @Transient
    private String tutorName;
    public Review() {}
    public Review(int studentId, int tutorId, int bookingId, int rating, String comment) {
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.bookingId = bookingId;
        this.rating = rating;
        this.comment = comment;
    }
    //abstraction concept method-subclasses return subject(Review)type
    public abstract String getReviewType();
    public abstract String getDisplayBadge();
    public boolean isPositiveReview() {
        return rating >= 4;
    }
    //formatting logic is hidden inside this method.-format rating stars
    public String getRatingSummary() {
        String stars = "";
        for (int i = 0; i < rating; i++) {
            stars += "★";
        }
        return stars + " (" + rating + "/5)";
    }
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public int getTutorId() { return tutorId; }
    public void setTutorId(int tutorId) { this.tutorId = tutorId; }
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getTutorName() { return tutorName; }
    public void setTutorName(String tutorName) { this.tutorName = tutorName; }
}

