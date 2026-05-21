package com.tutorlink.repository;
import com.tutorlink.model.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository

public interface SubjectRepository extends JpaRepository<Subject, Integer> {
    List<Subject> findAllByOrderByNameAsc();
    List<Subject> findByStatusOrderByNameAsc(String status);
    List<Subject> findByMediumOrderByNameAsc(String medium);
    List<Subject> findByCategoryOrderByNameAsc(String category);
}
