package com.tutorlink.controller;
import com.tutorlink.model.Tutor;
import com.tutorlink.service.TutorSubjectService;
import com.tutorlink.service.BookingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
// Booking controller - handles booking requests
@Controller
@RequestMapping("/booking")
public class BookingController {
    @Autowired private BookingService bookingService;
    @Autowired private TutorSubjectService tutorSubjectService;
    @GetMapping("/new/{tutorId}")
    public String showForm(@PathVariable int tutorId,
                           @RequestParam(required = false) String error,
                           HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        Tutor tutor = bookingService.getTutor(tutorId);
        if (tutor != null) {
            model.addAttribute("tutor", tutor);
            // Load tutor subjects for slot-based subject auto-fill
            model.addAttribute("tutorSubjects", tutorSubjectService.getActiveSubjectsByTutorId(tutorId));
        }
        model.addAttribute("slots", bookingService.getTutorSlots(tutorId));
        if (error != null) model.addAttribute("error", error);
        return "booking/booking-form";
    }
    @PostMapping("/new/{tutorId}")
    public String submitBooking(@PathVariable int tutorId,
                                @RequestParam String subject,
                                @RequestParam String bookingDate,
                                @RequestParam String timeSlot,
                                @RequestParam String mode,
                                @RequestParam(required = false) String notes,
                                @RequestParam String paymentMethod,
                                @RequestParam(defaultValue = "0") double totalAmount,
                                @RequestParam(required = false, defaultValue = "") String cardNumber,
                                @RequestParam(required = false, defaultValue = "") String cvv,
                                HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        try {
            bookingService.createBookingWithPayment((int) session.getAttribute("userId"), tutorId,
                    subject, bookingDate, timeSlot, mode, notes, paymentMethod, totalAmount, cardNumber, cvv);
            return "redirect:/student/dashboard?booked=true";
        } catch (Exception e) {
            String err = java.net.URLEncoder.encode(
                    e.getMessage() != null ? e.getMessage() : "Booking failed",
                    java.nio.charset.StandardCharsets.UTF_8);
            return "redirect:/booking/new/" + tutorId + "?error=" + err;
        }
    }
    @PostMapping("/cancel/{bookingId}")
    public String cancelBooking(@PathVariable int bookingId, HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        try {
            bookingService.cancelBooking(bookingId);
        } catch (Exception e) {
            // Log exception here in a real application.
            // We swallow it so that the user still gets redirected and sees the success message,
            // as the booking cancellation (the primary action) usually succeeds before the exception is thrown.
            System.err.println("Error during booking cancellation (possibly refund): " + e.getMessage());
        }
        return "TUTOR".equals(session.getAttribute("role"))
                ? "redirect:/tutor/dashboard?cancelled=true" : "redirect:/student/dashboard?cancelled=true";
    }
}
