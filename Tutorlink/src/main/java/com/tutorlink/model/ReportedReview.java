package com.tutorlink.model;
import jakarta.persistence.*;
// ReportedReview class-extends Review
@Entity
@DiscriminatorValue("REPORTED")
public class ReportedReview extends Review {
    @Column(name = "report_reason")
    private String reportReason;
    public ReportedReview() {
        super();
    }
    public ReportedReview(int studentId, int tutorId, int bookingId,
                          int rating, String comment, String reportReason) {
        super(studentId, tutorId, bookingId, rating, comment);
        this.reportReason = reportReason;
    }
    // polymorphism-override review type
    @Override
    public String getReviewType() {
        return "REPORTED";
    }
    // polymorphism-override review badge
    @Override
    public String getDisplayBadge() {
        return "Under Review";
    }
    public String getReportReason() { return reportReason; }
    public void setReportReason(String reportReason) { this.reportReason = reportReason; }
}