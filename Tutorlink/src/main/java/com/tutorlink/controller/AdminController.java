package com.tutorlink.controller;
import com.tutorlink.model.User;
import com.tutorlink.service.AdminService;
import com.tutorlink.service.BookingService;
import com.tutorlink.service.ReviewService;
import com.tutorlink.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
// Admin controller - handles admin requests
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired private AdminService adminService;
    @Autowired private BookingService bookingService;
    @Autowired private ReviewService reviewService;
    @Autowired private PaymentService paymentService;
    @Autowired private com.tutorlink.repository.TutorSubjectRepository tutorSubjectRepository;
    private boolean checkAdmin(HttpSession session) {
        Object role = session.getAttribute("role");
        return role != null && role.equals("ADMIN");
    }
    // READ - show dashboard
    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        model.addAttribute("allUsers", adminService.getAllUsers());
        model.addAttribute("allBookings", bookingService.getAllBookingsWithNames());
        model.addAttribute("allReviews", reviewService.getAllReviewsWithNames());
        model.addAttribute("allSubjects", adminService.getAllSubjects());
        model.addAttribute("studentCount", adminService.countByRole("STUDENT"));
        model.addAttribute("tutorCount", adminService.countByRole("TUTOR"));
        model.addAttribute("adminCount", adminService.countByRole("ADMIN"));
        return "admin/dashboard";
    }
    // READ - bookings grouped by week
    @GetMapping("/bookings")
    public String bookingsList(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        java.util.List<com.tutorlink.model.Booking> allBookings = bookingService.getAllBookingsWithNames();
        // Group by week label
        java.util.LinkedHashMap<String, java.util.List<com.tutorlink.model.Booking>> bookingsByWeek = new java.util.LinkedHashMap<>();
        java.time.format.DateTimeFormatter fmt = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (com.tutorlink.model.Booking b : allBookings) {
            String weekLabel = "Unknown Week";
            if (b.getBookingDate() != null) {
                try {
                    java.time.LocalDate bd = java.time.LocalDate.parse(b.getBookingDate(), fmt);
                    java.time.LocalDate mon = bd.with(java.time.DayOfWeek.MONDAY);
                    java.time.LocalDate sun = bd.with(java.time.DayOfWeek.SUNDAY);
                    weekLabel = "Week of " + mon.format(java.time.format.DateTimeFormatter.ofPattern("MMM d")) +
                            " – " + sun.format(java.time.format.DateTimeFormatter.ofPattern("MMM d, yyyy"));
                } catch (Exception ignored) {}
            }
            bookingsByWeek.computeIfAbsent(weekLabel, k -> new java.util.ArrayList<>()).add(b);
        }
        model.addAttribute("bookingsByWeek", bookingsByWeek);
        model.addAttribute("bookings", allBookings);
        return "admin/bookings";
    }
    @GetMapping("/admins")
    public String adminsList(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin/admins-list";
    }
    @GetMapping("/admins/{adminId}")
    public String viewAdmin(@PathVariable int adminId, HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        User admin = adminService.getAdmin(adminId);
        if (admin == null) return "redirect:/admin/admins";
        model.addAttribute("adminUser", admin);
        return "admin/view-admin";
    }
    @GetMapping("/create")
    public String showCreateAdminForm(HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        return "admin/create-admin";
    }
    // CREATE - save new record
    @PostMapping("/create")
    public String createNewAdmin(@RequestParam String fullName,
                                 @RequestParam String email,
                                 @RequestParam String password,
                                 @RequestParam String phone,
                                 HttpSession session,
                                 Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        if (adminService.emailExists(email)) {
            model.addAttribute("error", "This email is already registered.");
            return "admin/create-admin";
        }
        adminService.createAdmin(fullName, email, password, phone);
        return "redirect:/admin/admins?created=true";
    }
    @GetMapping("/users")
    public String usersList(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        model.addAttribute("users", adminService.getAllUsers());
        return "admin/users";
    }
    @PostMapping("/users/deactivate/{userId}")
    public String deactivate(@PathVariable int userId, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        adminService.deactivateUser(userId);
        return "redirect:/admin/users?deactivated=true";
    }
    @PostMapping("/users/activate/{userId}")
    public String activate(@PathVariable int userId, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        adminService.activateUser(userId);
        return "redirect:/admin/users?activated=true";
    }
    @PostMapping("/users/delete/{userId}")
    public String deleteUser(@PathVariable int userId, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        adminService.deleteUser(userId);
        return "redirect:/admin/users?deleted=true";
    }

    @PostMapping("/bookings/delete/{bookingId}")
    public String deleteBooking(@PathVariable int bookingId, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        bookingService.deleteBooking(bookingId);
        return "redirect:/admin/bookings?deleted=true";
    }
    @GetMapping("/reviews")
    public String reviewsList(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";
        model.addAttribute("reviews", reviewService.getAllReviewsWithNames());
        return "admin/reviews";
    }
    @PostMapping("/reviews/report/{reviewId}")
    public String reportReview(@PathVariable int reviewId,
                               @RequestParam String reportReason,
                               HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        reviewService.reportReview(reviewId, reportReason);
        return "redirect:/admin/reviews?reported=true";
    }
    @PostMapping("/reviews/delete/{reviewId}")
    public String deleteReview(@PathVariable int reviewId, HttpSession session) {
        if (!checkAdmin(session)) return "redirect:/login";
        reviewService.deleteReview(reviewId);
        return "redirect:/admin/reviews";
    }

    // READ - system analytics dashboard (admin specific feature)
    @GetMapping("/analytics")
    public String analytics(HttpSession session, Model model) {
        if (!checkAdmin(session)) return "redirect:/login";

        java.util.List<com.tutorlink.model.Booking> allBookings = bookingService.getAllBookingsWithNames();
        java.util.List<com.tutorlink.model.Payment> allPayments = paymentService.getAllPayments();
        java.util.List<com.tutorlink.model.User> allUsers = adminService.getAllUsers();

        // Revenue per month - last 6 months (from PAID payments)
        java.time.LocalDate today = java.time.LocalDate.now();
        java.time.format.DateTimeFormatter monthFmt = java.time.format.DateTimeFormatter.ofPattern("MMM yyyy");
        java.util.LinkedHashMap<String, Double> revenuePerMonth = new java.util.LinkedHashMap<>();
        for (int i = 5; i >= 0; i--) {
            revenuePerMonth.put(today.minusMonths(i).format(monthFmt), 0.0);
        }
        for (com.tutorlink.model.Payment p : allPayments) {
            if (p.getPaymentStatus() != null && "PAID".equals(p.getPaymentStatus().toString())) {
                for (com.tutorlink.model.Booking b : allBookings) {
                    if (b.getBookingId() == p.getBookingId() && b.getBookingDate() != null) {
                        try {
                            java.time.LocalDate bd = java.time.LocalDate.parse(b.getBookingDate());
                            String key = bd.format(monthFmt);
                            if (revenuePerMonth.containsKey(key)) {
                                revenuePerMonth.merge(key, p.getAmount(), Double::sum);
                            }
                        } catch (Exception ignored) {}
                        break;
                    }
                }
            }
        }
        // Convert to int for display
        java.util.LinkedHashMap<String, Integer> revenuePerMonthInt = new java.util.LinkedHashMap<>();
        revenuePerMonth.forEach((k, v) -> revenuePerMonthInt.put(k, (int) Math.round(v)));
        model.addAttribute("revenuePerMonth", revenuePerMonthInt);

        // Student retention - returning (2+ bookings) vs first-time
        java.util.Map<Integer, Long> studentBookingCount = new java.util.HashMap<>();
        for (com.tutorlink.model.Booking b : allBookings) {
            studentBookingCount.merge(b.getStudentId(), 1L, Long::sum);
        }
        long returning = studentBookingCount.values().stream().filter(c -> c >= 2).count();
        long firstTime = studentBookingCount.values().stream().filter(c -> c == 1).count();
        model.addAttribute("returningStudents", returning);
        model.addAttribute("firstTimeStudents", firstTime);

        // Peak booking days (Mon-Sun)
        java.util.LinkedHashMap<String, Integer> peakDays = new java.util.LinkedHashMap<>();
        String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"};
        for (String d : days) peakDays.put(d, 0);
        for (com.tutorlink.model.Booking b : allBookings) {
            if (b.getBookingDate() != null) {
                try {
                    java.time.LocalDate bd = java.time.LocalDate.parse(b.getBookingDate());
                    String dayName = bd.getDayOfWeek().getDisplayName(
                            java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);
                    peakDays.merge(dayName, 1, Integer::sum);
                } catch (Exception ignored) {}
            }
        }
        model.addAttribute("peakDays", peakDays);

        // District activity - count tutors per district
        java.util.Map<String, Integer> districtCount = new java.util.LinkedHashMap<>();
        for (com.tutorlink.model.User u : allUsers) {
            if ("TUTOR".equals(u.getRole()) && u instanceof com.tutorlink.model.Tutor) {
                com.tutorlink.model.Tutor t = (com.tutorlink.model.Tutor) u;
                if (t.getDistrict() != null && !t.getDistrict().isEmpty()) {
                    districtCount.merge(t.getDistrict(), 1, Integer::sum);
                }
            }
        }
        // Sort by count
        java.util.List<java.util.Map.Entry<String,Integer>> distList = new java.util.ArrayList<>(districtCount.entrySet());
        distList.sort((a, b) -> b.getValue() - a.getValue());
        java.util.LinkedHashMap<String, Integer> districtActivity = new java.util.LinkedHashMap<>();
        distList.stream().limit(8).forEach(e -> districtActivity.put(e.getKey(), e.getValue()));
        model.addAttribute("districtActivity", districtActivity);

        // Tutor acceptance rate
        java.util.Map<String, int[]> tutorStats = new java.util.LinkedHashMap<>();
        for (com.tutorlink.model.Booking b : allBookings) {
            String tutorName = b.getTutorName() != null ? b.getTutorName() : "Tutor #" + b.getTutorId();
            tutorStats.putIfAbsent(tutorName, new int[]{0, 0}); // [received, confirmed]
            tutorStats.get(tutorName)[0]++;
            if ("CONFIRMED".equals(b.getStatus()) || "COMPLETED".equals(b.getStatus())) {
                tutorStats.get(tutorName)[1]++;
            }
        }
        java.util.LinkedHashMap<String, java.util.Map<String,Object>> tutorAcceptance = new java.util.LinkedHashMap<>();
        for (java.util.Map.Entry<String, int[]> e : tutorStats.entrySet()) {
            java.util.Map<String,Object> stats = new java.util.LinkedHashMap<>();
            stats.put("received", e.getValue()[0]);
            stats.put("confirmed", e.getValue()[1]);
            int rate = e.getValue()[0] > 0 ? (e.getValue()[1] * 100 / e.getValue()[0]) : 0;
            stats.put("rate", rate);
            tutorAcceptance.put(e.getKey(), stats);
        }
        model.addAttribute("tutorAcceptance", tutorAcceptance);

        // Subject gap analysis - subjects with no tutor currently teaching them
        java.util.List<String> preferredSubjectIds = new java.util.ArrayList<>();
        // Get all booked subject names from booking history
        java.util.Set<String> bookedSubjects = new java.util.HashSet<>();
        allBookings.forEach(b -> { if (b.getSubject() != null) bookedSubjects.add(b.getSubject()); });
        // Get all tutor subjects
        java.util.List<com.tutorlink.model.TutorSubject> allTutorSubjects =
                tutorSubjectRepository.findAll();
        java.util.Set<Integer> taughtSubjectIds = new java.util.HashSet<>();
        allTutorSubjects.forEach(ts -> taughtSubjectIds.add(ts.getSubjectId()));
        // Get all subjects and find gaps
        java.util.List<String> subjectGaps = new java.util.ArrayList<>();
        for (com.tutorlink.model.Subject s : adminService.getAllSubjects()) {
            if (!taughtSubjectIds.contains(s.getSubjectId())) {
                subjectGaps.add(s.getName() + " (" + s.getSubjectType() + ")");
            }
        }
        model.addAttribute("subjectGaps", subjectGaps);

        return "admin/analytics";
    }
}