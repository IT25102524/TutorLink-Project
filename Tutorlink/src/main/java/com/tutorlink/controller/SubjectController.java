package com.tutorlink.controller;
import com.tutorlink.service.SubjectService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

// Subject controller - handles subject catalogue CRUD
@Controller
@RequestMapping("/subject")
public class SubjectController {
    @Autowired private SubjectService subjectService;

    // READ - list subjects grouped by level
    @GetMapping("/list")
    public String getAllSubjects(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        model.addAttribute("alevelSubjects", subjectService.getSubjectsByLevel("12"));
        model.addAttribute("olevelSubjects", subjectService.getSubjectsByLevel("6"));
        model.addAttribute("primarySubjects", subjectService.getSubjectsByLevel("1"));
        model.addAttribute("totalCount", subjectService.getAllSubjects().size());
        return "subject/list";
    }

    // CREATE - show add form
    @GetMapping("/add")
    public String addSubjectForm(HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/";
        return "subject/add";
    }

    // CREATE - save new subject with medium, category, status
    @PostMapping("/add")
    public String addSubject(@RequestParam String name,
                             @RequestParam String subjectType,
                             @RequestParam(required = false) String medium,
                             @RequestParam(required = false) String category,
                             @RequestParam(defaultValue = "ACTIVE") String status,
                             HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/";
        subjectService.addSubject(name, subjectType, medium, category, status);
        return "redirect:/subject/list?added=true";
    }

    @GetMapping("/edit/{subjectId}")
    public String editSubjectForm(@PathVariable int subjectId,
                                  HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/";
        model.addAttribute("subject", subjectService.getSubject(subjectId));
        return "subject/edit";
    }

    // UPDATE - save updated subject
    @PostMapping("/edit/{subjectId}")
    public String updateSubject(@PathVariable int subjectId,
                                @RequestParam String name,
                                @RequestParam(required = false) String medium,
                                @RequestParam(required = false) String category,
                                @RequestParam(defaultValue = "ACTIVE") String status,
                                HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/";
        subjectService.updateSubject(subjectId, name, medium, category, status);
        return "redirect:/subject/list?updated=true";
    }

    @PostMapping("/delete/{subjectId}")
    public String deleteSubject(@PathVariable int subjectId, HttpSession session) {
        if (session.getAttribute("userId") == null) return "redirect:/login";
        if (!"ADMIN".equals(session.getAttribute("role"))) return "redirect:/";
        subjectService.deleteSubject(subjectId);
        return "redirect:/subject/list?deleted=true";
    }

}
