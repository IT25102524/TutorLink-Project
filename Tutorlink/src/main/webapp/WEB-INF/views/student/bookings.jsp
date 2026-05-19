<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Bookings - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
</head>
<body>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-brand">
        <div class="sb-logo"><i class="fas fa-graduation-cap"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </a>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-link">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/search" class="sb-link">
            <i class="fas fa-search"></i><span>Find & Book Tutor</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/favorites" class="sb-link">
            <i class="fas fa-heart"></i><span>My Favorites</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/goals" class="sb-link">
            <i class="fas fa-chart-line"></i><span>Learning Progress</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/bookings" class="sb-link active">
            <i class="fas fa-calendar-check"></i><span>My Bookings</span>
        </a>

        <a href="${pageContext.request.contextPath}/student/reviews" class="sb-link">
            <i class="fas fa-star"></i><span>My Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
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
            <h4 class="page-title">My Bookings</h4>
            <p class="page-sub">Track all your tutor session bookings.</p>
        </div>
        <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern">
            <i class="fas fa-plus"></i> New Booking
        </a>
    </div>

    <div class="card p-4 border-0 shadow-sm" style="background: #ffffff;">
        <c:choose>
            <c:when test="${empty myBookings}">
                <div class="empty-state">
                    <i class="fas fa-calendar-xmark empty-icon"></i>
                    <div class="empty-title">No bookings yet</div>
                    <div class="empty-desc">Find a tutor and book a session to get started!</div>
                    <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern">Browse Tutors</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-flex flex-column gap-3">
                    <c:forEach var="b" items="${myBookings}">
                        <div class="list-item align-items-center">
                            <div>
                                <div class="item-title d-flex align-items-center gap-3">
                                        ${b.subject}
                                    <span class="status-badge badge-${b.status}">${b.status}</span>
                                </div>
                                <div class="item-sub mt-1">
                                    Tutor: <strong class="text-dark">${b.tutorName}</strong>
                                </div>
                                <div class="item-meta">
                                    <span><i class="far fa-calendar"></i> ${b.bookingDate}</span>
                                    <span><i class="far fa-clock"></i> ${b.timeSlot}</span>
                                    <span><i class="fas fa-video"></i> ${b.mode}</span>
                                </div>
                                <c:if test="${not empty b.notes}">
                                    <div class="mt-2 p-2 bg-light rounded text-muted small border">
                                        <i class="fas fa-sticky-note me-1 text-secondary"></i> ${b.notes}
                                    </div>
                                </c:if>
                            </div>

                            <div class="d-flex gap-2 align-items-center mt-3 mt-md-0">
                                <c:if test="${b.status == 'PENDING' || b.status == 'CONFIRMED'}">
                                    <form action="${pageContext.request.contextPath}/booking/cancel/${b.bookingId}" method="post" style="display:inline;">
                                        <button class="btn-danger-outline" onclick="return confirm('Cancel this booking?')">
                                            <i class="fas fa-times"></i> Cancel
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${b.status == 'COMPLETED'}">
                                    <a href="${pageContext.request.contextPath}/review/write/${b.bookingId}?tutorId=${b.tutorId}" class="btn-action-small" style="background:var(--warning);">
                                        <i class="fas fa-star"></i> Write Review
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
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
</script></body>
</html>
