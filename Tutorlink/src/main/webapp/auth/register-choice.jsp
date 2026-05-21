<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Join TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<div class="left-panel" style="background-image: url('${pageContext.request.contextPath}/images/auth-choice-bg.jpg');">
        <div class="lp-grid"></div>
        <a href="${pageContext.request.contextPath}/" class="lp-brand">
            <div class="lp-icon"><i class="fas fa-graduation-cap"></i></div>
            <div class="lp-name">Tutor<span>Link</span></div>
        </a>
        <h2 class="lp-heading">Join Thousands<br><span class="gradient">Already Learning</span></h2>
        <p class="lp-sub">Create your free account and connect with the best tutors across Sri Lanka.</p>



        <ul class="lp-points">
            <li>
                <div class="lp-pt-icon"><i class="fas fa-user-graduate"></i></div>
                Students find tutors by subject & district
            </li>
            <li>
                <div class="lp-pt-icon"><i class="fas fa-chalkboard-teacher"></i></div>
                Tutors get discovered & manage bookings
            </li>
            <li>
                <div class="lp-pt-icon"><i class="fas fa-shield-alt"></i></div>
                Completely free to register and get started
            </li>
        </ul>
        <div class="lp-stats">
            <div class="lp-stat"><div class="lp-stat-num">500+</div><div class="lp-stat-lbl">Tutors</div></div>
            <div class="lp-stat"><div class="lp-stat-num">2K+</div><div class="lp-stat-lbl">Students</div></div>
            <div class="lp-stat"><div class="lp-stat-num">13</div><div class="lp-stat-lbl">Districts</div></div>
        </div>
    </div>
<div class="right-panel">
        <div class="form-box">

            <a href="${pageContext.request.contextPath}/" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to home
            </a>

            <h3 class="form-title">How would you like to join?</h3>
            <p class="form-sub">Choose your role to create your account</p>

            <a href="${pageContext.request.contextPath}/register/student" class="role-card student" id="roleStudent">
                <div class="role-icon student-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="role-title">I'm a Student</div>
                <div class="role-desc">Find and book qualified home tutors near you</div>
                <div class="role-arrow">Get started <i class="fas fa-arrow-right"></i></div>
            </a>

            <a href="${pageContext.request.contextPath}/register/tutor" class="role-card tutor" id="roleTutor">
                <div class="role-icon tutor-icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div class="role-title">I'm a Tutor</div>
                <div class="role-desc">Offer sessions, manage bookings & grow your reach</div>
                <div class="role-arrow">Get started <i class="fas fa-arrow-right"></i></div>
            </a>

            <p class="auth-bottom-text" style="margin-top:1.5rem;">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login" class="link-primary">Sign in</a>
            </p>

        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
