package com.tutorlink.repository;
import com.tutorlink.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByTutorIdOrderByReviewIdDesc(int tutorId);
    List<Review> findByStudentIdOrderByReviewIdDesc(int studentId);
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.tutorId = :tutorId AND TYPE(r) != com.tutorlink.model.ReportedReview")
    Double getAverageRatingByTutorId(@Param("tutorId") int tutorId);
}