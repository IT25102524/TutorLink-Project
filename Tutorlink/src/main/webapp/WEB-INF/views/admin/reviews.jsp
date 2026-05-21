<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reviews - TutorLink Admin</title>
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
        <a href="${pageContext.request.contextPath}/admin/reviews" class="sb-link active">
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


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout">
        <i class="fas fa-sign-out-alt"></i><span>Logout</span>
    </a>
</div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">Review Moderation</h4>
            <p class="page-sub">Manage and moderate all student reviews.</p>
        </div>
    </div>

    <c:if test="${param.reported == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Review has been reported successfully!</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-trash-alt"></i> Review deleted successfully.</div>
    </c:if>

    <div class="table-wrap">
        <div class="table-header">
            <div class="table-title"><i class="fas fa-star me-2" style="color:var(--accent-gold)"></i>All Reviews</div>
            <span class="table-count">${reviews.size()} total</span>
        </div>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Student</th>
                    <th>Tutor</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty reviews}">
                        <tr><td colspan="7" class="text-center py-4" style="color:var(--text-faint)">No reviews recorded yet.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${reviews}" varStatus="vs">
                            <tr>
                                <td style="color:var(--text-faint)">${vs.index+1}</td>
                                <td>${r.studentName}</td>
                                <td class="text-bold">${r.tutorName}</td>
                                <td>
                                    <span class="stars">
                                        <c:forEach begin="1" end="${r.rating}"><i class="fas fa-star"></i></c:forEach>
                                    </span>
                                    <c:if test="${r.rating < 5}">
                                        <span class="stars-empty">
                                            <c:forEach begin="${r.rating+1}" end="5"><i class="far fa-star"></i></c:forEach>
                                        </span>
                                    </c:if>
                                </td>
                                <td style="max-width:200px;font-size:0.85rem;color:var(--text-dim);">${r.comment}</td>
                                <td><span class="sbadge badge-${r.reviewType}">${r.displayBadge}</span></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <c:if test="${r.reviewType != 'REPORTED'}">
                                            <form action="${pageContext.request.contextPath}/admin/reviews/report/${r.reviewId}" method="post" style="display:inline;">
                                                <input type="hidden" name="reportReason" value="Reported by admin">
                                                <button class="btn-tbl warn" onclick="return confirm('Flag this review as reported?')">
                                                    <i class="fas fa-flag"></i> Report
                                                </button>
                                            </form>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/admin/reviews/delete/${r.reviewId}" method="post" style="display:inline;">
                                            <button class="btn-tbl danger" onclick="return confirm('Delete this review permanently?')">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script></body>
</html>
