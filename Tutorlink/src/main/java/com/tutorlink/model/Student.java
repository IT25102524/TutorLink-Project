package com.tutorlink.model;
import jakarta.persistence.*;

// Student model class - extends User
@Entity
@DiscriminatorValue("STUDENT")
public class Student extends User {

    // encapsulation - student fields
    @Column(name = "grade_level", columnDefinition = "int default 0")
    private int gradeLevel;

    @Column(name = "address")
    private String address;

    @Column(name = "district")
    private String district;

    public Student() {
        super();
    }

    public Student(String fullName, String email, String password, String phone, int gradeLevel, String address, String district) {
        super(fullName, email, password, phone);
        this.gradeLevel = gradeLevel;
        this.address = address;
        this.district = district;
    }

    // polymorphism - override dashboard page
    @Override
    public String getDashboardPage() {
        return "student/dashboard";
    }

    // polymorphism - override profile summary
    @Override
    public String getProfileSummary() {
        return "Grade " + gradeLevel + " Student | " + district;
    }

    // get student id
    public int getStudentId() {
        return getUserId();
    }

    // show profile summary
    public String getFullProfile() {
        return "Name: " + getFullName() + " | Grade: " + gradeLevel + " | District: " + district;
    }

    public int getGradeLevel() {
        return gradeLevel;
    }

    public void setGradeLevel(int gradeLevel) {
        this.gradeLevel = gradeLevel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

}
