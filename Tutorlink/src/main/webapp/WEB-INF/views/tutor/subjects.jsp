<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Teaching Subjects - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor.css">
</head>
<body>

<div class="sidebar">
    <div class="sb-brand">
        <div class="sb-logo"><i class="fas fa-chalkboard-teacher"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </div>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/tutor/dashboard" class="sb-link">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/bookings" class="sb-link">
            <i class="fas fa-calendar-check"></i><span>Booking Requests</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/reviews" class="sb-link">
            <i class="fas fa-star"></i><span>My Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link active">
            <i class="fas fa-book-open"></i><span>My Subjects</span>
        </a>
        <a href="${pageContext.request.contextPath}/availability/list" class="sb-link">
            <i class="fas fa-clock"></i><span>Availability</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
    </nav>


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout">
        <i class="fas fa-sign-out-alt"></i><span>Logout</span>
    </a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">My Teaching Subjects</h4>
            <p class="page-sub">Manage the subjects you teach, your medium, mode, and rates.</p>
        </div>
        <a href="${pageContext.request.contextPath}/tutor/subjects/add" class="btn-tutor-primary">
            <i class="fas fa-plus"></i> Add Subject
        </a>
    </div>

    <c:if test="${param.added == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Subject added successfully!</div>
    </c:if>
    <c:if test="${param.updated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Subject updated!</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Subject removed!</div>
    </c:if>

    <div class="card">
        <c:choose>
            <c:when test="${empty tutorSubjects}">
                <div class="empty-state">
                    <span class="empty-icon"><i class="fas fa-book-open"></i></span>
                    <div class="empty-title">No teaching subjects yet</div>
                    <div class="empty-desc">Add the subjects you teach so students can find and book you.</div>
                    <a href="${pageContext.request.contextPath}/tutor/subjects/add" class="btn-tutor-primary">
                        <i class="fas fa-plus"></i> Add First Subject
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card-header-title"><i class="fas fa-book-open" style="color:var(--t-primary)"></i> Subjects You Teach</div>
                <div class="table-responsive mt-3">
                    <table class="table" style="color:var(--t-text);">
                        <thead>
                            <tr style="border-bottom:1px solid rgba(5,150,105,0.15);">
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Subject</th>
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Type</th>
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Medium</th>
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Mode</th>
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Online Rate</th>
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Home Rate</th>
                                <th style="color:var(--t-text-muted);font-weight:700;font-size:0.82rem;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ts" items="${tutorSubjects}">
                                <tr style="border-bottom:1px solid rgba(5,150,105,0.07);">
                                    <td style="font-weight:700;">${ts.subjectName}</td>
                                    <td style="color:var(--t-text-sec);font-size:0.85rem;">${ts.subjectType}</td>
                                    <td><span style="background:rgba(5,150,105,0.1);color:var(--t-primary);padding:3px 10px;border-radius:6px;font-size:0.8rem;font-weight:700;">${ts.medium}</span></td>
                                    <td style="color:var(--t-text-sec);font-size:0.85rem;">${ts.teachingMode}</td>
                                    <td style="font-weight:600;">Rs. ${ts.onlineHourlyRate}/hr</td>
                                    <td style="font-weight:600;">Rs. ${ts.homeVisitHourlyRate}/hr</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/tutor/subjects/edit/${ts.tutorSubjectId}"
                                               style="background:rgba(245,158,11,0.12);color:#f59e0b;border:1px solid rgba(245,158,11,0.3);padding:5px 12px;border-radius:8px;font-size:0.8rem;font-weight:700;text-decoration:none;">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/tutor/subjects/delete/${ts.tutorSubjectId}" method="post" style="display:inline;">
                                                <button style="background:transparent;border:1px solid rgba(239,68,68,0.3);color:#ef4444;padding:5px 12px;border-radius:8px;font-size:0.8rem;font-weight:700;cursor:pointer;"
                                                        onclick="return confirm('Remove this subject?')">
                                                    <i class="fas fa-trash-alt"></i> Remove
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
(function() {
    var STORAGE_KEY = 'tl_theme';
    // Clear any stale/corrupted theme value from old buggy code
    var _saved = localStorage.getItem(STORAGE_KEY);
    if (_saved !== 'light' && _saved !== 'dark') { localStorage.removeItem(STORAGE_KEY); }
    var html = document.documentElement;
    var isAdmin = document.querySelector('link[href*="admin.css"]') !== null;
    function getDefault() { return isAdmin ? 'dark' : 'light'; }
    function getOpposite(t) { return t === 'dark' ? 'light' : 'dark'; }
    function applyTheme(theme) {
        html.setAttribute('data-theme', theme);
        var icon = document.getElementById('dm-icon');
        var label = document.getElementById('dm-label');
        if (isAdmin) {
            if (icon) icon.className = theme === 'light' ? 'fas fa-moon dm-icon' : 'fas fa-sun dm-icon';
            if (label) label.textContent = theme === 'light' ? 'Dark Mode' : 'Light Mode';
        } else {
            if (icon) icon.className = theme === 'dark' ? 'fas fa-sun dm-icon' : 'fas fa-moon dm-icon';
            if (label) label.textContent = theme === 'dark' ? 'Light Mode' : 'Dark Mode';
        }
    }
    var saved = localStorage.getItem(STORAGE_KEY);
    var current = saved ? saved : getDefault();
    applyTheme(current);
    window.__tlToggleTheme = function() {
        var cur = html.getAttribute('data-theme') || getDefault(); var next = getOpposite(cur);
        localStorage.setItem(STORAGE_KEY, next);
        applyTheme(next);
    };
})();
</script>
</body>
</html>
