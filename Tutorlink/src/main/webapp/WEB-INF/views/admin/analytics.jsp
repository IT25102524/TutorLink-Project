<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>System Analytics - TutorLink Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-card {
            background: var(--admin-card);
            border: 1px solid var(--admin-border);
            border-radius: 18px;
            padding: 1.5rem 1.8rem;
            margin-bottom: 1.5rem;
            height: 100%;
        }
        .chart-title {
            font-weight: 800; color: #fff;
            font-size: 0.92rem; margin-bottom: 0.3rem;
            display: flex; align-items: center; gap: 8px;
        }
        .chart-sub {
            font-size: 0.78rem; color: var(--text-faint);
            margin-bottom: 1.2rem;
        }
        .insight-row {
            display: flex; align-items: center; gap: 14px;
            padding: 10px 0; border-bottom: 1px solid var(--admin-border);
        }
        .insight-row:last-child { border-bottom: none; }
        .insight-badge {
            padding: 4px 12px; border-radius: 20px;
            font-size: 0.78rem; font-weight: 700; white-space: nowrap;
        }
        .tutor-rank {
            width: 30px; height: 30px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 900; font-size: 0.82rem; flex-shrink: 0;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sb-brand">
        <div class="sb-logo"><i class="fas fa-shield-alt"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </div>
    <div class="sb-section-label">Navigation</div>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-link"><i class="fas fa-th-large"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/admin/users" class="sb-link"><i class="fas fa-users-cog"></i><span>Users</span></a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="sb-link"><i class="fas fa-calendar-check"></i><span>Bookings</span></a>
        <a href="${pageContext.request.contextPath}/admin/reviews" class="sb-link"><i class="fas fa-star-half-alt"></i><span>Reviews</span></a>
        <a href="${pageContext.request.contextPath}/subject/list" class="sb-link"><i class="fas fa-book-open"></i><span>Subjects</span></a>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sb-link active"><i class="fas fa-chart-bar"></i><span>Analytics</span></a>
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link"><i class="fas fa-user-shield"></i><span>Admin Accounts</span></a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link"><i class="fas fa-credit-card"></i><span>Payments</span></a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link"><i class="fas fa-user-plus"></i><span>Add Admin</span></a>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
</div></div>

<div class="main-content">
    <div class="page-header">
        <div>
            <h4 class="page-title">System Analytics</h4>
            <p class="page-sub">Deep platform insights to support admin decision-making.</p>
        </div>
    </div>

    <div class="row g-4">

        <%-- REVENUE TREND --%>
        <div class="col-md-8">
            <div class="chart-card">
                <div class="chart-title"><i class="fas fa-coins" style="color:#fbbf24;"></i>Revenue Trend</div>
                <div class="chart-sub">Monthly revenue (Rs.) from paid sessions — last 6 months</div>
                <canvas id="revenueChart" style="max-height:220px;"></canvas>
            </div>
        </div>

        <%-- STUDENT RETENTION --%>
        <div class="col-md-4">
            <div class="chart-card">
                <div class="chart-title"><i class="fas fa-user-check" style="color:#2dd4bf;"></i>Student Retention</div>
                <div class="chart-sub">Returning vs first-time students</div>
                <canvas id="retentionChart" style="max-height:160px;"></canvas>
                <div style="margin-top:1rem;font-size:0.82rem;color:var(--text-faint);">
                    <div style="display:flex;align-items:center;gap:8px;margin-bottom:5px;">
                        <span style="width:12px;height:12px;background:#10b981;border-radius:3px;display:inline-block;"></span>
                        Returning (2+ bookings): ${returningStudents}
                    </div>
                    <div style="display:flex;align-items:center;gap:8px;">
                        <span style="width:12px;height:12px;background:#3b82f6;border-radius:3px;display:inline-block;"></span>
                        First-time: ${firstTimeStudents}
                    </div>
                </div>
            </div>
        </div>

        <%-- PEAK BOOKING DAYS --%>
        <div class="col-md-6">
            <div class="chart-card">
                <div class="chart-title"><i class="fas fa-calendar-week" style="color:#c084fc;"></i>Peak Booking Days</div>
                <div class="chart-sub">Which days of the week have most bookings</div>
                <canvas id="peakDaysChart" style="max-height:200px;"></canvas>
            </div>
        </div>

        <%-- MOST POPULAR DISTRICTS --%>
        <div class="col-md-6">
            <div class="chart-card">
                <div class="chart-title"><i class="fas fa-map-marker-alt" style="color:#f87171;"></i>Most Active Districts</div>
                <div class="chart-sub">Districts with most tutor activity — recruit in low-activity areas</div>
                <c:choose>
                    <c:when test="${empty districtActivity}">
                        <div style="text-align:center;padding:2rem;color:var(--text-faint);font-size:0.88rem;">No data yet</div>
                    </c:when>
                    <c:otherwise>
                        <canvas id="districtChart" style="max-height:200px;"></canvas>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- TUTOR ACCEPTANCE RATE --%>
        <div class="col-md-6">
            <div class="chart-card">
                <div class="chart-title"><i class="fas fa-handshake" style="color:#60a5fa;"></i>Tutor Response Rate</div>
                <div class="chart-sub">Bookings received vs confirmed per tutor — identify unresponsive tutors</div>
                <c:choose>
                    <c:when test="${empty tutorAcceptance}">
                        <div style="text-align:center;padding:2rem;color:var(--text-faint);font-size:0.88rem;">No booking data yet</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="entry" items="${tutorAcceptance}" varStatus="vs">
                            <div class="insight-row">
                                <div style="flex:1;">
                                    <div style="font-weight:700;color:#fff;font-size:0.88rem;">${entry.key}</div>
                                    <div style="font-size:0.75rem;color:var(--text-faint);">
                                        ${entry.value.received} received · ${entry.value.confirmed} confirmed
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${entry.value.rate >= 80}">
                                        <span class="insight-badge" style="background:rgba(16,185,129,0.15);color:#2dd4bf;border:1px solid rgba(16,185,129,0.3);">${entry.value.rate}%</span>
                                    </c:when>
                                    <c:when test="${entry.value.rate >= 50}">
                                        <span class="insight-badge" style="background:rgba(245,158,11,0.15);color:#fbbf24;border:1px solid rgba(245,158,11,0.3);">${entry.value.rate}%</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="insight-badge" style="background:rgba(239,68,68,0.15);color:#f87171;border:1px solid rgba(239,68,68,0.3);">${entry.value.rate}%</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- SUBJECT GAP ANALYSIS --%>
        <div class="col-md-6">
            <div class="chart-card">
                <div class="chart-title"><i class="fas fa-exclamation-triangle" style="color:#f59e0b;"></i>Subject Demand vs Supply</div>
                <div class="chart-sub">Subjects students prefer but no tutor teaches — add these subjects</div>
                <c:choose>
                    <c:when test="${empty subjectGaps}">
                        <div style="text-align:center;padding:2rem;color:var(--text-faint);font-size:0.88rem;">
                            <i class="fas fa-check-circle" style="color:#2dd4bf;margin-right:6px;"></i>
                            No gaps found — all preferred subjects have tutors!
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="gap" items="${subjectGaps}">
                            <div class="insight-row">
                                <i class="fas fa-book" style="color:rgba(245,158,11,0.6);font-size:0.85rem;"></i>
                                <div style="flex:1;">
                                    <div style="font-weight:700;color:#fff;font-size:0.88rem;">${gap}</div>
                                    <div style="font-size:0.75rem;color:var(--text-faint);">Students want this — no tutor teaching it</div>
                                </div>
                                <span class="insight-badge" style="background:rgba(245,158,11,0.15);color:#fbbf24;border:1px solid rgba(245,158,11,0.3);">Gap</span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const chartDefaults = {
        responsive: true,
        plugins: { legend: { display: false } },
    };

    // Revenue trend chart
    const revLabels = [<c:forEach var="e" items="${revenuePerMonth}" varStatus="vs">"${e.key}"${vs.last ? '' : ','}</c:forEach>];
    const revData   = [<c:forEach var="e" items="${revenuePerMonth}" varStatus="vs">${e.value}${vs.last ? '' : ','}</c:forEach>];
    new Chart(document.getElementById('revenueChart'), {
        type: 'bar',
        data: {
            labels: revLabels,
            datasets: [{
                label: 'Revenue (Rs.)',
                data: revData,
                backgroundColor: 'rgba(251,191,36,0.7)',
                borderRadius: 10,
                borderSkipped: false
            }]
        },
        options: {
            ...chartDefaults,
            scales: {
                y: { beginAtZero: true, ticks: { color: '#94a3b8', callback: v => 'Rs.' + v }, grid: { color: 'rgba(255,255,255,0.05)' } },
                x: { ticks: { color: '#94a3b8' }, grid: { display: false } }
            }
        }
    });

    // Student retention doughnut
    new Chart(document.getElementById('retentionChart'), {
        type: 'doughnut',
        data: {
            labels: ['Returning', 'First-time'],
            datasets: [{
                data: [${returningStudents}, ${firstTimeStudents}],
                backgroundColor: ['rgba(16,185,129,0.8)', 'rgba(59,130,246,0.8)'],
                borderWidth: 0, hoverOffset: 6
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } }, cutout: '65%' }
    });

    // Peak booking days
    const dayLabels = [<c:forEach var="e" items="${peakDays}" varStatus="vs">"${e.key}"${vs.last ? '' : ','}</c:forEach>];
    const dayData   = [<c:forEach var="e" items="${peakDays}" varStatus="vs">${e.value}${vs.last ? '' : ','}</c:forEach>];
    new Chart(document.getElementById('peakDaysChart'), {
        type: 'bar',
        data: {
            labels: dayLabels,
            datasets: [{
                data: dayData,
                backgroundColor: 'rgba(192,132,252,0.7)',
                borderRadius: 8, borderSkipped: false
            }]
        },
        options: {
            ...chartDefaults,
            scales: {
                y: { beginAtZero: true, ticks: { stepSize: 1, color: '#94a3b8' }, grid: { color: 'rgba(255,255,255,0.05)' } },
                x: { ticks: { color: '#94a3b8' }, grid: { display: false } }
            }
        }
    });

    // District activity
    <c:if test="${not empty districtActivity}">
    const distLabels = [<c:forEach var="e" items="${districtActivity}" varStatus="vs">"${e.key}"${vs.last ? '' : ','}</c:forEach>];
    const distData   = [<c:forEach var="e" items="${districtActivity}" varStatus="vs">${e.value}${vs.last ? '' : ','}</c:forEach>];
    new Chart(document.getElementById('districtChart'), {
        type: 'bar',
        data: {
            labels: distLabels,
            datasets: [{
                data: distData,
                backgroundColor: 'rgba(248,113,113,0.7)',
                borderRadius: 8, borderSkipped: false
            }]
        },
        options: {
            ...chartDefaults,
            indexAxis: 'y',
            scales: {
                x: { beginAtZero: true, ticks: { stepSize: 1, color: '#94a3b8' }, grid: { color: 'rgba(255,255,255,0.05)' } },
                y: { ticks: { color: '#94a3b8' }, grid: { display: false } }
            }
        }
    });
    </c:if>
</script></body>
</html>