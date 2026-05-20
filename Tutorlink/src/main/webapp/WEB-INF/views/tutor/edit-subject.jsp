<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Teaching Subject - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css">
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
            <h4 class="page-title">Edit Teaching Subject</h4>
            <p class="page-sub">Update medium, mode, and rates for this subject.</p>
        </div>
    </div>

    <div class="card" style="max-width:580px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid rgba(5,150,105,0.1);">
            <div style="width:48px;height:48px;border-radius:14px;background:linear-gradient(135deg,#f59e0b,#fbbf24);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
                <i class="fas fa-edit"></i>
            </div>
            <div>
                <div style="font-weight:700;color:var(--t-text);">Editing: ${tutorSubject.subjectName}</div>
                <div style="font-size:0.82rem;color:var(--t-text-muted);">${tutorSubject.subjectType}</div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/tutor/subjects/edit/${tutorSubject.tutorSubjectId}" method="post">
            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">Teaching Medium <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="medium" class="form-select" required>
                        <option value="Sinhala" ${tutorSubject.medium == 'Sinhala' ? 'selected' : ''}>Sinhala</option>
                        <option value="English" ${tutorSubject.medium == 'English' ? 'selected' : ''}>English</option>
                        <option value="Tamil" ${tutorSubject.medium == 'Tamil' ? 'selected' : ''}>Tamil</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Teaching Mode <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="teachingMode" class="form-select" required>
                        <option value="ONLINE" ${tutorSubject.teachingMode == 'ONLINE' ? 'selected' : ''}>Online</option>
                        <option value="HOME_VISIT" ${tutorSubject.teachingMode == 'HOME_VISIT' ? 'selected' : ''}>Home Visit</option>
                        <option value="BOTH" ${tutorSubject.teachingMode == 'BOTH' ? 'selected' : ''}>Both</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Online Hourly Rate (Rs.) <span style="color:var(--t-accent-rose)">*</span></label>
                    <input type="number" name="onlineHourlyRate" class="form-control"
                           value="${tutorSubject.onlineHourlyRate}" min="0" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Home Visit Rate (Rs.) <span style="color:var(--t-accent-rose)">*</span></label>
                    <input type="number" name="homeVisitHourlyRate" class="form-control"
                           value="${tutorSubject.homeVisitHourlyRate}" min="0" required>
                </div>
                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid rgba(5,150,105,0.1);">
                    <button type="submit" class="btn-tutor-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/tutor/subjects" class="btn-tutor-secondary">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
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
</script><script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
<script>
(function(){
    document.querySelectorAll('select.form-select').forEach(function(el){
        if (el.tomselect) return;
        new TomSelect(el, {
            create: false,
            allowEmptyOption: true,
            maxOptions: null,
            render: {
                item: function(data, escape) {
                    var text = data.text || '';
                    var parts = text.split(' | ');
                    return '<div>' + escape(parts[0]) + '</div>';
                },
                option: function(data, escape) {
                    var text = data.text || '';
                    var parts = text.split(' | ');
                    if (parts.length === 1) {
                        return '<div><span style="font-weight: 600;">' + escape(parts[0]) + '</span></div>';
                    }
                    var html = '<div><div style="font-weight: 600; font-size: 0.95rem; margin-bottom: 2px;">' + escape(parts[0]) + '</div>';
                    html += '<div style="display: flex; gap: 6px; font-size: 0.75rem;">';
                    if (parts[1]) html += '<span class="ts-pill-primary">' + escape(parts[1]) + '</span>';
                    if (parts[2]) html += '<span class="ts-pill-secondary">' + escape(parts[2]) + '</span>';
                    html += '</div></div>';
                    return html;
                }
            }
        });
    });
})();
</script>
</body>
</html>
