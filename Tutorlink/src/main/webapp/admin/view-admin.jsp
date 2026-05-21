<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Admin - TutorLink Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .profile-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 2rem;
            max-width: 600px;
        }
        .profile-avatar {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-cyan), var(--accent-purple));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 1.25rem;
        }
        .profile-name {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }
        .profile-role-badge {
            display: inline-block;
            padding: 3px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: rgba(99,179,237,0.15);
            color: var(--accent-cyan);
            margin-bottom: 1.5rem;
        }
        .info-row {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid var(--border-color);
        }
        .info-row:last-child { border-bottom: none; }
        .info-icon {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: var(--sidebar-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-cyan);
            font-size: 14px;
            flex-shrink: 0;
        }
        .info-label { font-size: 12px; color: var(--text-faint); margin-bottom: 2px; }
        .info-value { font-size: 14px; color: var(--text-primary); font-weight: 500; }
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-link">
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
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link active">
            <i class="fas fa-user-shield"></i><span>Admin Accounts</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link">
            <i class="fas fa-user-plus"></i><span>Add Admin</span>
        </a>
    </nav>


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout">
        <i class="fas fa-sign-out-alt"></i><span>Logout</span>
    </a>
</div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">Admin Profile</h4>
            <p class="page-sub">Viewing administrator account details.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/admins" class="btn-admin-primary">
            <i class="fas fa-arrow-left"></i> Back to Admins
        </a>
    </div>

    <div class="profile-card">
        <div class="profile-avatar">
            <i class="fas fa-user-shield"></i>
        </div>
        <div class="profile-name">${adminUser.fullName}</div>
        <div class="profile-role-badge">Administrator</div>

        <div class="info-row">
            <div class="info-icon"><i class="fas fa-id-badge"></i></div>
            <div>
                <div class="info-label">User ID</div>
                <div class="info-value">#${adminUser.userId}</div>
            </div>
        </div>
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-envelope"></i></div>
            <div>
                <div class="info-label">Email Address</div>
                <div class="info-value">${adminUser.email}</div>
            </div>
        </div>
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-phone"></i></div>
            <div>
                <div class="info-label">Phone Number</div>
                <div class="info-value">${adminUser.phone}</div>
            </div>
        </div>
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-toggle-on"></i></div>
            <div>
                <div class="info-label">Account Status</div>
                <div class="info-value">
                    <span class="sbadge badge-${adminUser.status}">${adminUser.status}</span>
                </div>
            </div>
        </div>
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-user-tag"></i></div>
            <div>
                <div class="info-label">Role</div>
                <div class="info-value">${adminUser.roleName}</div>
            </div>
        </div>

        <c:if test="${adminUser.userId != sessionScope.userId}">
            <div style="margin-top: 1.5rem; display: flex; gap: 10px;">
                <c:if test="${adminUser.status == 'ACTIVE'}">
                    <form action="${pageContext.request.contextPath}/admin/users/deactivate/${adminUser.userId}" method="post">
                        <button class="btn-tbl warn"><i class="fas fa-ban"></i> Deactivate Account</button>
                    </form>
                </c:if>
                <c:if test="${adminUser.status == 'INACTIVE'}">
                    <form action="${pageContext.request.contextPath}/admin/users/activate/${adminUser.userId}" method="post">
                        <button class="btn-tbl success"><i class="fas fa-check"></i> Activate Account</button>
                    </form>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/users/delete/${adminUser.userId}" method="post">
                    <button class="btn-tbl danger"
                            onclick="return confirm('Delete this admin account permanently?')">
                        <i class="fas fa-trash-alt"></i> Delete Account
                    </button>
                </form>
            </div>
        </c:if>
        <c:if test="${adminUser.userId == sessionScope.userId}">
            <p style="margin-top:1rem;font-size:13px;color:var(--text-faint);">
                <i class="fas fa-info-circle"></i> This is your own account.
            </p>
        </c:if>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script></body>
</html>
