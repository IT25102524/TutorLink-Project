//repository package - for database access logic in Spring Boot
package com.tutorlink.repository;

//Entity classes
import com.tutorlink.model.Tutor; // main tutor entity
import com.tutorlink.model.TutorSubject; // mapping between tutor and subject
import com.tutorlink.model.Subject; // subject entity

// Gives ready-made database methods (create, read, update, delete - CRUD operations)
import org.springframework.data.jpa.repository.JpaRepository;

//Query - to write custom database queries when the default methods are not enough
import org.springframework.data.jpa.repository.Query;

//Param - to pass method values into named placeholders inside a custom JPQL query
import org.springframework.data.repository.query.Param;

//Repository - to mark a class or interface as a database layer component
import org.springframework.stereotype.Repository;

//List - store multiple values in a single variable in an ordered way
import java.util.List;

//OOP concepts
//Abstraction -  Hides complex SQL logic inside @Query
//Encapsulation - Data is accessed safely using parameters
//Association (relationship) - Tutor and Subject relationship through TutorSubject
//Polymorphism - Repository can use both built-in methods and custom queries
@Repository
public interface TutorRepository extends JpaRepository<Tutor, Integer> {

    // READ - search tutors by subject and district
    @Query("SELECT DISTINCT t FROM Tutor t WHERE t.status = 'ACTIVE'" +
            " AND (:district IS NULL OR :district = '' OR t.district = :district)" +
            " AND (:subject IS NULL OR :subject = '' OR EXISTS (" +
            "   SELECT ts FROM TutorSubject ts JOIN Subject s ON ts.subjectId = s.subjectId" +
            "   WHERE ts.tutorId = t.userId AND ts.status = 'ACTIVE'" +
            "   AND LOWER(s.name) = LOWER(:subject)" +
            "))")

    List<Tutor> searchTutors(@Param("subject") String subject,
                             @Param("district") String district);
}

