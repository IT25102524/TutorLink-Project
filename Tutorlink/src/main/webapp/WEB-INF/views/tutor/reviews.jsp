<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Reviews - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/tutor/reviews" class="sb-link active">
            <i class="fas fa-star"></i><span>My Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link">
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
            <h4 class="page-title">My Reviews</h4>
            <p class="page-sub">Reviews students have written about you.</p>
        </div>
    </div>

    <div class="card">
        <c:choose>
            <c:when test="${empty myReviews}">
                <div class="empty-state">
                    <span class="empty-icon"><i class="fas fa-star"></i></span>
                    <div class="empty-title">No reviews yet</div>
                    <div class="empty-desc">Complete sessions to start receiving reviews from students!</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card-header-title"><i class="fas fa-star" style="color:#f59e0b"></i> ${myReviews.size()} Reviews</div>
                <c:forEach var="r" items="${myReviews}">
                    <div class="review-item">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="d-flex align-items-center gap-3 mb-2">
                                    <div style="width:38px;height:38px;border-radius:50%;background:linear-gradient(135deg,#d1fae5,#a7f3d0);display:flex;align-items:center;justify-content:center;color:var(--t-primary);font-weight:800;font-size:0.9rem;">
                                        ${r.studentName.charAt(0)}
                                    </div>
                                    <div>
                                        <div style="font-weight:700;font-size:0.95rem;">${r.studentName}</div>
                                        <div class="stars" style="font-size:0.82rem;">
                                            <c:forEach begin="1" end="${r.rating}"><i class="fas fa-star"></i></c:forEach>
                                            <c:if test="${r.rating < 5}">
                                                <span class="stars-empty">
                                                    <c:forEach begin="${r.rating+1}" end="5"><i class="far fa-star"></i></c:forEach>
                                                </span>
                                            </c:if>
                                            <span style="color:var(--t-text-muted);font-size:0.78rem;margin-left:6px;">${r.rating}/5</span>
                                        </div>
                                    </div>
                                </div>
                                <p style="font-size:0.9rem;color:var(--t-text-sec);margin:0;line-height:1.6;">${r.comment}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
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
</script></body>
</html>
