package com.tutorlink.service;
import com.tutorlink.model.Admin;
import com.tutorlink.model.User;
import com.tutorlink.repository.SubjectRepository;
import com.tutorlink.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;
// Admin service - handles admin logic
@Service
public class AdminService {
    @Autowired private UserRepository userRepository;
    @Autowired private SubjectRepository subjectRepository;
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    public List<User> getAllAdmins() {
        return userRepository.findAll().stream()
                .filter(u -> "ADMIN".equals(u.getRole()))
                .collect(Collectors.toList());
    }
    public User getAdmin(int adminId) {
        User admin = userRepository.findById(adminId).orElse(null);
        if (admin == null || !"ADMIN".equals(admin.getRole())) return null;
        return admin;
    }
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }
    public Admin createAdmin(String fullName, String email, String password, String phone) {
        Admin admin = new Admin(fullName, email, password, phone);
        return userRepository.save(admin);
    }
    public void activateUser(int userId) {
        userRepository.findById(userId).ifPresent(u -> {
            u.setStatus("ACTIVE");
            userRepository.save(u);
        });
    }
    public void deactivateUser(int userId) {
        userRepository.findById(userId).ifPresent(u -> {
            u.setStatus("INACTIVE");
            userRepository.save(u);
        });
    }
    public void deleteUser(int userId) {
        userRepository.deleteById(userId);
    }
    public long countByRole(String role) {
        return userRepository.findAll().stream()
                .filter(u -> role.equals(u.getRole()))
                .count();
    }
    public List<com.tutorlink.model.Subject> getAllSubjects() {
        return subjectRepository.findAll();
    }
}
