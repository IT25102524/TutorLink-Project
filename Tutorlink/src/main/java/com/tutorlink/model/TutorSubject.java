package com.tutorlink.model;
import jakarta.persistence.*;
// TutorSubject model - one tutor can teach many subjects
@Entity  //Converts class into database entity

@Table(name = "tutor_subjects")

public class TutorSubject { //create the TutorSubject class

    // ENCAPSULATION - private attributes protect data from direct access
    @Id //primary key of the table

    @GeneratedValue(strategy = GenerationType.IDENTITY) //auto increment ID

    @Column(name = "tutor_subject_id") //maps to tutor_id column
    private int tutorSubjectId; //stores subject ID

    @Column(name = "tutor_id")
    private int tutorId;

    @Column(name = "subject_id")
    private int subjectId;

    @Column(name = "medium")
    private String medium;

    @Column(name = "teaching_mode")
    private String teachingMode;

    @Column(name = "online_hourly_rate", columnDefinition = "int default 0")
    private int onlineHourlyRate;

    @Column(name = "home_visit_hourly_rate", columnDefinition = "int default 0")
    private int homeVisitHourlyRate;

    @Column(name = "status", columnDefinition = "varchar(20) default 'ACTIVE'")
    private String status = "ACTIVE";

    //ABSTRACTION - temporary values used only for display
    @Transient // transient - not saved in database. temporary fields only for display
    private String subjectName;

    @Transient
    private String subjectType; //store subject type temporary

    //Default constructor
    public TutorSubject() {

    }
    //Parameterized Constructor
    public TutorSubject(int tutorId, int subjectId, String medium,
                        String teachingMode, int onlineHourlyRate, int homeVisitHourlyRate) {
        //assign objects
        this.tutorId = tutorId;
        this.subjectId = subjectId;
        this.medium = medium;
        this.teachingMode = teachingMode;
        this.onlineHourlyRate = onlineHourlyRate;
        this.homeVisitHourlyRate = homeVisitHourlyRate;
        this.status = "ACTIVE";
    }
    // ABSTRACTION & INFORMATION HIDING
    public boolean isActive() {
        return "ACTIVE".equalsIgnoreCase(status);
    }

    // ABSTRACTION & INFORMATION HIDING
    public String getTeachingSummary() {
        return medium + " | " + teachingMode
                + " | Online Rs." + onlineHourlyRate
                + " | Home Rs." + homeVisitHourlyRate;
        //English | ONLINE | Online Rs.1500 | Home Rs.2000
    }

    //ABSTRACTION & POLYMORPHISM
    public int getRateByMode(String mode) {
        if ("ONLINE".equalsIgnoreCase(mode)) {
            return onlineHourlyRate;
        }
        return homeVisitHourlyRate;
    }

    //ENCAPSULATION - Getters and Setters
    public int getTutorSubjectId() { //gives controlled access to private variable
        return tutorSubjectId;
    }
    public void setTutorSubjectId(int tutorSubjectId) { //safely updates private variable values
        this.tutorSubjectId = tutorSubjectId;
    }
    public int getTutorId() {
        return tutorId;
    }
    public void setTutorId(int tutorId) {
        this.tutorId = tutorId;
    }
    public int getSubjectId() {
        return subjectId;
    }
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
    public String getMedium() {
        return medium;
    }
    public void setMedium(String medium) {
        this.medium = medium;
    }
    public String getTeachingMode() {
        return teachingMode;
    }
    public void setTeachingMode(String teachingMode) {
        this.teachingMode = teachingMode;
    }
    public int getOnlineHourlyRate() {
        return onlineHourlyRate;
    }
    public void setOnlineHourlyRate(int onlineHourlyRate) {
        this.onlineHourlyRate = onlineHourlyRate;
    }
    public int getHomeVisitHourlyRate() {
        return homeVisitHourlyRate;
    }
    public void setHomeVisitHourlyRate(int homeVisitHourlyRate) {
        this.homeVisitHourlyRate = homeVisitHourlyRate;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    public String getSubjectType() {
        return subjectType;
    }
    public void setSubjectType(String subjectType) {
        this.subjectType = subjectType;
    }
}

