package com.tutorlink.model;
import jakarta.persistence.*;
//PublicReview class inherits from the Review class.
@Entity
@DiscriminatorValue("PUBLIC")
public class PublicReview extends Review {
    public PublicReview() {
        super();
    }
    public PublicReview(int studentId, int tutorId, int bookingId, int rating, String comment) {
        super(studentId, tutorId, bookingId, rating, comment);
    }
    //The child class overrides the method of the parent class.
    @Override
    public String getReviewType() {
        return "PUBLIC";
    }
    // polymorphism-Override the parent class method for the display badge.
    @Override
    public String getDisplayBadge() {
        return "Visible";
    }
}