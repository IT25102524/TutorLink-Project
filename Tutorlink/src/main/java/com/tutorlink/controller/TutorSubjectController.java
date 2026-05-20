package com.tutorlink.controller;
import com.tutorlink.model.Tutor;
import com.tutorlink.model.TutorSubject;
import com.tutorlink.service.AvailabilityService;
import com.tutorlink.service.SubjectService;
import com.tutorlink.service.TutorSubjectService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

// TutorSubjectController - handles tutor teaching subject CRUD
@Controller

@RequestMapping("/tutor/subjects")

public class TutorSubjectController {

    // Abstraction - hides business logic inside service layer
    @Autowired
    private TutorSubjectService tutorSubjectService;

    // Used to get subject list
    @Autowired
    private SubjectService subjectService;

    //Used to fetch Tutor details using userId
    @Autowired
    private AvailabilityService availabilityService;

    // READ - list all subjects this tutor teaches
    @GetMapping("")
    public String listTutorSubjects(HttpSession session, Model model) {

        //Security Check (session handling)
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        if (!"TUTOR".equals(session.getAttribute("role"))) return "redirect:/";

        int userId = (int) session.getAttribute("userId");

        Tutor tutor = availabilityService.getTutorByUserId(userId);

        if (tutor == null) {
            return "redirect:/login";
        }
        model.addAttribute("tutorSubjects",
                tutorSubjectService.getSubjectsByTutorId(tutor.getTutorId()));
        return "tutor/subjects";
    }

    // CREATE - show add subject form
    @GetMapping("/add")
    public String addSubjectForm(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"TUTOR".equals(session.getAttribute("role"))) {
            return "redirect:/";
        }
        // Load active subjects from DB
        model.addAttribute("subjects", subjectService.getActiveSubjects());
        return "tutor/add-subject";
    }
    // CREATE - save new tutor subject
    @PostMapping("/add")
    public String addSubject(@RequestParam int subjectId,
                             @RequestParam String medium,
                             @RequestParam String teachingMode,
                             @RequestParam int onlineHourlyRate,
                             @RequestParam int homeVisitHourlyRate,
                             HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"TUTOR".equals(session.getAttribute("role"))){
            return "redirect:/";
        }
        int userId = (int) session.getAttribute("userId");

        Tutor tutor = availabilityService.getTutorByUserId(userId);

        if (tutor == null){
            return "redirect:/login";
        }

        //CREATE operation (saving new tutorsubject)
        tutorSubjectService.addTutorSubject(tutor.getTutorId(), subjectId, medium,
                teachingMode, onlineHourlyRate, homeVisitHourlyRate);
        return "redirect:/tutor/subjects?added=true";
    }
    // UPDATE - show edit form
    @GetMapping("/edit/{id}")
    public String editSubjectForm(@PathVariable int id, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"TUTOR".equals(session.getAttribute("role"))){
            return "redirect:/";
        }
        TutorSubject ts = tutorSubjectService.getTutorSubject(id);

        if (ts == null) {
            return "redirect:/tutor/subjects";
        }
        //send data to edit page
        model.addAttribute("tutorSubject", ts);
        return "tutor/edit-subject";
    }
    // UPDATE - save changes
    @PostMapping("/edit/{id}")
    public String updateSubject(@PathVariable int id,
                                @RequestParam String medium,
                                @RequestParam String teachingMode,
                                @RequestParam int onlineHourlyRate,
                                @RequestParam int homeVisitHourlyRate,
                                HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"TUTOR".equals(session.getAttribute("role"))){
            return "redirect:/";
        }
        //UPDATE operation (modify existing record)
        tutorSubjectService.updateTutorSubject(id, medium, teachingMode,
                onlineHourlyRate, homeVisitHourlyRate);
        return "redirect:/tutor/subjects?updated=true";
    }
    // DELETE - remove tutor subject
    @PostMapping("/delete/{id}")
    public String deleteSubject(@PathVariable int id, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"TUTOR".equals(session.getAttribute("role"))) {
            return "redirect:/";
        }
        //DELETE operation
        tutorSubjectService.deleteTutorSubject(id);
        return "redirect:/tutor/subjects?deleted=true";
    }
}
