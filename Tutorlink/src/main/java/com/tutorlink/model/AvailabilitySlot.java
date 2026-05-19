package com.tutorlink.model;
import jakarta.persistence.*;
// AvailabilitySlot model class - linked to a specific tutor subject
@Entity
@Table(name = "availability_slots")
public class AvailabilitySlot { // AvailabilitySlot class
    //Attributes
    // encapsulation - private variables

    @Id //primary key

    @GeneratedValue(strategy = GenerationType.IDENTITY)//GenerationType.IDENTITY - Uses MySQL AUTO_INCREMENT.

    //ENCAPSULATION - data hiding using private
    @Column(name = "slot_id")
    private int slotId;

    @Column(name = "tutor_id", columnDefinition = "int default 0")
    private int tutorId;

    @Column(name = "tutor_subject_id", columnDefinition = "int default 0")
    private int tutorSubjectId;

    @Column(name = "day")
    private String day;

    @Column(name = "start_time")
    private String startTime;

    @Column(name = "end_time")
    private String endTime;

    @Column(name = "medium")
    private String medium;

    @Column(name = "status", columnDefinition = "varchar(20) default 'ACTIVE'")
    private String status = "ACTIVE";

    // transient - Used only display purposes. not in database
    @Transient
    private String subjectName;

    public AvailabilitySlot() { //Default Constructor

    }
    //Parameterized Constructor
    public AvailabilitySlot(int tutorId, int tutorSubjectId, String day,
                            String startTime, String endTime, String medium) {

        //assign values to object variables
        this.tutorId = tutorId;
        this.tutorSubjectId = tutorSubjectId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.day = day;
        this.medium = medium;
        this.status = "ACTIVE"; //set default status when object is created
    }
    // information hiding - Returns formatted slot details
    public String getFormattedSlot() {
        return day + "  " + startTime + " - " + endTime
                + (medium != null ? " (" + medium + ")" : "");
        // Monday 8.00AM - 10.00AM (Online) 
    }
    // abstraction - check slot validity
    public boolean isValidSlot() {
        return day != null && startTime != null && endTime != null && !startTime.equals(endTime);
    }
    // information hiding - check if slot is active
    public boolean isAvailable() {
        return "ACTIVE".equalsIgnoreCase(status);
    }
    public int getSlotId()   {
        return slotId;
    }
    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }
    public int getTutorId()  {
        return tutorId;
    }
    public void setTutorId(int tutorId) {
        this.tutorId = tutorId;
    }
    public int getTutorSubjectId() {
        return tutorSubjectId;
    }
    public void setTutorSubjectId(int tutorSubjectId) {
        this.tutorSubjectId = tutorSubjectId;
    }
    public String getDay() {
        return day;
    }
    public void setDay(String day) {
        this.day = day;
    }
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    public String getMedium() {
        return medium;
    }
    public void setMedium(String medium) {
        this.medium = medium;
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
}


