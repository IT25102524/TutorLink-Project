<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${tutor.fullName} - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Plus Jakarta Sans', sans-serif; }
        .main-content { background: #f0f4ff; min-height: 100vh; }


        .back-link { display:inline-flex;align-items:center;gap:8px;font-size:.88rem;font-weight:600;color:#4f46e5;text-decoration:none;padding:8px 18px;background:#eef2ff;border:2px solid #c7d2fe;border-radius:99px;margin-bottom:1.5rem;transition:all .2s; }
        .back-link:hover { background:#4f46e5;color:#fff;border-color:#4f46e5; }


        .hero-card { border-radius:24px;overflow:hidden;margin-bottom:1.25rem;box-shadow:0 8px 40px rgba(79,70,229,.18); }
        .hero-banner { height:72px;background:linear-gradient(120deg,#312e81 0%,#4f46e5 45%,#7c3aed 75%,#ec4899 100%);position:relative;overflow:hidden; }
        .hero-banner::before { content:'';position:absolute;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,.07);top:-120px;right:-60px; }
        .hero-banner::after  { content:'';position:absolute;width:160px;height:160px;border-radius:50%;background:rgba(255,255,255,.06);bottom:-60px;left:120px; }


        .hero-body { background:#fff;padding:0 2rem 2rem;position:relative; }

        .tutor-avatar {
            width:100px;height:100px;border-radius:50%;
            border:5px solid #fff;
            box-shadow:0 4px 20px rgba(79,70,229,.35);
            display:flex;align-items:center;justify-content:center;
            font-size:2.4rem;font-weight:800;color:#fff;
            background:linear-gradient(135deg,#4f46e5,#7c3aed);
            margin-top:-55px;
            margin-bottom:1rem;
            position:relative;
            z-index:10;
        }

        .tutor-name { font-size:1.9rem;font-weight:800;color:#1e1b4b;margin:0 0 .5rem;letter-spacing:-.5px; }

        .available-pill { display:inline-flex;align-items:center;gap:6px;background:#dcfce7;color:#15803d;border:2px solid #86efac;border-radius:99px;font-size:.8rem;font-weight:700;padding:4px 12px; }
        .available-pill::before { content:'';width:8px;height:8px;border-radius:50%;background:#16a34a;animation:pulse 1.5s infinite; }
        @keyframes pulse { 0%,100%{opacity:1}50%{opacity:.4} }

        .star-row  { display:flex;align-items:center;gap:6px;margin-bottom:1rem; }
        .stars i   { color:#f59e0b;font-size:1rem; }
        .stars i.e { color:#e2e8f0; }
        .rating-num   { font-size:1rem;font-weight:800;color:#1e1b4b; }
        .review-count { font-size:.88rem;color:#6b7280; }

        .tag-row      { display:flex;flex-wrap:wrap;gap:10px; }
        .info-tag     { display:inline-flex;align-items:center;gap:7px;padding:7px 16px;border-radius:12px;font-size:.88rem;font-weight:700; }
        .tag-subject  { background:#eef2ff;color:#4338ca;border:2px solid #c7d2fe; }
        .tag-location { background:#fff1f2;color:#be123c;border:2px solid #fecdd3; }
        .tag-travel   { background:#faf5ff;color:#7e22ce;border:2px solid #e9d5ff; }


        .section-card { background:#fff;border-radius:20px;border:2px solid #e0e7ff;padding:1.75rem;margin-bottom:1.25rem;box-shadow:0 2px 12px rgba(79,70,229,.06); }
        .section-head { display:flex;align-items:center;gap:10px;font-size:.72rem;font-weight:800;text-transform:uppercase;letter-spacing:.12em;margin-bottom:1.1rem; }
        .section-head-icon { width:28px;height:28px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:.75rem;flex-shrink:0; }
        .ic-purple { background:#ede9fe;color:#7c3aed; } .head-purple { color:#7c3aed; }
        .ic-blue   { background:#dbeafe;color:#1d4ed8; } .head-blue   { color:#1d4ed8; }
        .ic-green  { background:#dcfce7;color:#15803d; } .head-green  { color:#15803d; }
        .ic-pink   { background:#fce7f3;color:#be185d; } .head-pink   { color:#be185d; }
        .bio-text  { font-size:1rem;color:#374151;line-height:1.85; }


        .exp-badge   { display:inline-flex;align-items:center;gap:7px;padding:8px 18px;border-radius:12px;font-size:.9rem;font-weight:700; }
        .exp-subject { background:linear-gradient(135deg,#eef2ff,#e0e7ff);color:#3730a3;border:2px solid #c7d2fe; }
        .exp-exp     { background:linear-gradient(135deg,#dcfce7,#bbf7d0);color:#166534;border:2px solid #86efac; }
        .exp-qual    { background:linear-gradient(135deg,#fffbeb,#fef3c7);color:#92400e;border:2px solid #fde68a; }


        .slot-row  { display:flex;align-items:center;gap:14px;padding:14px 18px;border-radius:14px;margin-bottom:10px;border:2px solid #e0e7ff;background:#fafbff;transition:all .2s; }
        .slot-row:hover { border-color:#a5b4fc;background:#eef2ff;transform:translateX(4px); }
        .slot-row:last-child { margin-bottom:0; }
        .day-pill  { min-width:105px;text-align:center;padding:5px 14px;border-radius:10px;font-size:.84rem;font-weight:800; }
        .dp-mon { background:#dbeafe;color:#1e40af;border:2px solid #93c5fd; }
        .dp-tue { background:#ede9fe;color:#5b21b6;border:2px solid #c4b5fd; }
        .dp-wed { background:#fef3c7;color:#92400e;border:2px solid #fcd34d; }
        .dp-thu { background:#e0e7ff;color:#3730a3;border:2px solid #a5b4fc; }
        .dp-fri { background:#dcfce7;color:#166534;border:2px solid #86efac; }
        .dp-sat { background:#fce7f3;color:#9d174d;border:2px solid #f9a8d4; }
        .dp-sun { background:#fff1f2;color:#9f1239;border:2px solid #fda4af; }
        .dp-def { background:#f1f5f9;color:#475569;border:2px solid #cbd5e1; }
        .slot-time { font-size:.97rem;font-weight:600;color:#1e1b4b; }
        .slot-dur  { margin-left:auto;padding:4px 12px;border-radius:99px;font-size:.8rem;font-weight:800;background:#dcfce7;color:#15803d;border:2px solid #86efac; }


        .review-card  { background:linear-gradient(135deg,#fafbff,#f0f4ff);border:2px solid #e0e7ff;border-radius:16px;padding:1.25rem;margin-bottom:10px; }
        .review-card:last-child { margin-bottom:0; }
        .review-top   { display:flex;justify-content:space-between;align-items:center;margin-bottom:8px; }
        .reviewer     { font-weight:700;font-size:.95rem;color:#1e1b4b; }
        .review-body  { font-size:.92rem;color:#4b5563;line-height:1.7; }
        .big-quote    { font-size:2.5rem;color:#a5b4fc;line-height:.8;margin-bottom:6px; }

        .empty-state   { text-align:center;padding:2.5rem 1rem;color:#9ca3af; }
        .empty-state i { font-size:2.5rem;opacity:.3;display:block;margin-bottom:.75rem; }
        .empty-state p { font-size:.9rem; }


        .book-sidebar { background:#fff;border-radius:24px;border:2px solid #e0e7ff;box-shadow:0 8px 40px rgba(79,70,229,.12);overflow:hidden;position:sticky;top:20px; }
        .book-sidebar-top { background:linear-gradient(120deg,#312e81,#4f46e5 60%,#7c3aed);padding:1.4rem 1.5rem 1rem; }
        .book-sidebar-top-label { font-size:.7rem;font-weight:800;text-transform:uppercase;letter-spacing:.12em;color:rgba(255,255,255,.65);margin-bottom:.9rem; }
        .rate-tile    { border-radius:14px;padding:13px 15px;display:flex;align-items:center;gap:12px;margin-bottom:10px; }
        .rt-online    { background:rgba(255,255,255,.14);border:1.5px solid rgba(255,255,255,.22); }
        .rt-homevisit { background:rgba(255,255,255,.08);border:1.5px solid rgba(255,255,255,.15); }
        .rt-icon      { width:40px;height:40px;border-radius:11px;display:flex;align-items:center;justify-content:center;font-size:1rem;flex-shrink:0; }
        .rt-icon-online    { background:rgba(255,255,255,.2);color:#fff; }
        .rt-icon-homevisit { background:rgba(236,72,153,.3);color:#fbcfe8; }
        .rt-label { font-size:.73rem;font-weight:700;color:rgba(255,255,255,.65);margin-bottom:2px; }
        .rt-value { font-size:1.25rem;font-weight:800;color:#fff; }
        .rt-value span { font-size:.76rem;font-weight:500;opacity:.7; }
        .travel-chip  { display:inline-flex;align-items:center;gap:7px;background:rgba(255,255,255,.12);border:1.5px solid rgba(255,255,255,.2);border-radius:99px;padding:5px 14px;font-size:.8rem;font-weight:700;color:rgba(255,255,255,.85); }
        .book-sidebar-body { padding:1.25rem 1.5rem; }
        .detail-head  { font-size:.7rem;font-weight:800;text-transform:uppercase;letter-spacing:.12em;color:#6366f1;margin-bottom:.85rem;display:flex;align-items:center;gap:6px; }
        .detail-row   { display:flex;justify-content:space-between;align-items:center;padding:10px 0;border-bottom:1.5px solid #e0e7ff;font-size:.9rem; }
        .detail-row:last-child { border-bottom:none; }
        .detail-label { color:#6b7280;font-weight:600; }
        .detail-value { font-weight:800;color:#1e1b4b;text-align:right; }
        .detail-value.indigo { color:#4f46e5; }
        .detail-value.amber  { color:#d97706; }
        .book-btn-wrap { padding:0 1.5rem 1.5rem; }
        .book-btn { display:flex;align-items:center;justify-content:center;gap:10px;width:100%;padding:16px;background:linear-gradient(135deg,#4f46e5,#7c3aed);color:#fff;font-size:1.05rem;font-weight:800;border:none;border-radius:14px;text-decoration:none;cursor:pointer;box-shadow:0 6px 20px rgba(79,70,229,.35);transition:all .2s;letter-spacing:.3px; }
        .book-btn:hover { transform:translateY(-2px);box-shadow:0 10px 28px rgba(79,70,229,.45);color:#fff; }
        .cancel-note  { text-align:center;font-size:.78rem;font-weight:600;color:#9ca3af;margin-top:10px;display:flex;align-items:center;justify-content:center;gap:5px; }
        .cancel-note i { color:#22c55e; }
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



    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">
    <a href="${pageContext.request.contextPath}/student/search" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Search
    </a>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="hero-card">
                <div class="hero-banner"></div>
                <%-- hero-body is a WHITE block BELOW the banner.
                     The avatar uses margin-top:-55px + z-index:10
                     to visually overlap the bottom edge of the banner. --%>
                <div class="hero-body">
                    <div class="tutor-avatar" id="tutorAvatar">${tutor.fullName.charAt(0)}</div>
                    <div class="d-flex flex-wrap align-items-center gap-3 mb-2">
                        <span class="tutor-name">${tutor.fullName}</span>
                        <span class="available-pill">Available</span>
                    </div>
                    <div class="star-row">
                        <div class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= avgRating}"><i class="fas fa-star"></i></c:when>
                                    <c:otherwise><i class="far fa-star e"></i></c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <span class="rating-num"><c:choose><c:when test="${avgRating > 0}">${avgRating}</c:when><c:otherwise>New</c:otherwise></c:choose></span>
                        <span class="review-count">(${reviews.size()} reviews)</span>
                    </div>
                    <div class="tag-row">
                        <c:forEach var="ts" items="${tutorSubjects}" begin="0" end="2">
                            <span class="info-tag tag-subject"><i class="fas fa-book-open"></i> ${ts.subjectName}</span>
                        </c:forEach>
                        <span class="info-tag tag-location"><i class="fas fa-map-marker-alt"></i> ${tutor.district}</span>
                        <c:if test="${tutor.travelRadius > 0}">
                            <span class="info-tag tag-travel"><i class="fas fa-route"></i> Travels up to ${tutor.travelRadius} km</span>
                        </c:if>
                    </div>
                </div>
            </div>
            <c:if test="${not empty tutor.bio}">
                <div class="section-card">
                    <div class="section-head head-purple"><span class="section-head-icon ic-purple"><i class="fas fa-user"></i></span>About Me</div>
                    <p class="bio-text">${tutor.bio}</p>
                </div>
            </c:if>
            <div class="section-card">
                <div class="section-head head-blue"><span class="section-head-icon ic-blue"><i class="fas fa-graduation-cap"></i></span>Teaching Expertise</div>
                <div class="d-flex flex-wrap gap-2">
                    <c:choose>
                        <c:when test="${not empty tutorSubjects}">
                            <c:forEach var="ts" items="${tutorSubjects}">
                                <span class="exp-badge exp-subject">
                                    <i class="fas fa-book"></i> ${ts.subjectName}
                                    <span style="font-size:0.75rem;opacity:0.8;margin-left:4px;">(${ts.medium})</span>
                                </span>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <span class="exp-badge exp-subject"><i class="fas fa-book"></i> ${tutor.subject}</span>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty tutor.experience}"><span class="exp-badge exp-exp"><i class="fas fa-award"></i> ${tutor.experience}</span></c:if>
                    <c:if test="${not empty tutor.qualification}"><span class="exp-badge exp-qual"><i class="fas fa-certificate"></i> ${tutor.qualification}</span></c:if>
                </div>
            </div>
            <div class="section-card">
                <div class="section-head head-green"><span class="section-head-icon ic-green"><i class="fas fa-calendar-alt"></i></span>Available Schedule</div>
                <c:choose>
                    <c:when test="${empty slots}">
                        <div class="empty-state"><i class="far fa-calendar-times"></i><p>No schedule posted yet.</p></div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="s" items="${slots}">
                            <div class="slot-row">
                                <span class="day-pill dp-def js-day-pill" data-day="${s.day}">${s.day}</span>
                                <i class="far fa-clock" style="color:#a5b4fc;font-size:.9rem;"></i>
                                <span class="slot-time">${s.startTime} – ${s.endTime}</span>
                                <c:if test="${not empty s.subjectName}">
                                    <span style="font-size:0.75rem;font-weight:700;color:#4338ca;background:#eef2ff;padding:2px 8px;border-radius:6px;">${s.subjectName}</span>
                                </c:if>
                                <c:if test="${not empty s.medium}">
                                    <span style="font-size:0.75rem;font-weight:700;color:#15803d;background:#dcfce7;padding:2px 8px;border-radius:6px;">${s.medium}</span>
                                </c:if>
                                <span class="slot-dur js-duration" data-start="${s.startTime}" data-end="${s.endTime}"></span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="section-card">
                <div class="section-head head-pink"><span class="section-head-icon ic-pink"><i class="fas fa-comments"></i></span>Student Reviews</div>
                <c:choose>
                    <c:when test="${empty reviews}">
                        <div class="empty-state"><i class="far fa-comment-dots"></i><p>No reviews yet — be the first to book and share your experience!</p></div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${reviews}">
                            <div class="review-card">
                                <div class="review-top">
                                    <span class="reviewer"><i class="fas fa-user-circle me-2" style="color:#818cf8;"></i>${r.studentName}</span>
                                    <div class="stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= r.rating}"><i class="fas fa-star"></i></c:when>
                                                <c:otherwise><i class="far fa-star e"></i></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="big-quote">"</div>
                                <p class="review-body">${r.comment}</p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

        </div><%-- /col-lg-8 --%>
        <div class="col-lg-4">
            <div class="book-sidebar">
                <div class="book-sidebar-top">
                    <div class="book-sidebar-top-label"><i class="fas fa-tag me-1"></i> Session Rates</div>
                    <c:set var="minOnline" value="9999999" />
                    <c:set var="maxOnline" value="-1" />
                    <c:set var="minHome" value="9999999" />
                    <c:set var="maxHome" value="-1" />
                    <c:set var="hasOnline" value="false" />
                    <c:set var="hasHome" value="false" />

                    <c:forEach var="ts" items="${tutorSubjects}">
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
                        <c:set var="minOnline" value="${tutor.effectiveOnlineRate}" />
                        <c:set var="maxOnline" value="${tutor.effectiveOnlineRate}" />
                        <c:set var="hasHome" value="true" />
                        <c:set var="minHome" value="${tutor.effectiveHomeVisitRate}" />
                        <c:set var="maxHome" value="${tutor.effectiveHomeVisitRate}" />
                    </c:if>

                    <c:if test="${hasOnline}">
                        <div class="rate-tile rt-online">
                            <div class="rt-icon rt-icon-online"><i class="fas fa-laptop"></i></div>
                            <div>
                                <div class="rt-label">Online</div>
                                <div class="rt-value">LKR <c:choose><c:when test="${minOnline == maxOnline}">${minOnline}</c:when><c:otherwise>${minOnline} – ${maxOnline}</c:otherwise></c:choose><span>/hr</span></div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${hasHome}">
                        <div class="rate-tile rt-homevisit">
                            <div class="rt-icon rt-icon-homevisit"><i class="fas fa-home"></i></div>
                            <div>
                                <div class="rt-label">Home Visit</div>
                                <div class="rt-value">LKR <c:choose><c:when test="${minHome == maxHome}">${minHome}</c:when><c:otherwise>${minHome} – ${maxHome}</c:otherwise></c:choose><span>/hr</span></div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${tutor.travelRadius > 0}">
                        <div class="mt-2"><span class="travel-chip"><i class="fas fa-route"></i> Travels up to ${tutor.travelRadius} km</span></div>
                    </c:if>
                </div>
                <div class="book-sidebar-body">
                    <div class="detail-head"><i class="fas fa-info-circle"></i> Details</div>
                    <div class="detail-row">
                        <span class="detail-label">Subjects</span>
                        <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${not empty tutorSubjects}">
                                                <c:forEach var="ts" items="${tutorSubjects}" varStatus="vs">
                                                    ${ts.subjectName}<c:if test="${!vs.last}">, </c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>${tutor.subject}</c:otherwise>
                                        </c:choose>
                                    </span>
                    </div>
                    <div class="detail-row"><span class="detail-label">Location</span><span class="detail-value">${tutor.district}</span></div>
                    <c:if test="${not empty tutor.experience}"><div class="detail-row"><span class="detail-label">Experience</span><span class="detail-value">${tutor.experience}</span></div></c:if>
                    <c:if test="${not empty tutor.qualification}"><div class="detail-row"><span class="detail-label">Qualification</span><span class="detail-value" style="font-size:.82rem;">${tutor.qualification}</span></div></c:if>
                    <c:if test="${not empty tutor.phone}"><div class="detail-row"><span class="detail-label">Contact</span><span class="detail-value indigo">${tutor.phone}</span></div></c:if>
                    <div class="detail-row">
                        <span class="detail-label">Rating</span>
                        <span class="detail-value amber"><i class="fas fa-star me-1"></i><c:choose><c:when test="${avgRating > 0}">${avgRating} / 5</c:when><c:otherwise>N/A</c:otherwise></c:choose></span>
                    </div>
                </div>
                <div class="book-btn-wrap">
                    <div style="display:flex;gap:10px;margin-bottom:10px;">
                        <a href="${pageContext.request.contextPath}/booking/new/${tutor.tutorId}" class="book-btn" style="flex:1;">
                            <i class="fas fa-calendar-check"></i> Book Session
                        </a>
                        <form action="${pageContext.request.contextPath}/student/favorite/toggle/${tutor.tutorId}" method="post" style="margin:0;">
                            <input type="hidden" name="returnUrl" value="/student/view-tutor/${tutor.tutorId}">
                            <button type="submit" style="display:flex;align-items:center;justify-content:center;width:54px;height:54px;border-radius:14px;cursor:pointer;transition:all 0.2s;background: ${isFavorited ? 'rgba(239,68,68,0.1)' : '#fff'}; color: ${isFavorited ? '#dc2626' : '#9ca3af'}; border: 2px solid ${isFavorited ? 'rgba(239,68,68,0.3)' : '#e0e7ff'}; font-size: 1.2rem;">
                                <i class="${isFavorited ? 'fas' : 'far'} fa-heart"></i>
                            </button>
                        </form>
                    </div>
                    <p class="cancel-note"><i class="fas fa-shield-alt"></i> Free cancellation up to 24 hrs before session</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

    (function(){
        var g=['linear-gradient(135deg,#4f46e5,#7c3aed)','linear-gradient(135deg,#0891b2,#0e7490)',
            'linear-gradient(135deg,#059669,#0f766e)','linear-gradient(135deg,#d97706,#b45309)',
            'linear-gradient(135deg,#dc2626,#9f1239)','linear-gradient(135deg,#7c3aed,#ec4899)',
            'linear-gradient(135deg,#db2777,#9d174d)','linear-gradient(135deg,#0f766e,#065f46)'];
        var el=document.getElementById('tutorAvatar');
        if(el) el.style.background=g[el.textContent.trim().charCodeAt(0)%g.length];
    })();


    (function(){
        var m={Monday:'dp-mon',Tuesday:'dp-tue',Wednesday:'dp-wed',Thursday:'dp-thu',
            Friday:'dp-fri',Saturday:'dp-sat',Sunday:'dp-sun'};
        document.querySelectorAll('.js-day-pill').forEach(function(el){
            var c=m[el.dataset.day]||'dp-def';el.classList.remove('dp-def');el.classList.add(c);
        });
    })();


    (function(){
        function mins(t){
            if(!t)return -1;t=t.trim();
            var a=t.match(/^(\d{1,2}):(\d{2})\s*(AM|PM)$/i);
            if(a){var h=+a[1],m=+a[2],p=a[3].toUpperCase();if(p==='PM'&&h!==12)h+=12;if(p==='AM'&&h===12)h=0;return h*60+m;}
            var b=t.match(/^(\d{1,2}):(\d{2})/);return b?+b[1]*60+ +b[2]:-1;
        }
        document.querySelectorAll('.js-duration').forEach(function(el){
            var s=mins(el.dataset.start),e=mins(el.dataset.end);
            if(s>=0&&e>s){var d=e-s,h=Math.floor(d/60),r=d%60;
                el.textContent=h>0?(r>0?h+'h '+r+'m':h+(h===1?' hr':' hrs')):r+' min';}
        });
    })();
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
</script></body>
</html>
