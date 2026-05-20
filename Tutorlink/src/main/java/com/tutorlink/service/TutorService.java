package com.tutorlink.service;
import com.tutorlink.model.Booking; //stores booking details
import com.tutorlink.model.Review; //stores review details
import com.tutorlink.model.Tutor; //stores tutor information
import com.tutorlink.model.User; //stores user details
import com.tutorlink.repository.*;

//Autowired - automatically injects objects
import org.springframework.beans.factory.annotation.Autowired;

//Service - marks this class as a service layer component
import org.springframework.stereotype.Service;

import java.util.ArrayList; //dynamic list
import java.util.List; //collection interface
import java.util.Optional;//avoid null-related issues

// Tutor service - handles tutor logic
@Service //Service class for tutor-related operations

public class TutorService { //create TutorService class

    //Automatically injects repository and service objects
    @Autowired private TutorRepository tutorRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private BookingRepository bookingRepository;
    @Autowired private PaymentService paymentService;
    @Autowired private ReviewRepository reviewRepository;
    @Autowired private SubjectRepository subjectRepository;
    @Autowired private StudentRepository studentRepository;


    //OOP concept - ABSTRACTION
    public Tutor getTutorByUserId(int userId) {
        Optional<User> userOpt = userRepository.findById(userId); // Find tutor details using user ID

        //Inheritance & Polymorphism
        if (userOpt.isPresent() && userOpt.get() instanceof Tutor) { // Search user in database
            //Convert User object into Tutor object
            return (Tutor) userOpt.get();
        }
        return null;
    }

    //Get all tutor bookings
    public List<Booking> getTutorBookings(int tutorId) {

        // Get bookings ordered by latest booking
        List<Booking> bookings = bookingRepository.findByTutorIdOrderByBookingIdDesc(tutorId);

        // Loop through all bookings
        for (Booking b : bookings) {

            // Find student details
            studentRepository.findById(b.getStudentId()).ifPresent(s -> {

                //OOP concept - Encapsulation (Set student details using setters
                b.setStudentName(s.getFullName());
                b.setStudentGrade(s.getGradeLevel());
                b.setStudentEmail(s.getEmail());
                b.setStudentPhone(s.getPhone());
                b.setStudentAddress(s.getAddress());
                b.setStudentDistrict(s.getDistrict());
            });
        }
        return bookings;
    }

    // Get visible tutor reviews
    public List<Review> getTutorPublicReviews(int tutorId) {

        // Collect all tutor reviews
        List<Review> allReviews = reviewRepository.findByTutorIdOrderByReviewIdDesc(tutorId);

        List<Review> visibleReviews = new ArrayList<>();

        for (Review r : allReviews) {

            // ignore reported reviews
            if (!"REPORTED".equals(r.getReviewType())) {

                //get student name
                studentRepository.findById(r.getStudentId()).ifPresent(s -> r.setStudentName(s.getFullName()));
                visibleReviews.add(r);
            }
        }
        return visibleReviews;
    }

    //get tutor average rating
    public double getAverageRating(int tutorId) {
        Double avg = reviewRepository.getAverageRatingByTutorId(tutorId);
        return avg != null ? avg : 0.0;
    }

    //Get all subjects
    public List<com.tutorlink.model.Subject> getAllSubjects() {

        return subjectRepository.findAllByOrderByNameAsc();
    }

    //Update tutor profile
    public Tutor updateProfile(int userId, String fullName, String phone, String subject,
                               String district, int onlineHourlyRate, int homeVisitHourlyRate,
                               int travelRadius, String experience, String qualification, String bio,
                               String bankName, String accountHolderName, String accountNumber,
                               String branch) {
        Tutor tutor = getTutorByUserId(userId);

        if (tutor == null) {
            return null;
        }

        //OOP concept - Encapsulation
        //Update tutor details using setters
        tutor.setFullName(fullName);
        tutor.setPhone(phone);
        tutor.setSubject(subject);
        tutor.setDistrict(district);
        tutor.setOnlineHourlyRate(onlineHourlyRate);
        tutor.setHomeVisitHourlyRate(homeVisitHourlyRate);
        tutor.setTravelRadius(travelRadius);
        tutor.setExperience(experience);
        tutor.setQualification(qualification);
        tutor.setBio(bio);
        tutor.setBankName(bankName);
        tutor.setAccountHolderName(accountHolderName);
        tutor.setAccountNumber(accountNumber);
        tutor.setBranch(branch);

        //Save updated information
        return tutorRepository.save(tutor);
    }
    public void deleteTutorAccount(int userId) {
        userRepository.deleteById(userId);
    }
    // UPDATE - confirm booking and charge card if card payment
    public void confirmBooking(int bookingId) {
        bookingRepository.findById(bookingId).ifPresent(b -> {

            //Change booking status
            b.setStatus("CONFIRMED");
            bookingRepository.save(b);
        });
        // Process card payment
        paymentService.confirmCardPayment(bookingId);
    }
    public void completeBooking(int bookingId) {
        bookingRepository.findById(bookingId).ifPresent(b -> {

            //Mark booking completed
            b.setStatus("COMPLETED");
            bookingRepository.save(b);
        });
        // Complete payment
        paymentService.completeCashPayment(bookingId);
    }
    // Tutor declines a booking - cancel booking and fail the payment
    public void declineBooking(int bookingId) {
        bookingRepository.findById(bookingId).ifPresent(b -> {

            //cancel booking
            b.setStatus("CANCELLED");
            bookingRepository.save(b);
        });
        // Mark payment failed 
        paymentService.failPayment(bookingId);
    }
}
