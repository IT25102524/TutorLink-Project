<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<div class="left-panel" style="background-image: url('${pageContext.request.contextPath}/images/auth-login-bg.jpg');">
        <div class="lp-grid"></div>
        <a href="${pageContext.request.contextPath}/" class="lp-brand">
            <div class="lp-icon"><i class="fas fa-graduation-cap"></i></div>
            <div class="lp-name">Tutor<span>Link</span></div>
        </a>
        <h2 class="lp-heading">Welcome Back to<br><span class="gradient">TutorLink</span></h2>
        <p class="lp-sub">Sign in to access your dashboard, manage bookings, and continue your learning journey.</p>



        <ul class="lp-points">
            <li>
                <div class="lp-pt-icon"><i class="fas fa-search"></i></div>
                Search tutors by subject & district
            </li>
            <li>
                <div class="lp-pt-icon"><i class="fas fa-calendar-check"></i></div>
                Book sessions instantly online or at home
            </li>
            <li>
                <div class="lp-pt-icon"><i class="fas fa-star"></i></div>
                Read verified reviews from real students
            </li>
        </ul>
        <div class="lp-stats">
            <div class="lp-stat"><div class="lp-stat-num">500+</div><div class="lp-stat-lbl">Tutors</div></div>
            <div class="lp-stat"><div class="lp-stat-num">2K+</div><div class="lp-stat-lbl">Students</div></div>
            <div class="lp-stat"><div class="lp-stat-num">25+</div><div class="lp-stat-lbl">Subjects</div></div>
        </div>
    </div>
<div class="right-panel">
        <div class="form-box">

            <a href="${pageContext.request.contextPath}/" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to home
            </a>

            <h3 class="form-title">Sign in to your account</h3>
            <p class="form-sub">Enter your credentials to continue</p>

            <c:if test="${param.registered == 'true'}">
                <div class="alert-success">
                    <i class="fas fa-check-circle"></i> Account created successfully! Please login.
                </div>
            </c:if>

            <c:if test="${param.deleted == 'true'}">
                <div class="alert-success">
                    <i class="fas fa-check-circle"></i> Your account has been deleted.
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">

                <div class="mb-field">
                    <label class="form-lbl">Email Address</label>
                    <input class="form-input" type="email" name="email" placeholder="you@example.com" required id="loginEmail">
                </div>

                <div class="mb-field">
                    <label class="form-lbl">Password</label>
                    <div class="password-wrapper">
                        <input class="form-input" type="password" name="password" placeholder="Enter your password" required id="loginPassword">
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-submit" style="margin-top:0.5rem;" id="loginSubmitBtn">
                    <span>Sign In</span>
                    <span class="btn-shine"></span>
                </button>

            </form>

            <div class="divider">or</div>

            <p class="auth-bottom-text">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register" class="link-primary">Create one free</a>
            </p>

        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function togglePassword() {
    const input = document.getElementById('loginPassword');
    const icon = document.getElementById('eyeIcon');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
}
</script>
</body>
</html>
