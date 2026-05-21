<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Subject - TutorLink Admin</title>
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
            <h4 class="page-title">Add New Subject</h4>
            <p class="page-sub">Add a new subject to the system curriculum.</p>
        </div>
    </div>

    <div class="card" style="max-width: 550px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid var(--admin-border);">
            <div style="width:48px;height:48px;border-radius:12px;background:linear-gradient(135deg,var(--accent-purple),var(--accent-blue));display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#fff;">
                <i class="fas fa-book-open"></i>
            </div>
            <div>
                <div style="font-weight:700;color:#fff;">New Subject</div>
                <div style="font-size:0.82rem;color:var(--text-faint);">This will be available for tutors to select.</div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/subject/add" method="post">
            <div class="row g-4">
                <div class="col-12">
                    <label class="form-label">Subject Name <span style="color:var(--accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-book"></i></span>
                        <input type="text" name="name" class="form-control" placeholder="e.g. Mathematics" required>
                    </div>
                </div>
                <div class="col-12">
                    <label class="form-label">Subject Type <span style="color:var(--accent-rose)">*</span></label>
<input type="hidden" name="subjectType" id="subjectTypeValue" required>
<div class="custom-select-wrap" id="customSelect">
                        <div class="custom-select-trigger" id="selectTrigger">
                            <span class="select-icon"><i class="fas fa-layer-group"></i></span>
                            <span class="select-text" id="selectText">Select subject type</span>
                            <span class="select-arrow"><i class="fas fa-chevron-down"></i></span>
                        </div>
                        <div class="custom-select-options" id="selectOptions">
                            <div class="custom-option" data-value="PRIMARY">
                                <span class="opt-dot" style="background:#2dd4bf;"></span>
                                <span class="opt-label">Primary</span>
                                <span class="opt-grade">Grade 1 - 5</span>
                            </div>
                            <div class="custom-option" data-value="OLEVEL">
                                <span class="opt-dot" style="background:#22d3ee;"></span>
                                <span class="opt-label">O/L</span>
                                <span class="opt-grade">Grade 6 - 11</span>
                            </div>
                            <div class="custom-option" data-value="ALEVEL">
                                <span class="opt-dot" style="background:#c084fc;"></span>
                                <span class="opt-label">A/L</span>
                                <span class="opt-grade">Grade 12 - 13</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Medium <span style="color:var(--accent-rose)">*</span></label>
                    <select name="medium" class="form-select" required>
                        <option value="">Select medium</option>
                        <option value="Sinhala">Sinhala</option>
                        <option value="English">English</option>
                        <option value="Tamil">Tamil</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Category <span style="color:var(--accent-rose)">*</span></label>
                    <select name="category" class="form-select" required>
                        <option value="">Select category</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Science">Science</option>
                        <option value="Commerce">Commerce</option>
                        <option value="Arts">Arts</option>
                        <option value="Technology">Technology</option>
                        <option value="Languages">Languages</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="col-12">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">
                        <option value="ACTIVE">Active</option>
                        <option value="INACTIVE">Inactive</option>
                    </select>
                </div>
                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid var(--admin-border);">
                    <button type="submit" class="btn-admin-primary">
                        <i class="fas fa-plus"></i> Add Subject
                    </button>
                    <a href="${pageContext.request.contextPath}/subject/list" class="btn-admin-secondary">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    .custom-select-wrap {
        position: relative;
        width: 100%;
    }
    .custom-select-trigger {
        display: flex; align-items: center; gap: 12px;
        background: var(--admin-bg);
        border: 1.5px solid var(--admin-border);
        border-radius: 10px;
        padding: 12px 16px;
        cursor: pointer;
        transition: all 0.3s;
        color: var(--text-dim);
        font-size: 0.95rem;
    }
    .custom-select-trigger:hover {
        border-color: rgba(59,130,246,0.3);
    }
    .custom-select-trigger.open {
        border-color: var(--accent-blue);
        box-shadow: 0 0 0 4px rgba(59,130,246,0.1);
        border-bottom-left-radius: 0;
        border-bottom-right-radius: 0;
    }
    .custom-select-trigger.selected {
        color: #fff;
    }
    .select-icon {
        color: var(--text-faint);
        font-size: 0.9rem; width: 20px; text-align: center;
    }
    .select-text { flex: 1; font-weight: 600; }
    .select-arrow {
        color: var(--text-faint);
        font-size: 0.75rem;
        transition: transform 0.3s;
    }
    .custom-select-trigger.open .select-arrow {
        transform: rotate(180deg);
        color: var(--accent-blue);
    }
    .custom-select-options {
        position: absolute;
        top: 100%;
        left: 0; right: 0;
        background: #1a2332;
        border: 1.5px solid var(--accent-blue);
        border-top: none;
        border-radius: 0 0 10px 10px;
        overflow: hidden;
        display: none;
        z-index: 50;
        box-shadow: 0 12px 30px rgba(0,0,0,0.4);
    }
    .custom-select-options.show { display: block; }
    .custom-option {
        display: flex; align-items: center; gap: 12px;
        padding: 14px 18px;
        cursor: pointer;
        transition: all 0.2s;
        border-bottom: 1px solid rgba(255,255,255,0.04);
    }
    .custom-option:last-child { border-bottom: none; }
    .custom-option:hover {
        background: rgba(59,130,246,0.08);
    }
    .custom-option.active {
        background: rgba(59,130,246,0.12);
    }
    .opt-dot {
        width: 10px; height: 10px; border-radius: 50%;
        flex-shrink: 0;
        box-shadow: 0 0 8px currentColor;
    }
    .opt-label {
        font-weight: 700; color: #fff; font-size: 0.95rem;
        flex: 1;
    }
    .opt-grade {
        font-size: 0.78rem; color: var(--text-faint); font-weight: 600;
    }
</style>
<script>
    const trigger = document.getElementById('selectTrigger');
    const options = document.getElementById('selectOptions');
    const textEl = document.getElementById('selectText');
    const hiddenInput = document.getElementById('subjectTypeValue');

    trigger.addEventListener('click', () => {
        trigger.classList.toggle('open');
        options.classList.toggle('show');
    });

    document.querySelectorAll('.custom-option').forEach(opt => {
        opt.addEventListener('click', () => {
            const value = opt.dataset.value;
            const label = opt.querySelector('.opt-label').textContent;
            const grade = opt.querySelector('.opt-grade').textContent;
            hiddenInput.value = value;
            textEl.textContent = label + '  —  ' + grade;
            trigger.classList.add('selected');
            trigger.classList.remove('open');
            options.classList.remove('show');
            document.querySelectorAll('.custom-option').forEach(o => o.classList.remove('active'));
            opt.classList.add('active');
        });
    });

    document.addEventListener('click', (e) => {
        if (!e.target.closest('.custom-select-wrap')) {
            trigger.classList.remove('open');
            options.classList.remove('show');
        }
    });
</script></body>
</html>
