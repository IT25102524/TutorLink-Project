<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Registration - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<div class="left-panel" style="background-image: url('${pageContext.request.contextPath}/images/auth-student-bg.jpg');">
        <div class="lp-grid"></div>
        <a href="${pageContext.request.contextPath}/" class="lp-brand">
            <div class="lp-icon"><i class="fas fa-graduation-cap"></i></div>
            <div class="lp-name">Tutor<span>Link</span></div>
        </a>
        <h2 class="lp-heading">Start Your<br><span class="gradient">Learning Journey</span></h2>
        <p class="lp-sub">Create your student account and find the perfect tutor in your district.</p>



        <ul class="lp-points">
            <li>
                <div class="lp-pt-icon"><i class="fas fa-search"></i></div>
                Search tutors by subject & area
            </li>
            <li>
                <div class="lp-pt-icon"><i class="fas fa-calendar-check"></i></div>
                Book home visits or online sessions
            </li>
            <li>
                <div class="lp-pt-icon"><i class="fas fa-star"></i></div>
                Review tutors after each session
            </li>
        </ul>
        <div class="lp-stats">
            <div class="lp-stat"><div class="lp-stat-num">500+</div><div class="lp-stat-lbl">Tutors</div></div>
            <div class="lp-stat"><div class="lp-stat-num">25+</div><div class="lp-stat-lbl">Subjects</div></div>
            <div class="lp-stat"><div class="lp-stat-num">13</div><div class="lp-stat-lbl">Districts</div></div>
        </div>
    </div>
<div class="right-panel scroll-top">
        <div class="form-box wide">

            <a href="${pageContext.request.contextPath}/register" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to role selection
            </a>

            <h3 class="form-title">Student Registration</h3>
            <p class="form-sub">Create your account to find and book tutors</p>

            <c:if test="${not empty error}">
                <div class="alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register/student" method="post" id="studentRegForm">
                <div class="row g-3">
                    <div class="col-12 mb-field">
                        <label class="form-lbl">Full Name *</label>
                        <input type="text" name="fullName" class="form-input" placeholder="Enter your full name" required id="studentName">
                    </div>
                    <div class="col-md-6 mb-field">
                        <label class="form-lbl">Email *</label>
                        <input type="email" name="email" class="form-input" placeholder="you@example.com" required id="studentEmail">
                    </div>
                    <div class="col-md-6 mb-field">
                        <label class="form-lbl">Phone</label>
                        <input type="text" name="phone" class="form-input" placeholder="07X XXXXXXX" id="studentPhone">
                    </div>
                    <div class="col-md-6 mb-field">
                        <label class="form-lbl">Password *</label>
                        <div class="password-wrapper">
                            <input type="password" name="password" class="form-input" placeholder="Create a password" required id="studentPassword">
                            <button type="button" class="password-toggle" onclick="togglePw('studentPassword','eyeStudent')">
                                <i class="fas fa-eye" id="eyeStudent"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6 mb-field">
                        <label class="form-lbl">Grade Level *</label>
                        <select name="gradeLevel" class="form-select" required id="studentGrade">
                            <option value="">Select grade</option>
                            <c:forEach begin="1" end="13" var="g">
                                <option value="${g}">Grade ${g}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-12 mb-field">
                        <label class="form-lbl">Address *</label>
                        <input type="text" name="address" class="form-input" placeholder="Your home address" required id="studentAddress">
                    </div>
                    <div class="col-12 mb-field">
                        <label class="form-lbl">District *</label>
                        <select name="district" class="form-select" required id="studentDistrict">
                            <option value="">Select your district</option>
                            <c:forEach var="d" items="${districts}">
                                <option value="${d}" ${district == d ? 'selected' : ''}>${d}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-12 mt-1">
                        <button type="submit" class="btn-submit" id="studentSubmitBtn">
                            <span>Create Student Account</span>
                            <span class="btn-shine"></span>
                        </button>
                    </div>
                </div>
            </form>

            <p class="auth-bottom-text">
                Already registered?
                <a href="${pageContext.request.contextPath}/login" class="link-primary">Sign in</a>
            </p>

        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function togglePw(inputId, iconId) {
    const input = document.getElementById(inputId);
    const icon = document.getElementById(iconId);
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
