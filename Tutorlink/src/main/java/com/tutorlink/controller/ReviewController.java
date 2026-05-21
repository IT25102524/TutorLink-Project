package com.tutorlink.controller;
import com.tutorlink.model.Review;
import com.tutorlink.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
//web controller class-class handles review CRUD
@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired private ReviewService reviewService;
    @GetMapping("/write/{bookingId}")
    public String writeReviewForm(@PathVariable int bookingId,
                                  @RequestParam int tutorId,
                                  HttpSession session,
                                  Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        model.addAttribute("bookingId", bookingId);
        model.addAttribute("tutorId", tutorId);
        return "review/write-review";
    }
    @PostMapping("/write/{bookingId}")
    public String submitReview(@PathVariable int bookingId,
                               @RequestParam int tutorId,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        try {
            reviewService.createPublicReview((int) session.getAttribute("userId"), tutorId, bookingId, rating, comment);
        } catch (Exception e) {
            return "redirect:/student/dashboard";
        }
        return "redirect:/student/dashboard?reviewed=true";
    }
    @GetMapping("/edit/{reviewId}")
    public String editReviewForm(@PathVariable int reviewId,
                                 @RequestParam int tutorId,
                                 HttpSession session,
                                 Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        Review review = reviewService.getReview(reviewId);
        if (review == null) return "redirect:/student/dashboard";
        model.addAttribute("review", review);
        model.addAttribute("reviewId", reviewId);
        model.addAttribute("tutorId", tutorId);
        return "review/edit-review.jsp";
    }
    @PostMapping("/edit/{reviewId}")
    public String updateReview(@PathVariable int reviewId,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        reviewService.updateReview(reviewId, rating, comment);
        return "redirect:/student/dashboard?updated=true";
    }
    @PostMapping("/delete/{reviewId}")
    public String deleteReview(@PathVariable int reviewId, HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        reviewService.deleteReview(reviewId);
        String role = (String) session.getAttribute("role");
        if ("ADMIN".equals(role)) return "redirect:/admin/reviews?deleted=true";
        return "redirect:/student/dashboard?reviewDeleted=true";
    }
}
