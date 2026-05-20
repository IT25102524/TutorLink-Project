<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>All Payments - TutorLink Admin</title>
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-link"><i class="fas fa-th-large"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/admin/users" class="sb-link"><i class="fas fa-users-cog"></i><span>Users</span></a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="sb-link"><i class="fas fa-calendar-check"></i><span>Bookings</span></a>
        <a href="${pageContext.request.contextPath}/admin/reviews" class="sb-link"><i class="fas fa-star-half-alt"></i><span>Reviews</span></a>
        <a href="${pageContext.request.contextPath}/subject/list" class="sb-link"><i class="fas fa-book-open"></i><span>Subjects</span></a>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sb-link"><i class="fas fa-chart-bar"></i><span>Analytics</span></a>
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link"><i class="fas fa-user-shield"></i><span>Admin Accounts</span></a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link active"><i class="fas fa-credit-card"></i><span>Payments</span></a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link"><i class="fas fa-user-plus"></i><span>Add Admin</span></a>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
</div>
<div class="main-content">
    <div class="page-header">
        <div>
            <h4 class="page-title">All Payments</h4>
            <p class="page-sub">Payment records grouped by week.</p>
        </div>
    </div>

    <div style="margin-bottom:1rem;">
        <span style="font-size:0.88rem;color:var(--text-faint);font-weight:600;">
            <i class="fas fa-credit-card me-2" style="color:var(--accent-cyan);"></i>
            ${payments.size()} total payments
        </span>
    </div>

    <c:choose>
        <c:when test="${empty payments}">
            <div style="text-align:center;padding:3rem;color:var(--text-faint);">No payments recorded yet.</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="weekEntry" items="${paymentsByWeek}">
                <div style="margin-bottom:1.5rem;">
                    <%-- Week header --%>
                    <div style="background:rgba(255,255,255,0.04);border:1px solid var(--admin-border);border-radius:12px 12px 0 0;padding:12px 18px;display:flex;align-items:center;justify-content:space-between;">
                        <div style="font-weight:800;color:#fff;font-size:0.9rem;">
                            <i class="fas fa-calendar-week me-2" style="color:var(--accent-cyan);"></i>
                            ${weekEntry.key}
                        </div>
                        <span style="background:rgba(6,182,212,0.15);color:#22d3ee;border:1px solid rgba(6,182,212,0.3);padding:3px 12px;border-radius:20px;font-size:0.78rem;font-weight:700;">
                            ${weekEntry.value.size()} payment(s)
                        </span>
                    </div>
                    <%-- Week payments table --%>
                    <div style="background:var(--admin-card);border:1px solid var(--admin-border);border-top:none;border-radius:0 0 12px 12px;">
                        <table style="width:100%;border-collapse:collapse;">
                            <thead>
                                <tr>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Payment ID</th>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Booking</th>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Amount</th>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Method</th>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Status</th>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Date</th>
                                    <th style="padding:10px 16px;font-size:0.72rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${weekEntry.value}">
                                    <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                                        <td style="padding:11px 16px;font-weight:700;color:#fff;font-size:0.88rem;">#${p.paymentId}</td>
                                        <td style="padding:11px 16px;color:var(--text-dim);font-size:0.88rem;">#${p.bookingId}</td>
                                        <td style="padding:11px 16px;font-weight:700;color:#fff;">LKR ${p.amount}</td>
                                        <td style="padding:11px 16px;">
                                            <span style="background:rgba(99,102,241,0.12);color:#a5b4fc;border:1px solid rgba(99,102,241,0.2);padding:3px 10px;border-radius:20px;font-size:0.75rem;font-weight:700;">
                                                ${p.methodLabel}
                                            </span>
                                        </td>
                                        <td style="padding:11px 16px;">
                                            <c:choose>
                                                <c:when test="${p.paymentStatus.toString() == 'PAID'}">
                                                    <span style="background:rgba(16,185,129,0.15);color:#2dd4bf;border:1px solid rgba(16,185,129,0.3);padding:3px 12px;border-radius:20px;font-size:0.75rem;font-weight:700;">Paid</span>
                                                </c:when>
                                                <c:when test="${p.paymentStatus.toString() == 'FAILED'}">
                                                    <span style="background:rgba(239,68,68,0.12);color:#f87171;border:1px solid rgba(239,68,68,0.25);padding:3px 12px;border-radius:20px;font-size:0.75rem;font-weight:700;">Failed</span>
                                                </c:when>
                                                <c:when test="${p.paymentStatus.toString() == 'REFUNDED'}">
                                                    <span style="background:rgba(124,58,237,0.15);color:#a78bfa;border:1px solid rgba(124,58,237,0.3);padding:3px 12px;border-radius:20px;font-size:0.75rem;font-weight:700;">Refunded</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:rgba(245,158,11,0.15);color:#fbbf24;border:1px solid rgba(245,158,11,0.3);padding:3px 12px;border-radius:20px;font-size:0.75rem;font-weight:700;">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding:11px 16px;color:var(--text-dim);font-size:0.82rem;">${p.paymentDate}</td>
                                        <td style="padding:11px 16px;">
                                            <form action="${pageContext.request.contextPath}/payment/admin/delete/${p.paymentId}" method="post" style="display:inline;">
                                                <button class="btn-tbl danger" onclick="return confirm('Delete this payment?')">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
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