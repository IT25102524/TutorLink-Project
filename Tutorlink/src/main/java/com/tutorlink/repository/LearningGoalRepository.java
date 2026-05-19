package com.tutorlink.repository;
import com.tutorlink.model.LearningGoal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

//Handles database operations related to student learning goals
@Repository
public interface LearningGoalRepository extends JpaRepository<LearningGoal, Integer> {

    //Finds a learning goal by student ID and academic year
    Optional<LearningGoal> findByStudentIdAndYearSet(int studentId, int yearSet);
}
