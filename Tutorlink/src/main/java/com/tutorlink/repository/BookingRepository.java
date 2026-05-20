package com.tutorlink.repository;
import com.tutorlink.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface BookingRepository extends JpaRepository<Booking, Integer> {
    List<Booking> findByStudentIdOrderByBookingIdDesc(int studentId);
    List<Booking> findByTutorIdOrderByBookingIdDesc(int tutorId);
}
