package com.tutorlink.service;
import com.tutorlink.model.Booking;
import com.tutorlink.model.LearningGoal;
import com.tutorlink.repository.BookingRepository;
import com.tutorlink.repository.LearningGoalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.DayOfWeek;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;

// LearningGoalService - manages student learning goals and progress
@Service
public class LearningGoalService {
    
    @Autowired private LearningGoalRepository goalRepository;
    @Autowired private BookingRepository bookingRepository;

    public LearningGoal getGoalForStudent(int studentId) {
        int currentYear = LocalDate.now().getYear();
        LearningGoal goal = goalRepository.findByStudentIdAndYearSet(studentId, currentYear).orElse(null);
        if (goal != null) {
            List<Booking> bookings = bookingRepository.findByStudentIdOrderByBookingIdDesc(studentId);
            // Calculate this week sessions (Mon-Sun of current week)
            LocalDate today = LocalDate.now();
            LocalDate weekStart = today.with(DayOfWeek.MONDAY);
            LocalDate weekEnd = today.with(DayOfWeek.SUNDAY);
            // Calculate this month sessions
            int currentMonth = today.getMonthValue();
            int thisWeek = 0, thisMonth = 0, total = 0;
            // Track which weeks had sessions (week number from year start)
            java.util.Set<Integer> weeksWithSessions = new java.util.HashSet<>();
            for (Booking b : bookings) {
                if ("COMPLETED".equals(b.getStatus())) {
                    total++;
                    try {
                        LocalDate bookingDate = LocalDate.parse(b.getBookingDate());
                        if (!bookingDate.isBefore(weekStart) && !bookingDate.isAfter(weekEnd)) thisWeek++;
                        if (bookingDate.getMonthValue() == currentMonth && bookingDate.getYear() == currentYear) thisMonth++;
                        // Get week number for streak calculation
                        int weekNum = bookingDate.get(java.time.temporal.WeekFields.ISO.weekOfWeekBasedYear());
                        int year = bookingDate.getYear();
                        weeksWithSessions.add(year * 100 + weekNum);
                    } catch (Exception ignored) {}
                }
            }
            // Calculate consecutive week streak going backwards from current week
            int streak = 0;
            LocalDate checkWeek = today;
            while (true) {
                int weekNum = checkWeek.get(java.time.temporal.WeekFields.ISO.weekOfWeekBasedYear());
                int year = checkWeek.getYear();
                if (weeksWithSessions.contains(year * 100 + weekNum)) {
                    streak++;
                    checkWeek = checkWeek.minusWeeks(1);
                } else {
                    break;
                }
            }
            goal.setThisWeekSessions(thisWeek);
            goal.setThisMonthSessions(thisMonth);
            goal.setTotalCompletedSessions(total);
            goal.setStudyStreak(streak);

            // Calculate overall progress percentage towards target sessions
            if (goal.getTargetSessions() > 0) {
                int pct = (total * 100) / goal.getTargetSessions();
                goal.setProgressPercentage(Math.min(pct, 100));
            } else {
                goal.setProgressPercentage(0);
            }

            // Calculate days remaining until goal date
            if (goal.getGoalDate() != null && !goal.getGoalDate().isEmpty()) {
                try {
                    LocalDate goalDate = LocalDate.parse(goal.getGoalDate());
                    long days = java.time.temporal.ChronoUnit.DAYS.between(today, goalDate);
                    goal.setDaysRemaining((int) days);
                } catch (Exception ignored) {
                    goal.setDaysRemaining(-1);
                }
            } else {
                goal.setDaysRemaining(-1);
            }

            // Calculate required sessions per week to meet target by goal date
            if (goal.getDaysRemaining() > 0 && goal.getTargetSessions() > total) {
                double weeksLeft = goal.getDaysRemaining() / 7.0;
                int sessionsLeft = goal.getTargetSessions() - total;
                goal.setRequiredSessionsPerWeek((int) Math.ceil(sessionsLeft / weeksLeft));
            } else {
                goal.setRequiredSessionsPerWeek(0);
            }
        }
        return goal;
    }

    // Save or update learning goal
    public void saveGoal(int studentId, int weeklyTarget, String focusSubjects, int targetSessions, String goalDate) {
        int currentYear = LocalDate.now().getYear();
        LearningGoal goal = goalRepository.findByStudentIdAndYearSet(studentId, currentYear)
                .orElse(new LearningGoal());
        goal.setStudentId(studentId);
        goal.setWeeklySessionTarget(weeklyTarget);
        goal.setFocusSubjects(focusSubjects);
        goal.setYearSet(currentYear);
        if (targetSessions > 0) goal.setTargetSessions(targetSessions);
        if (goalDate != null && !goalDate.isEmpty()) goal.setGoalDate(goalDate);
        goalRepository.save(goal);
    }

    // Delete goal
    public void deleteGoal(int studentId) {
        int currentYear = LocalDate.now().getYear();
        goalRepository.findByStudentIdAndYearSet(studentId, currentYear)
                .ifPresent(g -> goalRepository.deleteById(g.getGoalId()));
    }

    // Sessions per subject breakdown for display
    public Map<String, Integer> getSessionsBySubject(int studentId) {
        Map<String, Integer> breakdown = new LinkedHashMap<>();
        List<Booking> bookings = bookingRepository.findByStudentIdOrderByBookingIdDesc(studentId);
        for (Booking b : bookings) {
            if ("COMPLETED".equals(b.getStatus()) && b.getSubject() != null && !b.getSubject().isEmpty()) {
                breakdown.merge(b.getSubject(), 1, Integer::sum);
            }
        }
        return breakdown;
    }

    // Sessions per month for last 6 months (for chart)
    public Map<String, Integer> getSessionsPerMonth(int studentId) {
        Map<String, Integer> monthly = new java.util.LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        java.time.format.DateTimeFormatter monthFmt = java.time.format.DateTimeFormatter.ofPattern("MMM yyyy");
        // Initialize last 6 months with 0
        for (int i = 5; i >= 0; i--) {
            LocalDate month = today.minusMonths(i);
            monthly.put(month.format(monthFmt), 0);
        }
        List<Booking> bookings = bookingRepository.findByStudentIdOrderByBookingIdDesc(studentId);
        for (Booking b : bookings) {
            if ("COMPLETED".equals(b.getStatus())) {
                try {
                    LocalDate bookingDate = LocalDate.parse(b.getBookingDate());
                    String key = bookingDate.format(monthFmt);
                    if (monthly.containsKey(key)) {
                        monthly.merge(key, 1, Integer::sum);
                    }
                } catch (Exception ignored) {}
            }
        }
        return monthly;
    }
}
