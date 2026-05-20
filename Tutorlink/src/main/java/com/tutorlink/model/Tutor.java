package com.tutorlink.model;
import jakarta.persistence.*;

@Entity // Represents a DataBase Table

@DiscriminatorValue("TUTOR") // Tells the database this object is a Tutor

public class Tutor extends User { //Tutor class inherit from user (OOP concept - INHERITANCE)
    //Attributes
//private - Variable accessible only inside class
//@column - Maps variable to database column
    //OOP concept - Encapsulation (private attributes)
    @Column(name = "subject")
    private String subject; //stores subject

    @Column(name = "district")
    private String district; //stores district

    // columnDefinition = "int default 0" - Sets default value as 0 in the database
    @Column(name = "hourly_rate", columnDefinition = "int default 0")
    private int hourlyRate; //stores hourly rate

    @Column(name = "online_hourly_rate", columnDefinition = "int default 0")
    private int onlineHourlyRate;

    @Column(name = "home_visit_hourly_rate", columnDefinition = "int default 0")
    private int homeVisitHourlyRate;

    @Column(name = "travel_radius", columnDefinition = "int default 0")
    private int travelRadius;

    @Column(name = "experience")
    private String experience;

    @Column(name = "qualification")
    private String qualification;

    //columnDefinition = "TEXT" - Stores long text data for tutor description
    @Column(name = "bio", columnDefinition = "TEXT")
    private String bio;

    @Column(name = "bank_name")
    private String bankName;

    @Column(name = "account_holder_name")
    private String accountHolderName;

    @Column(name = "account_number")
    private String accountNumber;

    @Column(name = "branch")
    private String branch;

    public boolean hasBankDetails() { //hasBankDetails() method

        //OOP Concept - Abstraction (hiding complex bank field validations inside one method and showing only true/false result)
        return bankName != null && !bankName.isEmpty() // Checks whether bank name is not empty or null
                && accountHolderName != null && !accountHolderName.isEmpty()
                && accountNumber != null && !accountNumber.isEmpty()
                && branch != null && !branch.isEmpty();
    }
    // OOP Concept - INHERITANCE (Child class uses parent class constructor and properties)
    public Tutor() {//Default Constructor
        super();//calls the parent class (user) constructor
    }

    public Tutor(String fullName, String email, String password, String phone,
                 String subject, String district, int onlineHourlyRate,
                 int homeVisitHourlyRate, int travelRadius,
                 String experience, String qualification, String bio) { //parameterized constructor

        super(fullName, email, password, phone); //Calls parent class constructor

        //this - current object variable
        this.subject = subject;
        this.district = district;
        this.onlineHourlyRate = onlineHourlyRate;
        this.homeVisitHourlyRate = homeVisitHourlyRate;
        this.hourlyRate = homeVisitHourlyRate;
        this.travelRadius = travelRadius;
        this.experience = experience;
        this.qualification = qualification;
        this.bio = bio;
    }
    //OOP concept - POLYMORPHISM (Method Overriding)
    // @Override - Overrides the parent class method with new implementation
    @Override public String getDashboardPage() {
        return "tutor/dashboard"; //return dashboard page path
    }
    @Override
    public String getProfileSummary() {
        String subjectPart = (subject != null && !subject.isEmpty()) ? subject + " Tutor" : "Tutor"; return subjectPart + " | Online: Rs." + getEffectiveOnlineRate() + " | Home: Rs." + getEffectiveHomeVisitRate() + "/hr | " + district;
    }
    public String getTutorSummary() {
        String subjectPart = (subject != null && !subject.isEmpty()) ? subject + " | " : ""; return getFullName() + " | " + subjectPart + "Rs." + getEffectiveHomeVisitRate() + "/hr | " + district; //ternary operator
    }
    //OOP concept - ENCAPSULATION (using getters and setters because variables are private)
    public int getEffectiveOnlineRate() {
        return onlineHourlyRate > 0    ? onlineHourlyRate    : hourlyRate;
    }
    public int getEffectiveHomeVisitRate() {
        return homeVisitHourlyRate > 0 ? homeVisitHourlyRate : hourlyRate;
    }
    public int getTutorId() { //Getter Method - Reads variable value
        return getUserId();
    }
    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject){ //Setter - Updates variable value
        this.subject = subject;
    }
    public String getDistrict() {
        return district;
    }
    public void setDistrict(String district){
        this.district = district;
    }
    public int getHourlyRate(){
        return hourlyRate;
    }
    public void setHourlyRate(int hourlyRate){
        this.hourlyRate = hourlyRate;
    }
    public int getOnlineHourlyRate(){
        return onlineHourlyRate;
    }
    public void setOnlineHourlyRate(int onlineHourlyRate) {
        this.onlineHourlyRate = onlineHourlyRate;
    }
    public int getHomeVisitHourlyRate(){
        return homeVisitHourlyRate;
    }
    public void setHomeVisitHourlyRate(int v){
        this.homeVisitHourlyRate = v; this.hourlyRate = v;
    }
    public int getTravelRadius(){
        return travelRadius;
    }
    public void setTravelRadius(int travelRadius){
        this.travelRadius = travelRadius;
    }
    public String getExperience() {
        return experience;
    }
    public void setExperience(String experience){
        this.experience = experience;
    }
    public String getQualification(){
        return qualification;
    }
    public void setQualification(String qualification){
        this.qualification = qualification;
    }
    public String getBio(){
        return bio;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }
    public String getBankName() {
        return bankName;
    }
    public void setBankName(String bankName) {
        this.bankName = bankName;
    }
    public String getAccountHolderName() {
        return accountHolderName;
    }
    public void setAccountHolderName(String accountHolderName){
        this.accountHolderName = accountHolderName;
    }
    public String getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(String accountNumber){
        this.accountNumber = accountNumber;
    }
    public String getBranch() {
        return branch;
    }
    public void setBranch(String branch) {
        this.branch = branch;
    }
}
