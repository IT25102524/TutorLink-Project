package com.tutorlink.model;
import jakarta.persistence.*;

// LearningGoal - student sets personal learning targets
@Entity
@Table(name = "learning_goals")
public class LearningGoal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "goal_id")
    private int goalId;

    @Column(name = "student_id")
    private int studentId;

    @Column(name = "weekly_session_target", columnDefinition = "int default 2")
    private int weeklySessionTarget;

    @Column(name = "focus_subjects")
    private String focusSubjects;

    @Column(name = "year_set", columnDefinition = "int default 0")
    private int yearSet;

    @Column(name = "target_sessions", columnDefinition = "int default 0")
    private int targetSessions;

    @Column(name = "goal_date")
    private String goalDate;

    // transient fields - auto calculated
    @Transient private int thisWeekSessions;
    @Transient private int thisMonthSessions;
    @Transient private int totalCompletedSessions;
    @Transient private int studyStreak;
    @Transient private int progressPercentage;
    @Transient private int daysRemaining;
    @Transient private int requiredSessionsPerWeek;

    public LearningGoal() {

    }

    // weekly progress percentage
    public int getWeeklyProgressPercentage() {
        if (weeklySessionTarget <= 0) return 0;
        int pct = (thisWeekSessions * 100) / weeklySessionTarget;
        return Math.min(pct, 100);
    }

    // check if weekly target met
    public boolean isWeeklyTargetMet() {
        return thisWeekSessions >= weeklySessionTarget;
    }

    // goal summary for display
    public String getGoalSummary() {
        return "Weekly Target: " + weeklySessionTarget + " sessions | Focus: " + focusSubjects;
    }

    // returns overall goal progress status label
    public String getProgressStatus() {
        if (progressPercentage == 0) return "Not Started";
        if (progressPercentage >= 100) return "Completed";
        if (progressPercentage >= 80) return "Almost Complete";
        return "In Progress";
    }

    // returns a contextual auto-generated message based on progress
    public String getAutoMessage() {
        if (targetSessions <= 0) return "";
        if (progressPercentage >= 100) return "Congratulations! You have completed your goal!";
        if (daysRemaining >= 0 && daysRemaining <= 21)
            return "Deadline is near! Book " + (targetSessions - totalCompletedSessions) + " more session(s) before your goal date.";
        if (progressPercentage >= 80)
            return "Almost there! Just " + (targetSessions - totalCompletedSessions) + " more session(s) to go.";
        if (progressPercentage > 0)
            return "Good progress! You completed " + totalCompletedSessions + " of " + targetSessions + " sessions. Keep going!";
        return "Start booking sessions to begin working towards your goal.";
    }

    // Setters and Getters

    // returns true if the goal deadline is within 21 days
    public boolean isDeadlineNear() {
        return daysRemaining >= 0 && daysRemaining <= 21;
    }

    public int getGoalId() {
        return goalId;
    }

    public void setGoalId(int goalId) {
        this.goalId = goalId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getWeeklySessionTarget() {
        return weeklySessionTarget;
    }

    public void setWeeklySessionTarget(int weeklySessionTarget) {
        this.weeklySessionTarget = weeklySessionTarget;
    }

    public String getFocusSubjects() {
        return focusSubjects;
    }

    public void setFocusSubjects(String focusSubjects) {
        this.focusSubjects = focusSubjects;
    }

    public int getYearSet() {
        return yearSet;
    }

    public void setYearSet(int yearSet) {
        this.yearSet = yearSet;
    }

    public int getTargetSessions() {
        return targetSessions;
    }

    public void setTargetSessions(int targetSessions) {
        this.targetSessions = targetSessions;
    }

    public String getGoalDate() {
        return goalDate;
    }

    public void setGoalDate(String goalDate) {
        this.goalDate = goalDate;
    }

    public int getThisWeekSessions() {
        return thisWeekSessions;
    }

    public void setThisWeekSessions(int thisWeekSessions) {
        this.thisWeekSessions = thisWeekSessions;
    }

    public int getThisMonthSessions() {
        return thisMonthSessions;
    }

    public void setThisMonthSessions(int thisMonthSessions) {
        this.thisMonthSessions = thisMonthSessions;
    }

    public int getTotalCompletedSessions() {
        return totalCompletedSessions;
    }

    public void setTotalCompletedSessions(int totalCompletedSessions) {
        this.totalCompletedSessions = totalCompletedSessions;
    }

    public int getStudyStreak() {
        return studyStreak;
    }

    public void setStudyStreak(int studyStreak) {
        this.studyStreak = studyStreak;
    }

    public int getProgressPercentage() {
        return progressPercentage;
    }

    public void setProgressPercentage(int progressPercentage) {
        this.progressPercentage = progressPercentage;
    }

    public int getDaysRemaining() {
        return daysRemaining;
    }

    public void setDaysRemaining(int daysRemaining) {
        this.daysRemaining = daysRemaining;
    }

    public int getRequiredSessionsPerWeek() {
        return requiredSessionsPerWeek;
    }

    public void setRequiredSessionsPerWeek(int requiredSessionsPerWeek) {
        this.requiredSessionsPerWeek = requiredSessionsPerWeek;
    }
}
