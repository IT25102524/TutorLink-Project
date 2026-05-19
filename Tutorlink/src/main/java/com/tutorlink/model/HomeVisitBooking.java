package com.tutorlink.model;
import jakarta.persistence.*;
// HomeVisitBooking class - extends Booking
@Entity
@DiscriminatorValue("HOME_VISIT")
public class HomeVisitBooking extends Booking {
    public HomeVisitBooking() {
        super();
    }
    public HomeVisitBooking(int studentId, int tutorId, String subject,
                            String bookingDate, String timeSlot, String notes) {
        super(studentId, tutorId, subject, bookingDate, timeSlot, notes);
    }
    // polymorphism - override booking type
    @Override
    public String getBookingType() {
        return "HOME_VISIT";
    }
    // polymorphism - override cost calculation
    @Override
    public int calculateCost(int hourlyRate) {
        return hourlyRate;
    }
}
