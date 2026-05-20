<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tutor Dashboard - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/tutor/dashboard" class="sb-link active">
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
        <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
    </nav>


    <div class="sb-user-section">
        <div class="sb-user-avatar">${sessionScope.userName.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="sb-user-name">${sessionScope.userName}</div>
            <div class="sb-user-role">Tutor</div>
        </div>
    </div>
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
            <h4 class="page-title">Welcome, <span class="highlight">${sessionScope.userName}</span> 👋</h4>
            <p class="page-sub">Your tutoring overview for today.</p>
        </div>
        <a href="${pageContext.request.contextPath}/tutor/profile/edit" class="btn-tutor-primary">
            <i class="fas fa-user-edit"></i> Update Profile
        </a>
    </div>

    <c:if test="${param.confirmed=='true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Booking confirmed successfully!</div>
    </c:if>
    <c:if test="${param.completed=='true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Booking marked as completed!</div>
    </c:if>
    <c:if test="${param.declined=='true'}">
        <div class="alert-modern alert-success"><i class="fas fa-times-circle"></i> Booking declined.</div>
    </c:if>
    <c:if test="${param.cancelled=='true'}">
        <div class="alert-modern alert-success"><i class="fas fa-ban"></i> Booking cancelled successfully.</div>
    </c:if>

    <%-- Profile completion banner - shown when key profile fields are missing --%>
    <c:if test="${(empty tutor.bio or empty tutor.qualification or empty tutor.experience) and param.dismissProfile != 'true'}">
        <div class="alert-modern" style="background:linear-gradient(135deg,rgba(234,179,8,0.12),rgba(234,179,8,0.06));border:1px solid rgba(234,179,8,0.35);border-radius:14px;padding:1rem 1.25rem;display:flex;align-items:center;justify-content:space-between;gap:1rem;margin-bottom:1.5rem;">
            <div style="display:flex;align-items:center;gap:0.85rem;">
                <div style="width:38px;height:38px;border-radius:10px;background:rgba(234,179,8,0.18);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                    <i class="fas fa-user-circle" style="color:#d97706;font-size:1.1rem;"></i>
                </div>
                <div>
                    <div style="font-weight:700;color:#d97706;font-size:0.9rem;margin-bottom:2px;">Complete Your Profile</div>
                    <div style="font-size:0.8rem;color:var(--t-text-muted);">Add your experience, qualifications, and bio so students can find and trust you.</div>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/tutor/profile/edit" style="white-space:nowrap;background:#d97706;color:#fff;border:none;padding:0.45rem 1.1rem;border-radius:8px;font-size:0.82rem;font-weight:700;text-decoration:none;">
                <i class="fas fa-pen me-1"></i> Complete Now
            </a>
        </div>
    </c:if>

    <%-- Count everything in ONE loop --%>
    <c:set var="cntPending"   value="0"/>
    <c:set var="cntConfirmed" value="0"/>
    <c:set var="cntCompleted" value="0"/>
    <c:set var="cntCancelled" value="0"/>
    <c:set var="cnt1star" value="0"/>
    <c:set var="cnt2star" value="0"/>
    <c:set var="cnt3star" value="0"/>
    <c:set var="cnt4star" value="0"/>
    <c:set var="cnt5star" value="0"/>
    <c:forEach var="b" items="${myBookings}">
        <c:if test="${b.status == 'PENDING'}">   <c:set var="cntPending"   value="${cntPending   + 1}"/></c:if>
        <c:if test="${b.status == 'CONFIRMED'}"> <c:set var="cntConfirmed" value="${cntConfirmed + 1}"/></c:if>
        <c:if test="${b.status == 'COMPLETED'}"> <c:set var="cntCompleted" value="${cntCompleted + 1}"/></c:if>
        <c:if test="${b.status == 'CANCELLED'}"> <c:set var="cntCancelled" value="${cntCancelled + 1}"/></c:if>
    </c:forEach>
    <c:forEach var="r" items="${myReviews}">
        <c:if test="${r.rating == 1}"><c:set var="cnt1star" value="${cnt1star + 1}"/></c:if>
        <c:if test="${r.rating == 2}"><c:set var="cnt2star" value="${cnt2star + 1}"/></c:if>
        <c:if test="${r.rating == 3}"><c:set var="cnt3star" value="${cnt3star + 1}"/></c:if>
        <c:if test="${r.rating == 4}"><c:set var="cnt4star" value="${cnt4star + 1}"/></c:if>
        <c:if test="${r.rating == 5}"><c:set var="cnt5star" value="${cnt5star + 1}"/></c:if>
    </c:forEach>
<div class="row g-4 mb-5">
        <div class="col-md-3 col-sm-6">
            <div class="stat-card green">
                <div class="stat-icon green"><i class="fas fa-calendar-alt"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${myBookings.size()}">0</div>
                    <div class="stat-lbl">Total Bookings</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card gold">
                <div class="stat-icon gold"><i class="fas fa-star"></i></div>
                <div class="stat-details">
                    <div class="stat-num">
                        <c:choose>
                            <c:when test="${avgRating > 0}">${avgRating}</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-lbl">Avg Rating</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card blue">
                <div class="stat-icon blue"><i class="fas fa-comment-dots"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${myReviews.size()}">0</div>
                    <div class="stat-lbl">Reviews</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card rose">
                <div class="stat-icon rose"><i class="fas fa-hourglass-half"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${cntPending}">0</div>
                    <div class="stat-lbl">Pending</div>
                </div>
            </div>
        </div>
    </div>
<div class="card mb-4">
        <h6 class="card-header-title mb-4">
            <i class="fas fa-star me-2" style="color:#f59e0b;"></i>Rating Distribution
        </h6>
        <c:choose>
            <c:when test="${empty myReviews}">
                <div class="empty-state">
                    <i class="fas fa-star empty-icon"></i>
                    <div class="empty-title">No reviews yet</div>
                    <div class="empty-desc">Your rating breakdown will appear once students review your sessions.</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row align-items-center g-4">
                    <div class="col-lg-8">
                        <div style="position:relative;height:220px;">
                            <canvas id="ratingChart"
                                    data-1="${cnt1star}"
                                    data-2="${cnt2star}"
                                    data-3="${cnt3star}"
                                    data-4="${cnt4star}"
                                    data-5="${cnt5star}"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div style="display:flex;flex-direction:column;gap:0.55rem;">
                                <%-- 5★ to 1★ top to bottom --%>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#d1fae540,#a7f3d020);border-radius:12px;border-left:4px solid #059669;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="color:#059669;font-size:0.85rem;">★★★★★</span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">5 Stars</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cnt5star}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#d1fae530,#a7f3d015);border-radius:12px;border-left:4px solid #34d399;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="color:#34d399;font-size:0.85rem;">★★★★</span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">4 Stars</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cnt4star}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#fef3c740,#fde68a20);border-radius:12px;border-left:4px solid #f59e0b;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="color:#f59e0b;font-size:0.85rem;">★★★</span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">3 Stars</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cnt3star}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#ffedd540,#fed7aa20);border-radius:12px;border-left:4px solid #f97316;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="color:#f97316;font-size:0.85rem;">★★</span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">2 Stars</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cnt2star}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#fee2e240,#fecaca20);border-radius:12px;border-left:4px solid #ef4444;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="color:#ef4444;font-size:0.85rem;">★</span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">1 Star</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cnt1star}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
<div class="card mb-5">
        <h6 class="card-header-title mb-4">
            <i class="fas fa-chart-bar me-2" style="color:#059669;"></i>Booking Status Breakdown
        </h6>
        <c:choose>
            <c:when test="${empty myBookings}">
                <div class="empty-state">
                    <i class="fas fa-chart-bar empty-icon"></i>
                    <div class="empty-title">No booking data yet</div>
                    <div class="empty-desc">Your booking breakdown will appear once you receive bookings.</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row align-items-center g-4">
                    <div class="col-lg-8">
                        <div style="position:relative;height:210px;">
                            <canvas id="bookingStatusChart"
                                    data-pending="${cntPending}"
                                    data-confirmed="${cntConfirmed}"
                                    data-completed="${cntCompleted}"
                                    data-cancelled="${cntCancelled}"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div style="display:flex;flex-direction:column;gap:0.55rem;">
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#fef3c740,#fde68a20);border-radius:12px;border-left:4px solid #f59e0b;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#f59e0b;flex-shrink:0;box-shadow:0 2px 6px rgba(245,158,11,0.4);"></span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">Pending</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cntPending}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#d1fae540,#a7f3d020);border-radius:12px;border-left:4px solid #059669;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#059669;flex-shrink:0;box-shadow:0 2px 6px rgba(5,150,105,0.4);"></span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">Confirmed</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cntConfirmed}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#dbeafe40,#bfdbfe20);border-radius:12px;border-left:4px solid #3b82f6;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#3b82f6;flex-shrink:0;box-shadow:0 2px 6px rgba(59,130,246,0.4);"></span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">Completed</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cntCompleted}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 14px;background:linear-gradient(135deg,#fee2e240,#fecaca20);border-radius:12px;border-left:4px solid #ef4444;">
                                <div style="display:flex;align-items:center;gap:9px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#ef4444;flex-shrink:0;box-shadow:0 2px 6px rgba(239,68,68,0.4);"></span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#475569;">Cancelled</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:#0f172a;">${cntCancelled}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
<div class="row g-4">
        <div id="bookings"></div>
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header-title"><i class="fas fa-inbox" style="color:var(--t-primary)"></i> Booking Requests</div>
                <c:choose>
                    <c:when test="${empty myBookings}">
                        <div class="empty-state">
                            <span class="empty-icon"><i class="fas fa-calendar-xmark"></i></span>
                            <div class="empty-title">No bookings yet</div>
                            <div class="empty-desc">Complete your profile to get discovered by students.</div>
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
                                        <div class="booking-meta">Student: <strong>${b.studentName}</strong> <span class="badge bg-secondary ms-2" style="font-size: 0.72rem; padding: 4px 8px; vertical-align: middle;">Grade ${b.studentGrade}</span></div>
                                        <div class="d-flex flex-wrap gap-2 mt-2 mb-1">
                                            <span style="background:#f8fafc;color:#475569;padding:5px 12px;border-radius:8px;font-size:0.82rem;font-weight:600;border:1px solid #e2e8f0;display:inline-flex;align-items:center;">
                                                <i class="far fa-calendar-alt text-primary me-2"></i>${b.bookingDate}
                                            </span>
                                            <span style="background:#f8fafc;color:#475569;padding:5px 12px;border-radius:8px;font-size:0.82rem;font-weight:600;border:1px solid #e2e8f0;display:inline-flex;align-items:center;">
                                                <i class="far fa-clock text-warning me-2"></i>${b.timeSlot}
                                            </span>
                                            <span style="background:${b.mode == 'ONLINE' ? '#eff6ff' : '#ecfdf5'};color:${b.mode == 'ONLINE' ? '#1d4ed8' : '#047857'};padding:5px 12px;border-radius:8px;font-size:0.82rem;font-weight:700;border:1px solid ${b.mode == 'ONLINE' ? '#bfdbfe' : '#a7f3d0'};display:inline-flex;align-items:center;">
                                                <i class="fas ${b.mode == 'ONLINE' ? 'fa-laptop' : 'fa-home'} me-2"></i>${b.mode == 'ONLINE' ? 'Online' : 'Home Visit'}
                                            </span>
                                        </div>
                                        <c:if test="${not empty b.notes}">
                                            <div style="color:var(--t-text-muted);font-size:0.82rem;margin-top:4px;"><i class="fas fa-sticky-note me-1"></i>${b.notes}</div>
                                        </c:if>
                                    </div>
                                    <div class="d-flex gap-2 flex-wrap align-items-center">
                                        <span class="status-badge badge-${b.status}">${b.status}</span>
                                        <c:if test="${b.status=='PENDING'}">
                                            <form action="${pageContext.request.contextPath}/tutor/booking/confirm/${b.bookingId}" method="post" style="display:inline;">
                                                <button class="btn-confirm"><i class="fas fa-check"></i> Confirm</button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/tutor/booking/decline/${b.bookingId}" method="post" style="display:inline;">
                                                <button class="btn-decline"><i class="fas fa-times"></i> Decline</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${b.status=='CONFIRMED'}">
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
            </div>
        </div>
        <div id="reviews"></div>
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header-title"><i class="fas fa-star" style="color:#f59e0b"></i> Recent Reviews</div>
                <c:choose>
                    <c:when test="${empty myReviews}">
                        <div class="empty-state" style="padding:2rem 1rem;">
                            <span class="empty-icon" style="font-size:2.5rem;"><i class="fas fa-star"></i></span>
                            <div class="empty-desc">No reviews yet</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${myReviews}" varStatus="vs">
                            <c:if test="${vs.index < 4}">
                                <div class="review-item">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span style="font-size:0.88rem;font-weight:700;">${r.studentName}</span>
                                        <span class="stars" style="font-size:0.82rem;">
                                            <c:forEach begin="1" end="${r.rating}"><i class="fas fa-star"></i></c:forEach>
                                        </span>
                                    </div>
                                    <p style="font-size:0.85rem;color:var(--t-text-sec);margin:0;">${r.comment}</p>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    (function () {
        var tooltipStyle = {
            backgroundColor: 'rgba(15,23,42,0.92)',
            titleColor: '#f1f5f9',
            bodyColor: '#94a3b8',
            borderColor: 'rgba(255,255,255,0.08)',
            borderWidth: 1,
            padding: 12,
            cornerRadius: 10,
            titleFont: { family: 'Plus Jakarta Sans', size: 13, weight: '700' },
            bodyFont:  { family: 'Inter', size: 12 },
            displayColors: true,
            boxWidth: 10, boxHeight: 10, boxPadding: 4,
        };


        var ratingEl = document.getElementById('ratingChart');
        if (ratingEl) {
            var d1 = ratingEl.dataset;
            new Chart(ratingEl, {
                type: 'bar',
                data: {
                    labels: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
                    datasets: [{
                        data: [
                            Number(d1['1'] || 0),
                            Number(d1['2'] || 0),
                            Number(d1['3'] || 0),
                            Number(d1['4'] || 0),
                            Number(d1['5'] || 0)
                        ],
                        backgroundColor: [
                            'rgba(239,68,68,0.75)',
                            'rgba(249,115,22,0.75)',
                            'rgba(245,158,11,0.75)',
                            'rgba(52,211,153,0.75)',
                            'rgba(5,150,105,0.75)'
                        ],
                        borderColor: [
                            '#ef4444',
                            '#f97316',
                            '#f59e0b',
                            '#34d399',
                            '#059669'
                        ],
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 900, easing: 'easeOutQuart' },
                    plugins: {
                        legend: { display: false },
                        tooltip: Object.assign({}, tooltipStyle, {
                            callbacks: {
                                label: function(ctx) {
                                    var n = ctx.parsed.y;
                                    return ' ' + n + ' review' + (n !== 1 ? 's' : '');
                                }
                            }
                        })
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            suggestedMax: 5,
                            ticks: {
                                stepSize: 1,
                                precision: 0,
                                color: '#94a3b8',
                                font: { family: 'Inter', size: 11 }
                            },
                            grid: { color: 'rgba(5,150,105,0.06)' }
                        },
                        x: {
                            ticks: {
                                color: '#475569',
                                font: { family: 'Inter', size: 12, weight: '600' }
                            },
                            grid: { display: false }
                        }
                    }
                }
            });
        }


        var statusEl = document.getElementById('bookingStatusChart');
        if (statusEl) {
            var d2 = statusEl.dataset;
            new Chart(statusEl, {
                type: 'bar',
                data: {
                    labels: ['Pending', 'Confirmed', 'Completed', 'Cancelled'],
                    datasets: [{
                        data: [
                            Number(d2.pending   || 0),
                            Number(d2.confirmed || 0),
                            Number(d2.completed || 0),
                            Number(d2.cancelled || 0)
                        ],
                        backgroundColor: [
                            'rgba(245,158,11,0.75)',
                            'rgba(5,150,105,0.75)',
                            'rgba(59,130,246,0.75)',
                            'rgba(239,68,68,0.75)'
                        ],
                        borderColor: [
                            '#f59e0b',
                            '#059669',
                            '#3b82f6',
                            '#ef4444'
                        ],
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 900, easing: 'easeOutQuart' },
                    plugins: {
                        legend: { display: false },
                        tooltip: Object.assign({}, tooltipStyle, {
                            callbacks: {
                                label: function(ctx) {
                                    var n = ctx.parsed.x;
                                    return ' ' + n + ' booking' + (n !== 1 ? 's' : '');
                                }
                            }
                        })
                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            suggestedMax: 5,
                            ticks: {
                                stepSize: 1,
                                precision: 0,
                                color: '#94a3b8',
                                font: { family: 'Inter', size: 11 }
                            },
                            grid: { color: 'rgba(5,150,105,0.06)' }
                        },
                        y: {
                            ticks: {
                                color: '#475569',
                                font: { family: 'Inter', size: 12, weight: '600' }
                            },
                            grid: { display: false }
                        }
                    }
                }
            });
        }

    })();
</script>

<script>

    (function() {
        function animateCounter(el) {
            var target = parseInt(el.getAttribute('data-target')) || 0;
            if (target === 0) { el.textContent = '0'; return; }
            var duration = 1200;
            var start = null;
            function step(timestamp) {
                if (!start) start = timestamp;
                var progress = Math.min((timestamp - start) / duration, 1);
                var ease = 1 - Math.pow(1 - progress, 4);
                el.textContent = Math.floor(ease * target);
                if (progress < 1) requestAnimationFrame(step);
                else el.textContent = target;
            }
            requestAnimationFrame(step);
        }
        var observer = new IntersectionObserver(function(entries) {
            entries.forEach(function(e) {
                if (e.isIntersecting) { animateCounter(e.target); observer.unobserve(e.target); }
            });
        }, { threshold: 0.3 });
        document.querySelectorAll('.counter').forEach(function(el) { observer.observe(el); });
    })();

    document.querySelectorAll('a[href]').forEach(function(link) {
        var href = link.getAttribute('href');
        if (!href || href.startsWith('#') || href.startsWith('javascript') || link.target === '_blank') return;
        link.addEventListener('click', function(e) {
            var dest = link.href;
            if (dest && dest !== window.location.href) {
                e.preventDefault();
                document.body.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                document.body.style.opacity = '0';
                document.body.style.transform = 'translateY(-8px)';
                setTimeout(function() { window.location.href = dest; }, 280);
            }
        });
    });
</script>

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
