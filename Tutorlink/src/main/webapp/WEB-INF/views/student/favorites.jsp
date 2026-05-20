<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Favorites - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <style>
        .fav-hero {
            background: linear-gradient(135deg, #dc2626 0%, #f43f5e 50%, #fb7185 100%);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            position: relative;
            overflow: hidden;
        }
        .fav-hero::before {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 200px; height: 200px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }
        .fav-hero-title {
            font-size: 1.5rem;
            font-weight: 900;
            color: #fff;
            margin: 0 0 0.3rem;
        }
        .fav-hero-sub {
            color: rgba(255,255,255,0.8);
            font-size: 0.88rem;
            margin: 0;
        }
        .fav-hero-count {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.25);
            border-radius: 20px;
            padding: 5px 14px;
            font-size: 0.82rem;
            font-weight: 700;
            color: #fff;
            margin-top: 0.8rem;
        }
        .fav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.2rem;
        }
        .fav-card {
            background: var(--s-card, #fff);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
            transition: transform 0.22s, box-shadow 0.22s;
            position: relative;
        }
        .fav-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 40px rgba(220,38,38,0.12);
        }
        .fav-accent {
            height: 5px;
            background: linear-gradient(90deg, #dc2626, #f43f5e, #fb7185);
        }
        .fav-body {
            padding: 1.4rem;
        }
        .fav-top {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .fav-avatar {
            width: 56px; height: 56px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; font-weight: 900; color: #fff;
            flex-shrink: 0;
        }
        .fav-name {
            font-size: 1.05rem;
            font-weight: 800;
            color: var(--s-text, #1e293b);
        }
        .fav-meta-pills {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin-top: 4px;
        }
        .fav-meta-pill {
            font-size: 0.72rem;
            font-weight: 700;
            padding: 2px 10px;
            border-radius: 20px;
        }
        .fav-meta-pill.subject {
            background: rgba(37,99,235,0.08);
            color: #2563eb;
            border: 1px solid rgba(37,99,235,0.18);
        }
        .fav-meta-pill.location {
            background: rgba(239,68,68,0.08);
            color: #dc2626;
            border: 1px solid rgba(239,68,68,0.18);
        }
        .fav-meta-pill.exp {
            background: rgba(245,158,11,0.08);
            color: #d97706;
            border: 1px solid rgba(245,158,11,0.18);
        }
        .fav-rates {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-bottom: 1rem;
        }
        .fav-rate-box {
            border-radius: 12px;
            padding: 10px 8px;
            text-align: center;
        }
        .fav-rate-box.online {
            background: rgba(6,182,212,0.07);
            border: 1px solid rgba(6,182,212,0.18);
        }
        .fav-rate-box.home {
            background: rgba(139,92,246,0.07);
            border: 1px solid rgba(139,92,246,0.18);
        }
        .fav-rate-label {
            font-size: 0.62rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            margin-bottom: 2px;
        }
        .fav-rate-box.online .fav-rate-label { color: #0891b2; }
        .fav-rate-box.home .fav-rate-label { color: #7c3aed; }
        .fav-rate-amt {
            font-weight: 900;
            font-size: 0.88rem;
            color: var(--text-main, #1e293b);
        }
        .fav-actions {
            display: flex;
            gap: 8px;
        }
        .fav-btn-view {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 10px;
            background: linear-gradient(135deg, #2563eb, #0891b2);
            color: #fff;
            font-weight: 700;
            font-size: 0.82rem;
            border-radius: 12px;
            text-decoration: none;
            transition: opacity 0.18s;
        }
        .fav-btn-view:hover { opacity: 0.9; color: #fff; }
        .fav-btn-remove {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            background: rgba(239,68,68,0.08);
            border: 2px solid rgba(239,68,68,0.2);
            color: #dc2626;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.18s;
            font-size: 0.9rem;
        }
        .fav-btn-remove:hover {
            background: #dc2626;
            color: #fff;
            border-color: #dc2626;
        }
        .fav-date {
            font-size: 0.72rem;
            color: var(--text-muted, #94a3b8);
            margin-top: 0.7rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .empty-fav {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--s-card, #fff);
            border-radius: 18px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.05);
        }
        .empty-fav i {
            font-size: 3.5rem;
            color: #fca5a5;
            margin-bottom: 1rem;
        }
        .empty-fav h5 {
            color: var(--s-text, #1e293b);
            font-weight: 800;
        }
        .empty-fav p {
            color: var(--s-text-sec, #64748b);
            font-size: 0.88rem;
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
            <i class="fas fa-search"></i><span>Find & Book Tutor</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/favorites" class="sb-link active">
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
        <a href="${pageContext.request.contextPath}/student/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div>
</div>

<div class="main-content">

    <%-- Alerts --%>
    <c:if test="${param.fav == 'added'}">
        <div class="alert-modern alert-success"><i class="fas fa-heart"></i> Tutor added to favorites!</div>
    </c:if>
    <c:if test="${param.fav == 'removed'}">
        <div class="alert-modern alert-success"><i class="fas fa-heart-broken"></i> Tutor removed from favorites.</div>
    </c:if>

    <%-- Hero --%>
    <div class="fav-hero">
        <div class="fav-hero-title"><i class="fas fa-heart me-2"></i>My Favorite Tutors</div>
        <div class="fav-hero-sub">Your saved tutors for quick access and booking.</div>
        <div class="fav-hero-count"><i class="fas fa-heart"></i> ${favorites.size()} saved</div>
    </div>

    <%-- Content --%>
    <c:choose>
        <c:when test="${empty favorites}">
            <div class="empty-fav">
                <i class="far fa-heart"></i>
                <h5>No favorites yet</h5>
                <p>Browse tutors and click the ❤️ button to save your favorites here.</p>
                <a href="${pageContext.request.contextPath}/student/search" class="btn-primary-modern mt-3">
                    <i class="fas fa-search me-1"></i> Find Tutors
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="fav-grid">
                <c:forEach var="f" items="${favorites}" varStatus="loop">
                    <c:set var="idx" value="${loop.index % 6}" />
                    <c:choose>
                        <c:when test="${idx == 0}"><c:set var="grad" value="linear-gradient(135deg,#3b82f6,#60a5fa)"/></c:when>
                        <c:when test="${idx == 1}"><c:set var="grad" value="linear-gradient(135deg,#10b981,#34d399)"/></c:when>
                        <c:when test="${idx == 2}"><c:set var="grad" value="linear-gradient(135deg,#f59e0b,#fbbf24)"/></c:when>
                        <c:when test="${idx == 3}"><c:set var="grad" value="linear-gradient(135deg,#8b5cf6,#a78bfa)"/></c:when>
                        <c:when test="${idx == 4}"><c:set var="grad" value="linear-gradient(135deg,#f43f5e,#fb7185)"/></c:when>
                        <c:otherwise><c:set var="grad" value="linear-gradient(135deg,#06b6d4,#22d3ee)"/></c:otherwise>
                    </c:choose>
                    <div class="fav-card">
                        <div class="fav-accent"></div>
                        <div class="fav-body">
                            <div class="fav-top">
                                <div class="fav-avatar" style="background:${grad};">${f.tutorName.charAt(0)}</div>
                                <div>
                                    <div class="fav-name">${f.tutorName}</div>
                                    <div class="fav-meta-pills">
                                        <c:if test="${not empty f.tutorSubject}">
                                            <span class="fav-meta-pill subject"><i class="fas fa-book me-1"></i>${f.tutorSubject}</span>
                                        </c:if>
                                        <c:if test="${not empty f.tutorDistrict}">
                                            <span class="fav-meta-pill location"><i class="fas fa-map-marker-alt me-1"></i>${f.tutorDistrict}</span>
                                        </c:if>
                                        <c:if test="${not empty f.tutorExperience}">
                                            <span class="fav-meta-pill exp"><i class="fas fa-award me-1"></i>${f.tutorExperience}</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="fav-rates">
                                <div class="fav-rate-box online">
                                    <div class="fav-rate-label"><i class="fas fa-laptop me-1"></i>Online</div>
                                    <div class="fav-rate-amt">LKR ${f.tutorOnlineRate}/hr</div>
                                </div>
                                <div class="fav-rate-box home">
                                    <div class="fav-rate-label"><i class="fas fa-home me-1"></i>Home Visit</div>
                                    <div class="fav-rate-amt">LKR ${f.tutorHomeVisitRate}/hr</div>
                                </div>
                            </div>

                            <div class="fav-actions">
                                <a href="${pageContext.request.contextPath}/student/view-tutor/${f.tutorId}" class="fav-btn-view">
                                    <i class="fas fa-user"></i> View Profile & Book
                                </a>
                                <form action="${pageContext.request.contextPath}/student/favorite/toggle/${f.tutorId}" method="post" style="margin:0;">
                                    <input type="hidden" name="returnUrl" value="/student/favorites">
                                    <button type="submit" class="fav-btn-remove" onclick="return confirm('Remove from favorites?')">
                                        <i class="fas fa-heart-broken"></i>
                                    </button>
                                </form>
                            </div>

                            <div class="fav-date"><i class="far fa-clock"></i> Added: ${f.formattedDate}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function() {
        var STORAGE_KEY = 'tl_theme';
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
        applyTheme(saved ? saved : getDefault());
        window.__tlToggleTheme = function() {
            var cur = html.getAttribute('data-theme') || getDefault(); var next = getOpposite(cur);
            localStorage.setItem(STORAGE_KEY, next);
            applyTheme(next);
        };
    })();
</script>

</body>
</html>
