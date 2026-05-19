package com.tutorlink.controller;
import com.tutorlink.model.Payment;
import com.tutorlink.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
// Payment controller - handles payment requests
@Controller
@RequestMapping("/payment")
public class PaymentController {
    @Autowired
    private PaymentService paymentService;
    // READ - show payment history
    @GetMapping("/history")
    public String paymentHistory(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        int    userId = (int)    session.getAttribute("userId");
        String role   = (String) session.getAttribute("role");
        List<Payment> payments = "TUTOR".equals(role)
                ? paymentService.getPaymentsByTutor(userId)
                : paymentService.getPaymentsByStudent(userId);
        model.addAttribute("payments", payments);
        model.addAttribute("role", role);
        return "payment/payment-history";
    }
    // READ - show all payments for admin grouped by week
    @GetMapping("/admin/all")
    public String allPayments(HttpSession session, Model model) {
        Object role = session.getAttribute("role");
        if (role == null || !"ADMIN".equals(role)) return "redirect:/login";
        java.util.List<com.tutorlink.model.Payment> allPayments = paymentService.getAllPayments();
        // Group by week
        java.util.LinkedHashMap<String, java.util.List<com.tutorlink.model.Payment>> paymentsByWeek = new java.util.LinkedHashMap<>();
        for (com.tutorlink.model.Payment p : allPayments) {
            String weekLabel = "Unknown Week";
            if (p.getPaymentDate() != null) {
                try {
                    java.time.LocalDate pd = java.time.LocalDate.parse(p.getPaymentDate().substring(0, 10));
                    java.time.LocalDate mon = pd.with(java.time.DayOfWeek.MONDAY);
                    java.time.LocalDate sun = pd.with(java.time.DayOfWeek.SUNDAY);
                    weekLabel = "Week of " + mon.format(java.time.format.DateTimeFormatter.ofPattern("MMM d")) +
                            " – " + sun.format(java.time.format.DateTimeFormatter.ofPattern("MMM d, yyyy"));
                } catch (Exception ignored) {}
            }
            paymentsByWeek.computeIfAbsent(weekLabel, k -> new java.util.ArrayList<>()).add(p);
        }
        model.addAttribute("payments", allPayments);
        model.addAttribute("paymentsByWeek", paymentsByWeek);
        return "payment/admin-payments";
    }
}
