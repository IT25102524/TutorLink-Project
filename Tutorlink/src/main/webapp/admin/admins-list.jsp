<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Accounts - TutorLink Admin</title>
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
            <h4 class="page-title">Admin Accounts</h4>
            <p class="page-sub">View and manage all administrator accounts.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/create" class="btn-admin-primary">
            <i class="fas fa-user-plus"></i> Add Admin
        </a>
    </div>

    <c:if test="${param.created == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> New admin account created successfully!</div>
    </c:if>

    <div class="table-wrap">
        <div class="table-header">
            <div class="table-title"><i class="fas fa-user-shield me-2" style="color:var(--accent-cyan)"></i>All Administrators</div>
            <span class="table-count">${admins.size()} total</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${admins}" varStatus="vs">
                <tr>
                    <td style="color:var(--text-faint)">${vs.index + 1}</td>
                    <td class="text-bold">${a.fullName}</td>
                    <td>${a.email}</td>
                    <td>${a.phone}</td>
                    <td><span class="sbadge badge-${a.status}">${a.status}</span></td>
                    <td>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/admin/admins/${a.userId}"
                               class="btn-tbl success">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <c:if test="${a.userId != sessionScope.userId}">
                                <form action="${pageContext.request.contextPath}/admin/users/delete/${a.userId}"
                                      method="post" style="display:inline;">
                                    <button class="btn-tbl danger"
                                            onclick="return confirm('Delete this admin account permanently?')">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script></body>
</html>
