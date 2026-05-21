package com.tutorlink.service;
import com.tutorlink.model.ALevelSubject;
import com.tutorlink.model.OLevelSubject;
import com.tutorlink.model.PrimarySubject;
import com.tutorlink.model.Subject;
import com.tutorlink.repository.SubjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

// Subject service - handles subject catalogue CRUD
@Service
public class SubjectService {
    @Autowired private SubjectRepository subjectRepository;
    public List<Subject> getAllSubjects() {
        return subjectRepository.findAllByOrderByNameAsc();
    }

    public List<Subject> getActiveSubjects() {
        return subjectRepository.findByStatusOrderByNameAsc("ACTIVE");
    }

    // Get subjects filtered by grade level keyword (e.g. "12" = A/L, "6" = O/L, "1" = Primary)
    public List<Subject> getSubjectsByLevel(String gradeLevelKeyword) {
        return subjectRepository.findAllByOrderByNameAsc().stream()
                .filter(s -> s.getGradeLevel() != null && s.getGradeLevel().contains(gradeLevelKeyword))
                .sorted(java.util.Comparator.comparing(s -> (s.getCategory() != null ? s.getCategory() : "")))
                .collect(Collectors.toList());
    }
    public Subject getSubject(int subjectId) {
        return subjectRepository.findById(subjectId).orElse(null);
    }

    // Create new subject with medium, category, status
    public Subject addSubject(String name, String subjectType, String medium,
                              String category, String status) {
        Subject subject;
        if ("PRIMARY".equals(subjectType)) {
            subject = new PrimarySubject(name);
        } else if ("ALEVEL".equals(subjectType)) {
            subject = new ALevelSubject(name);
        } else {
            subject = new OLevelSubject(name);
        }
        subject.setMedium(medium);
        subject.setCategory(category);
        subject.setStatus(status != null ? status : "ACTIVE");
        return subjectRepository.save(subject);
    }

    // Update subject name, medium, category, status
    public void updateSubject(int subjectId, String name, String medium,
                              String category, String status) {
        Subject subject = subjectRepository.findById(subjectId).orElse(null);
        if (subject != null) {
            subject.setName(name);
            subject.setMedium(medium);
            subject.setCategory(category);
            subject.setStatus(status);
            subjectRepository.save(subject);
        }
    }
    public void deleteSubject(int subjectId) {
        subjectRepository.deleteById(subjectId);
    }
}
