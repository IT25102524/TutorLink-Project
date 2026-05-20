<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Profile - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <style>
        .profile-avatar {
            width: 80px; height: 80px; border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 2rem; font-weight: 800;
            box-shadow: 0 4px 15px rgba(37,99,235,0.3);
            flex-shrink: 0;
        }
        .info-label {
            font-size: 0.8rem; color: var(--text-muted);
            text-transform: uppercase; font-weight: 700;
            letter-spacing: 0.5px; margin-bottom: 4px;
        }
        .info-value {
            font-size: 1rem; color: var(--text-main); font-weight: 500;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-brand">
        <div class="sb-logo"><i class="fas fa-graduation-cap"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </a>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-link">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/search" class="sb-link">
            <i class="fas fa-search"></i><span>Find &amp; Book Tutor</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/favorites" class="sb-link">
            <i class="fas fa-heart"></i><span>My Favorites</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/goals" class="sb-link">
            <i class="fas fa-chart-line"></i><span>Learning Progress</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/bookings" class="sb-link">
            <i class="fas fa-calendar-check"></i><span>My Bookings</span>
        </a>

        <a href="${pageContext.request.contextPath}/student/reviews" class="sb-link">
            <i class="fas fa-star"></i><span>My Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/profile" class="sb-link active">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
    </nav>



    <a href="${pageContext.request.contextPath}/logout" class="sb-logout">
        <i class="fas fa-sign-out-alt"></i><span>Logout</span>
    </a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">My Profile</h4>
            <p class="page-sub">Manage your personal account details.</p>
        </div>
        <a href="${pageContext.request.contextPath}/student/profile/edit" class="btn-primary-modern">
            <i class="fas fa-edit"></i> Edit Profile
        </a>
    </div>

    <c:if test="${param.updated == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Profile updated successfully!</div>
    </c:if>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="d-flex align-items-center gap-4 mb-5 pb-4 border-bottom">
                    <div class="profile-avatar">${student.fullName.charAt(0)}</div>
                    <div>
                        <h4 style="font-weight: 800; color: var(--text-main); margin-bottom: 4px;">${student.fullName}</h4>
                        <span class="status-badge" style="background: var(--sidebar-active); color: var(--primary);">STUDENT ACCOUNT</span>
                    </div>
                </div>

                <div class="row g-4 mb-2">
                    <div class="col-sm-6">
                        <div class="info-label"><i class="far fa-envelope me-1"></i> Email Address</div>
                        <div class="info-value">${student.email}</div>
                    </div>
                    <div class="col-sm-6">
                        <div class="info-label"><i class="fas fa-phone-alt me-1"></i> Phone Number</div>
                        <div class="info-value"><c:out value="${not empty student.phone ? student.phone : '-'}"/></div>
                    </div>
                    <div class="col-sm-6">
                        <div class="info-label"><i class="fas fa-graduation-cap me-1"></i> Grade Level</div>
                        <div class="info-value">
                            <span class="badge bg-light text-dark border px-2 py-1">Grade ${student.gradeLevel}</span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="info-label"><i class="fas fa-map-marker-alt me-1"></i> District</div>
                        <div class="info-value">${student.district}</div>
                    </div>
                    <div class="col-12">
                        <div class="info-label"><i class="fas fa-home me-1"></i> Full Address</div>
                        <div class="info-value">${student.address}</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm" style="border-top: 4px solid var(--danger);">
                <h5 class="card-header-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i> Danger Zone</h5>
                <p class="text-muted small mb-4">Deleting your account will permanently remove all your bookings, reviews, and personal data. This action cannot be undone.</p>
                <form action="${pageContext.request.contextPath}/student/delete" method="post" onsubmit="return confirm('Are you absolutely sure you want to delete your account? This cannot be undone.')">
                    <button type="submit" class="btn-danger-outline w-100 justify-content-center py-2">
                        <i class="fas fa-trash-alt"></i> Delete My Account
                    </button>
                </form>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const avatars = document.querySelectorAll('.tc-avatar, .tutor-avatar-large, .profile-avatar, .tb-avatar');
        const gradients = [
            'linear-gradient(135deg, #3b82f6, #60a5fa)',
            'linear-gradient(135deg, #10b981, #34d399)',
            'linear-gradient(135deg, #f59e0b, #fbbf24)',
            'linear-gradient(135deg, #8b5cf6, #a78bfa)',
            'linear-gradient(135deg, #f43f5e, #fb7185)',
            'linear-gradient(135deg, #06b6d4, #22d3ee)'
        ];
        avatars.forEach(avatar => {
            const text = avatar.innerText.trim();
            if (text.length > 0) {
                const charCode = text.charCodeAt(0);
                const colorIndex = charCode % gradients.length;
                avatar.style.background = gradients[colorIndex];
                avatar.style.color = '#fff';
                avatar.style.border = 'none';
            }
        });
    });
</script>

<script>
    (function() {
        var STORAGE_KEY = 'tl_theme';
        // Clear any stale/corrupted theme value from old buggy code
        var _saved = localStorage.getItem(STORAGE_KEY);
        if (_saved !== 'light' && _saved !== 'dark') { localStorage.removeItem(STORAGE_KEY); }
        var html = document.documentElement;
        var isAdmin = document.querySelector('link[href*="admin.css"]') !== null;
        function getDefault() { return isAdmin ? 'dark' : 'light'; }
        function getOpposite(t) { return t === 'dark' ? 'light' : 'dark'; }
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
            var cur = html.getAttribute('data-theme') || getDefault(); var next = getOpposite(cur);
            localStorage.setItem(STORAGE_KEY, next);
            applyTheme(next);
        };
    })();
</script>
</body>
</html>
