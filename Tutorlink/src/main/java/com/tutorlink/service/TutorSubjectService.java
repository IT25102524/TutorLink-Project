package com.tutorlink.service; // Defines that this class belongs to the service package

import com.tutorlink.model.Subject; // Imports Subject model class

import com.tutorlink.model.TutorSubject; //  Imports TutorSubject model class

import com.tutorlink.repository.SubjectRepository; //Imports SubjectRepository for database operations

import com.tutorlink.repository.TutorSubjectRepository; // Imports TutorSubjectRepository for database operations

import org.springframework.beans.factory.annotation.Autowired; // Imports Autowired annotation for dependency injection

import org.springframework.stereotype.Service; //Imports Service annotation to mark this class as a service layer

import java.util.List; // Imports List interface to store multiple objects

// TutorSubjectService - manages subjects a tutor can teach
@Service

//TutorSubjectService class
public class TutorSubjectService { // Handles all operations related to subjects taught by tutors

    //OOP concept - Abstraction (Service uses repository interfaces without knowing database details)
    @Autowired
    private TutorSubjectRepository tutorSubjectRepository;

    @Autowired
    private SubjectRepository subjectRepository;

    // Get all subjects for a tutor
    public List<TutorSubject> getSubjectsByTutorId(int tutorId) {

        // collect subjects by tutor ID
        List<TutorSubject> tutorSubjects = tutorSubjectRepository.findByTutorId(tutorId);

        //loop through each tutor subject
        for (TutorSubject ts : tutorSubjects) {

            // Abstraction - Database getting logic hidden inside repository
            subjectRepository.findById(ts.getSubjectId()).ifPresent(s -> {

                // Encapsulation - Accessing private fields through setter methods
                ts.setSubjectName(s.getName());
                ts.setSubjectType(s.getSubjectType());
            });
        }
        return tutorSubjects;
    }
    // Get only active subjects
    public List<TutorSubject> getActiveSubjectsByTutorId(int tutorId) {

        //Collect active records only
        List<TutorSubject> tutorSubjects = tutorSubjectRepository.findByTutorIdAndStatus(tutorId, "ACTIVE");
        for (TutorSubject ts : tutorSubjects) {
            subjectRepository.findById(ts.getSubjectId()).ifPresent(s -> {

                //Encapsulation
                ts.setSubjectName(s.getName());
                ts.setSubjectType(s.getSubjectType());
            });
        }
        return tutorSubjects;
    }

    //Get one tutor subject by ID
    public TutorSubject getTutorSubject(int tutorSubjectId) {

        //collect record or return null
        TutorSubject ts = tutorSubjectRepository.findById(tutorSubjectId).orElse(null);
        if (ts != null) {

            subjectRepository.findById(ts.getSubjectId()).ifPresent(s -> {

                //Encapsulation
                ts.setSubjectName(s.getName());
                ts.setSubjectType(s.getSubjectType());
            });
        }
        return ts;
    }
    // Add new subject for a tutor
    public void addTutorSubject(int tutorId, int subjectId, String medium,
                                String teachingMode, int onlineRate, int homeRate) {

        //Object creation
        TutorSubject ts = new TutorSubject(tutorId, subjectId, medium, teachingMode, onlineRate, homeRate);

        // save object to database
        tutorSubjectRepository.save(ts);
    }
    // Update tutor subject details
    public void updateTutorSubject(int tutorSubjectId, String medium, String teachingMode,
                                   int onlineRate, int homeRate) {

        TutorSubject ts = tutorSubjectRepository.findById(tutorSubjectId).orElse(null);

        if (ts != null) {

            //Encapsulation - Updating values using setters
            ts.setMedium(medium);
            ts.setTeachingMode(teachingMode);
            ts.setOnlineHourlyRate(onlineRate);
            ts.setHomeVisitHourlyRate(homeRate);
            tutorSubjectRepository.save(ts);
        }
    }
    // Delete a tutor subject
    public void deleteTutorSubject(int tutorSubjectId) {
        //remove record by ID
        tutorSubjectRepository.deleteById(tutorSubjectId);
    }

    // Get subject name by subject id
    public String getSubjectName(int subjectId) {
        Subject s = subjectRepository.findById(subjectId).orElse(null);

        //Ternary operator
        return s != null ? s.getName() : "";
    }
}

