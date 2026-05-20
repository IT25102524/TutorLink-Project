<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Availability - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor.css">
    <style>
        .slot-item {
            padding: 1.4rem 1.6rem;
            border: 1px solid rgba(5,150,105,0.12);
            border-left: 5px solid var(--t-primary);
            border-radius: 16px;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #f8fdfb, #f0faf5);
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .slot-item:hover {
            background: #fff;
            border-left-color: var(--t-primary-dark);
            box-shadow: 0 8px 25px rgba(5,150,105,0.12);
            transform: translateX(5px);
        }
        .slot-day {
            font-weight: 800; font-size: 1.1rem; color: var(--t-text);
            margin-bottom: 6px;
        }
        .slot-subject {
            font-size: 0.9rem; font-weight: 700;
            color: var(--t-primary); margin-bottom: 6px;
            display: flex; align-items: center; gap: 6px;
        }
        .slot-time {
            color: var(--t-text-sec); font-size: 0.88rem; font-weight: 600;
            display: flex; align-items: center; gap: 6px; margin-bottom: 10px;
        }
        .slot-time i { color: var(--t-primary); }
        .slot-badges { display: flex; gap: 8px; flex-wrap: wrap; }
        .badge-medium {
            padding: 3px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700;
            background: rgba(251,191,36,0.15); color: #d97706;
            border: 1px solid rgba(251,191,36,0.3);
        }
        .badge-mode {
            padding: 3px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700;
            background: rgba(59,130,246,0.12); color: #3b82f6;
            border: 1px solid rgba(59,130,246,0.25);
        }
        .btn-edit {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 1px solid #fcd34d; color: #92400e;
            padding: 7px 16px; border-radius: 10px;
            font-size: 0.82rem; font-weight: 700; cursor: pointer;
            transition: all 0.3s; text-decoration: none;
            display: inline-flex; align-items: center; gap: 5px;
            font-family: 'Inter', sans-serif;
        }
        .btn-edit:hover {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: #fff; border-color: transparent;
            box-shadow: 0 4px 15px rgba(245,158,11,0.3);
            transform: translateY(-2px);
        }
        .btn-remove {
            background: transparent;
            border: 1.5px solid #fca5a5; color: #ef4444;
            padding: 7px 16px; border-radius: 10px;
            font-size: 0.82rem; font-weight: 700; cursor: pointer;
            transition: all 0.3s;
            display: inline-flex; align-items: center; gap: 5px;
            font-family: 'Inter', sans-serif;
        }
        .btn-remove:hover {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: #fff; border-color: transparent;
            box-shadow: 0 4px 15px rgba(239,68,68,0.3);
            transform: translateY(-2px);
        }
    </style>
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
        <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link">
            <i class="fas fa-book-open"></i><span>My Subjects</span>
        </a>
        <a href="${pageContext.request.contextPath}/availability/list" class="sb-link active">
            <i class="fas fa-clock"></i><span>Availability</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile/edit" class="sb-link">
            <i class="fas fa-user-edit"></i><span>Edit Profile</span>
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
            <h4 class="page-title">My Availability</h4>
            <p class="page-sub">Set your available days and times for students to see.</p>
        </div>
        <a href="${pageContext.request.contextPath}/availability/add" class="btn-tutor-primary">
            <i class="fas fa-plus"></i> Add Slot
        </a>
    </div>

    <c:if test="${param.added == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Availability slot added!</div>
    </c:if>
    <c:if test="${param.updated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Slot updated!</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Slot removed!</div>
    </c:if>

    <div class="card">
        <c:choose>
            <c:when test="${empty slots}">
                <div class="empty-state">
                    <span class="empty-icon"><i class="fas fa-clock"></i></span>
                    <div class="empty-title">No availability slots yet</div>
                    <div class="empty-desc">Add your available times so students can book sessions with you!</div>
                    <a href="${pageContext.request.contextPath}/availability/add" class="btn-tutor-primary">
                        <i class="fas fa-plus"></i> Add First Slot
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card-header-title"><i class="fas fa-calendar-week" style="color:var(--t-primary)"></i> Your Schedule</div>
                <c:forEach var="s" items="${slots}">
                    <div class="slot-item">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <div class="slot-day">${s.day}</div>
                                <c:if test="${not empty s.subjectName}">
                                    <div class="slot-subject">
                                        <i class="fas fa-book" style="font-size:0.8rem;"></i>
                                        ${s.subjectName}
                                    </div>
                                </c:if>
                                <div class="slot-time">
                                    <i class="far fa-clock"></i>
                                    ${s.startTime} – ${s.endTime}
                                </div>
                                <div class="slot-badges">
                                    <c:if test="${not empty s.medium}">
                                        <span class="badge-medium">
                                            <i class="fas fa-language" style="font-size:0.7rem;"></i>
                                            ${s.medium}
                                        </span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="d-flex gap-2 ms-3 flex-shrink-0">
                                <a href="${pageContext.request.contextPath}/availability/edit/${s.slotId}" class="btn-edit">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <form action="${pageContext.request.contextPath}/availability/delete/${s.slotId}" method="post" style="display:inline;">
                                    <button class="btn-remove" onclick="return confirm('Remove this slot?')">
                                        <i class="fas fa-trash-alt"></i> Remove
                                    </button>
                                </form>
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
</script>
</body>
</html>
