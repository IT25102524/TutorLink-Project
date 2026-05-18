package com.tutorlink.model;
import jakarta.persistence.*;


@Entity
@Table(name = "subjects")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "subject_type", discriminatorType = DiscriminatorType.STRING)
public abstract class Subject {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "subject_id")
    private int subjectId;
    @Column(name = "name")
    private String name;
    @Column(name = "grade_level")
    private String gradeLevel;
    @Column(name = "medium")
    private String medium;
    @Column(name = "category")
    private String category;
    @Column(name = "status", columnDefinition = "varchar(20) default 'ACTIVE'")
    private String status = "ACTIVE";

    public Subject() {

    }

    public Subject(String name, String gradeLevel) {
        this.name = name;
        this.gradeLevel = gradeLevel;
        this.status = "ACTIVE";
    }

    // subclasses return subject type
    public abstract String getSubjectType();

    //subclasses return display info
    public abstract String getDisplayInfo();

    // format subject info with medium and category
    public String getSubjectInfo() {
        return name + " | " + getSubjectType() + " | " + medium + " | " + category;
    }

    //check if subject is active
    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGradeLevel() {
        return gradeLevel;
    }

    public void setGradeLevel(String gradeLevel) {
        this.gradeLevel = gradeLevel;
    }

    public String getMedium() {
        return medium;
    }

    public void setMedium(String medium) {
        this.medium = medium;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
