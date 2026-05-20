package com.tutorlink.repository;
import com.tutorlink.model.FavoriteTutor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

// Handles database operations related to students' favorite tutors.
@Repository
public interface FavoriteTutorRepository extends JpaRepository<FavoriteTutor, Integer> {

    // Retrieves all favorite tutors of a student
    List<FavoriteTutor> findByStudentIdOrderByFavoriteIdDesc(int studentId);

    // Finds a favorite tutor record using student ID and tutor ID
    Optional<FavoriteTutor> findByStudentIdAndTutorId(int studentId, int tutorId);

    // Counts how many favorite tutors
    int countByStudentId(int studentId);

    // Removes a tutor from the student's favorites list.
    void deleteByStudentIdAndTutorId(int studentId, int tutorId);
}
