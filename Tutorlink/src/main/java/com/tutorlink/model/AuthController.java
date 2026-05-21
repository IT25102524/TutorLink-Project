package com.tutorlink.controller;
import com.tutorlink.model.User;
import com.tutorlink.service.AuthService;
import com.tutorlink.service.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Optional;
// Auth controller - handles login and register
@Controller
public class AuthController {
    @Autowired private AuthService authService;
    @Autowired private StudentService studentService;
    @GetMapping("/")
    public String homePage() { return "home"; }
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("role");
            if (role.equals("STUDENT")) return "redirect:/student/dashboard";
            if (role.equals("TUTOR"))   return "redirect:/tutor/dashboard";
            if (role.equals("ADMIN"))   return "redirect:/admin/dashboard";
        }
        return "auth/login";
    }
    @PostMapping("/login")
    public String doLogin(@RequestParam String email,
                          @RequestParam String password,
                          HttpSession session, Model model) {
        Optional<User> result = authService.findByEmail(email);
        if (result.isEmpty()) {
            model.addAttribute("error", "Email not found. Please register first.");
            return "auth/login";
        }
        User user = result.get();
        if (!user.checkPassword(password)) {
            model.addAttribute("error", "Incorrect password. Please try again.");
            return "auth/login";
        }
        if (!user.canLogin()) {
            model.addAttribute("error", "Your account has been deactivated.");
            return "auth/login";
        }
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("userName", user.getFullName());
        return "redirect:/" + user.getDashboardPage();
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    @GetMapping("/register")
    public String showRegisterChoice() { return "auth/register-choice"; }
    @GetMapping("/register/student")
    public String showStudentRegister(Model model) {
        model.addAttribute("districts", studentService.getAllDistricts());
        return "auth/register-student";
    }
    @PostMapping("/register/student")
    public String registerStudent(@RequestParam String fullName,
                                  @RequestParam String email,
                                  @RequestParam String password,
                                  @RequestParam String phone,
                                  @RequestParam int gradeLevel,
                                  @RequestParam String address,
                                  @RequestParam String district,
                                  Model model) {
        if (authService.emailExists(email)) {
            model.addAttribute("error", "This email is already registered.");
            model.addAttribute("districts", studentService.getAllDistricts());
            return "auth/register-student";
        }
        authService.registerStudent(fullName, email, password, phone, gradeLevel, address, district);
        return "redirect:/login?registered=true";
    }
    @GetMapping("/register/tutor")
    public String showTutorRegister(Model model) {
        model.addAttribute("districts", studentService.getAllDistricts());
        return "auth/register-tutor";
    }
    @PostMapping("/register/tutor")
    public String registerTutor(@RequestParam String fullName,
                                @RequestParam String email,
                                @RequestParam String password,
                                @RequestParam String phone,
                                @RequestParam String district,
                                Model model) {
        if (authService.emailExists(email)) {
            model.addAttribute("error", "This email is already registered.");
            model.addAttribute("districts", studentService.getAllDistricts());
            return "auth/register-tutor";
        }
        // Experience, qualifications, bio and travel radius are set after registration via Edit Profile
        authService.registerTutor(fullName, email, password, phone, "", district,
                0, 0, 0, null, null, null);
        return "redirect:/login?registered=true";
    }
}
