<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Subject - TutorLink Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="sidebar">
    <div class="sb-brand">
        <div class="sb-logo"><i class="fas fa-shield-alt"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </div>
    <div class="sb-section-label">Navigation</div>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-link">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="sb-link">
            <i class="fas fa-users-cog"></i><span>Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="sb-link">
            <i class="fas fa-calendar-check"></i><span>Bookings</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reviews" class="sb-link">
            <i class="fas fa-star-half-alt"></i><span>Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/subject/list" class="sb-link active">
            <i class="fas fa-book-open"></i><span>Subjects</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sb-link">
            <i class="fas fa-chart-bar"></i><span>Analytics</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/admins" class="sb-link">
            <i class="fas fa-user-shield"></i><span>Admin Accounts</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/admin/all" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/create" class="sb-link">
            <i class="fas fa-user-plus"></i><span>Add Admin</span>
        </a>
    </nav>


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout">
        <i class="fas fa-sign-out-alt"></i><span>Logout</span>
    </a>
</div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">Edit Subject</h4>
            <p class="page-sub">Update subject details.</p>
        </div>
    </div>

    <div class="card" style="max-width: 550px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid var(--admin-border);">
            <div style="width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,var(--accent-gold),var(--accent-rose));display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#fff;">
                <i class="fas fa-edit"></i>
            </div>
            <div>
                <div style="font-weight:700;color:#fff;">Editing: ${subject.name}</div>
                <div style="font-size:0.82rem;color:var(--text-faint);">${subject.subjectType} &bull; ${subject.gradeLevel}</div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/subject/edit/${subject.subjectId}" method="post">
            <div class="row g-4">
                <div class="col-12">
                    <label class="form-label">Subject Name <span style="color:var(--accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-book"></i></span>
                        <input type="text" name="name" class="form-control" value="${subject.name}" required>
                    </div>
                </div>
                <div class="col-12">
                    <label class="form-label">Subject Type</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-layer-group"></i></span>
                        <input type="text" class="form-control" value="${subject.subjectType} - ${subject.gradeLevel}" readonly style="opacity:0.6;">
                    </div>
                    <div class="mt-1" style="font-size:0.78rem;color:var(--text-faint);">
                        <i class="fas fa-info-circle me-1"></i> Subject type cannot be changed after creation.
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Medium <span style="color:var(--accent-rose)">*</span></label>
                    <select name="medium" class="form-select" required>
                        <option value="">Select medium</option>
                        <option value="Sinhala" ${subject.medium == 'Sinhala' ? 'selected' : ''}>Sinhala</option>
                        <option value="English" ${subject.medium == 'English' ? 'selected' : ''}>English</option>
                        <option value="Tamil" ${subject.medium == 'Tamil' ? 'selected' : ''}>Tamil</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Category <span style="color:var(--accent-rose)">*</span></label>
                    <select name="category" class="form-select" required>
                        <option value="">Select category</option>
                        <option value="Mathematics" ${subject.category == 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                        <option value="Science" ${subject.category == 'Science' ? 'selected' : ''}>Science</option>
                        <option value="Commerce" ${subject.category == 'Commerce' ? 'selected' : ''}>Commerce</option>
                        <option value="Arts" ${subject.category == 'Arts' ? 'selected' : ''}>Arts</option>
                        <option value="Technology" ${subject.category == 'Technology' ? 'selected' : ''}>Technology</option>
                        <option value="Languages" ${subject.category == 'Languages' ? 'selected' : ''}>Languages</option>
                        <option value="Other" ${subject.category == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div class="col-12">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">
                        <option value="ACTIVE" ${subject.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                        <option value="INACTIVE" ${subject.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid var(--admin-border);">
                    <button type="submit" class="btn-admin-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/subject/list" class="btn-admin-secondary">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script></body>
</html>
