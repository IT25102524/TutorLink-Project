<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tutor Registration - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>

<div class="left-panel" style="background-image: url('${pageContext.request.contextPath}/images/auth-tutor-bg.jpg');">
    <div class="lp-grid"></div>
    <a href="${pageContext.request.contextPath}/" class="lp-brand">
        <div class="lp-icon"><i class="fas fa-graduation-cap"></i></div>
        <div class="lp-name">Tutor<span>Link</span></div>
    </a>
    <h2 class="lp-heading">Grow Your<br><span class="gradient">Teaching Career</span></h2>
    <p class="lp-sub">Join as a tutor and reach thousands of students looking for quality education.</p>
    <ul class="lp-points">
        <li><div class="lp-pt-icon"><i class="fas fa-users"></i></div>Get discovered by students in your district</li>
        <li><div class="lp-pt-icon"><i class="fas fa-wallet"></i></div>Set your own rates for online and home visits</li>
        <li><div class="lp-pt-icon"><i class="fas fa-chart-line"></i></div>Build your reputation with reviews</li>
    </ul>
    <div class="lp-stats">
        <div class="lp-stat"><div class="lp-stat-num">500+</div><div class="lp-stat-lbl">Tutors</div></div>
        <div class="lp-stat"><div class="lp-stat-num">2K+</div><div class="lp-stat-lbl">Students</div></div>
        <div class="lp-stat"><div class="lp-stat-num">13</div><div class="lp-stat-lbl">Districts</div></div>
    </div>
</div>

<div class="right-panel scroll-top">
    <div class="form-box wide">
        <a href="${pageContext.request.contextPath}/register" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to role selection
        </a>
        <h3 class="form-title">Tutor Registration</h3>
        <p class="form-sub">Join TutorLink and start teaching students</p>

        <c:if test="${not empty error}">
            <div class="alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register/tutor" method="post">
            <div class="row g-3">

                <div class="col-12 mb-field">
                    <label class="form-lbl">Full Name *</label>
                    <input type="text" name="fullName" class="form-input" placeholder="Enter your full name" required>
                </div>
                <div class="col-md-6 mb-field">
                    <label class="form-lbl">Email *</label>
                    <input type="email" name="email" class="form-input" placeholder="you@example.com" required>
                </div>
                <div class="col-md-6 mb-field">
                    <label class="form-lbl">Phone *</label>
                    <input type="text" name="phone" class="form-input" placeholder="07X XXXXXXX" required>
                </div>
                <div class="col-md-6 mb-field">
                    <label class="form-lbl">Password *</label>
                    <div class="password-wrapper">
                        <input type="password" name="password" class="form-input" placeholder="Create a password" required id="tutorPassword">
                        <button type="button" class="password-toggle" onclick="togglePw('tutorPassword','eyeTutor')">
                            <i class="fas fa-eye" id="eyeTutor"></i>
                        </button>
                    </div>
                </div>

                <div class="col-md-6 mb-field">
                    <label class="form-lbl">District *</label>
                    <select name="district" class="form-select" required>
                        <option value="">Select your district</option>
                        <c:forEach var="d" items="${districts}">
                            <option value="${d}" ${district == d ? 'selected' : ''}>${d}</option>
                        </c:forEach>
                    </select>
                </div>


                <div class="col-12 mb-field">
                    <div style="background:rgba(5,150,105,0.08);border:1px solid rgba(5,150,105,0.2);border-radius:12px;padding:14px 18px;display:flex;align-items:flex-start;gap:12px;">
                        <i class="fas fa-info-circle" style="color:#059669;margin-top:2px;flex-shrink:0;"></i>
                        <div>
                            <div style="font-weight:700;color:#059669;font-size:0.88rem;margin-bottom:3px;">Complete Your Profile After Registration</div>
                            <div style="font-size:0.82rem;color:#64748b;">Once registered, you can add your experience, qualifications, bio, and travel radius from <strong>Edit Profile</strong> in your dashboard.</div>
                        </div>
                    </div>
                </div>
                <div class="col-12 mb-field">
                    <div style="background:rgba(5,150,105,0.08);border:1px solid rgba(5,150,105,0.2);border-radius:12px;padding:14px 18px;display:flex;align-items:flex-start;gap:12px;">
                        <i class="fas fa-info-circle" style="color:#059669;margin-top:2px;flex-shrink:0;"></i>
                        <div>
                            <div style="font-weight:700;color:#059669;font-size:0.88rem;margin-bottom:3px;">Teaching Subjects & Rates</div>
                            <div style="font-size:0.82rem;color:#64748b;">You can add your teaching subjects, medium, mode, and rates after registration from <strong>My Subjects</strong> in your dashboard.</div>
                        </div>
                    </div>
                </div>
                <div class="col-12 mt-1">
                    <button type="submit" class="btn-submit tutor-btn">
                        <span>Create Tutor Account</span>
                        <span class="btn-shine"></span>
                    </button>
                </div>
            </div>
        </form>

        <p class="auth-bottom-text">
            Already registered? <a href="${pageContext.request.contextPath}/login" class="link-primary">Sign in</a>
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePw(inputId, iconId) {
        var input = document.getElementById(inputId);
        var icon  = document.getElementById(iconId);
        if (input.type === 'password') { input.type = 'text'; icon.classList.replace('fa-eye','fa-eye-slash'); }
        else { input.type = 'password'; icon.classList.replace('fa-eye-slash','fa-eye'); }
    }
</script>
</body>
</html>
