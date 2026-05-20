<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Profile - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link">
            <i class="fas fa-book-open"></i><span>My Subjects</span>
        </a>
        <a href="${pageContext.request.contextPath}/availability/list" class="sb-link">
            <i class="fas fa-clock"></i><span>Availability</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link active">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
    </nav>


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">
    <div class="page-header">
        <div>
            <h4 class="page-title">My Profile</h4>
            <p class="page-sub">Manage your tutor profile details.</p>
        </div>
        <a href="${pageContext.request.contextPath}/tutor/profile/edit" class="btn-tutor-primary">
            <i class="fas fa-user-edit"></i> Edit Profile
        </a>
    </div>

    <c:if test="${param.updated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Profile updated successfully!</div>
    </c:if>

    <div class="card" style="max-width:750px;">
        <div class="d-flex align-items-center gap-4 mb-4 pb-4" style="border-bottom:1px solid rgba(5,150,105,0.1);">
            <div style="width:72px;height:72px;border-radius:18px;background:linear-gradient(135deg,#059669,#34d399);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.8rem;font-weight:800;box-shadow:0 6px 20px rgba(5,150,105,0.25);">
                ${tutor.fullName.charAt(0)}
            </div>
            <div>
                <h5 style="font-weight:800;margin-bottom:5px;font-size:1.3rem;">${tutor.fullName}</h5>
                <span style="background:linear-gradient(135deg,#ecfdf5,#d1fae5);color:#059669;padding:4px 14px;border-radius:50px;font-size:0.78rem;font-weight:700;border:1px solid #a7f3d0;">
                    <i class="fas fa-chalkboard-teacher me-1"></i> TUTOR
                </span>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="info-label">Full Name</div>
                <div class="info-value">${tutor.fullName}</div>
            </div>
            <div class="col-md-6">
                <div class="info-label">Email</div>
                <div class="info-value">${tutor.email}</div>
            </div>
            <div class="col-md-6">
                <div class="info-label">Phone</div>
                <div class="info-value"><c:out value="${not empty tutor.phone ? tutor.phone : '-'}"/></div>
            </div>
            <div class="col-12">
                <div class="info-label">Teaching Subjects</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${empty tutorSubjects}">
                            <span style="color:#94a3b8;font-size:0.85rem;">No subjects added yet.
                                <a href="${pageContext.request.contextPath}/tutor/subjects/add" style="color:#059669;font-weight:700;">Add subjects</a>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <div style="display:flex;flex-wrap:wrap;gap:8px;">
                                <c:forEach var="ts" items="${tutorSubjects}">
                                    <div style="background:linear-gradient(135deg,#ecfdf5,#d1fae5);border:1px solid rgba(5,150,105,0.2);border-radius:10px;padding:6px 14px;">
                                        <div style="font-weight:700;color:#059669;font-size:0.85rem;">${ts.subjectName}</div>
                                        <div style="font-size:0.75rem;color:#64748b;margin-top:2px;">
                                            ${ts.medium} &bull;
                                            <c:choose>
                                                <c:when test="${ts.teachingMode == 'ONLINE'}">Online</c:when>
                                                <c:when test="${ts.teachingMode == 'HOME_VISIT'}">Home Visit</c:when>
                                                <c:otherwise>Both</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="col-md-6">
                <div class="info-label">District</div>
                <div class="info-value">${tutor.district}</div>
            </div>
            <c:if test="${not empty tutor.experience}">
                <div class="col-md-6">
                    <div class="info-label">Experience</div>
                    <div class="info-value">${tutor.experience}</div>
                </div>
            </c:if>

            <%-- Qualifications --%>
            <c:if test="${not empty tutor.qualification}">
                <div class="col-12">
                    <div style="background:linear-gradient(135deg,#fffbeb,#fef3c7);border-radius:12px;padding:1rem 1.4rem;border:1px solid rgba(245,158,11,0.2);display:flex;align-items:center;gap:12px;">
                        <div style="width:36px;height:36px;border-radius:10px;background:rgba(245,158,11,0.12);color:#d97706;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fas fa-certificate"></i>
                        </div>
                        <div>
                            <div style="font-size:0.75rem;font-weight:700;color:#92400e;text-transform:uppercase;letter-spacing:0.3px;">Qualifications</div>
                            <div style="font-size:0.97rem;font-weight:600;color:#0f172a;">${tutor.qualification}</div>
                        </div>
                    </div>
                </div>
            </c:if>



            <%-- Travel Radius --%>
            <c:if test="${tutor.travelRadius > 0}">
                <div class="col-12">
                    <div style="background:linear-gradient(135deg,#f0f9ff,#e0f2fe);border-radius:12px;padding:1rem 1.4rem;border:1px solid rgba(6,182,212,0.15);display:flex;align-items:center;gap:12px;">
                        <div style="width:36px;height:36px;border-radius:10px;background:rgba(6,182,212,0.12);color:#0891b2;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fas fa-route"></i>
                        </div>
                        <div>
                            <div style="font-size:0.75rem;font-weight:700;color:#64748b;text-transform:uppercase;">Travel Radius</div>
                            <div style="font-size:1rem;font-weight:800;color:#0891b2;">Willing to travel up to ${tutor.travelRadius} km</div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty tutor.bio}">
                <div class="col-12">
                    <div class="info-label">Bio</div>
                    <div class="info-value" style="font-weight:400;line-height:1.7;color:var(--t-text-sec);">${tutor.bio}</div>
                </div>
            </c:if>
        </div>

        <div style="margin-top:2rem;padding-top:1.5rem;border-top:1px solid rgba(239,68,68,0.1);">
            <p style="color:var(--t-accent-rose);font-size:0.82rem;font-weight:700;margin-bottom:0.8rem;">
                <i class="fas fa-exclamation-triangle me-1"></i> Danger Zone
            </p>
            <form action="${pageContext.request.contextPath}/tutor/delete" method="post"
                  onsubmit="return confirm('Delete your account? This cannot be undone.')">
                <button type="submit" class="btn-decline"><i class="fas fa-trash-alt"></i> Delete My Account</button>
            </form>
        </div>
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
