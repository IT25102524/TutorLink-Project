package com.tutorlink.repository;
import com.tutorlink.model.TutorSubject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository

//OOP Concept - INHERITANCE
//TutorSubjectRepository - Name of the Repository
//extends - Used for Inheritance
//TutorSubject - Entity class managed by the Repository
//Integer - Data type of the primary key (id)
public interface TutorSubjectRepository extends JpaRepository<TutorSubject, Integer> {

    //ABSTRACTION - Database query details are hidden, and only the required functionality is exposed
    List<TutorSubject> findByTutorId(int tutorId);
    List<TutorSubject> findBySubjectId(int subjectId);
    List<TutorSubject> findByTutorIdAndStatus(int tutorId, String status);

}

