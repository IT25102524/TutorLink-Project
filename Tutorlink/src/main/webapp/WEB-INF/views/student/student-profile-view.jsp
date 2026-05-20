<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Profile View - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor.css">
    <style>
        body { background: #f8fafc; }
        .profile-view-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            padding: 2.5rem;
            max-width: 600px;
            margin: 2rem auto;
            border: 1px solid #e2e8f0;
        }
        .profile-avatar-container {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .profile-avatar {
            font-size: 5rem;
            color: #3b82f6;
            background: #eff6ff;
            width: 120px;
            height: 120px;
            line-height: 120px;
            border-radius: 50%;
            display: inline-block;
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.15);
        }
        .profile-name {
            font-size: 1.8rem;
            font-weight: 800;
            color: #1e293b;
            margin-top: 1rem;
            margin-bottom: 0.3rem;
        }
        .profile-subtitle {
            font-size: 1.05rem;
            font-weight: 500;
            color: #64748b;
            margin-bottom: 2rem;
        }
        .profile-detail-row {
            display: flex;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .profile-detail-row:last-of-type {
            border-bottom: none;
        }
        .profile-detail-icon {
            width: 45px;
            height: 45px;
            line-height: 45px;
            text-align: center;
            background: #f8fafc;
            color: #475569;
            border-radius: 12px;
            font-size: 1.1rem;
            margin-right: 1.2rem;
        }
        .profile-detail-content {
            flex-grow: 1;
        }
        .profile-detail-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.2rem;
        }
        .profile-detail-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #334155;
        }
        .back-btn-container {
            max-width: 600px;
            margin: 2rem auto 0;
        }
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #ffffff;
            color: #475569;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        }
        .btn-back:hover {
            background: #f1f5f9;
            color: #1e293b;
        }
    </style>
</head>
<body>

<div class="container pb-5">
    <div class="back-btn-container">
        <a href="javascript:history.back()" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Bookings
        </a>
    </div>

    <c:choose>
        <c:when test="${student != null}">
            <div class="profile-view-card">
                <div class="profile-avatar-container">
                    <div class="profile-avatar">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <h2 class="profile-name">${student.fullName}</h2>
                    <div class="profile-subtitle">${student.profileSummary}</div>
                </div>

                <div class="profile-details">
                    <div class="profile-detail-row">
                        <div class="profile-detail-icon"><i class="fas fa-user"></i></div>
                        <div class="profile-detail-content">
                            <div class="profile-detail-label">Full Name</div>
                            <div class="profile-detail-value">${student.fullName}</div>
                        </div>
                    </div>

                    <div class="profile-detail-row">
                        <div class="profile-detail-icon"><i class="fas fa-envelope"></i></div>
                        <div class="profile-detail-content">
                            <div class="profile-detail-label">Email Address</div>
                            <div class="profile-detail-value">${student.email}</div>
                        </div>
                    </div>

                    <div class="profile-detail-row">
                        <div class="profile-detail-icon"><i class="fas fa-phone"></i></div>
                        <div class="profile-detail-content">
                            <div class="profile-detail-label">Phone Number</div>
                            <div class="profile-detail-value">${student.phone}</div>
                        </div>
                    </div>

                    <div class="profile-detail-row">
                        <div class="profile-detail-icon"><i class="fas fa-graduation-cap"></i></div>
                        <div class="profile-detail-content">
                            <div class="profile-detail-label">Grade Level</div>
                            <div class="profile-detail-value">Grade ${student.gradeLevel}</div>
                        </div>
                    </div>

                    <div class="profile-detail-row">
                        <div class="profile-detail-icon"><i class="fas fa-map-marker-alt"></i></div>
                        <div class="profile-detail-content">
                            <div class="profile-detail-label">District</div>
                            <div class="profile-detail-value">${student.district}</div>
                        </div>
                    </div>

                    <c:if test="${not empty student.address}">
                        <div class="profile-detail-row">
                            <div class="profile-detail-icon"><i class="fas fa-home"></i></div>
                            <div class="profile-detail-content">
                                <div class="profile-detail-label">Address</div>
                                <div class="profile-detail-value">${student.address}</div>
                            </div>
                        </div>
                    </c:if>
                </div>

                <div class="text-center mt-4">
                    <small class="text-muted"><i class="fas fa-lock me-1"></i> This profile is visible to tutors for booking purposes.</small>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="profile-view-card text-center" style="padding: 3rem;">
                <i class="fas fa-exclamation-circle" style="color: #ef4444; font-size: 4rem; margin-bottom: 1rem;"></i>
                <h4 style="font-weight: 800; color: #1e293b;">Student Profile Not Found</h4>
                <p style="color: #64748b; font-weight: 500;">This student profile could not be loaded. Please go back and try again.</p>
                <a href="javascript:history.back()" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Bookings</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
