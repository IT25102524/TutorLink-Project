<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link active-if-payment"><i class="fas fa-credit-card"></i><span>Payments</span></a>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
</div>
