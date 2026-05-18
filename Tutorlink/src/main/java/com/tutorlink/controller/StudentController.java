package com.tutorlink.controller;

import com.tutorlink.model.Student;
import com.tutorlink.model.Tutor;
import com.tutorlink.service.StudentService;
import com.tutorlink.service.LearningGoalService;
import com.tutorlink.service.TutorSubjectService;
import com.tutorlink.service.SubjectService;
import com.tutorlink.service.FavoriteTutorService;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

// Student controller - handles student requests

@Controller
@RequestMapping("/student")
public class StudentController {
    @Autowired private StudentService studentService;
    @Autowired private LearningGoalService learningGoalService;
    @Autowired private TutorSubjectService tutorSubjectService;
    @Autowired private SubjectService subjectService;
    @Autowired private FavoriteTutorService favoriteTutorService;
    @Autowired private com.tutorlink.repository.StudentRepository studentRepository;

    private Student getStudentFromSession(HttpSession session) {
        Object userId = session.getAttribute("userId");
        if (userId == null)
            return null;
        return studentService.getStudentByUserId((int) userId);
    }

    // READ - show dashboard
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null) {
            session.invalidate();
            return "redirect:/login";
        }

        model.addAttribute("student", student);
        model.addAttribute("myBookings", studentService.getStudentBookings(student.getStudentId()));
        model.addAttribute("myReviews", studentService.getStudentReviews(student.getStudentId()));
        model.addAttribute("profileSummary", student.getProfileSummary());
        // Favorites count for dashboard stat card
        model.addAttribute("favoritesCount", favoriteTutorService.getFavoriteCount(student.getStudentId()));
        return "student/dashboard";
    }

    // READ - show profile
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        model.addAttribute("student", student);
        return "student/profile";
    }

    @GetMapping("/profile/edit")
    public String showEditProfile(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        model.addAttribute("student", student);
        model.addAttribute("districts", studentService.getAllDistricts());
        return "student/edit-profile";
    }

    // UPDATE
    @PostMapping("/profile/edit")
    public String updateProfile(@RequestParam String fullName,
                                @RequestParam String phone,
                                @RequestParam int gradeLevel,
                                @RequestParam String address,
                                @RequestParam String district,
                                HttpSession session) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        studentService.updateProfile((int) session.getAttribute("userId"), fullName, phone, gradeLevel, address, district);
        session.setAttribute("userName", fullName);
        return "redirect:/student/profile?updated=true";
    }

    // READ - standalone profile view for tutors
    @GetMapping("/profile/view/{studentId}")
    public String viewStudentProfile(@PathVariable int studentId, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        com.tutorlink.model.Student student = studentRepository.findById(studentId).orElse(null);
        if (student == null) {
            model.addAttribute("errorMessage", "Student profile not found.");
            return "student/student-profile-view";
        }
        model.addAttribute("student", student);
        return "student/student-profile-view";
    }

    // READ - Find & Book Tutor (search with filters)
    @GetMapping("/search")
    public String searchTutors(@RequestParam(required = false) String subject,
                               @RequestParam(required = false) String district,
                               @RequestParam(required = false) String medium,
                               @RequestParam(required = false) String teachingMode,
                               @RequestParam(defaultValue = "0") int minBudget,
                               @RequestParam(defaultValue = "0") int maxBudget,
                               HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        // Single search call
        java.util.List<com.tutorlink.model.Tutor> tutors =
                studentService.searchTutors(subject, district, medium, teachingMode, minBudget, maxBudget);
        model.addAttribute("tutors", tutors);
        model.addAttribute("subject", subject);
        model.addAttribute("district", district);
        model.addAttribute("medium", medium);
        model.addAttribute("teachingMode", teachingMode);
        model.addAttribute("minBudget", minBudget);
        model.addAttribute("maxBudget", maxBudget);
        model.addAttribute("subjects", studentService.getAllSubjects());
        model.addAttribute("districts", studentService.getAllDistricts());

        java.util.Map<Integer, java.util.List<com.tutorlink.model.TutorSubject>> tutorSubjectsMap = new java.util.HashMap<>();
        for (com.tutorlink.model.Tutor t : tutors) {
            tutorSubjectsMap.put(t.getTutorId(), tutorSubjectService.getActiveSubjectsByTutorId(t.getTutorId()));
        }
        model.addAttribute("tutorSubjectsMap", tutorSubjectsMap);
        // Favorited tutor IDs for heart button state
        Student student = getStudentFromSession(session);
        if (student != null) {
            model.addAttribute("favoritedTutorIds", favoriteTutorService.getFavoritedTutorIds(student.getStudentId()));
        }
        return "student/search";
    }

    @GetMapping("/view-tutor/{tutorId}")
    public String viewTutor(@PathVariable int tutorId, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Tutor tutor = studentService.getTutor(tutorId);

        if (tutor == null)
            return "redirect:/student/search";

        model.addAttribute("tutor", tutor);
        model.addAttribute("reviews", studentService.getPublicReviewsForTutor(tutorId));
        model.addAttribute("avgRating", studentService.getAverageRatingForTutor(tutorId));
        model.addAttribute("slots", studentService.getTutorAvailability(tutorId));
        // Load tutor teaching subjects for profile display
        model.addAttribute("tutorSubjects", tutorSubjectService.getActiveSubjectsByTutorId(tutorId));
        // Check if student has favorited this tutor
        Student student = getStudentFromSession(session);
        if (student != null) {
            model.addAttribute("isFavorited", favoriteTutorService.isFavorited(student.getStudentId(), tutorId));
        }
        return "student/view-tutor";
    }

    // READ - show bookings
    @GetMapping("/bookings")
    public String myBookings(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        model.addAttribute("myBookings", studentService.getStudentBookings(student.getStudentId()));
        return "student/bookings";
    }
    // READ - show reviews
    @GetMapping("/reviews")
    public String myReviews(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        model.addAttribute("myReviews", studentService.getStudentReviews(student.getStudentId()));
        return "student/reviews";
    }

    // DELETE - delete student account
    @PostMapping("/delete")
    public String deleteMyAccount(HttpSession session) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        studentService.deleteStudentAccount((int) session.getAttribute("userId"));
        session.invalidate();
        return "redirect:/login?deleted=true";
    }

    //------Learning Progrss-------
    // READ - show learning progress dashboard
    @GetMapping("/goals")
    public String learningGoals(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";

        com.tutorlink.model.LearningGoal goal = learningGoalService.getGoalForStudent(student.getStudentId());
        java.util.Map<String, Integer> sessionsBySubject = learningGoalService.getSessionsBySubject(student.getStudentId());

        java.util.List<String> missingFocusSubjects = new java.util.ArrayList<>();

        //check student have focus subjects
        if (goal != null && goal.getFocusSubjects() != null && !goal.getFocusSubjects().isEmpty()) {
            for (String subj : goal.getFocusSubjects().split(",")) {
                String cleanSubject = subj.trim();
                boolean foundInSessions = sessionsBySubject.keySet().stream().anyMatch(k -> k.equalsIgnoreCase(cleanSubject));
                if (!cleanSubject.isEmpty() && !foundInSessions) {
                    missingFocusSubjects.add(cleanSubject);
                }
            }
        }

        model.addAttribute("goal", goal);
        model.addAttribute("sessionsBySubject", sessionsBySubject);
        model.addAttribute("sessionsPerMonth", learningGoalService.getSessionsPerMonth(student.getStudentId()));
        int grade = student.getGradeLevel();
        //subject loading according to the grade
        String levelKeyword = grade <= 5 ? "Grade 1 - 5" : grade <= 11 ? "Grade 6 - 11" : "Grade 12 - 13";
        model.addAttribute("subjects", subjectService.getSubjectsByLevel(levelKeyword));
        model.addAttribute("missingFocusSubjects", missingFocusSubjects);

        return "student/goals";
    }

    // CREATE/UPDATE - save learning goal
    @PostMapping("/goals/save")
    public String saveGoal(@RequestParam int weeklySessionTarget,
                           @RequestParam(required = false) String focusSubjects,
                           @RequestParam(required = false, defaultValue = "0") int targetSessions,
                           @RequestParam(required = false) String goalDate,
                           HttpSession session) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        learningGoalService.saveGoal(student.getStudentId(),
                weeklySessionTarget, focusSubjects, targetSessions, goalDate);
        return "redirect:/student/goals?saved=true";
    }
    // DELETE - reset learning goal
    @PostMapping("/goals/delete")
    public String deleteGoal(HttpSession session) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        learningGoalService.deleteGoal(student.getStudentId());
        return "redirect:/student/goals?deleted=true";
    }

    // ------Favorite tutors--------
    // READ - show favorites page
    @GetMapping("/favorites")
    public String myFavorites(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        model.addAttribute("favorites", favoriteTutorService.getFavorites(student.getStudentId()));
        return "student/favorites";
    }

    // CREATE/DELETE - toggle favorite
    @PostMapping("/favorite/toggle/{tutorId}")
    public String toggleFavorite(@PathVariable int tutorId,
                                 @RequestParam(required = false) String returnUrl,
                                 HttpSession session) {
        if (session.getAttribute("userId") == null)
            return "redirect:/login";
        Student student = getStudentFromSession(session);
        if (student == null)
            return "redirect:/login";
        boolean added = favoriteTutorService.toggleFavorite(student.getStudentId(), tutorId);
        if (returnUrl != null && !returnUrl.isEmpty()) {
            return "redirect:" + returnUrl + (returnUrl.contains("?") ? "&" : "?") + "fav=" + (added ? "added" : "removed");
        }
        return "redirect:/student/search?fav=" + (added ? "added" : "removed");
    }


}