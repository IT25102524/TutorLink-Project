<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Learning Progress - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
        }
        h1, h2, h3, h4, h5, h6, .card-title-modern, .prog-card-label {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        /* --- Animations --- */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-up {
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            opacity: 0;
        }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }

        /* --- Premium Progress Cards --- */
        .prog-card {
            border-radius: 24px;
            padding: 1.8rem;
            color: #fff;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            z-index: 1;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .prog-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0) 100%);
            z-index: -1;
            border-radius: 24px;
        }
        .prog-card::after {
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
            z-index: -1;
            transition: transform 0.6s ease;
        }
        .prog-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        .prog-card:hover::after {
            transform: translate(10%, 10%);
        }

        .bg-blue-gradient { background: linear-gradient(135deg, #1e3a8a, #3b82f6); }
        .bg-green-gradient { background: linear-gradient(135deg, #064e3b, #10b981); }
        .bg-gold-gradient { background: linear-gradient(135deg, #78350f, #f59e0b); }

        .prog-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }
        .prog-card-icon {
            width: 50px; height: 50px;
            border-radius: 16px;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .prog-card-label {
            font-size: 0.85rem; font-weight: 800;
            text-transform: uppercase; letter-spacing: 1px;
            opacity: 0.9;
        }
        .prog-card-value {
            font-size: 3rem; font-weight: 800; line-height: 1;
            margin-bottom: 0.5rem;
            letter-spacing: -1px;
        }
        .prog-card-sub {
            font-size: 0.9rem; opacity: 0.85; margin-bottom: 1rem;
            font-weight: 500;
        }

        /* Progress Bar Modern */
        .prog-bar-container {
            margin-top: auto;
        }
        .prog-bar-bg {
            background: rgba(255,255,255,0.15);
            border-radius: 50px; height: 10px; overflow: hidden;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
        }
        .prog-bar-fill {
            height: 100%; border-radius: 50px;
            background: #fff;
            box-shadow: 0 0 10px rgba(255,255,255,0.5);
            transition: width 1.5s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
        }
        .prog-bar-fill::after {
            content: '';
            position: absolute;
            top: 0; left: 0; bottom: 0; right: 0;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            animation: shimmer 2s infinite;
        }
        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }
        .prog-pct {
            font-size: 0.85rem; font-weight: 700; opacity: 0.9; margin-top: 8px; text-align: right;
        }

        /* --- Glassmorphism Cards --- */
        .glass-card {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.6);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.04);
            padding: 1.8rem;
            transition: all 0.3s ease;
        }
        .glass-card:hover {
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.08);
            transform: translateY(-2px);
        }
        .card-title-modern {
            font-weight: 800; color: #1e293b; margin-bottom: 1.2rem;
            font-size: 1.1rem;
            display: flex; align-items: center; gap: 10px;
        }
        .card-title-modern i {
            color: #3b82f6;
            background: #eff6ff;
            padding: 10px;
            border-radius: 12px;
            font-size: 1.1rem;
        }

        /* --- Tags --- */
        .subject-tag {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 8px 16px; border-radius: 12px;
            font-size: 0.9rem; font-weight: 600;
            background: linear-gradient(135deg, #eff6ff, #dbeafe);
            color: #1d4ed8;
            box-shadow: 0 2px 10px rgba(37,99,235,0.1);
            margin: 0 8px 8px 0;
            transition: transform 0.2s;
        }
        .subject-tag:hover { transform: translateY(-2px); }
        .subject-tag strong { color: #1e3a8a; font-weight: 800; background: #fff; padding: 2px 8px; border-radius: 8px; font-size: 0.8rem; }

        .focus-tag {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 8px 16px; border-radius: 12px;
            font-size: 0.9rem; font-weight: 600;
            background: linear-gradient(135deg, #ecfdf5, #d1fae5);
            color: #047857;
            box-shadow: 0 2px 10px rgba(16,185,129,0.1);
            margin: 0 8px 8px 0;
            transition: transform 0.2s;
        }
        .focus-tag:hover { transform: translateY(-2px); }

        /* --- Chart Container --- */
        .chart-container {
            position: relative;
            height: 280px;
            width: 100%;
        }

        /* --- Form Elements --- */
        .floating-form-group {
            position: relative;
            margin-bottom: 1.5rem;
        }
        .floating-form-group .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 1rem;
            font-size: 1rem;
            font-weight: 500;
            background: #fff;
            transition: all 0.3s;
        }
        .floating-form-group .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        }
        .floating-form-group label {
            position: absolute;
            top: -10px; left: 15px;
            background: #fff;
            padding: 0 8px;
            font-size: 0.8rem;
            font-weight: 700;
            color: #64748b;
            border-radius: 4px;
        }

        .btn-update {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 14px;
            font-weight: 700;
            display: inline-flex; align-items: center; gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 8px 20px rgba(37,99,235,0.25);
        }
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(37,99,235,0.35);
            color: white;
        }
        .btn-cancel {
            background: #f1f5f9;
            color: #475569;
            border: none;
            padding: 12px 24px;
            border-radius: 14px;
            font-weight: 700;
            transition: all 0.3s;
        }
        .btn-cancel:hover {
            background: #e2e8f0;
            color: #1e293b;
        }

        .edit-goal-panel {
            background: #ffffff;
            border-radius: 24px;
            padding: 2rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 20px 40px rgba(0,0,0,0.06);
            display: none;
            animation: fadeInUp 0.4s ease forwards;
        }
        .subject-checkbox-tag { display: inline-flex; align-items: center; gap: 6px; padding: 8px 16px; border-radius: 12px; font-size: 0.85rem; font-weight: 600; cursor: pointer; border: 2px solid #e2e8f0; background: #f8fafc; color: #475569; margin: 4px; transition: all 0.2s ease; user-select: none; }
        .subject-checkbox-tag:hover { border-color: #10b981; color: #065f46; background: #ecfdf5; }
        .subject-checkbox-tag.selected { border-color: #10b981; background: linear-gradient(135deg, #ecfdf5, #d1fae5); color: #065f46; box-shadow: 0 2px 8px rgba(16,185,129,0.2); }
        .subject-checkbox-tag i { font-size: 0.8rem; }
    </style>
</head>
<body>
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-brand">
        <div class="sb-logo"><i class="fas fa-graduation-cap"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </a>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-link"><i class="fas fa-th-large"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/student/search" class="sb-link"><i class="fas fa-search"></i><span>Find & Book Tutor</span></a>
        <a href="${pageContext.request.contextPath}/student/favorites" class="sb-link"><i class="fas fa-heart"></i><span>My Favorites</span></a>
        <a href="${pageContext.request.contextPath}/student/goals" class="sb-link active"><i class="fas fa-chart-line"></i><span>Learning Progress</span></a>
        <a href="${pageContext.request.contextPath}/student/bookings" class="sb-link"><i class="fas fa-calendar-check"></i><span>My Bookings</span></a>

        <a href="${pageContext.request.contextPath}/student/reviews" class="sb-link"><i class="fas fa-star"></i><span>My Reviews</span></a>
        <a href="${pageContext.request.contextPath}/student/profile" class="sb-link"><i class="fas fa-user-circle"></i><span>My Profile</span></a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link"><i class="fas fa-credit-card"></i><span>Payments</span></a>
    </nav>
    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">
    <div class="page-header animate-up">
        <div>
            <h4 class="page-title" style="font-size: 2.2rem;">Learning Progress</h4>
            <p class="page-sub" style="font-size: 1.05rem;">Analyze your activity, track milestones, and visualize your growth.</p>
        </div>
        <c:if test="${goal != null}">
            <div>
                <button type="button" class="btn-update" style="background: #fff; color: #10b981; border: 2px solid #10b981; box-shadow: none; margin-right: 10px;" data-bs-toggle="modal" data-bs-target="#reportModal">
                    <i class="fas fa-file-alt"></i> Generate Report
                </button>
                <button onclick="toggleEditPanel()" class="btn-update" style="background: #fff; color: #2563eb; border: 2px solid #2563eb; box-shadow: none;">
                    <i class="fas fa-sliders-h"></i> Adjust Goals
                </button>
            </div>
        </c:if>
    </div>

    <c:if test="${param.saved == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Learning goals synchronized successfully.</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert-modern alert-success"><i class="fas fa-sync-alt"></i> Goals have been reset.</div>
    </c:if>

    <c:choose>
        <c:when test="${goal != null}">

            <%-- Calculate Gamification Rank --%>
            <c:choose>
                <c:when test="${goal.totalCompletedSessions >= 25}"><c:set var="rank" value="Diamond Master"/><c:set var="rankIcon" value="fa-gem"/><c:set var="rankDesc" value="Top tier scholar"/></c:when>
                <c:when test="${goal.totalCompletedSessions >= 10}"><c:set var="rank" value="Gold Scholar"/><c:set var="rankIcon" value="fa-medal"/><c:set var="rankDesc" value="Highly dedicated"/></c:when>
                <c:when test="${goal.totalCompletedSessions >= 5}"><c:set var="rank" value="Silver Achiever"/><c:set var="rankIcon" value="fa-shield-alt"/><c:set var="rankDesc" value="Consistent learner"/></c:when>
                <c:otherwise><c:set var="rank" value="Bronze Novice"/><c:set var="rankIcon" value="fa-user-graduate"/><c:set var="rankDesc" value="Journey started"/></c:otherwise>
            </c:choose>

            <style>
                .bg-purple-gradient { background: linear-gradient(135deg, #4c1d95, #8b5cf6); }
            </style>

            <%-- 4 PREMIUM STAT CARDS --%>
            <div class="row g-4 mb-4">
                    <%-- Weekly Progress --%>
                <div class="col-md-3 animate-up delay-1">
                    <div class="prog-card bg-blue-gradient">
                        <div class="prog-card-header">
                            <div>
                                <div class="prog-card-label">Weekly Activity</div>
                                <div class="prog-card-value">
                                        ${goal.thisWeekSessions} <span style="font-size: 1.2rem; opacity: 0.7;">/ ${goal.weeklySessionTarget}</span>
                                </div>
                                <div class="prog-card-sub" style="font-size: 0.8rem;">
                                    <c:choose>
                                        <c:when test="${goal.weeklyTargetMet}"><i class="fas fa-check-circle me-1"></i> Achieved</c:when>
                                        <c:otherwise>${goal.weeklySessionTarget - goal.thisWeekSessions} remaining</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="prog-card-icon"><i class="fas fa-bolt"></i></div>
                        </div>
                        <div class="prog-bar-container">
                            <div class="prog-bar-bg">
                                <div class="prog-bar-fill" style="width:${goal.weeklyProgressPercentage}%;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                    <%-- This Month --%>
                <div class="col-md-3 animate-up delay-2">
                    <div class="prog-card bg-green-gradient">
                        <div class="prog-card-header">
                            <div>
                                <div class="prog-card-label">Monthly Impact</div>
                                <div class="prog-card-value">${goal.thisMonthSessions}</div>
                                <div class="prog-card-sub" style="font-size: 0.8rem;">Completed this month</div>
                            </div>
                            <div class="prog-card-icon"><i class="fas fa-calendar-check"></i></div>
                        </div>
                        <div style="margin-top: auto; background: rgba(255,255,255,0.15); padding: 8px 12px; border-radius: 10px; font-size: 0.8rem; font-weight: 600;">
                            <i class="fas fa-chart-pie me-1"></i> Lifetime: ${goal.totalCompletedSessions}
                        </div>
                    </div>
                </div>

                    <%-- Study Streak --%>
                <div class="col-md-3 animate-up delay-3">
                    <div class="prog-card bg-gold-gradient">
                        <div class="prog-card-header">
                            <div>
                                <div class="prog-card-label">Consistency</div>
                                <div class="prog-card-value">${goal.studyStreak}</div>
                                <div class="prog-card-sub" style="font-size: 0.8rem;">Week Streak</div>
                            </div>
                            <div class="prog-card-icon"><i class="fas fa-fire-alt"></i></div>
                        </div>
                        <div style="margin-top: auto; font-size: 0.85rem; font-weight: 600; padding: 5px 0;">
                            <c:choose>
                                <c:when test="${goal.studyStreak >= 5}"><i class="fas fa-star me-1" style="color: #fde047;"></i> Unstoppable!</c:when>
                                <c:when test="${goal.studyStreak > 0}"><i class="fas fa-level-up-alt me-1" style="color: #fde047;"></i> Building up</c:when>
                                <c:otherwise><i class="fas fa-rocket me-1"></i> Start today</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                    <%-- Gamification Rank --%>
                <div class="col-md-3 animate-up delay-4">
                    <div class="prog-card bg-purple-gradient">
                        <div class="prog-card-header">
                            <div>
                                <div class="prog-card-label">Current Rank</div>
                                <div class="prog-card-value" style="font-size: 1.6rem; margin-top: 10px;">${rank}</div>
                                <div class="prog-card-sub" style="font-size: 0.8rem;">${rankDesc}</div>
                            </div>
                            <div class="prog-card-icon"><i class="fas ${rankIcon}"></i></div>
                        </div>
                        <div style="margin-top: auto; background: rgba(255,255,255,0.15); padding: 8px 12px; border-radius: 10px; font-size: 0.8rem; font-weight: 600; cursor: pointer; transition: background 0.3s;"
                             onmouseover="this.style.background='rgba(255,255,255,0.25)'"
                             onmouseout="this.style.background='rgba(255,255,255,0.15)'"
                             data-bs-toggle="modal" data-bs-target="#achievementsModal">
                            <i class="fas fa-trophy me-1"></i> View Achievements
                        </div>
                    </div>
                </div>
            </div>

            <%-- GOAL PROGRESS SECTION --%>
            <c:if test="${goal.targetSessions > 0}">
                <div class="glass-card mb-4 animate-up delay-2">
                    <div class="card-title-modern"><i class="fas fa-bullseye" style="color:#ef4444;background:#fff1f2;"></i> Learning Goal Progress</div>
                        <%-- Progress Bar --%>
                    <div style="background:#e2e8f0;border-radius:50px;height:14px;overflow:hidden;margin-bottom:1rem;">
                        <div style="height:100%;border-radius:50px;transition:width 1.2s cubic-bezier(0.16,1,0.3,1);width:${goal.progressPercentage}%;
                                background:<c:choose><c:when test="${goal.progressPercentage >= 100}">#10b981</c:when><c:when test="${goal.progressPercentage >= 80}">#f59e0b</c:when><c:when test="${goal.progressPercentage >= 40}">#f97316</c:when><c:otherwise>#ef4444</c:otherwise></c:choose>;"></div>
                    </div>
                        <%-- Stats Row --%>
                    <div class="d-flex flex-wrap align-items-center gap-3 mb-3">
                        <span style="font-size:1.5rem;font-weight:800;color:#1e293b;">${goal.progressPercentage}%</span>
                        <span style="padding:4px 14px;border-radius:20px;font-size:0.82rem;font-weight:700;<c:choose><c:when test="${goal.progressStatus == 'Completed'}">background:#d1fae5;color:#065f46;</c:when><c:when test="${goal.progressStatus == 'Almost Complete'}">background:#fef3c7;color:#92400e;</c:when><c:when test="${goal.progressStatus == 'In Progress'}">background:#dbeafe;color:#1e40af;</c:when><c:otherwise>background:#f1f5f9;color:#475569;</c:otherwise></c:choose>">${goal.progressStatus}</span>
                        <c:if test="${goal.daysRemaining >= 0}">
                        <span style="padding:4px 14px;border-radius:20px;font-size:0.82rem;font-weight:700;background:#f3e8ff;color:#6d28d9;">
                            <i class="fas fa-calendar-alt me-1"></i><c:choose><c:when test="${goal.daysRemaining == 0}">Due Today!</c:when><c:otherwise>${goal.daysRemaining} day(s) left</c:otherwise></c:choose>
                        </span>
                        </c:if>
                    </div>
                        <%-- Session count row --%>
                    <div class="d-flex flex-wrap gap-4 mb-3" style="font-size:0.95rem;font-weight:600;color:#334155;">
                        <span><i class="fas fa-check-circle me-1" style="color:#10b981;"></i>${goal.totalCompletedSessions} / ${goal.targetSessions} sessions completed</span>
                        <c:if test="${goal.progressPercentage < 100}">
                            <span><i class="fas fa-hourglass-half me-1" style="color:#f97316;"></i>${goal.targetSessions - goal.totalCompletedSessions} session(s) remaining</span>
                        </c:if>
                        <c:if test="${goal.requiredSessionsPerWeek > 0}">
                            <span><i class="fas fa-tachometer-alt me-1" style="color:#8b5cf6;"></i>${goal.requiredSessionsPerWeek} session(s)/week needed</span>
                        </c:if>
                    </div>
                        <%-- Auto Message --%>
                    <c:if test="${not empty goal.autoMessage}">
                        <div style="padding:14px 18px;border-radius:14px;font-weight:600;font-size:0.95rem;<c:choose><c:when test="${goal.progressPercentage >= 100}">background:#d1fae5;color:#065f46;border-left:4px solid #10b981;</c:when><c:when test="${goal.deadlineNear}">background:#fff1f2;color:#881337;border-left:4px solid #e11d48;</c:when><c:otherwise>background:#eff6ff;color:#1e40af;border-left:4px solid #3b82f6;</c:otherwise></c:choose>">
                            <i class="fas fa-info-circle me-2"></i>${goal.autoMessage}
                        </div>
                    </c:if>
                        <%-- Celebration --%>
                    <c:if test="${goal.progressPercentage >= 100}">
                        <div style="text-align:center;margin-top:1.5rem;padding:1.5rem;background:linear-gradient(135deg,#ecfdf5,#d1fae5);border-radius:18px;">
                            <div style="font-size:3rem;">&#127942;</div>
                            <h5 style="font-weight:800;color:#065f46;margin:0.5rem 0 0.3rem;">Goal Achievement Unlocked!</h5>
                            <p style="color:#047857;font-weight:500;margin:0;">You've reached your session target. Keep up the amazing work!</p>
                        </div>
                        <canvas id="confettiCanvas" style="position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:9999;"></canvas>
                        <script>
                            (function(){
                                var c=document.getElementById('confettiCanvas'),ctx=c.getContext('2d');
                                c.width=window.innerWidth;c.height=window.innerHeight;
                                var dots=[],colors=['#10b981','#3b82f6','#f59e0b','#ef4444','#8b5cf6','#f97316'];
                                for(var i=0;i<120;i++){dots.push({x:Math.random()*c.width,y:Math.random()*c.height-c.height,w:Math.random()*10+5,h:Math.random()*6+3,color:colors[Math.floor(Math.random()*colors.length)],speed:Math.random()*3+1,angle:Math.random()*Math.PI*2,spin:Math.random()*0.2-0.1,op:1});}
                                var f=0;
                                (function draw(){ctx.clearRect(0,0,c.width,c.height);dots.forEach(function(d){d.y+=d.speed;d.x+=Math.sin(d.angle)*1.5;d.angle+=d.spin;if(f>180)d.op=Math.max(0,d.op-0.01);ctx.save();ctx.globalAlpha=d.op;ctx.fillStyle=d.color;ctx.translate(d.x+d.w/2,d.y+d.h/2);ctx.rotate(d.angle);ctx.fillRect(-d.w/2,-d.h/2,d.w,d.h);ctx.restore();if(d.y>c.height){d.y=-20;d.x=Math.random()*c.width;}});f++;if(f<300)requestAnimationFrame(draw);else ctx.clearRect(0,0,c.width,c.height);})();
                            })();
                        </script>
                    </c:if>
                </div>
            </c:if>

            <%-- SMART ACTION ALERTS --%>
            <c:if test="${not empty missingFocusSubjects}">
                <div class="alert-modern mb-4 animate-up delay-4" style="background: linear-gradient(135deg, #fff1f2, #ffe4e6); border-left: 6px solid #e11d48; color: #881337; padding: 1.5rem; display: flex; align-items: flex-start; gap: 15px; border-radius: 16px; box-shadow: 0 4px 15px rgba(225, 29, 72, 0.1);">
                    <i class="fas fa-lightbulb" style="font-size: 1.8rem; color: #e11d48; margin-top: 5px;"></i>
                    <div>
                        <h5 style="font-weight: 800; margin-bottom: 5px;">System Insight: Action Recommended</h5>
                        <p style="margin: 0; font-weight: 500; opacity: 0.9;">
                            You marked the following subjects as a priority, but have no active sessions for them:
                            <strong><c:forEach var="sub" items="${missingFocusSubjects}" varStatus="s">${sub}${!s.last ? ', ' : ''}</c:forEach></strong>.
                            Consider booking a tutor to maintain a balanced learning profile!
                        </p>
                    </div>
                </div>
            </c:if>

            <%-- INSIGHTS SECTION --%>
            <div class="row g-4 mb-5 animate-up delay-4">
                <div class="col-md-6">
                    <div class="glass-card h-100">
                        <div class="card-title-modern"><i class="fas fa-layer-group"></i> Subject Distribution</div>
                        <c:choose>
                            <c:when test="${not empty sessionsBySubject}">
                                <div class="d-flex flex-wrap pt-2">
                                    <c:forEach var="entry" items="${sessionsBySubject}">
                                        <div class="subject-tag">
                                            <i class="fas fa-book-open"></i> ${entry.key}
                                            <strong>${entry.value}</strong>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center pt-4 pb-4" style="font-weight:500;">
                                    <i class="fas fa-inbox mb-2" style="font-size:2rem; opacity:0.5;"></i><br>
                                    No subject data available yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="glass-card h-100">
                        <div class="card-title-modern"><i class="fas fa-crosshairs" style="color: #10b981; background: #ecfdf5;"></i> Active Focus Areas</div>
                        <c:choose>
                            <c:when test="${not empty goal.focusSubjects}">
                                <div class="d-flex flex-wrap pt-2">
                                    <c:forTokens items="${goal.focusSubjects}" delims="," var="fs">
                                        <div class="focus-tag">
                                            <i class="fas fa-bullseye"></i> ${fs.trim()}
                                        </div>
                                    </c:forTokens>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center pt-4 pb-4" style="font-weight:500;">
                                    <i class="fas fa-map-marker-alt mb-2" style="font-size:2rem; opacity:0.5;"></i><br>
                                    No focus subjects defined.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <%-- ADVANCED CHART --%>
            <div class="glass-card mb-5 animate-up delay-4">
                <div class="card-title-modern"><i class="fas fa-chart-area" style="color: #8b5cf6; background: #f3e8ff;"></i> Monthly Engagement Trend</div>
                <div class="chart-container pt-3">
                    <canvas id="monthlyChart"></canvas>
                </div>
                <script>
                    const monthLabels = [<c:forEach var="entry" items="${sessionsPerMonth}" varStatus="vs">"${entry.key}"${vs.last ? '' : ','}</c:forEach>];
                    const monthData   = [<c:forEach var="entry" items="${sessionsPerMonth}" varStatus="vs">${entry.value}${vs.last ? '' : ','}</c:forEach>];

                    const ctx = document.getElementById('monthlyChart').getContext('2d');

                    // Create gradient for the line chart area
                    const gradient = ctx.createLinearGradient(0, 0, 0, 300);
                    gradient.addColorStop(0, 'rgba(59, 130, 246, 0.4)');
                    gradient.addColorStop(1, 'rgba(59, 130, 246, 0.0)');

                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: monthLabels,
                            datasets: [{
                                label: 'Sessions Completed',
                                data: monthData,
                                borderColor: '#3b82f6',
                                backgroundColor: gradient,
                                borderWidth: 3,
                                pointBackgroundColor: '#ffffff',
                                pointBorderColor: '#3b82f6',
                                pointBorderWidth: 2,
                                pointRadius: 5,
                                pointHoverRadius: 7,
                                fill: true,
                                tension: 0.4 // Smooth curves
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: false },
                                tooltip: {
                                    backgroundColor: 'rgba(15, 23, 42, 0.9)',
                                    titleFont: { size: 13, family: 'Inter' },
                                    bodyFont: { size: 14, weight: 'bold', family: 'Inter' },
                                    padding: 12,
                                    cornerRadius: 8,
                                    displayColors: false
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: { stepSize: 1, font: { family: 'Inter', size: 12 }, color: '#64748b' },
                                    grid: { color: 'rgba(226, 232, 240, 0.6)', borderDash: [5, 5] },
                                    border: { display: false }
                                },
                                x: {
                                    grid: { display: false },
                                    ticks: { font: { family: 'Inter', size: 12, weight: '600' }, color: '#475569' },
                                    border: { display: false }
                                }
                            },
                            interaction: {
                                intersect: false,
                                mode: 'index',
                            },
                        }
                    });
                </script>
            </div>

            <%-- EDIT FORM PANEL --%>
            <div id="editFormPanel" class="edit-goal-panel mb-5">
                <div class="card-title-modern mb-4"><i class="fas fa-sliders-h" style="color: #f59e0b; background: #fef3c7;"></i> Configure Learning Parameters</div>
                <form action="${pageContext.request.contextPath}/student/goals/save" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="floating-form-group">
                                <input type="number" id="weeklySessionTargetEdit" name="weeklySessionTarget" class="form-control" value="${goal.weeklySessionTarget}" min="1" max="14" placeholder=" " required>
                                <label for="weeklySessionTargetEdit">Weekly Target (Sessions)</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div style="margin-bottom: 1.5rem;">
                                <label style="font-size: 0.8rem; font-weight: 700; color: #64748b; display: block; margin-bottom: 8px;">Priority Subjects</label>
                                <div class="subject-tags-container" id="subjectTagsEdit">
                                    <c:forEach var="s" items="${subjects}">
                                        <span class="subject-checkbox-tag" data-value="${s.name}" onclick="toggleSubjectTag(this, 'focusSubjectsEdit')"><i class="fas fa-book-open"></i> ${s.name}</span>
                                    </c:forEach>
                                </div>
                                <input type="hidden" id="focusSubjectsEdit" name="focusSubjects" value="${goal.focusSubjects}">
                                <script>initSubjectTags('subjectTagsEdit', 'focusSubjectsEdit', '${goal.focusSubjects}');</script>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="floating-form-group">
                                <input type="number" id="targetSessionsEdit" name="targetSessions" class="form-control" value="${goal.targetSessions}" min="1" max="100" placeholder="e.g. 12">
                                <label for="targetSessionsEdit">Target Sessions (Total Goal)</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="floating-form-group">
                                <input type="date" id="goalDateEdit" name="goalDate" class="form-control" value="${goal.goalDate}">
                                <label for="goalDateEdit">Goal Date (Deadline)</label>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-3 pt-3" style="border-top: 1px solid #e2e8f0;">
                        <div class="d-flex gap-3">
                            <button type="submit" class="btn-update"><i class="fas fa-check"></i> Save Configuration</button>
                            <button type="button" onclick="toggleEditPanel()" class="btn-cancel">Cancel</button>
                        </div>
                        <!-- Empty div to push the reset button to the right, but the button itself is moved outside the form below -->
                        <div>
                            <button type="button" onclick="document.getElementById('resetGoalsForm').submit();" class="btn btn-link text-danger text-decoration-none" style="font-weight: 700;">
                                <i class="fas fa-trash-alt me-1"></i> Reset Goals
                            </button>
                        </div>
                    </div>
                </form>

                <form id="resetGoalsForm" action="${pageContext.request.contextPath}/student/goals/delete" method="post" style="display: none;" onsubmit="return confirm('Are you sure you want to completely reset your learning progress goals?');">
                </form>
            </div>

            <script>
                function toggleEditPanel() {
                    const panel = document.getElementById('editFormPanel');
                    if(panel.style.display === 'none' || panel.style.display === '') {
                        panel.style.display = 'block';
                        window.scrollTo({ top: panel.offsetTop - 100, behavior: 'smooth' });
                    } else {
                        panel.style.display = 'none';
                    }
                }
            </script>

        </c:when>
        <c:otherwise>
            <%-- INITIAL GOALS SETUP --%>
            <div class="glass-card animate-up" style="max-width: 600px; margin: 0 auto; margin-top: 2rem; padding: 2.5rem;">
                <div class="text-center mb-4">
                    <div style="width: 80px; height: 80px; background: linear-gradient(135deg, #eff6ff, #dbeafe); border-radius: 24px; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; color: #2563eb; margin: 0 auto 1.5rem; box-shadow: 0 10px 25px rgba(37,99,235,0.15);">
                        <i class="fas fa-rocket"></i>
                    </div>
                    <h3 style="font-weight: 800; color: #1e293b;">Initialize Your Journey</h3>
                    <p class="text-muted" style="font-weight: 500; font-size: 1rem;">Set your baseline parameters. Our system will dynamically track your velocity and streaks.</p>
                </div>

                <form action="${pageContext.request.contextPath}/student/goals/save" method="post">
                    <div class="floating-form-group mt-4">
                        <input type="number" id="weeklySessionTargetNew" name="weeklySessionTarget" class="form-control" placeholder="Recommended: 2-3" min="1" max="14" required>
                        <label for="weeklySessionTargetNew">Target Sessions per Week *</label>
                    </div>
                    <div class="mt-4" style="margin-bottom: 1.5rem;">
                        <label style="font-size: 0.8rem; font-weight: 700; color: #64748b; display: block; margin-bottom: 8px;">Priority Subjects (Optional)</label>
                        <div class="subject-tags-container" id="subjectTagsNew">
                            <c:forEach var="s" items="${subjects}">
                                <span class="subject-checkbox-tag" data-value="${s.name}" onclick="toggleSubjectTag(this, 'focusSubjectsNew')"><i class="fas fa-book-open"></i> ${s.name}</span>
                            </c:forEach>
                        </div>
                        <input type="hidden" id="focusSubjectsNew" name="focusSubjects" value="">
                    </div>
                    <div class="floating-form-group mt-4">
                        <input type="number" id="targetSessionsNew" name="targetSessions" class="form-control" min="1" max="100" placeholder="e.g. 12 (Optional)">
                        <label for="targetSessionsNew">Target Sessions (Total Goal)</label>
                    </div>
                    <div class="floating-form-group mt-4">
                        <input type="date" id="goalDateNew" name="goalDate" class="form-control">
                        <label for="goalDateNew">Goal Date (Optional)</label>
                    </div>
                    <button type="submit" class="btn-update w-100 justify-content-center mt-3" style="padding: 14px; font-size: 1.05rem;">
                        <i class="fas fa-play-circle"></i> Activate Progress Tracking
                    </button>
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%-- WEEKLY REPORT MODAL --%>
<c:if test="${goal != null}">
    <div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 20px; border: none; box-shadow: 0 20px 50px rgba(0,0,0,0.1);">
                <div class="modal-header" style="background: linear-gradient(135deg, #10b981, #059669); color: white; border-top-left-radius: 20px; border-top-right-radius: 20px; padding: 1.5rem;">
                    <h5 class="modal-title" id="reportModalLabel" style="font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800;">
                        <i class="fas fa-file-invoice me-2"></i> Automated Weekly Summary
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" style="padding: 2rem; font-family: 'Inter', sans-serif; font-size: 1.05rem; line-height: 1.6; color: #334155;">
                    <p>Hello! Here is your system-generated learning progress summary for this week:</p>

                    <div style="background: #f8fafc; padding: 15px; border-radius: 12px; border-left: 4px solid #3b82f6; margin-bottom: 15px;">
                        <strong>Activity:</strong> You have completed <strong>${goal.thisWeekSessions}</strong> out of your targeted <strong>${goal.weeklySessionTarget}</strong> sessions.
                        <c:choose>
                            <c:when test="${goal.weeklyTargetMet}"> Incredible work! You've successfully hit your weekly target.</c:when>
                            <c:otherwise> You need ${goal.weeklySessionTarget - goal.thisWeekSessions} more sessions to reach your goal. You can do it!</c:otherwise>
                        </c:choose>
                    </div>

                    <div style="background: #f8fafc; padding: 15px; border-radius: 12px; border-left: 4px solid #f59e0b; margin-bottom: 15px;">
                        <strong>Consistency:</strong> Your current study streak is <strong>${goal.studyStreak} weeks</strong>.
                        <c:choose>
                            <c:when test="${goal.studyStreak >= 3}"> Your momentum is unstoppable!</c:when>
                            <c:otherwise> Keep booking sessions to build a long-lasting learning habit.</c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${not empty goal.focusSubjects}">
                        <p style="margin-bottom: 0;"><strong>Primary Focus:</strong> You are actively focusing on <strong>${goal.focusSubjects}</strong>.</p>
                    </c:if>
                    <c:if test="${not empty missingFocusSubjects}">
                        <p style="color: #e11d48; margin-top: 10px; font-weight: 600;"><i class="fas fa-exclamation-triangle"></i> Reminder: You haven't had any sessions for <c:forEach var="sub" items="${missingFocusSubjects}" varStatus="s">${sub}${!s.last ? ', ' : ''}</c:forEach> recently!</p>
                    </c:if>

                    <hr style="opacity: 0.1; margin: 1.5rem 0;">
                    <p style="text-align: center; font-weight: 700; color: #1e293b; margin: 0;">Keep up the fantastic work on TutorLink! 🚀</p>
                </div>
                <div class="modal-footer" style="border-top: none; padding: 0 2rem 2rem;">
                    <button type="button" class="btn btn-light w-100" data-bs-dismiss="modal" style="font-weight: 700; border-radius: 12px; padding: 12px; background: #f1f5f9; color: #475569;">Close Report</button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<%-- ACHIEVEMENTS MODAL --%>
<c:if test="${goal != null}">
    <div class="modal fade" id="achievementsModal" tabindex="-1" aria-labelledby="achievementsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 20px; border: none; box-shadow: 0 20px 50px rgba(0,0,0,0.1);">
                <div class="modal-header" style="background: linear-gradient(135deg, #4c1d95, #8b5cf6); color: white; border-top-left-radius: 20px; border-top-right-radius: 20px; padding: 1.5rem;">
                    <h5 class="modal-title" id="achievementsModalLabel" style="font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800;">
                        <i class="fas fa-trophy me-2"></i> Your Gamification Profile
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" style="padding: 2rem; font-family: 'Inter', sans-serif; color: #334155;">
                    <div style="text-align: center; margin-bottom: 2rem;">
                        <div style="width: 100px; height: 100px; border-radius: 50%; background: #f3e8ff; color: #8b5cf6; font-size: 3rem; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; border: 4px solid #ede9fe;">
                            <i class="fas ${rankIcon}"></i>
                        </div>
                        <h3 style="font-weight: 800; color: #1e293b; margin-bottom: 5px;">${rank}</h3>
                        <p style="color: #64748b; font-weight: 500;">${goal.totalCompletedSessions} Lifetime Sessions</p>
                    </div>

                    <h6 style="font-weight: 700; color: #475569; margin-bottom: 15px; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 1px;">Rank Progression Path</h6>

                    <div style="display: flex; flex-direction: column; gap: 12px;">
                        <div style="padding: 12px 15px; border-radius: 12px; background: ${goal.totalCompletedSessions >= 25 ? '#f3e8ff' : '#f8fafc'}; border: 1px solid ${goal.totalCompletedSessions >= 25 ? '#c4b5fd' : '#e2e8f0'}; display: flex; align-items: center;">
                            <i class="fas fa-gem me-3" style="font-size: 1.5rem; color: ${goal.totalCompletedSessions >= 25 ? '#8b5cf6' : '#cbd5e1'};"></i>
                            <div style="flex: 1;">
                                <div style="font-weight: 700; color: ${goal.totalCompletedSessions >= 25 ? '#5b21b6' : '#94a3b8'};">Diamond Master</div>
                                <div style="font-size: 0.8rem; color: #64748b;">25+ sessions</div>
                            </div>
                            <c:if test="${goal.totalCompletedSessions >= 25}"><i class="fas fa-check-circle" style="color: #10b981; font-size: 1.2rem;"></i></c:if>
                        </div>

                        <div style="padding: 12px 15px; border-radius: 12px; background: ${goal.totalCompletedSessions >= 10 ? '#fef3c7' : '#f8fafc'}; border: 1px solid ${goal.totalCompletedSessions >= 10 ? '#fde68a' : '#e2e8f0'}; display: flex; align-items: center;">
                            <i class="fas fa-medal me-3" style="font-size: 1.5rem; color: ${goal.totalCompletedSessions >= 10 ? '#f59e0b' : '#cbd5e1'};"></i>
                            <div style="flex: 1;">
                                <div style="font-weight: 700; color: ${goal.totalCompletedSessions >= 10 ? '#b45309' : '#94a3b8'};">Gold Scholar</div>
                                <div style="font-size: 0.8rem; color: #64748b;">10+ sessions</div>
                            </div>
                            <c:if test="${goal.totalCompletedSessions >= 10}"><i class="fas fa-check-circle" style="color: #10b981; font-size: 1.2rem;"></i></c:if>
                        </div>

                        <div style="padding: 12px 15px; border-radius: 12px; background: ${goal.totalCompletedSessions >= 5 ? '#f1f5f9' : '#f8fafc'}; border: 1px solid ${goal.totalCompletedSessions >= 5 ? '#cbd5e1' : '#e2e8f0'}; display: flex; align-items: center;">
                            <i class="fas fa-shield-alt me-3" style="font-size: 1.5rem; color: ${goal.totalCompletedSessions >= 5 ? '#64748b' : '#cbd5e1'};"></i>
                            <div style="flex: 1;">
                                <div style="font-weight: 700; color: ${goal.totalCompletedSessions >= 5 ? '#334155' : '#94a3b8'};">Silver Achiever</div>
                                <div style="font-size: 0.8rem; color: #64748b;">5+ sessions</div>
                            </div>
                            <c:if test="${goal.totalCompletedSessions >= 5}"><i class="fas fa-check-circle" style="color: #10b981; font-size: 1.2rem;"></i></c:if>
                        </div>

                        <div style="padding: 12px 15px; border-radius: 12px; background: #ffedd5; border: 1px solid #fed7aa; display: flex; align-items: center;">
                            <i class="fas fa-user-graduate me-3" style="font-size: 1.5rem; color: #ea580c;"></i>
                            <div style="flex: 1;">
                                <div style="font-weight: 700; color: #9a3412;">Bronze Novice</div>
                                <div style="font-size: 0.8rem; color: #64748b;">0+ sessions</div>
                            </div>
                            <i class="fas fa-check-circle" style="color: #10b981; font-size: 1.2rem;"></i>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: none; padding: 0 2rem 2rem;">
                    <button type="button" class="btn btn-light w-100" data-bs-dismiss="modal" style="font-weight: 700; border-radius: 12px; padding: 12px; background: #f1f5f9; color: #475569;">Close</button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
    function toggleSubjectTag(element, hiddenInputId) {
        element.classList.toggle('selected');
        var hidden = document.getElementById(hiddenInputId);
        var selected = [];
        var container = element.closest('.subject-tags-container');
        container.querySelectorAll('.subject-checkbox-tag.selected').forEach(function(tag) {
            selected.push(tag.getAttribute('data-value'));
        });
        hidden.value = selected.join(',');
    }
    function initSubjectTags(containerId, hiddenInputId, savedValue) {
        if (!savedValue || savedValue.trim() === '') return;
        var saved = savedValue.split(',').map(function(s) { return s.trim().toLowerCase(); });
        var container = document.getElementById(containerId);
        if (!container) return;
        container.querySelectorAll('.subject-checkbox-tag').forEach(function(tag) {
            if (saved.includes(tag.getAttribute('data-value').toLowerCase())) {
                tag.classList.add('selected');
            }
        });
        var hidden = document.getElementById(hiddenInputId);
        hidden.value = savedValue;
    }
</script>
</body>
</html>
