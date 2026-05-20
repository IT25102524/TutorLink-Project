package com.tutorlink.model;
import jakarta.persistence.*;
// OnlineBooking class - extends Booking
@Entity
@DiscriminatorValue("ONLINE")
public class OnlineBooking extends Booking {
    public OnlineBooking() {
        super();
    }
    public OnlineBooking(int studentId, int tutorId, String subject,
                         String bookingDate, String timeSlot, String notes) {
        super(studentId, tutorId, subject, bookingDate, timeSlot, notes);
    }
    // polymorphism - override booking type
    @Override
    public String getBookingType() {
        return "ONLINE";
    }
    // polymorphism - override cost calculation
    @Override
    public int calculateCost(int hourlyRate) {
        return hourlyRate;
    }
}
