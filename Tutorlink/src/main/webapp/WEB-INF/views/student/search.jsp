<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Find & Book Tutor - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css">
    <style>
        /* ── HERO BAND ───────────────────────────────────────────── */
        .search-hero {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 50%, #0891b2 100%);
            border-radius: 20px;
            padding: 2rem 2rem 3.5rem;
            margin-bottom: -2.2rem;
            position: relative;
            overflow: hidden;
        }
        .search-hero::before {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 220px; height: 220px;
            background: rgba(255,255,255,0.06);
            border-radius: 50%;
        }
        .search-hero::after {
            content: '';
            position: absolute;
            bottom: -60px; left: 30%;
            width: 300px; height: 300px;
            background: rgba(255,255,255,0.04);
            border-radius: 50%;
        }
        .hero-title {
            font-size: 1.65rem;
            font-weight: 900;
            color: #fff;
            margin: 0 0 0.3rem;
            letter-spacing: -0.3px;
        }
        .hero-sub {
            color: rgba(255,255,255,0.75);
            font-size: 0.9rem;
            margin: 0 0 1.4rem;
        }
        .hero-stats {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
        }
        .hero-stat {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            color: rgba(255,255,255,0.9);
            font-size: 0.82rem;
            font-weight: 700;
            background: rgba(255,255,255,0.12);
            padding: 5px 14px;
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.15);
        }
        .hero-stat i { font-size: 0.75rem; opacity: 0.85; }

        /* ── FILTER CARD ─────────────────────────────────────────── */
        .filter-card {
            background: var(--s-card, #fff);
            border-radius: 18px;
            padding: 1.6rem 1.8rem 1.4rem;
            box-shadow: 0 8px 40px rgba(37,99,235,0.10);
            position: relative;
            z-index: 2;
            margin-bottom: 1.5rem;
        }
        .filter-card .form-label {
            font-size: 0.78rem;
            font-weight: 700;
            color: var(--s-text-sec, #64748b);
            margin-bottom: 0.35rem;
        }
        .filter-card .form-select,
        .filter-card .form-control {
            border-radius: 10px;
            border: 1.5px solid #e2e8f0;
            font-size: 0.87rem;
            transition: border-color 0.2s;
        }
        .filter-card .form-select:focus,
        .filter-card .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.08);
        }

        /* ── QUICK SUBJECT PILLS ─────────────────────────────────── */
        .quick-pills {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 1.2rem;
            align-items: center;
        }
        .quick-label {
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--s-text-sec, #64748b);
            white-space: nowrap;
        }
        .quick-pill {
            background: rgba(37,99,235,0.07);
            color: #2563eb;
            border: 1.5px solid rgba(37,99,235,0.18);
            border-radius: 20px;
            padding: 4px 14px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.18s;
            text-decoration: none;
            white-space: nowrap;
        }
        .quick-pill:hover, .quick-pill.active-pill {
            background: #2563eb;
            color: #fff;
            border-color: #2563eb;
        }

        /* ── RESULTS HEADER ──────────────────────────────────────── */
        .results-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.2rem;
        }
        .results-count {
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .results-count-badge {
            background: linear-gradient(135deg, #2563eb, #0891b2);
            color: #fff;
            font-size: 0.82rem;
            font-weight: 800;
            padding: 4px 14px;
            border-radius: 20px;
        }
        .results-count-label {
            color: var(--s-text-sec, #64748b);
            font-size: 0.88rem;
            font-weight: 600;
        }

        /* ── TUTOR CARD ──────────────────────────────────────────── */
        .tutor-card-v2 {
            background: var(--s-card, #fff);
            border-radius: 18px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.22s, box-shadow 0.22s;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
            position: relative;
        }
        .tutor-card-v2:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(37,99,235,0.15);
        }
        .tc-accent-bar {
            height: 5px;
            width: 100%;
        }
        .tc-body {
            padding: 1.4rem 1.4rem 1.2rem;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .tc-avatar-v2 {
            width: 72px; height: 72px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem; font-weight: 900; color: #fff;
            margin: 0 auto 0.9rem;
            position: relative;
        }
        .tc-verified {
            position: absolute;
            bottom: 1px; right: -2px;
            width: 22px; height: 22px;
            background: #10b981;
            border-radius: 50%;
            border: 2px solid var(--s-card, #fff);
            display: flex; align-items: center; justify-content: center;
        }
        .tc-verified i { font-size: 0.5rem; color: #fff; }
        .tc-name-v2 {
            font-size: 1rem;
            font-weight: 800;
            color: var(--s-text, #1e293b);
            text-align: center;
            margin-bottom: 0.6rem;
        }
        .tc-subjects {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 4px;
            margin-bottom: 0.7rem;
        }
        .tc-subject-pill {
            background: rgba(5,150,105,0.1);
            color: #059669;
            font-size: 0.71rem;
            font-weight: 700;
            padding: 2px 10px;
            border-radius: 20px;
            border: 1px solid rgba(5,150,105,0.2);
        }
        .tc-meta {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 0.8rem;
        }
        .tc-meta-pill {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 0.76rem;
            font-weight: 700;
            padding: 3px 11px;
            border-radius: 20px;
        }
        .tc-meta-pill.location {
            background: rgba(37,99,235,0.08);
            color: #2563eb;
            border: 1px solid rgba(37,99,235,0.18);
        }
        .tc-meta-pill.exp {
            background: rgba(245,158,11,0.1);
            color: #d97706;
            border: 1px solid rgba(245,158,11,0.2);
        }
        .tc-mode-pill {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 0.71rem;
            font-weight: 800;
            padding: 2px 10px;
            border-radius: 20px;
            background: rgba(139,92,246,0.09);
            color: #7c3aed;
            border: 1px solid rgba(139,92,246,0.18);
        }
        .tc-bio {
            font-size: 0.8rem;
            color: var(--text-muted, #94a3b8);
            text-align: center;
            font-style: italic;
            line-height: 1.55;
            margin-bottom: 1rem;
            flex: 1;
        }
        .tc-rates {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-bottom: 1rem;
        }
        .tc-rate-box {
            border-radius: 12px;
            padding: 9px 8px;
            text-align: center;
        }
        .tc-rate-box.online {
            background: rgba(6,182,212,0.07);
            border: 1px solid rgba(6,182,212,0.18);
        }
        .tc-rate-box.home {
            background: rgba(139,92,246,0.07);
            border: 1px solid rgba(139,92,246,0.18);
        }
        .tc-rate-label {
            font-size: 0.62rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 3px;
        }
        .tc-rate-box.online .tc-rate-label { color: #0891b2; }
        .tc-rate-box.home   .tc-rate-label { color: #7c3aed; }
        .tc-rate-amt {
            font-weight: 900;
            font-size: 0.88rem;
            color: var(--text-main, #1e293b);
        }
        .tc-rate-per {
            font-size: 0.6rem;
            color: var(--text-muted, #94a3b8);
        }
        .tc-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            width: 100%;
            padding: 10px;
            background: linear-gradient(135deg, #2563eb, #0891b2);
            color: #fff;
            font-weight: 700;
            font-size: 0.85rem;
            border-radius: 12px;
            text-decoration: none;
            transition: opacity 0.18s, transform 0.18s;
        }
        .tc-btn:hover { opacity: 0.9; transform: scale(1.01); color: #fff; }

        /* ── TUTOR GRID ──────────────────────────────────────────── */
        .tutor-grid-v2 {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
            gap: 1.2rem;
        }

        /* ── EMPTY STATE ─────────────────────────────────────────── */
        .empty-search {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--s-card, #fff);
            border-radius: 18px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.05);
        }
        .empty-search i {
            font-size: 3rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }
        .empty-search h5 { color: var(--s-text, #1e293b); font-weight: 800; }
        .empty-search p  { color: var(--s-text-sec, #64748b); font-size: 0.88rem; }
    </style>
</head>
<body>

<%-- ── SIDEBAR ──────────────────────────────────────────────────── --%>
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-brand">
        <div class="sb-logo"><i class="fas fa-graduation-cap"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </a>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-link">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/search" class="sb-link active">
            <i class="fas fa-search"></i><span>Find & Book Tutor</span>
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
        <a href="${pageContext.request.contextPath}/student/profile" class="sb-link">
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
    </div>
</div>

<%-- ── MAIN CONTENT ────────────────────────────────────────────── --%>
<div class="main-content">

    <%-- HERO BAND --%>
    <div class="search-hero">
        <div class="hero-title"><i class="fas fa-graduation-cap me-2" style="opacity:0.85;"></i>Find Your Perfect Tutor</div>
        <div class="hero-sub">Connect with qualified tutors across Sri Lanka. Filter by subject, location, budget and more.</div>
        <div class="hero-stats">
            <div class="hero-stat"><i class="fas fa-users"></i> <strong>${tutors.size()}</strong>&nbsp;tutors available</div>
            <div class="hero-stat"><i class="fas fa-map-marker-alt"></i> All 25 districts</div>
            <div class="hero-stat"><i class="fas fa-language"></i> Sinhala · English · Tamil</div>
        </div>
    </div>

    <%-- FILTER CARD --%>
    <div class="filter-card">

        <%-- Quick subject pills --%>
        <div class="quick-pills">
            <span class="quick-label"><i class="fas fa-bolt me-1" style="color:#f59e0b;"></i>Quick pick:</span>
            <c:forEach var="s" items="${subjects}" begin="0" end="6">
                <a href="${pageContext.request.contextPath}/student/search?subject=${s}"
                   class="quick-pill ${subject == s ? 'active-pill' : ''}">${s}</a>
            </c:forEach>
        </div>

        <%-- Filter form --%>
        <form action="${pageContext.request.contextPath}/student/search" method="get" id="searchForm">
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-book me-1"></i> Subject</label>
                    <select name="subject" class="form-select" id="sel-subject">
                        <option value="">All Subjects</option>
                        <c:forEach var="s" items="${subjects}">
                            <option value="${s}" ${subject == s ? 'selected' : ''}>${s}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-language me-1"></i> Medium</label>
                    <select name="medium" class="form-select">
                        <option value="">All Mediums</option>
                        <option value="Sinhala"    ${medium == 'Sinhala'    ? 'selected' : ''}>Sinhala</option>
                        <option value="English"    ${medium == 'English'    ? 'selected' : ''}>English</option>
                        <option value="Tamil"      ${medium == 'Tamil'      ? 'selected' : ''}>Tamil</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-chalkboard me-1"></i> Teaching Mode</label>
                    <select name="teachingMode" class="form-select">
                        <option value="">All Modes</option>
                        <option value="ONLINE"     ${teachingMode == 'ONLINE'     ? 'selected' : ''}>Online</option>
                        <option value="HOME_VISIT"  ${teachingMode == 'HOME_VISIT' ? 'selected' : ''}>Home Visit</option>
                        <option value="BOTH"        ${teachingMode == 'BOTH'       ? 'selected' : ''}>Both</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-map-marker-alt me-1"></i> District</label>
                    <select name="district" class="form-select">
                        <option value="">All Districts</option>
                        <c:forEach var="d" items="${districts}">
                            <option value="${d}" ${district == d ? 'selected' : ''}>${d}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-wallet me-1"></i> Budget Range (LKR/hr)</label>
                    <div class="d-flex gap-2">
                        <input type="number" name="minBudget" class="form-control"
                               placeholder="Min" min="0" value="${minBudget > 0 ? minBudget : ''}">
                        <input type="number" name="maxBudget" class="form-control"
                               placeholder="Max" min="0" value="${maxBudget > 0 ? maxBudget : ''}">
                    </div>
                </div>
                <div class="col-md-4 d-flex align-items-end gap-2">
                    <button type="submit" class="btn-primary-modern flex-grow-1">
                        <i class="fas fa-search me-1"></i> Search
                    </button>
                    <a href="${pageContext.request.contextPath}/student/search" class="btn-secondary-modern">
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </div>
        </form>
    </div>

    <%-- SEARCH RESULTS --%>
    <c:choose>
        <c:when test="${empty tutors}">
            <div class="empty-search">
                <i class="fas fa-search-minus"></i>
                <h5>No tutors found</h5>
                <p>Try adjusting your filters or clear them to browse all available tutors.</p>
                <a href="${pageContext.request.contextPath}/student/search" class="btn-secondary-modern d-inline-flex mt-2">
                    <i class="fas fa-redo me-1"></i> View All Tutors
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="results-header">
                <div class="results-count">
                    <span class="results-count-badge"><i class="fas fa-users me-1"></i>${tutors.size()}</span>
                    <span class="results-count-label">
                        tutor(s) found
                        <c:if test="${not empty subject}"> for <strong>${subject}</strong></c:if>
                        <c:if test="${not empty district}"> in <strong>${district}</strong></c:if>
                    </span>
                </div>
            </div>

            <div class="tutor-grid-v2">
                <c:forEach var="t" items="${tutors}" varStatus="loop">
                    <%-- Pick accent gradient cycling through 6 colours --%>
                    <c:set var="idx" value="${loop.index % 6}" />
                    <c:choose>
                        <c:when test="${idx == 0}"><c:set var="grad" value="linear-gradient(90deg,#3b82f6,#60a5fa)"/></c:when>
                        <c:when test="${idx == 1}"><c:set var="grad" value="linear-gradient(90deg,#10b981,#34d399)"/></c:when>
                        <c:when test="${idx == 2}"><c:set var="grad" value="linear-gradient(90deg,#f59e0b,#fbbf24)"/></c:when>
                        <c:when test="${idx == 3}"><c:set var="grad" value="linear-gradient(90deg,#8b5cf6,#a78bfa)"/></c:when>
                        <c:when test="${idx == 4}"><c:set var="grad" value="linear-gradient(90deg,#f43f5e,#fb7185)"/></c:when>
                        <c:otherwise>             <c:set var="grad" value="linear-gradient(90deg,#06b6d4,#22d3ee)"/></c:otherwise>
                    </c:choose>

                    <div class="tutor-card-v2">
                        <div class="tc-accent-bar" style="background:${grad};"></div>
                        <div class="tc-body">

                                <%-- Avatar --%>
                            <div class="tc-avatar-v2" data-name="${t.fullName}">
                                    ${t.fullName.charAt(0)}
                                <div class="tc-verified"><i class="fas fa-check"></i></div>
                            </div>

                                <%-- Name --%>
                            <div class="tc-name-v2">${t.fullName}</div>

                                <%-- Subjects --%>
                            <div class="tc-subjects">
                                <c:forEach var="ts" items="${tutorSubjectsMap[t.tutorId]}" begin="0" end="2">
                                    <span class="tc-subject-pill">${ts.subjectName}</span>
                                </c:forEach>
                            </div>

                                <%-- Meta: location + experience --%>
                            <div class="tc-meta">
                                <c:if test="${not empty t.district}">
                                    <span class="tc-meta-pill location">
                                        <i class="fas fa-map-marker-alt"></i>${t.district}
                                    </span>
                                </c:if>
                                <c:if test="${not empty t.experience}">
                                    <span class="tc-meta-pill exp">
                                        <i class="fas fa-award"></i>${t.experience}
                                    </span>
                                </c:if>
                            </div>

                                <%-- Bio --%>
                            <c:if test="${not empty t.bio}">
                                <p class="tc-bio">
                                    "<c:choose>
                                    <c:when test="${t.bio.length() > 70}">${t.bio.substring(0,70)}...</c:when>
                                    <c:otherwise>${t.bio}</c:otherwise>
                                </c:choose>"
                                </p>
                            </c:if>

                                <%-- Rates --%>
                            <c:set var="minOnline" value="9999999" />
                            <c:set var="maxOnline" value="-1" />
                            <c:set var="minHome" value="9999999" />
                            <c:set var="maxHome" value="-1" />
                            <c:set var="hasOnline" value="false" />
                            <c:set var="hasHome" value="false" />

                            <c:forEach var="ts" items="${tutorSubjectsMap[t.tutorId]}">
                                <c:if test="${ts.teachingMode == 'ONLINE' || ts.teachingMode == 'BOTH'}">
                                    <c:set var="hasOnline" value="true" />
                                    <c:if test="${ts.onlineHourlyRate < minOnline}"><c:set var="minOnline" value="${ts.onlineHourlyRate}" /></c:if>
                                    <c:if test="${ts.onlineHourlyRate > maxOnline}"><c:set var="maxOnline" value="${ts.onlineHourlyRate}" /></c:if>
                                </c:if>
                                <c:if test="${ts.teachingMode == 'HOME VISIT' || ts.teachingMode == 'HOME_VISIT' || ts.teachingMode == 'BOTH'}">
                                    <c:set var="hasHome" value="true" />
                                    <c:if test="${ts.homeVisitHourlyRate < minHome}"><c:set var="minHome" value="${ts.homeVisitHourlyRate}" /></c:if>
                                    <c:if test="${ts.homeVisitHourlyRate > maxHome}"><c:set var="maxHome" value="${ts.homeVisitHourlyRate}" /></c:if>
                                </c:if>
                            </c:forEach>

                            <c:if test="${not hasOnline && not hasHome}">
                                <c:set var="hasOnline" value="true" />
                                <c:set var="minOnline" value="${t.effectiveOnlineRate}" />
                                <c:set var="maxOnline" value="${t.effectiveOnlineRate}" />
                                <c:set var="hasHome" value="true" />
                                <c:set var="minHome" value="${t.effectiveHomeVisitRate}" />
                                <c:set var="maxHome" value="${t.effectiveHomeVisitRate}" />
                            </c:if>

                            <div class="tc-rates mt-auto" style="${hasOnline && hasHome ? '' : 'grid-template-columns: 1fr;'}">
                                <c:if test="${hasOnline}">
                                    <div class="tc-rate-box online">
                                        <div class="tc-rate-label"><i class="fas fa-laptop me-1"></i>Online</div>
                                        <div class="tc-rate-amt">LKR <c:choose><c:when test="${minOnline == maxOnline}">${minOnline}</c:when><c:otherwise>${minOnline} – ${maxOnline}</c:otherwise></c:choose></div>
                                        <div class="tc-rate-per">per hour</div>
                                    </div>
                                </c:if>
                                <c:if test="${hasHome}">
                                    <div class="tc-rate-box home">
                                        <div class="tc-rate-label"><i class="fas fa-home me-1"></i>Home Visit</div>
                                        <div class="tc-rate-amt">LKR <c:choose><c:when test="${minHome == maxHome}">${minHome}</c:when><c:otherwise>${minHome} – ${maxHome}</c:otherwise></c:choose></div>
                                        <div class="tc-rate-per">per hour</div>
                                    </div>
                                </c:if>
                            </div>

                                <%-- CTA --%>
                            <div style="display:flex;gap:8px;width:100%;">
                                <a href="${pageContext.request.contextPath}/student/view-tutor/${t.tutorId}"
                                   class="tc-btn" style="flex:1;">
                                    <i class="fas fa-user"></i> View & Book
                                </a>
                                <form action="${pageContext.request.contextPath}/student/favorite/toggle/${t.tutorId}" method="post" style="margin:0;">
                                    <button type="submit" class="tc-btn" style="width:42px;padding:0;background: ${favoritedTutorIds != null && favoritedTutorIds.contains(t.tutorId) ? 'rgba(239,68,68,0.1)' : 'rgba(100,116,139,0.08)'}; color: ${favoritedTutorIds != null && favoritedTutorIds.contains(t.tutorId) ? '#dc2626' : '#64748b'}; border: 1.5px solid ${favoritedTutorIds != null && favoritedTutorIds.contains(t.tutorId) ? 'rgba(239,68,68,0.2)' : 'rgba(100,116,139,0.15)'};">
                                        <i class="${favoritedTutorIds != null && favoritedTutorIds.contains(t.tutorId) ? 'fas' : 'far'} fa-heart"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div><%-- end main-content --%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%-- Avatar gradients --%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var gradients = [
            'linear-gradient(135deg,#3b82f6,#60a5fa)',
            'linear-gradient(135deg,#10b981,#34d399)',
            'linear-gradient(135deg,#f59e0b,#fbbf24)',
            'linear-gradient(135deg,#8b5cf6,#a78bfa)',
            'linear-gradient(135deg,#f43f5e,#fb7185)',
            'linear-gradient(135deg,#06b6d4,#22d3ee)'
        ];
        document.querySelectorAll('.tc-avatar-v2').forEach(function (el) {
            var ch = (el.dataset.name || el.innerText).trim().charCodeAt(0);
            el.style.background = gradients[ch % gradients.length];
        });
    });
</script>

<%-- Dark mode --%>
<script>
    (function () {
        var STORAGE_KEY = 'tl_theme';
        var _saved = localStorage.getItem(STORAGE_KEY);
        if (_saved !== 'light' && _saved !== 'dark') { localStorage.removeItem(STORAGE_KEY); }
        var html = document.documentElement;
        var isAdmin = document.querySelector('link[href*="admin.css"]') !== null;
        function getDefault() { return isAdmin ? 'dark' : 'light'; }
        function getOpposite(t) { return t === 'dark' ? 'light' : 'dark'; }
        function applyTheme(theme) {
            html.setAttribute('data-theme', theme);
            var icon  = document.getElementById('dm-icon');
            var label = document.getElementById('dm-label');
            if (isAdmin) {
                if (icon)  icon.className  = theme === 'light' ? 'fas fa-moon dm-icon' : 'fas fa-sun dm-icon';
                if (label) label.textContent = theme === 'light' ? 'Dark Mode' : 'Light Mode';
            } else {
                if (icon)  icon.className  = theme === 'dark' ? 'fas fa-sun dm-icon' : 'fas fa-moon dm-icon';
                if (label) label.textContent = theme === 'dark' ? 'Light Mode' : 'Dark Mode';
            }
        }
        var saved = localStorage.getItem(STORAGE_KEY);
        applyTheme(saved ? saved : getDefault());
        window.__tlToggleTheme = function () {
            var cur  = html.getAttribute('data-theme') || getDefault();
            var next = getOpposite(cur);
            localStorage.setItem(STORAGE_KEY, next);
            applyTheme(next);
        };
    })();
</script>

<%-- TomSelect on dropdowns --%>
<script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
<script>
    (function () {
        document.querySelectorAll('select.form-select').forEach(function (el) {
            if (el.tomselect) return;
            new TomSelect(el, {
                create: false,
                allowEmptyOption: true,
                dropdownParent: 'body',
                maxOptions: null,
                render: {
                    item: function (data, escape) {
                        return '<div>' + escape((data.text || '').split(' | ')[0]) + '</div>';
                    },
                    option: function (data, escape) {
                        var parts = (data.text || '').split(' | ');
                        if (parts.length === 1) return '<div><span style="font-weight:600;">' + escape(parts[0]) + '</span></div>';
                        var html = '<div><div style="font-weight:600;font-size:0.95rem;margin-bottom:2px;">' + escape(parts[0]) + '</div>';
                        html += '<div style="display:flex;gap:6px;font-size:0.75rem;">';
                        if (parts[1]) html += '<span class="ts-pill-primary">'   + escape(parts[1]) + '</span>';
                        if (parts[2]) html += '<span class="ts-pill-secondary">' + escape(parts[2]) + '</span>';
                        html += '</div></div>';
                        return html;
                    }
                }
            });
        });
    })();
</script>
</body>
</html>
