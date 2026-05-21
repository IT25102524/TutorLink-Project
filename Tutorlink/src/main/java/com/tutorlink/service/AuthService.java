package com.tutorlink.service;
import com.tutorlink.model.Student;
import com.tutorlink.model.Tutor;
import com.tutorlink.model.User;
import com.tutorlink.repository.StudentRepository;
import com.tutorlink.repository.TutorRepository;
import com.tutorlink.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;
// Auth service - handles login and register logic
@Service
public class AuthService {
    @Autowired private UserRepository userRepository;
    @Autowired private StudentRepository studentRepository;
    @Autowired private TutorRepository tutorRepository;
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }
    public Student registerStudent(String fullName, String email, String password, String phone,
                                   int gradeLevel, String address, String district) {
        Student student = new Student(fullName, email, password, phone, gradeLevel, address, district);
        return studentRepository.save(student);
    }
    public Tutor registerTutor(String fullName, String email, String password, String phone,
                               String subject, String district, int onlineHourlyRate,
                               int homeVisitHourlyRate, int travelRadius,
                               String experience, String qualification, String bio) {
        Tutor tutor = new Tutor(fullName, email, password, phone, subject, district,
                onlineHourlyRate, homeVisitHourlyRate, travelRadius,
                experience, qualification, bio);
        return tutorRepository.save(tutor);
    }
}