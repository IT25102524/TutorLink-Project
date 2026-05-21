<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Admin - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link">
            <i class="fas fa-user-shield"></i><span>Admin Accounts</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link active">
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
            <h4 class="page-title">Create New Admin</h4>
            <p class="page-sub">Add a new administrator account to the system.</p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert-modern alert-danger"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
    </c:if>

    <div class="card" style="max-width: 550px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid var(--admin-border);">
            <div style="width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,var(--accent-blue),var(--accent-cyan));display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#fff;">
                <i class="fas fa-user-shield"></i>
            </div>
            <div>
                <div style="font-weight:700;color:#fff;">New Administrator</div>
                <div style="font-size:0.82rem;color:var(--text-faint);">This account will have full system access.</div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin/create" method="post">
            <div class="row g-4">
                <div class="col-12">
                    <label class="form-label">Full Name <span style="color:var(--accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="far fa-user"></i></span>
                        <input type="text" name="fullName" class="form-control" placeholder="Enter full name" required>
                    </div>
                </div>
                <div class="col-12">
                    <label class="form-label">Email Address <span style="color:var(--accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="far fa-envelope"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="admin@tutorlink.com" required>
                    </div>
                </div>
                <div class="col-12">
                    <label class="form-label">Password <span style="color:var(--accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="Create a strong password" required id="adminPassword">
                    </div>
                </div>
                <div class="col-12">
                    <label class="form-label">Phone Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-phone-alt"></i></span>
                        <input type="text" name="phone" class="form-control" placeholder="07X XXXXXXX">
                    </div>
                </div>
                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid var(--admin-border);">
                    <button type="submit" class="btn-admin-primary">
                        <i class="fas fa-user-shield"></i> Create Admin Account
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn-admin-secondary">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script></body>
</html>
