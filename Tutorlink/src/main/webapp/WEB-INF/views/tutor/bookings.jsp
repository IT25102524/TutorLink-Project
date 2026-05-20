<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Booking Requests - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/tutor/bookings" class="sb-link active">
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
            <h4 class="page-title">Booking Requests</h4>
            <p class="page-sub">All student session requests for you.</p>
        </div>
    </div>

    <c:if test="${param.confirmed == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Booking confirmed successfully!</div>
    </c:if>
    <c:if test="${param.completed == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Booking marked as completed!</div>
    </c:if>

    <div class="card">
        <c:choose>
            <c:when test="${empty myBookings}">
                <div class="empty-state">
                    <span class="empty-icon"><i class="fas fa-calendar-xmark"></i></span>
                    <div class="empty-title">No booking requests yet</div>
                    <div class="empty-desc">Complete your profile to get discovered by students!</div>
                    <a href="${pageContext.request.contextPath}/tutor/profile/edit" class="btn-tutor-primary">
                        <i class="fas fa-user-edit"></i> Complete Profile
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="b" items="${myBookings}">
                    <div class="booking-item">
                        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                            <div>
                                <div class="booking-subject">${b.subject}</div>
                                <div class="booking-meta">Student: <strong>${b.studentName}</strong> <span class="badge bg-secondary ms-2" style="font-size: 0.72rem; padding: 4px 8px; vertical-align: middle;">Grade ${b.studentGrade}</span>
                                    <button type="button" class="btn btn-sm ms-2" style="background:linear-gradient(135deg,#4f46e5,#7c3aed);color:#fff;font-size:0.72rem;font-weight:700;padding:4px 12px;border-radius:8px;border:none;cursor:pointer;" data-bs-toggle="modal" data-bs-target="#studentModal${b.bookingId}">
                                        <i class="fas fa-user-circle me-1"></i>View Profile
                                    </button>
                                </div>
                                <div class="d-flex flex-wrap gap-2 mt-2 mb-1">
                                    <span style="background: #f8fafc; color: #475569; padding: 5px 12px; border-radius: 8px; font-size: 0.82rem; font-weight: 600; border: 1px solid #e2e8f0; display: inline-flex; align-items: center;">
                                        <i class="far fa-calendar-alt text-primary me-2"></i>${b.bookingDate}
                                    </span>
                                    <span style="background: #f8fafc; color: #475569; padding: 5px 12px; border-radius: 8px; font-size: 0.82rem; font-weight: 600; border: 1px solid #e2e8f0; display: inline-flex; align-items: center;">
                                        <i class="far fa-clock text-warning me-2"></i>${b.timeSlot}
                                    </span>
                                    <span style="background: ${b.mode == 'ONLINE' ? '#eff6ff' : '#ecfdf5'}; color: ${b.mode == 'ONLINE' ? '#1d4ed8' : '#047857'}; padding: 5px 12px; border-radius: 8px; font-size: 0.82rem; font-weight: 700; border: 1px solid ${b.mode == 'ONLINE' ? '#bfdbfe' : '#a7f3d0'}; display: inline-flex; align-items: center;">
                                        <i class="fas ${b.mode == 'ONLINE' ? 'fa-laptop' : 'fa-home'} me-2"></i>${b.mode == 'ONLINE' ? 'Online' : 'Home Visit'}
                                    </span>
                                </div>
                                <c:if test="${not empty b.notes}">
                                    <div style="color:var(--t-text-muted);font-size:0.82rem;margin-top:4px;">
                                        <i class="fas fa-sticky-note me-1"></i>${b.notes}
                                    </div>
                                </c:if>
                            </div>
                            <div class="d-flex gap-2 flex-wrap align-items-center">
                                <span class="status-badge badge-${b.status}">${b.status}</span>
                                <c:if test="${b.status == 'PENDING'}">
                                    <form action="${pageContext.request.contextPath}/tutor/booking/confirm/${b.bookingId}" method="post" style="display:inline;">
                                        <button class="btn-confirm"><i class="fas fa-check"></i> Confirm</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/tutor/booking/decline/${b.bookingId}" method="post" style="display:inline;">
                                        <button class="btn-decline"><i class="fas fa-times"></i> Decline</button>
                                    </form>
                                </c:if>
                                <c:if test="${b.status == 'CONFIRMED'}">
                                    <form action="${pageContext.request.contextPath}/tutor/booking/complete/${b.bookingId}" method="post" style="display:inline;">
                                        <button class="btn-complete"><i class="fas fa-check-double"></i> Mark Complete</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div><%-- end .card --%>

</div><%-- end .main-content --%>

<%-- Modals rendered here — outside ALL transformed ancestors, directly before
</body> --%>
<c:forEach var="b" items="${myBookings}">
    <%-- Student Profile Modal --%>
    <div class="modal fade" id="studentModal${b.bookingId}" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width:500px;">
            <div class="modal-content" style="border:none;border-radius:20px;overflow:hidden;box-shadow:0 20px 60px rgba(0,0,0,0.2);">
                <div class="modal-header p-0 border-0">
                    <div style="width:100%;background:linear-gradient(135deg,#312e81,#4f46e5,#7c3aed);padding:1.5rem 1.5rem 3rem;position:relative;text-align:center;">
                        <button type="button" class="btn-close btn-close-white" style="position:absolute;top:14px;right:14px;z-index:10;opacity:1;" data-bs-dismiss="modal" aria-label="Close"></button>
                        <div style="font-size:0.65rem;font-weight:800;text-transform:uppercase;letter-spacing:0.15em;color:rgba(255,255,255,0.5);margin-bottom:1rem;">
                            <i class="fas fa-id-card me-1"></i>Student Profile
                        </div>
                        <div style="width:80px;height:80px;border-radius:50%;background:rgba(255,255,255,0.2);display:flex;align-items:center;justify-content:center;font-size:2rem;font-weight:800;color:#fff;border:3px solid rgba(255,255,255,0.3);margin:0 auto 0.8rem;">
                                ${b.studentName.substring(0,1).toUpperCase()}
                        </div>
                        <h5 style="margin:0 0 4px;color:#fff;font-weight:800;font-size:1.25rem;">${b.studentName}</h5>
                        <span style="display:inline-flex;align-items:center;gap:5px;background:rgba(255,255,255,0.15);color:rgba(255,255,255,0.9);padding:4px 14px;border-radius:99px;font-size:0.75rem;font-weight:700;">
                                            <i class="fas fa-graduation-cap"></i> Grade ${b.studentGrade}
                                        </span>
                    </div>
                </div>
                <div class="modal-body p-0" style="background:#f1f5f9;margin-top:-1.2rem;border-radius:16px 16px 0 0;position:relative;z-index:2;">
                    <div style="padding:1.5rem;">
                        <div style="font-size:0.68rem;font-weight:800;text-transform:uppercase;letter-spacing:0.1em;color:#6366f1;margin-bottom:10px;"><i class="fas fa-address-book me-1"></i>Contact Information</div>
                        <c:if test="${not empty b.studentEmail}">
                            <div style="display:flex;align-items:center;gap:12px;padding:10px 14px;background:#fff;border-radius:12px;border:1px solid #e2e8f0;margin-bottom:8px;">
                                <div style="width:32px;height:32px;border-radius:8px;background:#4f46e5;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="fas fa-envelope" style="color:#fff;font-size:0.75rem;"></i></div>
                                <div><div style="font-size:0.62rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Email</div><div style="font-size:0.85rem;font-weight:700;color:#1e1b4b;">${b.studentEmail}</div></div>
                            </div>
                        </c:if>
                        <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;">
                            <c:if test="${not empty b.studentPhone}">
                                <div style="display:flex;align-items:center;gap:10px;padding:10px 12px;background:#fff;border-radius:12px;border:1px solid #e2e8f0;">
                                    <div style="width:32px;height:32px;border-radius:8px;background:#059669;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="fas fa-phone-alt" style="color:#fff;font-size:0.75rem;"></i></div>
                                    <div><div style="font-size:0.62rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Phone</div><div style="font-size:0.85rem;font-weight:700;color:#064e3b;">${b.studentPhone}</div></div>
                                </div>
                            </c:if>
                            <c:if test="${not empty b.studentDistrict}">
                                <div style="display:flex;align-items:center;gap:10px;padding:10px 12px;background:#fff;border-radius:12px;border:1px solid #e2e8f0;">
                                    <div style="width:32px;height:32px;border-radius:8px;background:#e11d48;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="fas fa-map-marker-alt" style="color:#fff;font-size:0.75rem;"></i></div>
                                    <div><div style="font-size:0.62rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">District</div><div style="font-size:0.85rem;font-weight:700;color:#881337;">${b.studentDistrict}</div></div>
                                </div>
                            </c:if>
                        </div>
                        <c:if test="${not empty b.studentAddress}">
                            <div style="display:flex;align-items:center;gap:12px;padding:10px 14px;background:#fff;border-radius:12px;border:1px solid #e2e8f0;margin-top:8px;">
                                <div style="width:32px;height:32px;border-radius:8px;background:#d97706;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="fas fa-home" style="color:#fff;font-size:0.75rem;"></i></div>
                                <div><div style="font-size:0.62rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Address</div><div style="font-size:0.85rem;font-weight:700;color:#78350f;">${b.studentAddress}</div></div>
                            </div>
                        </c:if>

                        <div style="font-size:0.68rem;font-weight:800;text-transform:uppercase;letter-spacing:0.1em;color:#059669;margin:16px 0 10px;"><i class="fas fa-calendar-check me-1"></i>Booking Summary</div>
                        <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;">
                            <div style="padding:10px 12px;background:#fff;border-radius:10px;border:1px solid #e2e8f0;">
                                <div style="font-size:0.6rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Subject</div>
                                <div style="font-size:0.85rem;font-weight:800;color:#1e1b4b;margin-top:2px;">${b.subject}</div>
                            </div>
                            <div style="padding:10px 12px;background:#fff;border-radius:10px;border:1px solid #e2e8f0;">
                                <div style="font-size:0.6rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Mode</div>
                                <div style="font-size:0.85rem;font-weight:800;color:#064e3b;margin-top:2px;"><i class="fas ${b.mode == 'ONLINE' ? 'fa-laptop' : 'fa-home'} me-1" style="font-size:0.7rem;"></i>${b.mode == 'ONLINE' ? 'Online' : 'Home Visit'}</div>
                            </div>
                            <div style="padding:10px 12px;background:#fff;border-radius:10px;border:1px solid #e2e8f0;">
                                <div style="font-size:0.6rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Date</div>
                                <div style="font-size:0.85rem;font-weight:800;color:#1e3a5f;margin-top:2px;">${b.bookingDate}</div>
                            </div>
                            <div style="padding:10px 12px;background:#fff;border-radius:10px;border:1px solid #e2e8f0;">
                                <div style="font-size:0.6rem;font-weight:700;color:#94a3b8;text-transform:uppercase;">Time Slot</div>
                                <div style="font-size:0.82rem;font-weight:800;color:#713f12;margin-top:2px;">${b.timeSlot}</div>
                            </div>
                        </div>
                        <c:if test="${not empty b.notes}">
                            <div style="font-size:0.68rem;font-weight:800;text-transform:uppercase;letter-spacing:0.1em;color:#7c3aed;margin:16px 0 10px;"><i class="fas fa-comment-dots me-1"></i>Student Notes</div>
                            <div style="font-size:0.85rem;color:#4b5563;line-height:1.6;background:#fff;padding:12px 14px;border-radius:12px;border:1px solid #e2e8f0;font-style:italic;">"${b.notes}"</div>
                        </c:if>
                    </div>
                </div>
                <div class="modal-footer border-0" style="background:#f1f5f9;padding:1rem 1.5rem;justify-content:space-between;">
                    <button type="button" class="btn" data-bs-dismiss="modal" style="background:#fff;color:#475569;font-weight:700;font-size:0.85rem;padding:8px 20px;border-radius:10px;border:1px solid #cbd5e1;">
                        <i class="fas fa-arrow-left me-1" style="font-size:0.75rem;"></i>Back
                    </button>
                    <span style="font-size:0.7rem;color:#94a3b8;font-weight:600;"><i class="fas fa-shield-alt me-1"></i>ID: #${b.studentId}</span>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

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
