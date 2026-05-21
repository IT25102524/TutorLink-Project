<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Users - TutorLink Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .role-section { margin-bottom: 2rem; }
        .role-header {
            display: flex; align-items: center; gap: 14px;
            padding: 14px 20px; border-radius: 14px 14px 0 0;
        }
        .role-header-student { background:linear-gradient(135deg,rgba(59,130,246,0.2),rgba(37,99,235,0.1)); border:1px solid rgba(59,130,246,0.3); border-bottom:none; }
        .role-header-tutor   { background:linear-gradient(135deg,rgba(16,185,129,0.2),rgba(5,150,105,0.1)); border:1px solid rgba(16,185,129,0.3); border-bottom:none; }
        .role-header-admin   { background:linear-gradient(135deg,rgba(168,85,247,0.2),rgba(139,92,246,0.1)); border:1px solid rgba(168,85,247,0.3); border-bottom:none; }
        .role-icon { width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;color:#fff;flex-shrink:0; }
        .icon-student { background:linear-gradient(135deg,#3b82f6,#2563eb); }
        .icon-tutor   { background:linear-gradient(135deg,#10b981,#059669); }
        .icon-admin   { background:linear-gradient(135deg,#a855f7,#7c3aed); }
        .role-title { font-weight:800;color:#fff;font-size:0.95rem; }
        .role-count { margin-left:auto;padding:4px 12px;border-radius:20px;font-size:0.78rem;font-weight:800; }
        .count-student { background:rgba(59,130,246,0.2);color:#60a5fa;border:1px solid rgba(59,130,246,0.3); }
        .count-tutor   { background:rgba(16,185,129,0.2);color:#2dd4bf;border:1px solid rgba(16,185,129,0.3); }
        .count-admin   { background:rgba(168,85,247,0.2);color:#c084fc;border:1px solid rgba(168,85,247,0.3); }
        .role-body { border-radius:0 0 14px 14px;background:var(--admin-card); }
        .role-body-student { border:1px solid rgba(59,130,246,0.3);border-top:none; }
        .role-body-tutor   { border:1px solid rgba(16,185,129,0.3);border-top:none; }
        .role-body-admin   { border:1px solid rgba(168,85,247,0.3);border-top:none; }
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
        <a href="${pageContext.request.contextPath}/admin/users" class="sb-link active"><i class="fas fa-users-cog"></i><span>Users</span></a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="sb-link"><i class="fas fa-calendar-check"></i><span>Bookings</span></a>
        <a href="${pageContext.request.contextPath}/admin/reviews" class="sb-link"><i class="fas fa-star-half-alt"></i><span>Reviews</span></a>
        <a href="${pageContext.request.contextPath}/subject/list" class="sb-link"><i class="fas fa-book-open"></i><span>Subjects</span></a>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sb-link"><i class="fas fa-chart-bar"></i><span>Analytics</span></a>
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link"><i class="fas fa-user-shield"></i><span>Admin Accounts</span></a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link"><i class="fas fa-credit-card"></i><span>Payments</span></a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link"><i class="fas fa-user-plus"></i><span>Add Admin</span></a>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
</div>
<div class="main-content">
    <div class="page-header">
        <div>
            <h4 class="page-title">Manage Users</h4>
            <p class="page-sub">View and manage all user accounts grouped by role.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/create" class="btn-admin-primary">
            <i class="fas fa-user-plus"></i> Add Admin
        </a>
    </div>

    <c:if test="${param.activated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> User account activated successfully.</div>
    </c:if>
    <c:if test="${param.deactivated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-ban"></i> User account deactivated.</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-trash-alt"></i> User account deleted.</div>
    </c:if>

    <%-- STUDENTS SECTION --%>
    <div class="role-section">
        <div class="role-header role-header-student">
            <div class="role-icon icon-student"><i class="fas fa-user-graduate"></i></div>
            <div class="role-title">Students</div>
            <span class="role-count count-student">
                <c:set var="studentCount" value="0"/>
                <c:forEach var="u" items="${users}"><c:if test="${u.role == 'STUDENT'}"><c:set var="studentCount" value="${studentCount + 1}"/></c:if></c:forEach>
                ${studentCount}
            </span>
        </div>
        <div class="role-body role-body-student">
            <table style="width:100%;border-collapse:collapse;">
                <thead><tr>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">#</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Name</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Email</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Status</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Actions</th>
                </tr></thead>
                <tbody>
                    <c:set var="idx" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.role == 'STUDENT'}">
                            <c:set var="idx" value="${idx + 1}"/>
                            <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                                <td style="padding:12px 18px;color:var(--text-faint);font-size:0.85rem;">${idx}</td>
                                <td style="padding:12px 18px;font-weight:700;color:#fff;">${u.fullName}</td>
                                <td style="padding:12px 18px;color:var(--text-dim);font-size:0.85rem;">${u.email}</td>
                                <td style="padding:12px 18px;"><span class="sbadge badge-${u.status}">${u.status}</span></td>
                                <td style="padding:12px 18px;">
                                    <div class="d-flex gap-2">
                                        <c:if test="${u.status == 'ACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/admin/users/deactivate/${u.userId}" method="post" style="display:inline;">
                                                <button class="btn-tbl warn"><i class="fas fa-ban"></i> Deactivate</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${u.status == 'INACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/admin/users/activate/${u.userId}" method="post" style="display:inline;">
                                                <button class="btn-tbl success"><i class="fas fa-check"></i> Activate</button>
                                            </form>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/admin/users/delete/${u.userId}" method="post" style="display:inline;">
                                            <button class="btn-tbl danger" onclick="return confirm('Delete this user permanently?')"><i class="fas fa-trash-alt"></i> Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <%-- TUTORS SECTION --%>
    <div class="role-section">
        <div class="role-header role-header-tutor">
            <div class="role-icon icon-tutor"><i class="fas fa-chalkboard-teacher"></i></div>
            <div class="role-title">Tutors</div>
            <span class="role-count count-tutor">
                <c:set var="tutorCount" value="0"/>
                <c:forEach var="u" items="${users}"><c:if test="${u.role == 'TUTOR'}"><c:set var="tutorCount" value="${tutorCount + 1}"/></c:if></c:forEach>
                ${tutorCount}
            </span>
        </div>
        <div class="role-body role-body-tutor">
            <table style="width:100%;border-collapse:collapse;">
                <thead><tr>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">#</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Name</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Email</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Status</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Actions</th>
                </tr></thead>
                <tbody>
                    <c:set var="idx" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.role == 'TUTOR'}">
                            <c:set var="idx" value="${idx + 1}"/>
                            <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                                <td style="padding:12px 18px;color:var(--text-faint);font-size:0.85rem;">${idx}</td>
                                <td style="padding:12px 18px;font-weight:700;color:#fff;">${u.fullName}</td>
                                <td style="padding:12px 18px;color:var(--text-dim);font-size:0.85rem;">${u.email}</td>
                                <td style="padding:12px 18px;"><span class="sbadge badge-${u.status}">${u.status}</span></td>
                                <td style="padding:12px 18px;">
                                    <div class="d-flex gap-2">
                                        <c:if test="${u.status == 'ACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/admin/users/deactivate/${u.userId}" method="post" style="display:inline;">
                                                <button class="btn-tbl warn"><i class="fas fa-ban"></i> Deactivate</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${u.status == 'INACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/admin/users/activate/${u.userId}" method="post" style="display:inline;">
                                                <button class="btn-tbl success"><i class="fas fa-check"></i> Activate</button>
                                            </form>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/admin/users/delete/${u.userId}" method="post" style="display:inline;">
                                            <button class="btn-tbl danger" onclick="return confirm('Delete this user permanently?')"><i class="fas fa-trash-alt"></i> Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <%-- ADMINS SECTION --%>
    <div class="role-section">
        <div class="role-header role-header-admin">
            <div class="role-icon icon-admin"><i class="fas fa-user-shield"></i></div>
            <div class="role-title">Administrators</div>
            <span class="role-count count-admin">
                <c:set var="adminCount" value="0"/>
                <c:forEach var="u" items="${users}"><c:if test="${u.role == 'ADMIN'}"><c:set var="adminCount" value="${adminCount + 1}"/></c:if></c:forEach>
                ${adminCount}
            </span>
        </div>
        <div class="role-body role-body-admin">
            <table style="width:100%;border-collapse:collapse;">
                <thead><tr>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">#</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Name</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Email</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Status</th>
                    <th style="padding:12px 18px;font-size:0.75rem;font-weight:800;color:var(--text-faint);text-transform:uppercase;letter-spacing:0.8px;border-bottom:1px solid var(--admin-border);">Actions</th>
                </tr></thead>
                <tbody>
                    <c:set var="idx" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.role == 'ADMIN'}">
                            <c:set var="idx" value="${idx + 1}"/>
                            <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                                <td style="padding:12px 18px;color:var(--text-faint);font-size:0.85rem;">${idx}</td>
                                <td style="padding:12px 18px;font-weight:700;color:#fff;">${u.fullName}</td>
                                <td style="padding:12px 18px;color:var(--text-dim);font-size:0.85rem;">${u.email}</td>
                                <td style="padding:12px 18px;"><span class="sbadge badge-${u.status}">${u.status}</span></td>
                                <td style="padding:12px 18px;">
                                    <div class="d-flex gap-2">
                                        <c:if test="${u.status == 'ACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/admin/users/deactivate/${u.userId}" method="post" style="display:inline;">
                                                <button class="btn-tbl warn"><i class="fas fa-ban"></i> Deactivate</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${u.status == 'INACTIVE'}">
                                            <form action="${pageContext.request.contextPath}/admin/users/activate/${u.userId}" method="post" style="display:inline;">
                                                <button class="btn-tbl success"><i class="fas fa-check"></i> Activate</button>
                                            </form>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/admin/users/delete/${u.userId}" method="post" style="display:inline;">
                                            <button class="btn-tbl danger" onclick="return confirm('Delete this admin permanently?')"><i class="fas fa-trash-alt"></i> Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
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