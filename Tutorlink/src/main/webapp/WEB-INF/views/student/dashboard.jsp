<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Dashboard - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-link active">
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
        <a href="${pageContext.request.contextPath}/student/bookings" class="sb-link">
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



    <div class="sb-user-section">
        <div class="sb-user-avatar">${sessionScope.userName.substring(0,1).toUpperCase()}</div>
        <div>
            <div class="sb-user-name">${sessionScope.userName}</div>
            <div class="sb-user-role">Student</div>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">Welcome back, <span style="color:var(--primary);">${sessionScope.userName}</span> 👋</h4>
            <p class="page-sub">Here is your learning overview for today.</p>
        </div>
        <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern">
            <i class="fas fa-search"></i> Find a Tutor
        </a>
    </div>

    <c:if test="${param.booked == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Booking request sent successfully!</div>
    </c:if>
    <c:if test="${param.reviewed == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Review submitted!</div>
    </c:if>
    <c:if test="${param.updated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Review updated!</div>
    </c:if>
    <c:if test="${param.cancelled == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-ban"></i> Booking cancelled successfully.</div>
    </c:if>
    <c:if test="${param.reviewDeleted == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-trash-alt"></i> Review deleted successfully.</div>
    </c:if>

    <%-- Count everything in ONE loop --%>
    <c:set var="cntPending"   value="0"/>
    <c:set var="cntConfirmed" value="0"/>
    <c:set var="cntCompleted" value="0"/>
    <c:set var="cntCancelled" value="0"/>
    <c:set var="cntOnline"    value="0"/>
    <c:set var="cntHomeVisit" value="0"/>
    <c:forEach var="b" items="${myBookings}">
        <c:if test="${b.status == 'PENDING'}">   <c:set var="cntPending"   value="${cntPending   + 1}"/></c:if>
        <c:if test="${b.status == 'CONFIRMED'}"> <c:set var="cntConfirmed" value="${cntConfirmed + 1}"/></c:if>
        <c:if test="${b.status == 'COMPLETED'}"> <c:set var="cntCompleted" value="${cntCompleted + 1}"/></c:if>
        <c:if test="${b.status == 'CANCELLED'}"> <c:set var="cntCancelled" value="${cntCancelled + 1}"/></c:if>
        <c:if test="${b.mode == 'ONLINE'}">      <c:set var="cntOnline"    value="${cntOnline    + 1}"/></c:if>
        <c:if test="${b.mode == 'HOME_VISIT'}">  <c:set var="cntHomeVisit" value="${cntHomeVisit + 1}"/></c:if>
    </c:forEach>
    <div class="row g-4 mb-5">
        <div class="col-md-3 col-sm-6">
            <div class="stat-card blue">
                <div class="stat-icon blue"><i class="fas fa-calendar-alt"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${myBookings.size()}">0</div>
                    <div class="stat-lbl">Total Bookings</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card green">
                <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${cntConfirmed}">0</div>
                    <div class="stat-lbl">Confirmed</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card gold">
                <div class="stat-icon gold"><i class="fas fa-heart"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${favoritesCount}">0</div>
                    <div class="stat-lbl">Favorite Tutors</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card purple">
                <div class="stat-icon purple"><i class="fas fa-star"></i></div>
                <div class="stat-details">
                    <div class="stat-num counter" data-target="${myReviews.size()}">0</div>
                    <div class="stat-lbl">My Reviews</div>
                </div>
            </div>
        </div>
    </div>
    <div class="card mb-4">
        <h6 class="card-header-title mb-4">
            <i class="fas fa-chart-bar me-2" style="color:var(--primary);"></i>Booking Status Breakdown
        </h6>
        <c:choose>
            <c:when test="${empty myBookings}">
                <div class="empty-state">
                    <i class="fas fa-chart-bar empty-icon"></i>
                    <div class="empty-title">No booking data yet</div>
                    <div class="empty-desc">Your status breakdown will appear once you make a booking.</div>
                    <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern">Find a Tutor</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row align-items-center g-4">
                    <div class="col-lg-8">
                        <div style="position:relative;height:210px;">
                            <canvas id="statusBarChart"
                                    data-pending="${cntPending}"
                                    data-confirmed="${cntConfirmed}"
                                    data-completed="${cntCompleted}"
                                    data-cancelled="${cntCancelled}"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div style="display:flex;flex-direction:column;gap:0.6rem;">
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:linear-gradient(135deg,#fef3c740,#fde68a20);border-radius:12px;border-left:4px solid #f59e0b;">
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#f59e0b;flex-shrink:0;box-shadow:0 2px 6px rgba(245,158,11,0.4);"></span>
                                    <span style="font-size:0.88rem;font-weight:600;color:var(--text-secondary);">Pending</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:var(--text-main);">${cntPending}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:linear-gradient(135deg,#d1fae540,#a7f3d020);border-radius:12px;border-left:4px solid #10b981;">
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#10b981;flex-shrink:0;box-shadow:0 2px 6px rgba(16,185,129,0.4);"></span>
                                    <span style="font-size:0.88rem;font-weight:600;color:var(--text-secondary);">Confirmed</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:var(--text-main);">${cntConfirmed}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:linear-gradient(135deg,#dbeafe40,#bfdbfe20);border-radius:12px;border-left:4px solid #2563eb;">
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#2563eb;flex-shrink:0;box-shadow:0 2px 6px rgba(37,99,235,0.4);"></span>
                                    <span style="font-size:0.88rem;font-weight:600;color:var(--text-secondary);">Completed</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:var(--text-main);">${cntCompleted}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:linear-gradient(135deg,#fee2e240,#fecaca20);border-radius:12px;border-left:4px solid #ef4444;">
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <span style="width:10px;height:10px;border-radius:50%;background:#ef4444;flex-shrink:0;box-shadow:0 2px 6px rgba(239,68,68,0.4);"></span>
                                    <span style="font-size:0.88rem;font-weight:600;color:var(--text-secondary);">Cancelled</span>
                                </div>
                                <span style="font-size:1.1rem;font-weight:900;color:var(--text-main);">${cntCancelled}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="card mb-5">
        <h6 class="card-header-title mb-4">
            <i class="fas fa-circle-half-stroke me-2" style="color:var(--accent-cyan);"></i>Session Type Distribution
        </h6>
        <c:choose>
            <c:when test="${empty myBookings}">
                <div class="empty-state">
                    <i class="fas fa-chart-pie empty-icon"></i>
                    <div class="empty-title">No session data yet</div>
                    <div class="empty-desc">Your session type breakdown will appear once you make a booking.</div>
                    <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern">Find a Tutor</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row align-items-center g-4">
                        <%-- Doughnut centred in col --%>
                    <div class="col-lg-4 d-flex justify-content-center">
                        <div style="position:relative;height:220px;width:220px;">
                            <canvas id="typeDoughnutChart"
                                    data-online="${cntOnline}"
                                    data-homevisit="${cntHomeVisit}"></canvas>
                                <%-- Total label in the hole --%>
                            <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);text-align:center;pointer-events:none;">
                                <div style="font-size:1.8rem;font-weight:900;color:var(--text-main);line-height:1;">${myBookings.size()}</div>
                                <div style="font-size:0.7rem;font-weight:700;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.6px;">Total</div>
                            </div>
                        </div>
                    </div>
                        <%-- Legend + detail on right --%>
                    <div class="col-lg-8">
                        <div style="display:flex;flex-direction:column;gap:1rem;">

                            <div style="display:flex;align-items:center;gap:1.2rem;padding:1.2rem 1.5rem;background:linear-gradient(135deg,#cffafe40,#a5f3fc20);border-radius:14px;border-left:4px solid #06b6d4;box-shadow:0 2px 12px rgba(6,182,212,0.08);">
                                <div style="width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,#06b6d4,#0891b2);display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 4px 12px rgba(6,182,212,0.3);">
                                    <i class="fas fa-laptop" style="color:#fff;font-size:1.1rem;"></i>
                                </div>
                                <div style="flex:1;">
                                    <div style="font-size:0.8rem;font-weight:700;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.4px;margin-bottom:2px;">Online Sessions</div>
                                    <div style="font-size:1.4rem;font-weight:900;color:var(--text-main);line-height:1;">${cntOnline}</div>
                                </div>
                                <span style="padding:4px 12px;background:rgba(6,182,212,0.15);color:#0891b2;border-radius:20px;font-size:0.75rem;font-weight:700;">Virtual</span>
                            </div>

                            <div style="display:flex;align-items:center;gap:1.2rem;padding:1.2rem 1.5rem;background:linear-gradient(135deg,#ede9fe40,#ddd6fe20);border-radius:14px;border-left:4px solid #8b5cf6;box-shadow:0 2px 12px rgba(139,92,246,0.08);">
                                <div style="width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,#8b5cf6,#7c3aed);display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 4px 12px rgba(139,92,246,0.3);">
                                    <i class="fas fa-house" style="color:#fff;font-size:1.1rem;"></i>
                                </div>
                                <div style="flex:1;">
                                    <div style="font-size:0.8rem;font-weight:700;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.4px;margin-bottom:2px;">Home Visit Sessions</div>
                                    <div style="font-size:1.4rem;font-weight:900;color:var(--text-main);line-height:1;">${cntHomeVisit}</div>
                                </div>
                                <span style="padding:4px 12px;background:rgba(139,92,246,0.15);color:#7c3aed;border-radius:20px;font-size:0.75rem;font-weight:700;">In-Person</span>
                            </div>

                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="row g-4">
        <div class="col-lg-7">
            <div class="card h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h6 class="card-header-title mb-0">Recent Bookings</h6>
                    <a href="${pageContext.request.contextPath}/student/bookings" class="btn-secondary-modern" style="padding:6px 12px;font-size:0.8rem;">View All</a>
                </div>
                <c:choose>
                    <c:when test="${empty myBookings}">
                        <div class="empty-state">
                            <i class="fas fa-calendar-xmark empty-icon"></i>
                            <div class="empty-title">No bookings yet</div>
                            <div class="empty-desc">Find a tutor and schedule your first session.</div>
                            <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern">Browse Tutors</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="b" items="${myBookings}" begin="0" end="4">
                            <div class="list-item">
                                <div>
                                    <div class="item-title">${b.subject} <span class="status-badge badge-${b.status} ms-2">${b.status}</span></div>
                                    <div class="item-sub">Tutor: <strong>${b.tutorName}</strong></div>
                                    <div class="item-meta">
                                        <span><i class="far fa-calendar"></i> ${b.bookingDate}</span>
                                        <span><i class="far fa-clock"></i> ${b.timeSlot}</span>
                                    </div>
                                </div>
                                <div class="d-flex gap-2">
                                    <c:if test="${b.status=='PENDING' || b.status=='CONFIRMED'}">
                                        <form action="${pageContext.request.contextPath}/booking/cancel/${b.bookingId}" method="post">
                                            <button class="btn-danger-outline" onclick="return confirm('Cancel this booking?')"><i class="fas fa-times"></i> Cancel</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${b.status=='COMPLETED'}">
                                        <a href="${pageContext.request.contextPath}/review/write/${b.bookingId}?tutorId=${b.tutorId}" class="btn-action-small" style="background:var(--warning);"><i class="fas fa-star"></i> Review</a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h6 class="card-header-title mb-0">Recent Reviews</h6>
                    <a href="${pageContext.request.contextPath}/student/reviews" class="btn-secondary-modern" style="padding:6px 12px;font-size:0.8rem;">View All</a>
                </div>
                <c:choose>
                    <c:when test="${empty myReviews}">
                        <div class="empty-state">
                            <i class="far fa-comment-dots empty-icon"></i>
                            <div class="empty-title">No reviews written</div>
                            <div class="empty-desc">Complete a session to review your tutor.</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${myReviews}" begin="0" end="3">
                            <div class="list-item flex-column align-items-start gap-2">
                                <div class="w-100 d-flex justify-content-between align-items-center">
                                    <div style="font-weight:600;font-size:0.95rem;">${r.tutorName}</div>
                                    <div style="color:var(--warning);font-size:0.85rem;">
                                        <c:forEach begin="1" end="${r.rating}"><i class="fas fa-star"></i></c:forEach>
                                    </div>
                                </div>
                                <div style="color:var(--text-muted);font-size:0.9rem;font-style:italic;">"${r.comment}"</div>
                            </div>
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
        var cssVar = function(key) {
            return getComputedStyle(document.documentElement).getPropertyValue(key).trim();
        };

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


        var statusEl = document.getElementById('statusBarChart');
        if (statusEl) {
            var d1 = statusEl.dataset;
            new Chart(statusEl, {
                type: 'bar',
                data: {
                    labels: ['Pending', 'Confirmed', 'Completed', 'Cancelled'],
                    datasets: [{
                        data: [
                            Number(d1.pending   || 0),
                            Number(d1.confirmed || 0),
                            Number(d1.completed || 0),
                            Number(d1.cancelled || 0)
                        ],
                        backgroundColor: [
                            'rgba(245,158,11,0.75)',
                            'rgba(16,185,129,0.75)',
                            'rgba(37,99,235,0.75)',
                            'rgba(239,68,68,0.75)'
                        ],
                        borderColor: ['#f59e0b','#10b981','#2563eb','#ef4444'],
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
                            grid: { color: 'rgba(37,99,235,0.05)', drawBorder: false }
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


        var doughnutEl = document.getElementById('typeDoughnutChart');
        if (doughnutEl) {
            var d2 = doughnutEl.dataset;
            new Chart(doughnutEl, {
                type: 'doughnut',
                data: {
                    labels: ['Online', 'Home Visit'],
                    datasets: [{
                        data: [
                            Number(d2.online    || 0),
                            Number(d2.homevisit || 0)
                        ],
                        backgroundColor: [
                            'rgba(6,182,212,0.85)',
                            'rgba(139,92,246,0.85)'
                        ],
                        borderColor: ['#06b6d4', '#8b5cf6'],
                        borderWidth: 3,
                        hoverOffset: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 900, easing: 'easeOutQuart' },
                    cutout: '68%',
                    plugins: {
                        legend: { display: false },
                        tooltip: Object.assign({}, tooltipStyle, {
                            callbacks: {
                                label: function(ctx) {
                                    var total = ctx.dataset.data[0] + ctx.dataset.data[1];
                                    var pct   = total > 0 ? Math.round((ctx.parsed / total) * 100) : 0;
                                    var n     = ctx.parsed;
                                    return ' ' + n + ' session' + (n !== 1 ? 's' : '') + ' (' + pct + '%)';
                                }
                            }
                        })
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
                if (e.isIntersecting) {
                    animateCounter(e.target);
                    observer.unobserve(e.target);
                }
            });
        }, { threshold: 0.3 });
        document.querySelectorAll('.counter').forEach(function(el) {
            observer.observe(el);
        });
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
