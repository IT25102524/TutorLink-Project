<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Teaching Subject - TutorLink</title>
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
        <a href="${pageContext.request.contextPath}/tutor/subjects" class="sb-link active">
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
            <h4 class="page-title">Add Teaching Subject</h4>
            <p class="page-sub">Select a subject and set your teaching mode and rates.</p>
        </div>
    </div>

    <div class="card" style="max-width:580px;">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid rgba(5,150,105,0.1);">
            <div style="width:48px;height:48px;border-radius:14px;background:linear-gradient(135deg,#059669,#34d399);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
                <i class="fas fa-book-open"></i>
            </div>
            <div>
                <div style="font-weight:700;color:var(--t-text);">New Teaching Subject</div>
                <div style="font-size:0.82rem;color:var(--t-text-muted);">Students will see this when searching for tutors.</div>
            </div>
        </div>

        <c:if test="${empty subjects}">
            <div style="background:rgba(245,158,11,0.1);border:1px solid rgba(245,158,11,0.3);color:#f59e0b;padding:14px 18px;border-radius:12px;margin-bottom:1rem;">
                <i class="fas fa-exclamation-triangle me-2"></i>
                No subjects available. Please ask an admin to add subjects first.
            </div>
        </c:if>

        <%-- Build subject->medium map for JS --%>
        <script>
            // Map subjectId -> {name, medium}
            const subjectMap = {
                <c:forEach var="s" items="${subjects}" varStatus="vs">
                "${s.subjectId}": { name: "${s.name}", medium: "${s.medium}" }${vs.last ? '' : ','}
                </c:forEach>
            };

            function onSubjectChange(select) {
                const selectedId = select.value;
                const mediumDisplay = document.getElementById('mediumDisplay');
                const mediumInput = document.getElementById('mediumInput');

                if (selectedId && subjectMap[selectedId]) {
                    const data = subjectMap[selectedId];
                    // Show only subject name in the selected option display
                    const selectedOpt = select.options[select.selectedIndex];
                    selectedOpt.dataset.display = data.name;
                    select.setAttribute('data-selected-name', data.name);
                    // Show only subject name visually
                    const overlay = document.getElementById('subjectNameOverlay');
                    overlay.textContent = data.name;
                    overlay.style.display = 'block';
                    select.style.color = 'transparent';
                    // Auto-fill medium
                    mediumDisplay.textContent = data.medium;
                    mediumInput.value = data.medium;
                    document.getElementById('mediumBox').style.display = 'block';
                } else {
                    document.getElementById('mediumBox').style.display = 'none';
                    mediumInput.value = '';
                }
            }

            document.getElementById('subjectSelect').addEventListener('mousedown', function() {
                this.style.color = '';
                document.getElementById('subjectNameOverlay').style.display = 'none';
            });
            document.getElementById('subjectSelect').addEventListener('blur', function() {
                if (this.value) {
                    const data = subjectMap[this.value];
                    if (data) {
                        const overlay = document.getElementById('subjectNameOverlay');
                        overlay.textContent = data.name;
                        overlay.style.display = 'block';
                        this.style.color = 'transparent';
                    }
                }
            });

            function onModeChange(select) {
                const mode = select.value;
                const onlineBox = document.getElementById('onlineRateBox');
                const homeBox = document.getElementById('homeRateBox');
                const onlineInput = document.getElementById('onlineRateInput');
                const homeInput = document.getElementById('homeRateInput');

                if (mode === 'ONLINE') {
                    onlineBox.style.display = 'block';
                    homeBox.style.display = 'none';
                    onlineInput.required = true;
                    homeInput.required = false;
                    homeInput.value = '0';
                } else if (mode === 'HOME_VISIT') {
                    onlineBox.style.display = 'none';
                    homeBox.style.display = 'block';
                    onlineInput.required = false;
                    homeInput.required = true;
                    onlineInput.value = '0';
                } else if (mode === 'BOTH') {
                    onlineBox.style.display = 'block';
                    homeBox.style.display = 'block';
                    onlineInput.required = true;
                    homeInput.required = true;
                } else {
                    onlineBox.style.display = 'none';
                    homeBox.style.display = 'none';
                }
            }
        </script>

        <form action="${pageContext.request.contextPath}/tutor/subjects/add" method="post">
            <div class="row g-4">

                <%-- Subject dropdown --%>
                <div class="col-12">
                    <label class="form-label">Subject <span style="color:var(--t-accent-rose)">*</span></label>
                    <div style="position:relative;">
                        <select name="subjectId" id="subjectSelect" class="form-select"
                                required onchange="onSubjectChange(this)">
                            <option value="">Select subject from catalogue</option>
                            <c:forEach var="s" items="${subjects}">
                                <option value="${s.subjectId}" data-name="${s.name}">
                                        ${s.name} | ${s.subjectType} | ${s.medium}
                                </option>
                            </c:forEach>
                        </select>
                        <div id="subjectNameOverlay" style="display:none;position:absolute;top:0;left:0;right:30px;bottom:0;background:white;border-radius:8px;padding:10px 14px;font-weight:600;color:#1e293b;pointer-events:none;line-height:1.5;"></div>
                    </div>
                </div>

                <%-- Medium auto-filled from subject (read only) --%>
                <div class="col-12" id="mediumBox" style="display:none;">
                    <label class="form-label">Teaching Medium</label>
                    <div style="background:rgba(5,150,105,0.08);border:1px solid rgba(5,150,105,0.2);border-radius:10px;padding:12px 16px;display:flex;align-items:center;gap:10px;">
                        <i class="fas fa-language" style="color:var(--t-primary);"></i>
                        <span id="mediumDisplay" style="font-weight:700;color:var(--t-text);"></span>
                        <span style="font-size:0.78rem;color:var(--t-text-muted);margin-left:4px;">(from selected subject)</span>
                    </div>
                    <input type="hidden" name="medium" id="mediumInput">
                </div>

                <%-- Teaching mode --%>
                <div class="col-12">
                    <label class="form-label">Teaching Mode <span style="color:var(--t-accent-rose)">*</span></label>
                    <select name="teachingMode" class="form-select" required onchange="onModeChange(this)">
                        <option value="">Select mode</option>
                        <option value="ONLINE">Online</option>
                        <option value="HOME_VISIT">Home Visit</option>
                        <option value="BOTH">Both (Online & Home Visit)</option>
                    </select>
                </div>

                <%-- Online rate - shown only for ONLINE or BOTH --%>
                <div class="col-12" id="onlineRateBox" style="display:none;">
                    <label class="form-label">Online Hourly Rate (Rs.) <span style="color:var(--t-accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-wifi"></i></span>
                        <input type="number" name="onlineHourlyRate" id="onlineRateInput"
                               class="form-control" placeholder="e.g. 1200" min="0">
                    </div>
                </div>

                <%-- Home visit rate - shown only for HOME_VISIT or BOTH --%>
                <div class="col-12" id="homeRateBox" style="display:none;">
                    <label class="form-label">Home Visit Hourly Rate (Rs.) <span style="color:var(--t-accent-rose)">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-home"></i></span>
                        <input type="number" name="homeVisitHourlyRate" id="homeRateInput"
                               class="form-control" placeholder="e.g. 1500" min="0">
                    </div>
                </div>

                <div class="col-12 mt-4 pt-3 d-flex gap-3" style="border-top:1px solid rgba(5,150,105,0.1);">
                    <button type="submit" class="btn-tutor-primary">
                        <i class="fas fa-plus"></i> Add Subject
                    </button>
                    <a href="${pageContext.request.contextPath}/tutor/subjects" class="btn-tutor-secondary">
                        Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>

</div>

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
