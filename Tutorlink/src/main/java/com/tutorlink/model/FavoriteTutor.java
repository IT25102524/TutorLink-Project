package com.tutorlink.model;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// FavoriteTutor model - student saves tutors they like (encapsulation)
@Entity
@Table(name = "favorite_tutors")
public class FavoriteTutor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "favorite_id")
    private int favoriteId;

    @Column(name = "student_id", nullable = false)
    private int studentId;

    @Column(name = "tutor_id", nullable = false)
    private int tutorId;

    @Column(name = "created_at")
    private String createdAt;

    // transient fields - loaded from related entities
    @Transient
    private String tutorName;

    @Transient
    private String tutorSubject;

    @Transient
    private String tutorDistrict;

    @Transient
    private int tutorOnlineRate;

    @Transient
    private int tutorHomeVisitRate;

    @Transient
    private String tutorExperience;

    @Transient
    private String tutorBio;

    public FavoriteTutor() {
        this.createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public FavoriteTutor(int studentId, int tutorId) {
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    // formatted date for display
    public String getFormattedDate() {
        if (createdAt == null) return "";
        return createdAt;
    }

    // summary for display
    public String getFavoriteSummary() {
        return tutorName + " | " + tutorSubject + " | " + tutorDistrict;
    }

    public int getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(int favoriteId) {
        this.favoriteId = favoriteId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getTutorId() {
        return tutorId;
    }

    public void setTutorId(int tutorId) {
        this.tutorId = tutorId;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getTutorName() {
        return tutorName;
    }

    public void setTutorName(String tutorName) {
        this.tutorName = tutorName;
    }

    public String getTutorSubject() {
        return tutorSubject;
    }

    public void setTutorSubject(String tutorSubject) {
        this.tutorSubject = tutorSubject;
    }

    public String getTutorDistrict() {
        return tutorDistrict;
    }

    public void setTutorDistrict(String tutorDistrict) {
        this.tutorDistrict = tutorDistrict;
    }

    public int getTutorOnlineRate() {
        return tutorOnlineRate;
    }

    public void setTutorOnlineRate(int tutorOnlineRate) {
        this.tutorOnlineRate = tutorOnlineRate;
    }

    public int getTutorHomeVisitRate() {
        return tutorHomeVisitRate;
    }

    public void setTutorHomeVisitRate(int tutorHomeVisitRate) {
        this.tutorHomeVisitRate = tutorHomeVisitRate;
    }

    public String getTutorExperience() {
        return tutorExperience;
    }

    public void setTutorExperience(String tutorExperience) {
        this.tutorExperience = tutorExperience;
    }

    public String getTutorBio() {
        return tutorBio;
    }

    public void setTutorBio(String tutorBio) {
        this.tutorBio = tutorBio;
    }

}
