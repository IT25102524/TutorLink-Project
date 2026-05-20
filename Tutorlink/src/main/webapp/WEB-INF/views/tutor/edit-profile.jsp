<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Profile - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tutor.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.css">
</head>
<body>

<div class="sidebar">
    <div class="sb-brand">
        <div class="sb-logo"><i class="fas fa-chalkboard-teacher"></i></div>
        <div class="sb-name">Tutor<span>Link</span></div>
    </div>
    <nav class="sb-nav">
        <a href="${pageContext.request.contextPath}/tutor/dashboard" class="sb-link">
            <i class="fas fa-th-large"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/bookings" class="sb-link">
            <i class="fas fa-calendar-check"></i><span>Booking Requests</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/reviews" class="sb-link">
            <i class="fas fa-star"></i><span>My Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link">
            <i class="fas fa-book-open"></i><span>My Subjects</span>
        </a>
        <a href="${pageContext.request.contextPath}/availability/list" class="sb-link">
            <i class="fas fa-clock"></i><span>Availability</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
    </nav>


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    <div class="dm-toggle" onclick="window.__tlToggleTheme()">
        <i id="dm-icon" class="fas fa-moon dm-icon"></i>
        <span id="dm-label">Dark Mode</span>
        <div class="dm-track"></div>
    </div></div>

<div class="main-content">
    <div class="page-header">
        <div>
            <h4 class="page-title">Edit Profile</h4>
            <p class="page-sub">Update your tutor profile details.</p>
        </div>
    </div>

    <div class="card" style="max-width:700px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid rgba(5,150,105,0.1);">
            <div style="width:48px;height:48px;border-radius:14px;background:linear-gradient(135deg,#059669,#34d399);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
                <i class="fas fa-user-edit"></i>
            </div>
            <div>
                <div style="font-weight:700;color:var(--t-text);">Edit Your Profile</div>
                <div style="font-size:0.82rem;color:var(--t-text-muted);">Keep your details up to date for students to find you.</div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/tutor/profile/edit" method="post">
            <div class="row g-4">

                <div class="col-12">
                    <label class="form-label">Full Name <span style="color:var(--t-accent-rose)">*</span></label>
                    <input type="text" name="fullName" class="form-control" value="${tutor.fullName}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Phone</label>
                    <input type="text" name="phone" class="form-control" value="${tutor.phone}" placeholder="07X XXXXXXX">
                </div>
                <div class="col-md-6">
                    <div style="background-color: #ecfdf5; border: 1px solid rgba(5,150,105,0.2); border-radius: 12px; padding: 14px 18px;">
                        <p style="margin: 0; font-size: 0.9rem; font-weight: 600; color: #065f46;">
                            <i class="fas fa-book-open" style="color: #059669; margin-right: 8px;"></i>Manage your teaching subjects from the <a href="${pageContext.request.contextPath}/tutor/subjects" style="color: #059669; font-weight: 700; text-decoration: underline;">My Subjects section</a>.
                        </p>
                        <small style="color: #64748b; font-size: 0.8rem; font-weight: 500; display: block; margin-top: 4px;">You can add multiple subjects with different mediums, modes, and rates there.</small>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label">District <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="district" class="form-select" required>
                        <option value="">Select your district</option>
                        <c:forEach var="d" items="${districts}">
                            <option value="${d}" ${tutor.district == d ? 'selected' : ''}>${d}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Experience</label>
                    <input type="text" name="experience" class="form-control" value="${tutor.experience}" placeholder="e.g. 3 years teaching Mathematics">
                </div>

                <%-- Session Pricing --%>
                <div class="col-12">
                    <div style="background:linear-gradient(135deg,#f0fdf4,#dcfce7);border-radius:12px;padding:1.2rem 1.4rem;border:1px solid rgba(5,150,105,0.15);">
                        <div style="font-size:0.8rem;font-weight:800;color:#059669;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:1rem;">
                            <i class="fas fa-tag me-2"></i>Session Pricing
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-laptop me-1" style="color:#06b6d4;"></i> Online Rate (LKR/hr) *</label>
                                <input type="number" name="onlineHourlyRate" class="form-control"
                                       value="${tutor.effectiveOnlineRate}" min="0" step="50" required>
                                <div style="font-size:0.75rem;color:#64748b;margin-top:4px;">Rate for virtual sessions (Zoom, Meet)</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><i class="fas fa-home me-1" style="color:#8b5cf6;"></i> Home Visit Rate (LKR/hr) *</label>
                                <input type="number" name="homeVisitHourlyRate" class="form-control"
                                       value="${tutor.effectiveHomeVisitRate}" min="0" step="50" required>
                                <div style="font-size:0.75rem;color:#64748b;margin-top:4px;">Rate when you travel to student</div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Travel Preference --%>
                <div class="col-12">
                    <div style="background:linear-gradient(135deg,#f0f9ff,#e0f2fe);border-radius:12px;padding:1.2rem 1.4rem;border:1px solid rgba(6,182,212,0.15);">
                        <div style="font-size:0.8rem;font-weight:800;color:#0891b2;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:1rem;">
                            <i class="fas fa-map-marker-alt me-2"></i>Travel Preference
                        </div>
                        <div class="row g-3 align-items-center">
                            <div class="col-md-5">
                                <label class="form-label">Travel Radius (km)</label>
                                <input type="number" name="travelRadius" id="travelRadiusInput" class="form-control"
                                       value="${tutor.travelRadius}" min="0" max="200" step="1"
                                       placeholder="e.g. 10" oninput="updateRadiusLabel(this.value)">
                                <div style="font-size:0.75rem;color:#64748b;margin-top:4px;">Set 0 if you prefer not to specify</div>
                            </div>
                            <div class="col-md-7 d-flex align-items-center" style="padding-top:1.5rem;">
                                <div id="radiusPreview" style="font-size:0.9rem;font-weight:600;color:#0891b2;">
                                    <c:choose>
                                        <c:when test="${tutor.travelRadius > 0}">
                                            <i class="fas fa-circle-check me-2"></i>Willing to travel up to <strong>${tutor.travelRadius} km</strong>
                                        </c:when>
                                        <c:otherwise><i class="fas fa-info-circle me-2"></i>No travel radius set</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Qualifications --%>
                <div class="col-12">
                    <div style="background:linear-gradient(135deg,#fffbeb,#fef3c7);border-radius:12px;padding:1.2rem 1.4rem;border:1px solid rgba(245,158,11,0.2);">
                        <div style="font-size:0.8rem;font-weight:800;color:#d97706;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:1rem;">
                            <i class="fas fa-certificate me-2"></i>Qualifications
                        </div>
                        <input type="text" name="qualification" class="form-control"
                               value="${tutor.qualification}"
                               placeholder="e.g. BSc in Mathematics, University of Colombo">
                        <div style="font-size:0.75rem;color:#64748b;margin-top:4px;">Your educational background or teaching certifications</div>
                    </div>
                </div>

                <div class="col-12">
                    <label class="form-label">Bio</label>
                    <textarea name="bio" class="form-control" rows="4"
                              placeholder="Tell students about yourself, your teaching style, qualifications...">${tutor.bio}</textarea>
                </div>

                <%-- ── Bank Transfer Details ─────────────────────────────── --%>
                <div class="col-12">
                    <div style="background:linear-gradient(135deg,#eff6ff,#dbeafe);border-radius:12px;padding:1.2rem 1.4rem;border:1px solid rgba(37,99,235,0.18);">
                        <div style="font-size:0.8rem;font-weight:800;color:#1d4ed8;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:0.4rem;">
                            <i class="fas fa-university me-2"></i>Bank Transfer Details
                        </div>
                        <div style="font-size:0.8rem;color:#64748b;margin-bottom:1rem;">
                            These details are shown to students when they choose <strong>Bank Transfer</strong> as their payment method. Leave blank if you don't accept bank transfers.
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Bank Name</label>
                                <input type="text" name="bankName" class="form-control"
                                       value="${tutor.bankName}"
                                       placeholder="e.g. Bank of Ceylon">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Account Holder Name</label>
                                <input type="text" name="accountHolderName" class="form-control"
                                       value="${tutor.accountHolderName}"
                                       placeholder="e.g. Kasun Perera">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Account Number</label>
                                <input type="text" name="accountNumber" class="form-control"
                                       value="${tutor.accountNumber}"
                                       placeholder="e.g. 12345678901">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Branch</label>
                                <input type="text" name="branch" class="form-control"
                                       value="${tutor.branch}"
                                       placeholder="e.g. Colombo Main">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid rgba(5,150,105,0.1);">
                    <button type="submit" class="btn-tutor-primary"><i class="fas fa-save"></i> Save Changes</button>
                    <a href="${pageContext.request.contextPath}/tutor/profile" class="btn-tutor-secondary">Cancel</a>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function updateRadiusLabel(val) {
        var el = document.getElementById('radiusPreview');
        var n = parseInt(val) || 0;
        el.innerHTML = n > 0
            ? '<i class="fas fa-circle-check me-2"></i>Willing to travel up to <strong>' + n + ' km</strong>'
            : '<i class="fas fa-info-circle me-2"></i>No travel radius set';
    }
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
</script><script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
<script>
(function(){
    document.querySelectorAll('select.form-select').forEach(function(el){
        if (el.tomselect) return;
        new TomSelect(el, {
            create: false,
            allowEmptyOption: true,
            maxOptions: null,
            render: {
                item: function(data, escape) {
                    var text = data.text || '';
                    var parts = text.split(' | ');
                    return '<div>' + escape(parts[0]) + '</div>';
                },
                option: function(data, escape) {
                    var text = data.text || '';
                    var parts = text.split(' | ');
                    if (parts.length === 1) {
                        return '<div><span style="font-weight: 600;">' + escape(parts[0]) + '</span></div>';
                    }
                    var html = '<div><div style="font-weight: 600; font-size: 0.95rem; margin-bottom: 2px;">' + escape(parts[0]) + '</div>';
                    html += '<div style="display: flex; gap: 6px; font-size: 0.75rem;">';
                    if (parts[1]) html += '<span class="ts-pill-primary">' + escape(parts[1]) + '</span>';
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
