package com.tutorlink.controller;
import com.tutorlink.model.Tutor;
import com.tutorlink.service.TutorService;
import com.tutorlink.service.TutorSubjectService;
import com.tutorlink.service.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
// Tutor controller - handles tutor requests

//Controller - Handles HTTP requests related to tutor actions
//OOP concept - Abstraction (hides service logic and only exposes endpoints)
@Controller
@RequestMapping("/tutor")
public class TutorController {

    //Spring automatically create & provides objects
    @Autowired private TutorService tutorService;
    @Autowired private TutorSubjectService tutorSubjectService;
    @Autowired private StudentService studentService;

    //get the currently logged-in tutor from the session
    //Encapsulation - internal logic hidden inside method
    private Tutor getTutorFromSession(HttpSession session) {
        Object userId = session.getAttribute("userId");

        if (userId == null) {
            return null;
        }

        return tutorService.getTutorByUserId((int) userId);
    }
    // show dashboard
    @GetMapping("/dashboard") //Map an HTTP GET request
    public String dashboard(HttpSession session, Model model) {

        //Security check
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        Tutor tutor = getTutorFromSession(session); //get logged-in tutor object

        if (tutor == null) {
            session.invalidate(); return "redirect:/login";
        }
        //Check session --> get tutor --> validity --> allow dashboard

        //sending data from controller to dashboard page
        //Encapsulation (data packed into model)
        model.addAttribute("tutor", tutor); // send tutor info to frontend
        model.addAttribute("myBookings", tutorService.getTutorBookings(tutor.getTutorId())); //shows tutor's booking list
        model.addAttribute("myReviews", tutorService.getTutorPublicReviews(tutor.getTutorId())); //shows student reviews
        model.addAttribute("avgRating", tutorService.getAverageRating(tutor.getTutorId())); //shows tutor rating
        model.addAttribute("profileSummary", tutor.getProfileSummary()); //short bio for dashboard

        return "tutor/dashboard"; //return page
        // Controller --> collects data --> sends to Model --> UI displays
    }

    // show profile
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }
        Tutor tutor = getTutorFromSession(session);

        if (tutor == null) {
            return "redirect:/login";
        }

        model.addAttribute("tutor", tutor);

        // Load tutor subjects
        model.addAttribute("tutorSubjects",
                tutorSubjectService.getSubjectsByTutorId(tutor.getTutorId()));
        return "tutor/profile";

       //Login check --> get tutor --> load subjects--> show profile page
    }
    //Edit profile form
    @GetMapping("/profile/edit")
    public String editProfileForm(HttpSession session, Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Tutor tutor = getTutorFromSession(session);
        if (tutor == null){
            return "redirect:/login";
        }

        model.addAttribute("tutor", tutor); //tutor data
        model.addAttribute("subjects", tutorService.getAllSubjects());
        model.addAttribute("districts", studentService.getAllDistricts());

        return "tutor/edit-profile";

        // edit profile
    }

    //Save Profile
    @PostMapping("/profile/edit")

    //@RequestParam - to get data from the HTML form and put it into Java variables
    public String saveProfile(@RequestParam String fullName,
                              @RequestParam String phone,
                              @RequestParam(required = false, defaultValue = "") String subject,
                              @RequestParam String district,
                              @RequestParam int onlineHourlyRate,
                              @RequestParam int homeVisitHourlyRate,
                              @RequestParam(defaultValue = "0") int travelRadius,
                              @RequestParam(required = false) String experience,
                              @RequestParam(required = false) String qualification,
                              @RequestParam(required = false) String bio,
                              @RequestParam(required = false) String bankName,
                              @RequestParam(required = false) String accountHolderName,
                              @RequestParam(required = false) String accountNumber,
                              @RequestParam(required = false) String branch,
                              HttpSession session) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }
        //update profile using Service layer(database)
        //Abstraction - service hides DB logic 
        tutorService.updateProfile((int) session.getAttribute("userId"), fullName, phone, subject, district,
                onlineHourlyRate, homeVisitHourlyRate, travelRadius, experience, qualification, bio,
                bankName, accountHolderName, accountNumber, branch);

        //Update session name
        session.setAttribute("userName", fullName);

        return "redirect:/tutor/profile?updated=true";
    }
    // show bookings
    @GetMapping("/bookings")
    public String myBookings(HttpSession session, Model model) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        Tutor tutor = getTutorFromSession(session);

        if (tutor == null) {
            return "redirect:/login";
        }

        model.addAttribute("myBookings", tutorService.getTutorBookings(tutor.getTutorId()));
        return "tutor/bookings";
    }

    // show reviews
    @GetMapping("/reviews")
    public String myReviews(HttpSession session, Model model) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        Tutor tutor = getTutorFromSession(session);

        if (tutor == null) {
            return "redirect:/login";
        }

        model.addAttribute("myReviews", tutorService.getTutorPublicReviews(tutor.getTutorId()));
        return "tutor/reviews";
    }
    // delete Account
    @PostMapping("/delete") //used to delete a tutor account using a POST request
    public String deleteAccount(HttpSession session) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        tutorService.deleteTutorAccount((int) session.getAttribute("userId"));
        session.invalidate();
        return "redirect:/login?deleted=true";
    }

    //booking actions
    @PostMapping("/booking/confirm/{bookingId}")
    public String confirmBooking(@PathVariable int bookingId, HttpSession session) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        tutorService.confirmBooking(bookingId);
        return "redirect:/tutor/dashboard?confirmed=true";
    }

    @PostMapping("/booking/complete/{bookingId}")

    //@PathVariable - takes a value from the URL path and uses it in the method
    public String completeBooking(@PathVariable int bookingId, HttpSession session) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        tutorService.completeBooking(bookingId);
        return "redirect:/tutor/dashboard?completed=true";
    }
    // Tutor declines a booking request
    @PostMapping("/booking/decline/{bookingId}")
    public String declineBooking(@PathVariable int bookingId, HttpSession session) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        tutorService.declineBooking(bookingId);
        return "redirect:/tutor/dashboard?declined=true";
    }
}

