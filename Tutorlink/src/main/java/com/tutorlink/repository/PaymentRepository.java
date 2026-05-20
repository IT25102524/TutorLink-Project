package com.tutorlink.repository;
import com.tutorlink.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
@Repository
public interface PaymentRepository extends JpaRepository<Payment, Integer> {
    List<Payment>     findByStudentIdOrderByPaymentIdDesc(int studentId);
    List<Payment>     findByTutorIdOrderByPaymentIdDesc(int tutorId);
    Optional<Payment> findByBookingId(int bookingId);
    List<Payment>     findAll();
}
