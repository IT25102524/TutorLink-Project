<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Availability - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/availability/list" class="sb-link active">
            <i class="fas fa-clock"></i><span>Availability</span>
        </a>
        <a href="${pageContext.request.contextPath}/payment/history" class="sb-link">
            <i class="fas fa-credit-card"></i><span>Payments</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile" class="sb-link">
            <i class="fas fa-user-circle"></i><span>My Profile</span>
        </a>
        <a href="${pageContext.request.contextPath}/tutor/profile/edit" class="sb-link">
            <i class="fas fa-user-edit"></i><span>Edit Profile</span>
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
            <h4 class="page-title">Edit Availability Slot</h4>
            <p class="page-sub">Update this time slot.</p>
        </div>
    </div>

    <div class="card" style="max-width: 550px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid rgba(5,150,105,0.1);">
            <div style="width:48px;height:48px;border-radius:14px;background:linear-gradient(135deg,#f59e0b,#fbbf24);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
                <i class="fas fa-edit"></i>
            </div>
            <div>
                <div style="font-weight:700;color:var(--t-text);">Editing: ${slot.day}</div>
                <div style="font-size:0.82rem;color:var(--t-text-muted);">${slot.startTime} - ${slot.endTime}</div>
            </div>
        </div>

        <%-- JS map: tutorSubjectId -> {name, medium, mode} --%>
        <script>
            const tsMap = {
                <c:forEach var="ts" items="${tutorSubjects}" varStatus="vs">
                "${ts.tutorSubjectId}": {
                    name: "${ts.subjectName}",
                    medium: "${ts.medium}",
                    mode: "${ts.teachingMode}"
                }${vs.last ? '' : ','}
                </c:forEach>
            };

            function onTutorSubjectChange(select) {
                const id = select.value;
                const infoBox = document.getElementById('subjectInfoBox');
                const mediumVal = document.getElementById('mediumVal');
                const modeVal = document.getElementById('modeVal');
                const mediumInput = document.getElementById('mediumInput');
                const overlay = document.getElementById('tsOverlay');

                if (id && tsMap[id]) {
                    const data = tsMap[id];
                    overlay.textContent = data.name;
                    overlay.style.display = 'block';
                    select.style.color = 'transparent';
                    mediumVal.textContent = data.medium;
                    modeVal.textContent = data.mode === 'ONLINE' ? 'Online' :
                                          data.mode === 'HOME_VISIT' ? 'Home Visit' : 'Both';
                    mediumInput.value = data.medium;
                    infoBox.style.display = 'block';
                } else {
                    overlay.style.display = 'none';
                    select.style.color = '';
                    infoBox.style.display = 'none';
                    mediumInput.value = '';
                }
            }

            // On page load, auto-fill from currently selected subject
            window.addEventListener('load', function() {
                const select = document.getElementById('tsSelect');
                if (select.value) {
                    onTutorSubjectChange(select);
                }
            });
        </script>

        <form action="${pageContext.request.contextPath}/availability/edit/${slot.slotId}" method="post">
            <div class="row g-4">

                <%-- Teaching Subject --%>
                <div class="col-12">
                    <label class="form-label">Teaching Subject <span style="color:var(--t-accent-rose)">*</span></label>
                    <div style="position:relative;">
                        <select name="tutorSubjectId" id="tsSelect" class="form-select"
                                required onchange="onTutorSubjectChange(this)">
                            <option value="">Select subject</option>
                            <c:forEach var="ts" items="${tutorSubjects}">
                                <option value="${ts.tutorSubjectId}"
                                        ${ts.tutorSubjectId == slot.tutorSubjectId ? 'selected' : ''}>
                                    ${ts.subjectName} | ${ts.medium} | ${ts.teachingMode}
                                </option>
                            </c:forEach>
                        </select>
                        <div id="tsOverlay" style="display:none;position:absolute;top:0;left:0;right:30px;bottom:0;background:white;border-radius:8px;padding:10px 14px;font-weight:600;color:#1e293b;pointer-events:none;line-height:1.5;"></div>
                    </div>
                </div>

                <%-- Auto-filled medium and mode (read-only) --%>
                <div class="col-12" id="subjectInfoBox" style="display:none;">
                    <div style="background:rgba(5,150,105,0.06);border:1px solid rgba(5,150,105,0.2);border-radius:12px;padding:14px 18px;">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <div style="font-size:0.75rem;font-weight:700;color:var(--t-text-muted);text-transform:uppercase;letter-spacing:0.5px;margin-bottom:4px;">Medium</div>
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <i class="fas fa-language" style="color:var(--t-primary);font-size:0.85rem;"></i>
                                    <span id="mediumVal" style="font-weight:700;color:var(--t-text);"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div style="font-size:0.75rem;font-weight:700;color:var(--t-text-muted);text-transform:uppercase;letter-spacing:0.5px;margin-bottom:4px;">Teaching Mode</div>
                                <div style="display:flex;align-items:center;gap:8px;">
                                    <i class="fas fa-chalkboard" style="color:var(--t-primary);font-size:0.85rem;"></i>
                                    <span id="modeVal" style="font-weight:700;color:var(--t-text);"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Hidden medium for form submission --%>
                <input type="hidden" name="medium" id="mediumInput" value="${slot.medium}">

                <%-- Day --%>
                <div class="col-12">
                    <label class="form-label">Day <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="day" class="form-select" required>
                        <c:forEach var="d" items="${'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday'.split(',')}">
                            <option value="${d}" ${slot.day == d ? 'selected' : ''}>${d}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- Start Time --%>
                <div class="col-md-6">
                    <label class="form-label">Start Time <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="startTime" class="form-select" required>
                        <c:forEach var="t" items="${'7:00 AM,8:00 AM,9:00 AM,10:00 AM,11:00 AM,12:00 PM,1:00 PM,2:00 PM,3:00 PM,4:00 PM,5:00 PM,6:00 PM'.split(',')}">
                            <option value="${t}" ${slot.startTime == t ? 'selected' : ''}>${t}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- End Time --%>
                <div class="col-md-6">
                    <label class="form-label">End Time <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="endTime" class="form-select" required>
                        <c:forEach var="t" items="${'8:00 AM,9:00 AM,10:00 AM,11:00 AM,12:00 PM,1:00 PM,2:00 PM,3:00 PM,4:00 PM,5:00 PM,6:00 PM,7:00 PM,8:00 PM'.split(',')}">
                            <option value="${t}" ${slot.endTime == t ? 'selected' : ''}>${t}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid rgba(5,150,105,0.1);">
                    <button type="submit" class="btn-tutor-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/availability/list" class="btn-tutor-secondary">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('tsSelect').addEventListener('mousedown', function() {
        this.style.color = '';
        document.getElementById('tsOverlay').style.display = 'none';
    });
    document.getElementById('tsSelect').addEventListener('blur', function() {
        if (this.value && tsMap[this.value]) {
            const overlay = document.getElementById('tsOverlay');
            overlay.textContent = tsMap[this.value].name;
            overlay.style.display = 'block';
            this.style.color = 'transparent';
        }
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