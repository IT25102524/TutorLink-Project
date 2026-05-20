<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Payment History - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <c:choose>
        <c:when test="${role == 'TUTOR'}"><link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor.css"></c:when>
        <c:otherwise><link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css"></c:otherwise>
    </c:choose>
    <style>
        .pay-table { width:100%;border-collapse:separate;border-spacing:0; }
        .pay-table th { padding:14px 18px;font-size:.78rem;font-weight:700;text-transform:uppercase;letter-spacing:.8px;color:#64748b;background:#f8fafc;border-bottom:2px solid #e2e8f0; }
        .pay-table td { padding:16px 18px;vertical-align:middle;border-bottom:1px solid #f1f5f9;font-size:.93rem;color:#0f172a; }
        .pay-table tbody tr:hover { background:#f8fafc; }
        .pay-table tbody tr:last-child td { border-bottom:none; }
        .method-badge { display:inline-flex;align-items:center;gap:6px;padding:5px 12px;border-radius:20px;font-size:.82rem;font-weight:600; }
        .method-CARD          { background:#eff6ff;color:#2563eb; }
        .method-CASH          { background:#f0fdf4;color:#16a34a; }
        .method-BANK_TRANSFER { background:#fffbeb;color:#d97706; }
        .status-badge { display:inline-flex;align-items:center;gap:5px;padding:5px 12px;border-radius:20px;font-size:.82rem;font-weight:600; }
        .status-PAID     { background:#f0fdf4;color:#16a34a; }
        .status-PENDING  { background:#fffbeb;color:#d97706; }
        .status-FAILED   { background:#fef2f2;color:#dc2626; }
        .status-REFUNDED { background:#f5f3ff;color:#7c3aed; }
        .amount-cell { font-size:1rem;font-weight:700; }
        .booking-id  { font-weight:600;color:#475569; }
        .date-cell   { font-size:.85rem;color:#94a3b8; }
        .note-cell   { font-size:.85rem;color:#64748b;max-width:220px; }
        .empty-box   { text-align:center;padding:4rem 2rem;color:#94a3b8; }
        .empty-box i { font-size:3rem;display:block;margin-bottom:1rem;opacity:.3; }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.role == 'TUTOR'}">
        <div class="sidebar">
            <div class="sb-brand">
                <div class="sb-logo"><i class="fas fa-chalkboard-teacher"></i></div>
                <div class="sb-name">Tutor<span>Link</span></div>
            </div>
            <nav class="sb-nav">
                <a href="${pageContext.request.contextPath}/tutor/dashboard" class="sb-link"><i class="fas fa-th-large"></i><span>Dashboard</span></a>
                <a href="${pageContext.request.contextPath}/tutor/bookings" class="sb-link"><i class="fas fa-calendar-check"></i><span>Booking Requests</span></a>
                <a href="${pageContext.request.contextPath}/tutor/reviews" class="sb-link"><i class="fas fa-star"></i><span>My Reviews</span></a>
                <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link"><i class="fas fa-book-open"></i><span>My Subjects</span></a>
                <a href="${pageContext.request.contextPath}/availability/list" class="sb-link"><i class="fas fa-clock"></i><span>Availability</span></a>
                <a href="${pageContext.request.contextPath}/payment/history" class="sb-link active"><i class="fas fa-credit-card"></i><span>Payments</span></a>
                <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link"><i class="fas fa-user-circle"></i><span>My Profile</span></a>
                <a href="${pageContext.request.contextPath}/tutor/profile/edit" class="sb-link"><i class="fas fa-user-edit"></i><span>Edit Profile</span></a>
            </nav>
            <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="sidebar">
            <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-brand">
                <div class="sb-logo"><i class="fas fa-graduation-cap"></i></div>
                <div class="sb-name">Tutor<span>Link</span></div>
            </a>
            <nav class="sb-nav">
                <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-link"><i class="fas fa-th-large"></i><span>Dashboard</span></a>
                <a href="${pageContext.request.contextPath}/student/search" class="sb-link"><i class="fas fa-search"></i><span>Find & Book Tutor</span></a>
                <a href="${pageContext.request.contextPath}/student/goals" class="sb-link"><i class="fas fa-chart-line"></i><span>Learning Progress</span></a>
                <a href="${pageContext.request.contextPath}/student/bookings" class="sb-link"><i class="fas fa-calendar-check"></i><span>My Bookings</span></a>
                <a href="${pageContext.request.contextPath}/student/reviews" class="sb-link"><i class="fas fa-star"></i><span>My Reviews</span></a>
                <a href="${pageContext.request.contextPath}/student/profile" class="sb-link"><i class="fas fa-user-circle"></i><span>My Profile</span></a>
                <a href="${pageContext.request.contextPath}/payment/history" class="sb-link active"><i class="fas fa-credit-card"></i><span>Payments</span></a>
            </nav>
            <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
        </div>
    </c:otherwise>
</c:choose>
<div class="main-content">
    <div class="page-header">
        <div>
            <h4 class="page-title">Payment History</h4>
            <p class="page-sub">All your booking payments.</p>
        </div>
    </div>

    <c:if test="${empty payments}">
        <div class="empty-box">
            <i class="fas fa-receipt"></i>
            <p style="font-weight:600;font-size:1rem;margin-bottom:4px;">No payments yet</p>
            <p style="font-size:.88rem;">Your payments will appear here after you book a session.</p>
        </div>
    </c:if>

    <c:if test="${not empty payments}">
        <div class="table-wrap">
            <div class="table-header">
                <div class="table-title"><i class="fas fa-credit-card me-2" style="color:var(--accent-cyan)"></i>Payments</div>
                <span class="table-count">${payments.size()} total</span>
            </div>
            <table class="pay-table">
                <thead>
                    <tr><th>#</th><th>Booking</th><th>Amount</th><th>Method</th><th>Status</th><th>Note</th><th>Date &amp; Time</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${payments}" varStatus="vs">
                        <tr>
                            <td style="color:#94a3b8;font-size:.85rem">${vs.index + 1}</td>
                            <td class="booking-id">#${p.bookingId}</td>
                            <td class="amount-cell">LKR ${p.amount}</td>
                            <td>
                                <span class="method-badge method-${p.paymentMethod}">
                                    <c:choose>
                                        <c:when test="${p.paymentMethod == 'CARD'}"><i class="fas fa-credit-card"></i></c:when>
                                        <c:when test="${p.paymentMethod == 'CASH'}"><i class="fas fa-money-bill-wave"></i></c:when>
                                        <c:otherwise><i class="fas fa-university"></i></c:otherwise>
                                    </c:choose>
                                    ${p.methodLabel}
                                </span>
                            </td>
                            <td>
                                <span class="status-badge status-${p.paymentStatus}">
                                    <c:choose>
                                        <c:when test="${p.paymentStatus == 'PAID'}"><i class="fas fa-check-circle"></i></c:when>
                                        <c:when test="${p.paymentStatus == 'FAILED'}"><i class="fas fa-times-circle"></i></c:when>
                                        <c:when test="${p.paymentStatus == 'REFUNDED'}"><i class="fas fa-undo-alt"></i></c:when>
                                        <c:otherwise><i class="fas fa-hourglass-half"></i></c:otherwise>
                                    </c:choose>
                                    ${p.statusLabel}
                                </span>
                            </td>
                            <td class="note-cell">${p.receiptNote}</td>
                            <td class="date-cell">${p.paymentDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
(function() {
    var STORAGE_KEY = 'tl_theme';
    var html = document.documentElement;
    var isAdmin = document.querySelector('link[href*="admin.css"]') !== null;
    function getDefault() { return isAdmin ? 'dark' : 'light'; }
    function getOpposite() { return isAdmin ? 'light' : 'dark'; }
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
        var next = html.getAttribute('data-theme') === getOpposite() ? getDefault() : getOpposite();
        localStorage.setItem(STORAGE_KEY, next);
        applyTheme(next);
    };
})();
</script></body>
</html>
