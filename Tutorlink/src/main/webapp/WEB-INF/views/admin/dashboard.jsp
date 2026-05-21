<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="sidebar">
    <div class="sb-brand">
        <div class="sb-logo"><i class="fas fa-shield-alt"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </div>
    <div class="sb-section-label">Navigation</div>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-link active">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="sb-link">
            <i class="fas fa-users-cog"></i><span>Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="sb-link">
            <i class="fas fa-calendar-check"></i><span>Bookings</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reviews" class="sb-link">
            <i class="fas fa-star-half-alt"></i><span>Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/subject/list" class="sb-link">
            <i class="fas fa-book-open"></i><span>Subjects</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sb-link">
            <i class="fas fa-chart-bar"></i><span>Analytics</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link">
            <i class="fas fa-user-shield"></i><span>Admin Accounts</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link">
            <i class="fas fa-user-plus"></i><span>Add Admin</span>
        </a>
    </nav>


    <div class="sb-user-section">
        <div class="sb-user-avatar">A</div>
        <div>
            <div class="sb-user-name">${sessionScope.userName}</div>
            <div class="sb-user-role">Admin</div>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout">
        <i class="fas fa-sign-out-alt"></i><span>Logout</span>
    </a>
</div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">Admin Dashboard</h4>
            <p class="page-sub">System overview and analytics.</p>
        </div>
    </div>
<div class="stat-grid">
        <div class="stat-card c-blue">
            <div class="stat-icon blue"><i class="fas fa-user-graduate"></i></div>
            <div class="stat-num counter" data-target="${studentCount}">0</div>
            <div class="stat-lbl">Students</div>
        </div>
        <div class="stat-card c-indigo">
            <div class="stat-icon indigo"><i class="fas fa-chalkboard-teacher"></i></div>
            <div class="stat-num counter" data-target="${tutorCount}">0</div>
            <div class="stat-lbl">Tutors</div>
        </div>
        <div class="stat-card c-green">
            <div class="stat-icon green"><i class="fas fa-user-shield"></i></div>
            <div class="stat-num counter" data-target="${adminCount}">0</div>
            <div class="stat-lbl">Admins</div>
        </div>
        <div class="stat-card c-gold">
            <div class="stat-icon gold"><i class="fas fa-calendar-alt"></i></div>
            <div class="stat-num counter" data-target="${allBookings.size()}">0</div>
            <div class="stat-lbl">Bookings</div>
        </div>
        <div class="stat-card c-purple">
            <div class="stat-icon purple"><i class="fas fa-star"></i></div>
            <div class="stat-num counter" data-target="${allReviews.size()}">0</div>
            <div class="stat-lbl">Reviews</div>
        </div>
        <div class="stat-card c-rose">
            <div class="stat-icon rose"><i class="fas fa-book"></i></div>
            <div class="stat-num counter" data-target="${allSubjects.size()}">0</div>
            <div class="stat-lbl">Subjects</div>
        </div>
    </div>

    <%-- Count booking statuses and review types in ONE loop each --%>
    <c:set var="cntPending"   value="0"/>
    <c:set var="cntConfirmed" value="0"/>
    <c:set var="cntCompleted" value="0"/>
    <c:set var="cntCancelled" value="0"/>
    <c:forEach var="b" items="${allBookings}">
        <c:if test="${b.status == 'PENDING'}">   <c:set var="cntPending"   value="${cntPending   + 1}"/></c:if>
        <c:if test="${b.status == 'CONFIRMED'}"> <c:set var="cntConfirmed" value="${cntConfirmed + 1}"/></c:if>
        <c:if test="${b.status == 'COMPLETED'}"> <c:set var="cntCompleted" value="${cntCompleted + 1}"/></c:if>
        <c:if test="${b.status == 'CANCELLED'}"> <c:set var="cntCancelled" value="${cntCancelled + 1}"/></c:if>
    </c:forEach>

    <c:set var="cntPublic"   value="0"/>
    <c:set var="cntReported" value="0"/>
    <c:forEach var="r" items="${allReviews}">
        <c:if test="${r.reviewType == 'PUBLIC'}">   <c:set var="cntPublic"   value="${cntPublic   + 1}"/></c:if>
        <c:if test="${r.reviewType == 'REPORTED'}"> <c:set var="cntReported" value="${cntReported + 1}"/></c:if>
    </c:forEach>
<div class="row g-4 mb-4">
<div class="col-lg-7">
            <div class="card h-100">
                <div class="card-header-title">
                    <i class="fas fa-chart-bar" style="color:#3b82f6;"></i> Booking Pipeline Health
                </div>
                <c:choose>
                    <c:when test="${empty allBookings}">
                        <div class="empty-state">
                            <span class="empty-icon"><i class="fas fa-chart-bar"></i></span>
                            <div class="empty-title">No booking data yet</div>
                            <div class="empty-desc">Booking pipeline chart will appear once bookings are made.</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="position:relative;height:200px;margin-bottom:1.2rem;">
                            <canvas id="bookingStatusChart"
                                    data-pending="${cntPending}"
                                    data-confirmed="${cntConfirmed}"
                                    data-completed="${cntCompleted}"
                                    data-cancelled="${cntCancelled}"></canvas>
                        </div>
                        <%-- Legend: 2x2 grid --%>
                        <div style="display:grid;grid-template-columns:1fr 1fr;gap:0.5rem;">
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:8px 12px;background:rgba(245,158,11,0.08);border-radius:10px;border-left:3px solid #f59e0b;">
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <span style="width:8px;height:8px;border-radius:50%;background:#fbbf24;flex-shrink:0;"></span>
                                    <span style="font-size:0.83rem;font-weight:600;color:#94a3b8;">Pending</span>
                                </div>
                                <span style="font-size:1rem;font-weight:900;color:#f1f5f9;">${cntPending}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:8px 12px;background:rgba(16,185,129,0.08);border-radius:10px;border-left:3px solid #10b981;">
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <span style="width:8px;height:8px;border-radius:50%;background:#34d399;flex-shrink:0;"></span>
                                    <span style="font-size:0.83rem;font-weight:600;color:#94a3b8;">Confirmed</span>
                                </div>
                                <span style="font-size:1rem;font-weight:900;color:#f1f5f9;">${cntConfirmed}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:8px 12px;background:rgba(59,130,246,0.08);border-radius:10px;border-left:3px solid #3b82f6;">
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <span style="width:8px;height:8px;border-radius:50%;background:#60a5fa;flex-shrink:0;"></span>
                                    <span style="font-size:0.83rem;font-weight:600;color:#94a3b8;">Completed</span>
                                </div>
                                <span style="font-size:1rem;font-weight:900;color:#f1f5f9;">${cntCompleted}</span>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:8px 12px;background:rgba(239,68,68,0.08);border-radius:10px;border-left:3px solid #ef4444;">
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <span style="width:8px;height:8px;border-radius:50%;background:#f87171;flex-shrink:0;"></span>
                                    <span style="font-size:0.83rem;font-weight:600;color:#94a3b8;">Cancelled</span>
                                </div>
                                <span style="font-size:1rem;font-weight:900;color:#f1f5f9;">${cntCancelled}</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
<div class="col-lg-5">
            <div class="card h-100">
                <div class="card-header-title">
                    <i class="fas fa-chart-pie" style="color:#8b5cf6;"></i> Review Health
                </div>
                <c:choose>
                    <c:when test="${empty allReviews}">
                        <div class="empty-state">
                            <span class="empty-icon"><i class="fas fa-chart-pie"></i></span>
                            <div class="empty-title">No review data yet</div>
                            <div class="empty-desc">Review health chart will appear once reviews are submitted.</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="d-flex justify-content-center" style="margin-bottom:1.2rem;">
                            <div style="position:relative;height:180px;width:180px;">
                                <canvas id="reviewTypeChart"
                                        data-pub="${cntPublic}"
                                        data-reported="${cntReported}"></canvas>
                                <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);text-align:center;pointer-events:none;">
                                    <div style="font-size:1.6rem;font-weight:900;color:#f1f5f9;line-height:1;">${allReviews.size()}</div>
                                    <div style="font-size:0.65rem;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:0.6px;">Total</div>
                                </div>
                            </div>
                        </div>
                        <%-- Legend --%>
                        <div style="display:flex;flex-direction:column;gap:0.5rem;">
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:rgba(16,185,129,0.08);border-radius:10px;border-left:3px solid #10b981;">
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <span style="width:9px;height:9px;border-radius:50%;background:#34d399;flex-shrink:0;"></span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#94a3b8;">Public Reviews</span>
                                </div>
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <span style="font-size:1rem;font-weight:900;color:#f1f5f9;">${cntPublic}</span>
                                    <span style="padding:2px 8px;background:rgba(16,185,129,0.15);color:#34d399;border-radius:20px;font-size:0.7rem;font-weight:700;">Visible</span>
                                </div>
                            </div>
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;background:rgba(244,63,94,0.08);border-radius:10px;border-left:3px solid #f43f5e;">
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <span style="width:9px;height:9px;border-radius:50%;background:#fb7185;flex-shrink:0;"></span>
                                    <span style="font-size:0.87rem;font-weight:600;color:#94a3b8;">Reported Reviews</span>
                                </div>
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <span style="font-size:1rem;font-weight:900;color:#f1f5f9;">${cntReported}</span>
                                    <span style="padding:2px 8px;background:rgba(244,63,94,0.15);color:#fb7185;border-radius:20px;font-size:0.7rem;font-weight:700;">Flagged</span>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
<div class="table-wrap">
        <div class="table-header">
            <div class="table-title"><i class="fas fa-clock me-2" style="color:var(--accent-gold)"></i>Recent Bookings</div>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="table-count">View All &rarr;</a>
        </div>
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Student</th>
                <th>Tutor</th>
                <th>Subject</th>
                <th>Date</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty allBookings}">
                    <tr><td colspan="6" class="text-center py-4" style="color:var(--text-faint)">No bookings yet.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="b" items="${allBookings}" varStatus="vs">
                        <c:if test="${vs.index < 10}">
                            <tr>
                                <td style="color:var(--text-faint)">${vs.index+1}</td>
                                <td>${b.studentName}</td>
                                <td class="text-bold">${b.tutorName}</td>
                                <td>${b.subject}</td>
                                <td style="font-size:0.82rem;">${b.bookingDate}</td>
                                <td><span class="sbadge badge-${b.status}">${b.status}</span></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
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


        var statusEl = document.getElementById('bookingStatusChart');
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
                            'rgba(245,158,11,0.6)',
                            'rgba(16,185,129,0.6)',
                            'rgba(59,130,246,0.6)',
                            'rgba(239,68,68,0.6)'
                        ],
                        borderColor: ['#fbbf24','#34d399','#60a5fa','#f87171'],
                        borderWidth: 1.5,
                        borderRadius: 6,
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
                                color: '#475569',
                                font: { family: 'Inter', size: 11 }
                            },
                            grid: { color: 'rgba(255,255,255,0.04)', drawBorder: false }
                        },
                        y: {
                            ticks: {
                                color: '#94a3b8',
                                font: { family: 'Inter', size: 12, weight: '600' }
                            },
                            grid: { display: false }
                        }
                    }
                }
            });
        }


        var reviewEl = document.getElementById('reviewTypeChart');
        if (reviewEl) {
            var d2 = reviewEl.dataset;
            new Chart(reviewEl, {
                type: 'doughnut',
                data: {
                    labels: ['Public', 'Reported'],
                    datasets: [{
                        data: [
                            Number(d2.pub || 0),
                            Number(d2.reported || 0)
                        ],
                        backgroundColor: [
                            'rgba(16,185,129,0.8)',
                            'rgba(244,63,94,0.8)'
                        ],
                        borderColor: ['#059669','#e11d48'],
                        borderWidth: 2,
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
                                    return ' ' + n + ' review' + (n !== 1 ? 's' : '') + ' (' + pct + '%)';
                                }
                            }
                        })
                    }
                }
            });
        }

    })();
</script></body>
</html>
