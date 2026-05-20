package com.tutorlink.service;
import com.tutorlink.model.PublicReview;
import com.tutorlink.model.ReportedReview;
import com.tutorlink.model.Review;
import com.tutorlink.model.Student;
import com.tutorlink.model.User;
import com.tutorlink.repository.ReviewRepository;
import com.tutorlink.repository.StudentRepository;
import com.tutorlink.repository.TutorRepository;
import com.tutorlink.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
//service layer class-handles review CRUD
@Service
public class ReviewService {
    @Autowired private ReviewRepository reviewRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private StudentRepository studentRepository;
    @Autowired private TutorRepository tutorRepository;
    public Student getStudentByUserId(int userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent() && userOpt.get() instanceof Student) {
            return (Student) userOpt.get();
        }
        return null;
    }
    public Review createPublicReview(int studentUserId, int tutorId, int bookingId,
                                     int rating, String comment) throws Exception {
        Student student = getStudentByUserId(studentUserId);
        if (student == null) throw new Exception("Student not found.");
        Review review = new PublicReview(student.getStudentId(), tutorId, bookingId, rating, comment);
        return reviewRepository.save(review);
    }
    public Review getReview(int reviewId) {
        return reviewRepository.findById(reviewId).orElse(null);
    }
    public void updateReview(int reviewId, int rating, String comment) {
        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review != null) {
            review.setRating(rating);
            review.setComment(comment);
            reviewRepository.save(review);
        }
    }
    public void deleteReview(int reviewId) {
        reviewRepository.deleteById(reviewId);
    }
    public List<Review> getAllReviewsWithNames() {
        List<Review> reviews = reviewRepository.findAll();
        for (Review r : reviews) {
            studentRepository.findById(r.getStudentId()).ifPresent(s -> r.setStudentName(s.getFullName()));
            tutorRepository.findById(r.getTutorId()).ifPresent(t -> r.setTutorName(t.getFullName()));
        }
        return reviews;
    }
    public void reportReview(int reviewId, String reportReason) {
        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review != null) {
            ReportedReview reported = new ReportedReview(
                    review.getStudentId(),
                    review.getTutorId(),
                    review.getBookingId(),
                    review.getRating(),
                    review.getComment(),
                    reportReason
            );
            reviewRepository.deleteById(reviewId);
            reviewRepository.save(reported);
        }
    }
}
