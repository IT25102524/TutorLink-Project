package com.tutorlink.controller;
import com.tutorlink.model.AvailabilitySlot;
import com.tutorlink.model.Tutor;
import com.tutorlink.service.AvailabilityService;
import com.tutorlink.service.TutorSubjectService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

// Availability controller - handles availability CRUD
@Controller

@RequestMapping("/availability")

public class AvailabilityController {
    @Autowired private AvailabilityService availabilityService;
    @Autowired private TutorSubjectService tutorSubjectService;

    // READ - show all availability slots for logged-in tutor
    @GetMapping("/list")
    public String listSlots(HttpSession session, Model model) {

        //Session check (Security - prevents unauthorized access)
        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        //Inheritance/Association (Tutor object linked with User)
        Tutor tutor = availabilityService.getTutorByUserId((int) session.getAttribute("userId"));

        if (tutor == null) { // if tutor not found, redirect to login
            return "redirect:/login";
        }

        model.addAttribute("slots", availabilityService.getSlotsForTutor(tutor.getTutorId()));
        return "availability/list";
    }
    // CREATE - show add form with tutor subjects dropdown
    @GetMapping("/add")
    public String addSlotForm(HttpSession session, Model model) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        // Role-based access control (only tutors allowed)
        if (!"TUTOR".equals(session.getAttribute("role"))) {
            return "redirect:/";
        }

        // Get tutor subjects for dropdown
        int userId = (int) session.getAttribute("userId");

        Tutor tutor = availabilityService.getTutorByUserId(userId);

        if (tutor != null) {
            model.addAttribute("tutorSubjects",
                    tutorSubjectService.getActiveSubjectsByTutorId(tutor.getTutorId()));
        }
        return "availability/add";
    }
    // CREATE - save new availability slot
    @PostMapping("/add")
    public String addSlot(@RequestParam int tutorSubjectId,
                          @RequestParam String day,
                          @RequestParam String startTime,
                          @RequestParam String endTime,
                          @RequestParam String medium,
                          HttpSession session) {

        // Session validation (security)
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        if (!"TUTOR".equals(session.getAttribute("role"))) {
            return "redirect:/";
        }
        // Encapsulation (data handled inside service method)
        availabilityService.addSlot((int) session.getAttribute("userId"),
                tutorSubjectId, day, startTime, endTime, medium);
        return "redirect:/availability/list?added=true";
    }

    // UPDATE FORM - load existing slot data
    @GetMapping("/edit/{slotId}")
    public String editSlotForm(@PathVariable int slotId, HttpSession session, Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        AvailabilitySlot slot = availabilityService.getSlot(slotId);

        if (slot == null){
            return "redirect:/availability/list";
        }

        model.addAttribute("slot", slot);

        // Load tutor subjects for dropdown
        int userId = (int) session.getAttribute("userId");
        Tutor tutor = availabilityService.getTutorByUserId(userId);

        if (tutor != null) {
            model.addAttribute("tutorSubjects",
                    tutorSubjectService.getActiveSubjectsByTutorId(tutor.getTutorId()));
        }
        return "availability/edit";
    }
    // UPDATE OPERATION - save edited slot
    @PostMapping("/edit/{slotId}")
    public String updateSlot(@PathVariable int slotId,
                             @RequestParam int tutorSubjectId,
                             @RequestParam String day,
                             @RequestParam String startTime,
                             @RequestParam String endTime,
                             @RequestParam String medium,
                             HttpSession session) {

        if (session.getAttribute("userId") == null){
            return "redirect:/login";
        }

        if (!"TUTOR".equals(session.getAttribute("role"))){
            return "redirect:/";
        }

        availabilityService.updateSlot(slotId, tutorSubjectId, day, startTime, endTime, medium);
        return "redirect:/availability/list?updated=true";
    }

    // DELETE OPERATION - remove slot
    @PostMapping("/delete/{slotId}")
    public String deleteSlot(@PathVariable int slotId, HttpSession session) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        if (!"TUTOR".equals(session.getAttribute("role"))) {
            return "redirect:/";
        }

        availabilityService.deleteSlot(slotId);
        return "redirect:/availability/list?deleted=true";
    }
}
