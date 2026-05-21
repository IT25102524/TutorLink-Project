<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Subject Catalogue - TutorLink Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        /* ---- Level section headers ---- */
        .level-section { margin-bottom: 2.5rem; }
        .level-header {
            display: flex; align-items: center; gap: 14px;
            padding: 18px 24px; border-radius: 16px 16px 0 0;
        }
        .level-header-al  { background: linear-gradient(135deg,rgba(168,85,247,0.2),rgba(139,92,246,0.1)); border:1px solid rgba(168,85,247,0.3); border-bottom:none; }
        .level-header-ol  { background: linear-gradient(135deg,rgba(6,182,212,0.2),rgba(14,165,233,0.1));  border:1px solid rgba(6,182,212,0.3);  border-bottom:none; }
        .level-header-pri { background: linear-gradient(135deg,rgba(16,185,129,0.2),rgba(5,150,105,0.1));  border:1px solid rgba(16,185,129,0.3); border-bottom:none; }
        .level-icon { width:46px;height:46px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#fff;flex-shrink:0; }
        .icon-al  { background:linear-gradient(135deg,#a855f7,#7c3aed); }
        .icon-ol  { background:linear-gradient(135deg,#06b6d4,#0284c7); }
        .icon-pri { background:linear-gradient(135deg,#10b981,#059669); }
        .level-title { font-size:1.1rem;font-weight:800;color:#fff; }
        .level-sub   { font-size:0.8rem;color:var(--text-faint);margin-top:2px; }
        .level-count { margin-left:auto;padding:5px 14px;border-radius:20px;font-size:0.8rem;font-weight:800; }
        .count-al  { background:rgba(168,85,247,0.2);color:#c084fc;border:1px solid rgba(168,85,247,0.3); }
        .count-ol  { background:rgba(6,182,212,0.2); color:#22d3ee;border:1px solid rgba(6,182,212,0.3); }
        .count-pri { background:rgba(16,185,129,0.2);color:#2dd4bf;border:1px solid rgba(16,185,129,0.3); }

        /* ---- Level body ---- */
        .level-body { border-radius:0 0 16px 16px; padding:20px 24px; background:var(--admin-card); }
        .level-body-al  { border:1px solid rgba(168,85,247,0.3); border-top:none; }
        .level-body-ol  { border:1px solid rgba(6,182,212,0.3);  border-top:none; }
        .level-body-pri { border:1px solid rgba(16,185,129,0.3); border-top:none; }

        /* ---- Category label ---- */
        .category-label {
            font-size:0.72rem;font-weight:800;letter-spacing:1px;
            text-transform:uppercase;color:var(--text-faint);
            margin:20px 0 10px;padding-bottom:6px;
            border-bottom:1px solid rgba(255,255,255,0.05);
            display:flex;align-items:center;gap:8px;
        }
        .category-label:first-child { margin-top:0; }

        /* ---- Subject card ---- */
        .subject-card {
            display: flex;
            align-items: center;
            padding: 14px 18px;
            border-radius: 12px;
            background: var(--admin-bg);
            border: 1px solid var(--admin-border);
            margin-bottom: 8px;
            transition: all 0.25s;
            gap: 0;
        }
        .subject-card:last-child { margin-bottom:0; }
        .subject-card:hover { border-color:rgba(255,255,255,0.12); background:rgba(255,255,255,0.04); transform:translateX(4px); }

        /* LEFT: name takes all available space */
        .sc-name {
            flex: 1;
            font-weight: 700;
            color: #fff;
            font-size: 0.92rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* MIDDLE: badges grouped together with a clear separator */
        .sc-badges {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 0 20px;
            border-left: 1px solid rgba(255,255,255,0.07);
            border-right: 1px solid rgba(255,255,255,0.07);
            margin: 0 12px;
        }

        /* RIGHT: action buttons */
        .sc-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-shrink: 0;
        }

        /* Medium badges */
        .badge-medium { padding:4px 12px;border-radius:20px;font-size:0.75rem;font-weight:700; }
        .medium-sinhala { background:rgba(251,191,36,0.15);color:#fbbf24;border:1px solid rgba(251,191,36,0.3); }
        .medium-english { background:rgba(59,130,246,0.15); color:#60a5fa;border:1px solid rgba(59,130,246,0.3); }
        .medium-tamil   { background:rgba(239,68,68,0.15);  color:#f87171;border:1px solid rgba(239,68,68,0.3); }

        /* Status badges */
        .badge-active   { background:rgba(16,185,129,0.15);color:#2dd4bf;border:1px solid rgba(16,185,129,0.3);padding:4px 12px;border-radius:20px;font-size:0.75rem;font-weight:700; }
        .badge-inactive { background:rgba(239,68,68,0.12); color:#f87171;border:1px solid rgba(239,68,68,0.25);padding:4px 12px;border-radius:20px;font-size:0.75rem;font-weight:700; }

        /* Action buttons */
        .btn-edit-sm {
            background:rgba(245,158,11,0.12);color:#f59e0b;
            border:1px solid rgba(245,158,11,0.3);
            padding:6px 14px;border-radius:8px;
            font-size:0.78rem;font-weight:700;
            text-decoration:none;display:inline-flex;align-items:center;gap:5px;
            transition:all 0.2s;white-space:nowrap;
        }
        .btn-edit-sm:hover { background:rgba(245,158,11,0.25);color:#f59e0b; }
        .btn-del-sm {
            background:transparent;color:#ef4444;
            border:1px solid rgba(239,68,68,0.3);
            padding:6px 14px;border-radius:8px;
            font-size:0.78rem;font-weight:700;
            cursor:pointer;display:inline-flex;align-items:center;gap:5px;
            transition:all 0.2s;white-space:nowrap;font-family:inherit;
        }
        .btn-del-sm:hover { background:rgba(239,68,68,0.12); }

        .empty-level { text-align:center;padding:2rem;color:var(--text-faint);font-size:0.88rem; }
    </style>
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


    <a href="${pageContext.request.contextPath}/logout" class="sb-logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
</div></div>

<div class="main-content">

    <div class="page-header">
        <div>
            <h4 class="page-title">Subject Catalogue</h4>
            <p class="page-sub">Subjects organised by education level, category, and medium.</p>
        </div>
        <c:if test="${sessionScope.role == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/subject/add" class="btn-admin-primary">
                <i class="fas fa-plus"></i> Add Subject
            </a>
        </c:if>
    </div>

    <c:if test="${param.added=='true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Subject added!</div>
    </c:if>
    <c:if test="${param.updated=='true'}">
        <div class="alert-modern alert-success"><i class="fas fa-check-circle"></i> Subject updated!</div>
    </c:if>
    <c:if test="${param.deleted=='true'}">
        <div class="alert-modern alert-danger"><i class="fas fa-trash-alt"></i> Subject deleted.</div>
    </c:if>

    <%-- Summary bar --%>
    <div style="display:flex;gap:12px;margin-bottom:2rem;flex-wrap:wrap;">
        <div style="background:rgba(168,85,247,0.1);border:1px solid rgba(168,85,247,0.25);border-radius:12px;padding:12px 20px;display:flex;align-items:center;gap:10px;">
            <i class="fas fa-award" style="color:#c084fc;"></i>
            <span style="color:#c084fc;font-weight:700;font-size:0.88rem;">A/L — ${alevelSubjects.size()} subjects</span>
        </div>
        <div style="background:rgba(6,182,212,0.1);border:1px solid rgba(6,182,212,0.25);border-radius:12px;padding:12px 20px;display:flex;align-items:center;gap:10px;">
            <i class="fas fa-medal" style="color:#22d3ee;"></i>
            <span style="color:#22d3ee;font-weight:700;font-size:0.88rem;">O/L — ${olevelSubjects.size()} subjects</span>
        </div>
        <div style="background:rgba(16,185,129,0.1);border:1px solid rgba(16,185,129,0.25);border-radius:12px;padding:12px 20px;display:flex;align-items:center;gap:10px;">
            <i class="fas fa-seedling" style="color:#2dd4bf;"></i>
            <span style="color:#2dd4bf;font-weight:700;font-size:0.88rem;">Primary — ${primarySubjects.size()} subjects</span>
        </div>
        <div style="background:rgba(255,255,255,0.04);border:1px solid var(--admin-border);border-radius:12px;padding:12px 20px;display:flex;align-items:center;gap:10px;margin-left:auto;">
            <i class="fas fa-book-open" style="color:var(--text-faint);"></i>
            <span style="color:var(--text-dim);font-weight:700;font-size:0.88rem;">Total: ${totalCount}</span>
        </div>
    </div>

    <%-- Reusable card macro via repeated JSP sections --%>

    <%-- ===== A/L SECTION ===== --%>
    <div class="level-section">
        <div class="level-header level-header-al">
            <div class="level-icon icon-al"><i class="fas fa-award"></i></div>
            <div>
                <div class="level-title">Advanced Level (A/L)</div>
                <div class="level-sub">Grade 12 – 13</div>
            </div>
            <span class="level-count count-al">${alevelSubjects.size()} subjects</span>
        </div>
        <div class="level-body level-body-al">
            <c:choose>
                <c:when test="${empty alevelSubjects}">
                    <div class="empty-level"><i class="fas fa-inbox me-2"></i>No A/L subjects yet.</div>
                </c:when>
                <c:otherwise>
                    <c:set var="lastCat" value="__NONE__" />
                    <c:forEach var="s" items="${alevelSubjects}">
                        <c:set var="thisCat" value="${s.category != null ? s.category : 'Other'}" />
                        <c:if test="${thisCat != lastCat}">
                            <div class="category-label"><i class="fas fa-tag"></i> ${thisCat}</div>
                            <c:set var="lastCat" value="${thisCat}" />
                        </c:if>
                        <div class="subject-card">
                            <div class="sc-name">
                                <i class="fas fa-book" style="color:rgba(168,85,247,0.7);font-size:0.85rem;"></i>
                                ${s.name}
                            </div>
                            <div class="sc-badges">
                                <c:choose>
                                    <c:when test="${s.medium == 'Sinhala'}"><span class="badge-medium medium-sinhala"><i class="fas fa-language"></i> Sinhala</span></c:when>
                                    <c:when test="${s.medium == 'English'}"><span class="badge-medium medium-english"><i class="fas fa-language"></i> English</span></c:when>
                                    <c:when test="${s.medium == 'Tamil'}"><span class="badge-medium medium-tamil"><i class="fas fa-language"></i> Tamil</span></c:when>
                                    <c:otherwise><span class="badge-medium" style="background:rgba(255,255,255,0.05);color:var(--text-faint);border:1px solid var(--admin-border);">—</span></c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${s.status == 'ACTIVE'}"><span class="badge-active"><i class="fas fa-circle" style="font-size:0.5rem;vertical-align:middle;"></i> Active</span></c:when>
                                    <c:otherwise><span class="badge-inactive"><i class="fas fa-circle" style="font-size:0.5rem;vertical-align:middle;"></i> Inactive</span></c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${sessionScope.role == 'ADMIN'}">
                                <div class="sc-actions">
                                    <a href="${pageContext.request.contextPath}/subject/edit/${s.subjectId}" class="btn-edit-sm"><i class="fas fa-edit"></i> Edit</a>
                                    <form action="${pageContext.request.contextPath}/subject/delete/${s.subjectId}" method="post" style="display:inline;">
                                        <button class="btn-del-sm" onclick="return confirm('Delete this subject?')"><i class="fas fa-trash-alt"></i> Delete</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- ===== O/L SECTION ===== --%>
    <div class="level-section">
        <div class="level-header level-header-ol">
            <div class="level-icon icon-ol"><i class="fas fa-medal"></i></div>
            <div>
                <div class="level-title">Ordinary Level (O/L)</div>
                <div class="level-sub">Grade 6 – 11</div>
            </div>
            <span class="level-count count-ol">${olevelSubjects.size()} subjects</span>
        </div>
        <div class="level-body level-body-ol">
            <c:choose>
                <c:when test="${empty olevelSubjects}">
                    <div class="empty-level"><i class="fas fa-inbox me-2"></i>No O/L subjects yet.</div>
                </c:when>
                <c:otherwise>
                    <c:set var="lastCat" value="__NONE__" />
                    <c:forEach var="s" items="${olevelSubjects}">
                        <c:set var="thisCat" value="${s.category != null ? s.category : 'Other'}" />
                        <c:if test="${thisCat != lastCat}">
                            <div class="category-label"><i class="fas fa-tag"></i> ${thisCat}</div>
                            <c:set var="lastCat" value="${thisCat}" />
                        </c:if>
                        <div class="subject-card">
                            <div class="sc-name">
                                <i class="fas fa-book" style="color:rgba(6,182,212,0.7);font-size:0.85rem;"></i>
                                ${s.name}
                            </div>
                            <div class="sc-badges">
                                <c:choose>
                                    <c:when test="${s.medium == 'Sinhala'}"><span class="badge-medium medium-sinhala"><i class="fas fa-language"></i> Sinhala</span></c:when>
                                    <c:when test="${s.medium == 'English'}"><span class="badge-medium medium-english"><i class="fas fa-language"></i> English</span></c:when>
                                    <c:when test="${s.medium == 'Tamil'}"><span class="badge-medium medium-tamil"><i class="fas fa-language"></i> Tamil</span></c:when>
                                    <c:otherwise><span class="badge-medium" style="background:rgba(255,255,255,0.05);color:var(--text-faint);border:1px solid var(--admin-border);">—</span></c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${s.status == 'ACTIVE'}"><span class="badge-active"><i class="fas fa-circle" style="font-size:0.5rem;vertical-align:middle;"></i> Active</span></c:when>
                                    <c:otherwise><span class="badge-inactive"><i class="fas fa-circle" style="font-size:0.5rem;vertical-align:middle;"></i> Inactive</span></c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${sessionScope.role == 'ADMIN'}">
                                <div class="sc-actions">
                                    <a href="${pageContext.request.contextPath}/subject/edit/${s.subjectId}" class="btn-edit-sm"><i class="fas fa-edit"></i> Edit</a>
                                    <form action="${pageContext.request.contextPath}/subject/delete/${s.subjectId}" method="post" style="display:inline;">
                                        <button class="btn-del-sm" onclick="return confirm('Delete this subject?')"><i class="fas fa-trash-alt"></i> Delete</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- ===== PRIMARY SECTION ===== --%>
    <div class="level-section">
        <div class="level-header level-header-pri">
            <div class="level-icon icon-pri"><i class="fas fa-seedling"></i></div>
            <div>
                <div class="level-title">Primary Level</div>
                <div class="level-sub">Grade 1 – 5</div>
            </div>
            <span class="level-count count-pri">${primarySubjects.size()} subjects</span>
        </div>
        <div class="level-body level-body-pri">
            <c:choose>
                <c:when test="${empty primarySubjects}">
                    <div class="empty-level"><i class="fas fa-inbox me-2"></i>No Primary subjects yet.</div>
                </c:when>
                <c:otherwise>
                    <c:set var="lastCat" value="__NONE__" />
                    <c:forEach var="s" items="${primarySubjects}">
                        <c:set var="thisCat" value="${s.category != null ? s.category : 'Other'}" />
                        <c:if test="${thisCat != lastCat}">
                            <div class="category-label"><i class="fas fa-tag"></i> ${thisCat}</div>
                            <c:set var="lastCat" value="${thisCat}" />
                        </c:if>
                        <div class="subject-card">
                            <div class="sc-name">
                                <i class="fas fa-book" style="color:rgba(16,185,129,0.7);font-size:0.85rem;"></i>
                                ${s.name}
                            </div>
                            <div class="sc-badges">
                                <c:choose>
                                    <c:when test="${s.medium == 'Sinhala'}"><span class="badge-medium medium-sinhala"><i class="fas fa-language"></i> Sinhala</span></c:when>
                                    <c:when test="${s.medium == 'English'}"><span class="badge-medium medium-english"><i class="fas fa-language"></i> English</span></c:when>
                                    <c:when test="${s.medium == 'Tamil'}"><span class="badge-medium medium-tamil"><i class="fas fa-language"></i> Tamil</span></c:when>
                                    <c:otherwise><span class="badge-medium" style="background:rgba(255,255,255,0.05);color:var(--text-faint);border:1px solid var(--admin-border);">—</span></c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${s.status == 'ACTIVE'}"><span class="badge-active"><i class="fas fa-circle" style="font-size:0.5rem;vertical-align:middle;"></i> Active</span></c:when>
                                    <c:otherwise><span class="badge-inactive"><i class="fas fa-circle" style="font-size:0.5rem;vertical-align:middle;"></i> Inactive</span></c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${sessionScope.role == 'ADMIN'}">
                                <div class="sc-actions">
                                    <a href="${pageContext.request.contextPath}/subject/edit/${s.subjectId}" class="btn-edit-sm"><i class="fas fa-edit"></i> Edit</a>
                                    <form action="${pageContext.request.contextPath}/subject/delete/${s.subjectId}" method="post" style="display:inline;">
                                        <button class="btn-del-sm" onclick="return confirm('Delete this subject?')"><i class="fas fa-trash-alt"></i> Delete</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
