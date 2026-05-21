<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Session - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Flatpickr CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <style>
        :root { --radius-lg: 18px; --radius-md: 14px; }
        .booking-layout { display: flex; gap: 2rem; align-items: flex-start; }
        .tutor-panel    { flex: 0 0 290px; }
        .form-panel     { flex: 1; min-width: 0; }

        .tutor-book-card {
            background: linear-gradient(160deg, #1e3a8a 0%, #2563eb 100%);
            border-radius: var(--radius-lg);
            padding: 2rem 1.5rem; color: #fff;
            position: sticky; top: 2rem;
            box-shadow: 0 8px 32px rgba(37,99,235,0.3);
        }
        .tb-avatar {
            width: 78px; height: 78px;
            background: rgba(255,255,255,0.18);
            border: 3px solid rgba(255,255,255,0.35);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; font-weight: 900;
            margin: 0 auto 1rem;
        }
        .tb-name { font-size: 1.2rem; font-weight: 800; text-align: center; }
        .tb-sub  { text-align: center; opacity: 0.75; font-size: 0.88rem; margin-bottom: 1.5rem; }
        .tb-info-row { display: flex; gap: 8px; align-items: center; font-size: 0.85rem; opacity: 0.85; margin-bottom: 8px; }
        .tb-info-row i { width: 16px; text-align: center; }


        .tb-rate-section { margin-top: 1.5rem; }
        .tb-rate-row {
            display: flex; justify-content: space-between; align-items: center;
            padding: 8px 12px; border-radius: 10px;
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.12);
            margin-bottom: 6px;
            transition: all 0.3s;
        }
        .tb-rate-row.active {
            background: rgba(255,255,255,0.22);
            border-color: rgba(255,255,255,0.35);
        }
        .tb-rate-lbl { font-size: 0.8rem; opacity: 0.85; }
        .tb-rate-val { font-size: 1rem; font-weight: 800; }

        .tb-notice {
            background: rgba(255,255,255,0.1); border-radius: 10px;
            padding: 10px 12px; font-size: 0.78rem; margin-top: 1.2rem;
            border: 1px solid rgba(255,255,255,0.12); line-height: 1.5;
        }

        .form-book-card {
            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-lg);
            border: 1px solid rgba(255,255,255,0.95);
            padding: 2.5rem;
            box-shadow: 0 12px 50px rgba(37,99,235,0.07), 0 2px 8px rgba(0,0,0,0.03);
            transition: box-shadow 0.3s;
        }
        .sec-title {
            font-size: 0.72rem; font-weight: 800; color: #94a3b8;
            text-transform: uppercase; letter-spacing: 1.5px;
            margin-bottom: 1.2rem; padding-bottom: 0.5rem;
            border-bottom: 2px solid #f1f5f9;
            display: flex; align-items: center; gap: 8px;
        }
        .sec-title i { font-size: 0.9rem; color: #cbd5e1; }

        .form-label {
            font-size: 0.8rem; font-weight: 700; color: #475569;
            text-transform: uppercase; letter-spacing: 0.5px;
            margin-bottom: 8px; display: block;
        }
        .form-control, .form-select {
            border: 2px solid #e2e8f0; border-radius: 12px;
            padding: 12px 16px; font-size: 0.95rem; font-weight: 600;
            color: #0f172a; transition: all 0.3s;
            background-color: #f8fafc;
        }
        .form-control:hover, .form-select:hover { border-color: #cbd5e1; background-color: #fff; }
        .form-control:focus, .form-select:focus {
            border-color: #3b82f6; background-color: #fff;
            box-shadow: 0 0 0 4px rgba(59,130,246,0.15); outline: none;
        }
        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2364748b' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat; background-position: right 16px center;
            background-size: 14px; padding-right: 40px; cursor: pointer;
        }

        .time-trio { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.2rem; }

        .mode-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.2rem; }
        .mode-card {
            position: relative; border: 2px solid #e2e8f0; background: #f8fafc;
            border-radius: var(--radius-md); padding: 1.2rem;
            cursor: pointer; transition: all 0.3s;
            display: flex; align-items: center; gap: 14px;
        }
        .mode-card input { position: absolute; opacity: 0; }
        .mode-icon {
            width: 46px; height: 46px; border-radius: 12px;
            background: #fff; display: flex; align-items: center;
            justify-content: center; font-size: 1.2rem; color: #94a3b8;
            transition: all 0.3s; flex-shrink: 0;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            border: 1px solid #e2e8f0;
        }
        .mode-card:hover { border-color: #93c5fd; background: #eff6ff; transform: translateY(-2px); }
        .mode-card:has(input:checked) { border-color: #2563eb; background: #eff6ff; box-shadow: 0 8px 20px rgba(37,99,235,0.1); }
        .mode-card:has(input:checked) .mode-icon { background: linear-gradient(135deg, #2563eb, #1d4ed8); color: #fff; border-color: transparent; }
        .mode-label  { font-weight: 800; font-size: 0.95rem; color: #0f172a; display: block; margin-bottom: 2px; }
        .mode-sublbl { font-size: 0.8rem; color: #64748b; font-weight: 500; }
        .mode-rate   { font-size: 0.85rem; font-weight: 700; color: #2563eb; margin-top: 4px; }

        .cost-card {
            background: #f8fafc; border: 2px dashed #cbd5e1;
            border-radius: 14px; padding: 1.5rem;
        }
        .cost-placeholder { text-align: center; color: #64748b; font-size: 0.9rem; font-weight: 600; }

        .total-fee-card {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 60%, #1d4ed8 100%);
            border-radius: 16px; padding: 1.8rem 2rem; color: #fff;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 12px 35px rgba(37,99,235,0.35);
            position: relative; overflow: hidden;
            border: 1px solid rgba(255,255,255,0.15);
            animation: feeReveal 0.4s cubic-bezier(0.16,1,0.3,1);
        }
        @keyframes feeReveal {
            from { opacity:0; transform:translateY(12px) scale(0.98); }
            to   { opacity:1; transform:translateY(0) scale(1); }
        }
        .total-fee-card::after {
            content: ''; position: absolute; top: -50px; right: -50px;
            width: 150px; height: 150px; background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }
        .tf-label  { font-size: 0.85rem; font-weight: 700; opacity: 0.85; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px; }
        .tf-time   { font-size: 0.9rem; font-weight: 500; opacity: 0.95; }
        .tf-amount { font-size: 2.2rem; font-weight: 900; letter-spacing: -1px; z-index: 1; }

        .exceed-msg { color: #ef4444; font-size: 0.78rem; font-weight: 600; margin-top: 4px; display: none; }
        .exceed-msg.on { display: block; }

        @media (max-width: 992px) {
            .booking-layout { flex-direction: column; }
            .tutor-panel { flex: none; width: 100%; }
            .tutor-book-card { position: static; }
            .time-trio { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 576px) {
            .time-trio { grid-template-columns: 1fr; }
            .mode-grid { grid-template-columns: 1fr; }
        }


        .payment-panel { margin-bottom:1.2rem; }
        .pay-info-box  { border-radius:14px;padding:1.25rem;border:2px solid transparent; }
        .pay-card-box  { background:#eff6ff;border-color:#bfdbfe; }
        .pay-cash-box  { background:#f0fdf4;border-color:#bbf7d0; }
        .pay-bank-box  { background:#fffbeb;border-color:#fde68a; }
        .pay-panel-title { font-weight:700;font-size:.95rem;color:#1e293b;margin-bottom:.35rem; }
        .pay-panel-note  { font-size:.85rem;color:#475569;margin-bottom:.85rem; }
        .pay-tips { list-style:none;padding:0;margin:0;font-size:.83rem;color:#166534; }
        .pay-tips li { margin-bottom:5px; }
        .pay-bank-table { width:100%;font-size:.88rem;border-collapse:separate;border-spacing:0 5px; }
        .pay-bank-label { color:#92400e;font-weight:600;width:40%;padding:3px 6px; }
        .pay-bank-value { color:#1c1917;padding:3px 6px; }
        .pay-no-bank { background:#fef2f2;border:2px solid #fecaca;border-radius:10px;padding:.9rem;color:#b91c1c;font-size:.86rem;font-weight:600; }
    </style>
</head>
<body>

<jsp:include page="../student/sidebar.jsp"/>

<div class="main-content">
    <div class="container-fluid" style="max-width:1200px;margin:0 auto;padding-top:10px;">

        <div class="page-header mb-4">
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/student/view-tutor/${tutor.tutorId}"
                   class="btn-secondary-modern" style="padding:8px 12px;border-radius:50%;">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <div>
                    <h2 class="page-title mb-0">Book a Session</h2>
                    <div class="page-sub">Fill in the details to request your session</div>
                </div>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert-modern alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <div class="booking-layout">
<div class="tutor-panel">
                <div class="tutor-book-card">
                    <div class="tb-avatar">${fn:substring(tutor.fullName, 0, 1)}</div>
                    <div class="tb-name">${tutor.fullName}</div>
                    <div class="tb-sub">${tutor.subject}</div>

                    <div class="tb-info-row"><i class="fas fa-map-marker-alt"></i> ${tutor.district}</div>
                    <div class="tb-info-row"><i class="fas fa-graduation-cap"></i> ${tutor.experience}</div>
                    <c:if test="${tutor.travelRadius > 0}">
                        <div class="tb-info-row"><i class="fas fa-route"></i> Travels up to ${tutor.travelRadius} km</div>
                    </c:if>
                    <div class="tb-info-row"><i class="fas fa-calendar-check"></i>
                        <c:choose>
                            <c:when test="${empty slots}">No slots available</c:when>
                            <c:otherwise>${fn:length(slots)} available slot(s)</c:otherwise>
                        </c:choose>
                    </div>

                    <%-- Dynamic rate display - highlights the selected mode --%>
                    <div class="tb-rate-section">
                        <div class="tb-rate-row" id="panelOnlineRow">
                            <span class="tb-rate-lbl"><i class="fas fa-laptop me-1"></i> Online</span>
                            <span class="tb-rate-val">LKR ${tutor.effectiveOnlineRate}/hr</span>
                        </div>
                        <div class="tb-rate-row active" id="panelHomeRow">
                            <span class="tb-rate-lbl"><i class="fas fa-home me-1"></i> Home Visit</span>
                            <span class="tb-rate-val">LKR ${tutor.effectiveHomeVisitRate}/hr</span>
                        </div>
                    </div>

                    <div class="tb-notice">
                        <i class="fas fa-shield-alt me-1"></i>
                        Tutor confirms your session on their dashboard.
                    </div>
                </div>
            </div>
<div class="form-panel">
                <div class="form-book-card">

                    <form id="bookingForm" action="${pageContext.request.contextPath}/booking/new/${tutor.tutorId}" method="post">
                        <input type="hidden" name="timeSlot" id="timeSlotHidden">
<%-- Build slot data map and group by tutorSubjectId --%>
                        <script>
                            // Map tutorSubjectId -> array of slot objects
                            const slotsBySubject = {};
                            // Map tutorSubjectId -> {name, medium, mode}
                            const subjectInfoMap = {};
                        </script>
                        <c:forEach var="ts" items="${tutorSubjects}">
                            <script>
                                subjectInfoMap["${ts.tutorSubjectId}"] = {
                                    name: "${ts.subjectName}",
                                    medium: "${ts.medium}",
                                    mode: "${ts.teachingMode}",
                                    onlineRate: parseFloat('${ts.onlineHourlyRate}') || 0,
                                    homeRate: parseFloat('${ts.homeVisitHourlyRate}') || 0
                                };
                                slotsBySubject["${ts.tutorSubjectId}"] = [];
                            </script>
                        </c:forEach>
                        <c:forEach var="s" items="${slots}">
                            <script>
                                if (slotsBySubject["${s.tutorSubjectId}"] !== undefined) {
                                    slotsBySubject["${s.tutorSubjectId}"].push({
                                        value: "${s.startTime}|${s.endTime}",
                                        day: "${s.day}",
                                        label: "${s.day}: ${s.startTime} - ${s.endTime}"
                                    });
                                }
                            </script>
                        </c:forEach>

                        <div class="sec-title"><i class="fas fa-calendar-alt"></i>Session Details</div>
                        <div class="row g-3 mb-4">

                            <%-- STEP 1: Select Subject --%>
                            <div class="col-12">
                                <label class="form-label">Subject *</label>
                                <c:choose>
                                    <c:when test="${empty tutorSubjects}">
                                        <div style="background:#fef3c7;color:#92400e;border-radius:10px;padding:10px 14px;font-size:0.87rem;">
                                            <i class="fas fa-exclamation-triangle me-1"></i>This tutor has no teaching subjects set up yet.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <select id="subjectSelect" class="form-select" onchange="onSubjectSelect()" required>
                                            <option value="">- Select a subject -</option>
                                            <c:forEach var="ts" items="${tutorSubjects}">
                                                <option value="${ts.tutorSubjectId}">${ts.subjectName} | ${ts.medium} | ${ts.teachingMode}</option>
                                            </c:forEach>
                                        </select>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <%-- STEP 2: Slot filtered by subject --%>
                            <div class="col-12" id="slotBlock" style="display:none;">
                                <label class="form-label">Available Time Slot *</label>
                                <select id="slotSelect" class="form-select" onchange="onSlotChange()">
                                    <option value="">- Select a slot -</option>
                                </select>
                                <div id="noSlotsMsg" style="display:none;background:#fef3c7;color:#92400e;border-radius:10px;padding:10px 14px;font-size:0.87rem;margin-top:8px;">
                                    <i class="fas fa-calendar-times me-1"></i>No slots available for this subject.
                                </div>
                            </div>

                            <%-- STEP 3: Auto-filled info from selected slot --%>
                            <div class="col-12" id="slotInfoBox" style="display:none;">
                                <div style="background:#f0fdf4;border:1px solid rgba(5,150,105,0.2);border-radius:12px;padding:14px 18px;">
                                    <div class="row g-2">
                                        <div class="col-md-4">
                                            <div style="font-size:0.72rem;font-weight:800;color:#64748b;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:4px;">Subject</div>
                                            <div id="slotSubjectDisplay" style="font-weight:700;color:#0f172a;font-size:0.92rem;"></div>
                                        </div>
                                        <div class="col-md-4">
                                            <div style="font-size:0.72rem;font-weight:800;color:#64748b;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:4px;">Medium</div>
                                            <div id="slotMediumDisplay" style="font-weight:700;color:#0f172a;font-size:0.92rem;"></div>
                                        </div>
                                        <div class="col-md-4">
                                            <div style="font-size:0.72rem;font-weight:800;color:#64748b;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:4px;">Day</div>
                                            <div id="slotDayDisplay" style="font-weight:700;color:#0f172a;font-size:0.92rem;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- Hidden inputs for form submission --%>
                            <input type="hidden" name="subject" id="subjectHidden" value="">

                            <%-- STEP 4: Date picker --%>
                            <div class="col-12" id="dateBlock" style="display:none;">
                                <label class="form-label">Preferred Date *</label>
                                <input type="text" name="bookingDate" id="bookingDate" class="form-control" placeholder="Select a date..." required style="background-color: #fff; cursor: pointer;">
                                <div id="dateDayHint" style="font-size:0.75rem;color:#2563eb;font-weight:600;margin-top:5px;"></div>
                            </div>
                        </div>
<div id="sessionTimeBlock" style="display:none;">
                            <div class="sec-title"><i class="fas fa-clock"></i>Your Session Time</div>
                            <div class="time-trio mb-4">
                                <div>
                                    <label class="form-label">Start Time *</label>
                                    <select id="startSel" class="form-select" onchange="calcEndAndCost()">
                                        <option value="">- Pick start -</option>
                                    </select>
                                    <div style="font-size:0.75rem;color:#64748b;margin-top:6px;font-weight:500;">
                                        <i class="fas fa-info-circle me-1"></i>Within slot
                                    </div>
                                </div>
                                <div>
                                    <label class="form-label">Duration *</label>
                                    <select id="hoursSel" class="form-select" onchange="calcEndAndCost()">
                                        <option value="">- Hours -</option>
                                        <option value="1">1 hour</option>
                                        <option value="2">2 hours</option>
                                        <option value="3">3 hours</option>
                                        <option value="4">4 hours</option>
                                        <option value="5">5 hours</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="form-label">End Time</label>
                                    <input type="text" id="endDisplay" class="form-control" readonly
                                           placeholder="Auto-calculated"
                                           style="background:#f8fafc;cursor:not-allowed;font-weight:700;color:#2563eb;">
                                    <div id="exceedMsg" class="exceed-msg">
                                        <i class="fas fa-exclamation-triangle me-1"></i>Exceeds slot!
                                    </div>
                                </div>
                            </div>
                        </div>
<div class="sec-title"><i class="fas fa-chalkboard-teacher"></i>Teaching Mode</div>
                        <div class="mode-grid mb-4">
                            <label class="mode-card" onclick="onModeChange('HOME_VISIT')">
                                <input type="radio" name="mode" value="HOME_VISIT" checked>
                                <div class="mode-icon"><i class="fas fa-home"></i></div>
                                <div>
                                    <span class="mode-label">Home Visit</span>
                                    <span class="mode-sublbl">Tutor comes to you</span>
                                    <span class="mode-rate">LKR ${tutor.effectiveHomeVisitRate}/hr</span>
                                </div>
                            </label>
                            <label class="mode-card" onclick="onModeChange('ONLINE')">
                                <input type="radio" name="mode" value="ONLINE">
                                <div class="mode-icon"><i class="fas fa-laptop"></i></div>
                                <div>
                                    <span class="mode-label">Online Session</span>
                                    <span class="mode-sublbl">Zoom / Google Meet</span>
                                    <span class="mode-rate">LKR ${tutor.effectiveOnlineRate}/hr</span>
                                </div>
                            </label>
                        </div>
<div class="sec-title"><i class="fas fa-receipt"></i>Session Fee</div>
                        <div id="costPlaceholder" class="cost-card mb-4">
                            <div class="cost-placeholder">
                                <i class="fas fa-calculator me-1 mb-2 d-block" style="font-size:1.5rem;opacity:0.5;"></i>
                                Select a slot, start time, and duration to see the total fee
                            </div>
                        </div>
                        <div id="costDetails" class="total-fee-card mb-4" style="display:none;">
                            <div style="z-index:1;">
                                <div class="tf-label">Total Fee</div>
                                <div class="tf-time" id="cTimeRange"></div>
                            </div>
                            <div class="tf-amount" id="cCalcFull"></div>
                        </div>
<div class="sec-title"><i class="fas fa-sticky-note"></i>Notes for Tutor</div>
                        <div class="mb-4">
                            <textarea name="notes" class="form-control" rows="3"
                                      placeholder="E.g., I need help with calculus basics, chapter 3..."></textarea>
                        </div>
<div class="sec-title"><i class="fas fa-credit-card"></i>Payment Method</div>
                        <div class="mode-grid mb-3">
                            <label class="mode-card" onclick="showPaymentPanel('CARD')">
                                <input type="radio" name="paymentMethod" value="CARD" checked>
                                <div class="mode-icon"><i class="fas fa-credit-card"></i></div>
                                <div><span class="mode-label">Card</span><span class="mode-sublbl">Pending until tutor confirms</span></div>
                            </label>
                            <label class="mode-card" onclick="showPaymentPanel('CASH')">
                                <input type="radio" name="paymentMethod" value="CASH">
                                <div class="mode-icon"><i class="fas fa-money-bill-wave"></i></div>
                                <div><span class="mode-label">Cash</span><span class="mode-sublbl">Pay on session day</span></div>
                            </label>
                            <label class="mode-card" onclick="showPaymentPanel('BANK_TRANSFER')">
                                <input type="radio" name="paymentMethod" value="BANK_TRANSFER">
                                <div class="mode-icon"><i class="fas fa-university"></i></div>
                                <div><span class="mode-label">Bank Transfer</span><span class="mode-sublbl">Transfer to tutor</span></div>
                            </label>
                        </div>
<div id="panel-CARD" class="payment-panel" style="display:block;">
                            <div class="pay-info-box pay-card-box">
                                <p class="pay-panel-title"><i class="fas fa-credit-card me-2"></i>Card Details</p>
                                <p class="pay-panel-note">Simulated payment — no real charge is made.</p>
                                <div class="mb-3">
                                    <label class="form-label">Card Number (16 digits)</label>
                                    <input type="text" id="cardNumber" name="cardNumber" class="form-control" maxlength="19" placeholder="1234 5678 9012 3456" oninput="formatCardNumber(this)">
                                </div>
                                <div class="row">
                                    <div class="col-6"><label class="form-label">Expiry Date</label><input type="text" class="form-control" placeholder="MM/YY" maxlength="5"><small class="text-muted">Not validated (demo only)</small></div>
                                    <div class="col-6"><label class="form-label">CVV (3 digits)</label><input type="text" id="cvv" name="cvv" class="form-control" maxlength="3" placeholder="123" oninput="this.value=this.value.replace(/[^0-9]/g,'')"></div>
                                </div>
                            </div>
                        </div>
<div id="panel-CASH" class="payment-panel" style="display:none;">
                            <div class="pay-info-box pay-cash-box">
                                <p class="pay-panel-title"><i class="fas fa-money-bill-wave me-2"></i>Cash Payment</p>
                                <p class="pay-panel-note">Pay the tutor directly on the session day. Booking stays <strong>Pending</strong> until the tutor confirms receipt.</p>
                                <ul class="pay-tips">
                                    <li><i class="fas fa-check-circle me-2"></i>Bring exact amount on session day</li>
                                    <li><i class="fas fa-check-circle me-2"></i>No online payment needed</li>
                                    <li><i class="fas fa-check-circle me-2"></i>Status: <strong>Pending</strong> (tutor confirms)</li>
                                </ul>
                            </div>
                        </div>
<div id="panel-BANK_TRANSFER" class="payment-panel" style="display:none;">
                            <div class="pay-info-box pay-bank-box">
                                <p class="pay-panel-title"><i class="fas fa-university me-2"></i>Bank Transfer Details</p>
                                <p class="pay-panel-note">Transfer the session fee to the tutor's account, then submit your booking.</p>
                                <c:choose>
                                    <c:when test="${not empty tutor.bankName}">
                                        <table class="pay-bank-table">
                                            <tr><td class="pay-bank-label">Bank</td><td class="pay-bank-value">${tutor.bankName}</td></tr>
                                            <tr><td class="pay-bank-label">Account Holder</td><td class="pay-bank-value">${tutor.accountHolderName}</td></tr>
                                            <tr><td class="pay-bank-label">Account Number</td><td class="pay-bank-value"><strong>${tutor.accountNumber}</strong></td></tr>
                                            <tr><td class="pay-bank-label">Branch</td><td class="pay-bank-value">${tutor.branch}</td></tr>
                                        </table>
                                        <p style="font-size:.82rem;color:#92400e;margin-top:10px;"><i class="fas fa-info-circle me-1"></i>Booking stays <strong>Pending</strong> until tutor confirms the transfer.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="pay-no-bank"><i class="fas fa-exclamation-triangle me-2"></i>This tutor has not added bank details yet. Please choose <strong>Card</strong> or <strong>Cash</strong> instead.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <input type="hidden" name="totalAmount" id="totalAmountHidden" value="0">
<div class="d-flex gap-3 pt-2" style="border-top:1px solid #f1f5f9;">
                            <button type="submit" class="btn-primary-modern" onclick="return validateForm() && validatePayment()">
                                <i class="fas fa-paper-plane me-2"></i> Request Session
                            </button>
                            <a href="${pageContext.request.contextPath}/student/view-tutor/${tutor.tutorId}"
                               class="btn-secondary-modern" style="color:#475569;border-color:#e2e8f0;">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    (function () {
        var ONLINE_RATE    = parseFloat('${tutor.effectiveOnlineRate}')    || 0;
        var HOMEVISIT_RATE = parseFloat('${tutor.effectiveHomeVisitRate}') || 0;
        var currentRate    = HOMEVISIT_RATE;

        // Initialize Flatpickr
        window.fpInstance = flatpickr("#bookingDate", {
            minDate: "today",
            disableMobile: true,
            dateFormat: "Y-m-d",
        });

        var dayMap = { 'Sunday': 0, 'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6 };

        function toMins(s) {
            if (!s) return -1;
            s = s.trim();
            var am = s.match(/^(\d{1,2}):(\d{2})(?::\d+)?\s*(AM|PM)$/i);
            if (am) {
                var h = parseInt(am[1]), m = parseInt(am[2]), p = am[3].toUpperCase();
                if (p === 'PM' && h !== 12) h += 12;
                if (p === 'AM' && h === 12) h = 0;
                return h * 60 + m;
            }
            var h24 = s.match(/^(\d{1,2}):(\d{2})/);
            if (h24) return parseInt(h24[1]) * 60 + parseInt(h24[2]);
            return -1;
        }

        function toDisplay(mins) {
            var h = Math.floor(mins / 60) % 24, m = mins % 60;
            var p = h >= 12 ? 'PM' : 'AM';
            var h12 = h % 12 || 12;
            return h12 + ':' + (m < 10 ? '0' : '') + m + ' ' + p;
        }


        window.onModeChange = function(mode) {
            if (mode === 'ONLINE') {
                currentRate = ONLINE_RATE;
                document.getElementById('panelOnlineRow').classList.add('active');
                document.getElementById('panelHomeRow').classList.remove('active');
            } else {
                currentRate = HOMEVISIT_RATE;
                document.getElementById('panelHomeRow').classList.add('active');
                document.getElementById('panelOnlineRow').classList.remove('active');
            }
            calcEndAndCost();
        };

        // STEP 1: Subject selected - filter slots
        window.onSubjectSelect = function() {
            var subjectSel = document.getElementById('subjectSelect');
            var tsId = subjectSel.value;
            var slotSel = document.getElementById('slotSelect');
            var slotBlock = document.getElementById('slotBlock');
            var noSlotsMsg = document.getElementById('noSlotsMsg');

            // Reset downstream
            slotSel.innerHTML = '<option value="">- Select a slot -</option>';
            document.getElementById('slotInfoBox').style.display = 'none';
            document.getElementById('dateBlock').style.display = 'none';
            document.getElementById('sessionTimeBlock').style.display = 'none';
            resetCostPanel();

            if (!tsId) {
                slotBlock.style.display = 'none';
                ONLINE_RATE = parseFloat('${tutor.effectiveOnlineRate}') || 0;
                HOMEVISIT_RATE = parseFloat('${tutor.effectiveHomeVisitRate}') || 0;
                return;
            }

            var info = subjectInfoMap[tsId];
            if (info) {
                ONLINE_RATE = info.onlineRate;
                HOMEVISIT_RATE = info.homeRate;

                document.querySelector('#panelOnlineRow .tb-rate-val').innerText = 'LKR ' + ONLINE_RATE + '/hr';
                document.querySelector('#panelHomeRow .tb-rate-val').innerText = 'LKR ' + HOMEVISIT_RATE + '/hr';
                document.querySelector('label[onclick="onModeChange(\'ONLINE\')"] .mode-rate').innerText = 'LKR ' + ONLINE_RATE + '/hr';
                document.querySelector('label[onclick="onModeChange(\'HOME_VISIT\')"] .mode-rate').innerText = 'LKR ' + HOMEVISIT_RATE + '/hr';

                var modeCardOnline = document.querySelector('label[onclick="onModeChange(\'ONLINE\')"]');
                var modeCardHome = document.querySelector('label[onclick="onModeChange(\'HOME_VISIT\')"]');
                var panelOnlineRow = document.getElementById('panelOnlineRow');
                var panelHomeRow = document.getElementById('panelHomeRow');

                var supportedMode = info.mode.toUpperCase();
                if (supportedMode === 'ONLINE') {
                    modeCardHome.style.display = 'none';
                    panelHomeRow.style.display = 'none';
                    modeCardOnline.style.display = 'flex';
                    panelOnlineRow.style.display = 'flex';
                    document.querySelector('input[name="mode"][value="ONLINE"]').checked = true;
                    onModeChange('ONLINE');
                } else if (supportedMode.indexOf('HOME') !== -1) {
                    modeCardOnline.style.display = 'none';
                    panelOnlineRow.style.display = 'none';
                    modeCardHome.style.display = 'flex';
                    panelHomeRow.style.display = 'flex';
                    document.querySelector('input[name="mode"][value="HOME_VISIT"]').checked = true;
                    onModeChange('HOME_VISIT');
                } else {
                    modeCardOnline.style.display = 'flex';
                    panelOnlineRow.style.display = 'flex';
                    modeCardHome.style.display = 'flex';
                    panelHomeRow.style.display = 'flex';
                    var currentMode = document.querySelector('input[name="mode"]:checked');
                    if (currentMode) onModeChange(currentMode.value);
                }
            }

            // Filter slots for this tutorSubjectId
            var slots = slotsBySubject[tsId] || [];
            slotBlock.style.display = 'block';

            if (slots.length === 0) {
                noSlotsMsg.style.display = 'block';
                slotSel.style.display = 'none';
            } else {
                noSlotsMsg.style.display = 'none';
                slotSel.style.display = 'block';
                slots.forEach(function(s) {
                    var opt = document.createElement('option');
                    opt.value = s.value;
                    opt.setAttribute('data-day', s.day);
                    opt.textContent = s.label;
                    slotSel.appendChild(opt);
                });
            }
        };

        // STEP 2: Slot selected - show info box and date
        window.onSlotChange = function () {
            var subjectSel = document.getElementById('subjectSelect');
            var tsId = subjectSel ? subjectSel.value : '';
            var sel = document.getElementById('slotSelect');
            var block = document.getElementById('sessionTimeBlock');
            var val = sel.value;

            resetCostPanel();
            document.getElementById('timeSlotHidden').value = '';
            document.getElementById('endDisplay').value = '';
            document.getElementById('exceedMsg').classList.remove('on');

            if (!val) {
                block.style.display = 'none';
                document.getElementById('slotInfoBox').style.display = 'none';
                document.getElementById('dateBlock').style.display = 'none';
                return;
            }

            // Get subject info from map
            var subjectName = tsId && subjectInfoMap[tsId] ? subjectInfoMap[tsId].name : '';
            var medium = tsId && subjectInfoMap[tsId] ? subjectInfoMap[tsId].medium : '';
            var selectedOpt = sel.options[sel.selectedIndex];
            var day = selectedOpt.getAttribute('data-day') || '';

            // Show info box
            document.getElementById('slotSubjectDisplay').textContent = subjectName || 'N/A';
            document.getElementById('slotMediumDisplay').textContent = medium || 'N/A';
            document.getElementById('slotDayDisplay').textContent = day || 'N/A';
            document.getElementById('slotInfoBox').style.display = 'block';
            document.getElementById('subjectHidden').value = subjectName;

            // Show date block
            document.getElementById('dateBlock').style.display = 'block';
            if (day) {
                document.getElementById('dateDayHint').innerHTML =
                    '<i class="fas fa-info-circle me-1"></i>Please select a <strong>' + day + '</strong> date for this slot.';

                // Smart Day Locking with Flatpickr
                var allowedDayIndex = dayMap[day];
                if (window.fpInstance && allowedDayIndex !== undefined) {
                    window.fpInstance.set('disable', [
                        function(date) {
                            return date.getDay() !== allowedDayIndex;
                        }
                    ]);
                    window.fpInstance.clear(); // Clear previous selection if it's invalid now
                }
            }

            var parts = val.split('|');
            var slotStM = toMins(parts[0]);
            var slotEtM = toMins(parts[1]);

            var startSel = document.getElementById('startSel');
            startSel.innerHTML = '<option value="">- Pick start -</option>';
            for (var m = slotStM; m < slotEtM; m += 60) {
                var opt = document.createElement('option');
                opt.value = toDisplay(m);
                opt.textContent = toDisplay(m);
                startSel.appendChild(opt);
            }
            document.getElementById('hoursSel').value = '';
            block.style.display = 'block';
        };

        window.calcEndAndCost = function () {
            var startVal = document.getElementById('startSel').value;
            var hoursVal = parseInt(document.getElementById('hoursSel').value) || 0;
            var slotSel  = document.getElementById('slotSelect');
            var slotVal  = slotSel ? slotSel.value : '';
            var endDisp  = document.getElementById('endDisplay');
            var excMsg   = document.getElementById('exceedMsg');

            if (!startVal || !hoursVal) { endDisp.value = ''; resetCostPanel(); return; }

            var startMins = toMins(startVal);
            var endMins   = startMins + hoursVal * 60;
            var slotEtM   = slotVal ? toMins(slotVal.split('|')[1]) : 9999;

            if (endMins > slotEtM) {
                endDisp.value = 'Exceeds slot!';
                endDisp.style.color = '#ef4444';
                excMsg.classList.add('on');
                document.getElementById('timeSlotHidden').value = '';
                resetCostPanel();
                return;
            }

            excMsg.classList.remove('on');
            endDisp.style.color = '#2563eb';
            var endStr = toDisplay(endMins);
            endDisp.value = endStr;

            var selectedOption = slotSel.options[slotSel.selectedIndex];
            var day = selectedOption.getAttribute('data-day');
            document.getElementById('timeSlotHidden').value = day + ' ' + startVal + ' - ' + endStr;

            var total    = currentRate * hoursVal;
            var hrLabel  = hoursVal === 1 ? 'hour' : 'hours';

            document.getElementById('cTimeRange').innerHTML =
                '<i class="fas fa-clock me-1" style="opacity:0.8;"></i> ' + startVal + ' - ' + endStr + ' (' + hoursVal + ' ' + hrLabel + ')';
            document.getElementById('cCalcFull').textContent = 'LKR ' + total.toLocaleString('en-LK');

            document.getElementById('costPlaceholder').style.display = 'none';
            document.getElementById('costDetails').style.display = 'flex';
        };

        function resetCostPanel() {
            document.getElementById('costPlaceholder').style.display = 'block';
            document.getElementById('costDetails').style.display = 'none';
        }

        function showWarn(msg) {
            Swal.fire({ icon: 'warning', title: 'Missing Information', text: msg, confirmButtonColor: '#2563eb', borderRadius: '14px' });
        }

        window.validateForm = function () {
            var subjectSel = document.getElementById('subjectSelect');
            if (subjectSel && !subjectSel.value) { showWarn('Please select a subject.'); return false; }
            var ss = document.getElementById('slotSelect');
            if (ss && !ss.value) { showWarn('Please select an available time slot.'); return false; }
            if (!document.getElementById('bookingDate').value) {
                showWarn('Please select a date.'); return false;
            }
            if (ss && !document.getElementById('startSel').value) { showWarn('Please select a start time.'); return false; }
            if (ss && !document.getElementById('hoursSel').value) { showWarn('Please select number of hours.'); return false; }
            if (!document.getElementById('timeSlotHidden').value) {
                showWarn('Session time exceeds slot or is incomplete. Please adjust.'); return false;
            }
            var amtText = document.getElementById('cCalcFull').textContent.replace(/[^0-9.]/g,'');
            document.getElementById('totalAmountHidden').value = parseFloat(amtText) || 0;
            return true;
        };

        var di = document.getElementById('bookingDate');
        // Native min date is removed as Flatpickr handles it via minDate: "today"

    })();
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const avatars = document.querySelectorAll('.tc-avatar, .tutor-avatar-large, .profile-avatar, .tb-avatar');
        const gradients = [
            'linear-gradient(135deg, #3b82f6, #60a5fa)',
            'linear-gradient(135deg, #10b981, #34d399)',
            'linear-gradient(135deg, #f59e0b, #fbbf24)',
            'linear-gradient(135deg, #8b5cf6, #a78bfa)',
            'linear-gradient(135deg, #f43f5e, #fb7185)',
            'linear-gradient(135deg, #06b6d4, #22d3ee)'
        ];
        avatars.forEach(avatar => {
            const text = avatar.innerText.trim();
            if (text.length > 0) {
                const charCode = text.charCodeAt(0);
                const colorIndex = charCode % gradients.length;
                avatar.style.background = gradients[colorIndex];
                avatar.style.color = '#fff';
                avatar.style.border = 'none';
            }
        });
    });
</script>

<script>
    document.querySelectorAll('a[href]').forEach(function(link){
        var href=link.getAttribute('href');
        if(!href||href.startsWith('#')||href.startsWith('javascript')||link.target==='_blank') return;
        link.addEventListener('click',function(e){
            var dest=link.href;
            if(dest&&dest!==window.location.href){
                e.preventDefault();
                document.body.style.transition='opacity 0.3s ease,transform 0.3s ease';
                document.body.style.opacity='0';
                document.body.style.transform='translateY(-8px)';
                setTimeout(function(){window.location.href=dest;},280);
            }
        });
    });

    function showPaymentPanel(method) {
        document.querySelectorAll('.payment-panel').forEach(function(p){ p.style.display='none'; });
        var sel = document.getElementById('panel-' + method);
        if (sel) sel.style.display = 'block';
        if (method !== 'CARD') {
            var cn = document.getElementById('cardNumber');
            var cv = document.getElementById('cvv');
            if (cn) cn.value = '';
            if (cv) cv.value = '';
        }
    }
    function formatCardNumber(input) {
        var d = input.value.replace(/\D/g, '');
        input.value = d.replace(/(.{4})/g, '$1 ').trim();
    }
    function validatePayment() {
        var method = document.querySelector('input[name="paymentMethod"]:checked').value;
        if (method === 'CARD') {
            var card = document.getElementById('cardNumber').value.replace(/\s+/g, '');
            var cvv  = document.getElementById('cvv').value;
            if (card.length !== 16 || isNaN(card)) {
                Swal.fire({ icon: 'error', title: 'Invalid Card', text: 'Please enter a valid 16-digit card number.', confirmButtonColor: '#ef4444' });
                return false;
            }
            if (cvv.length  !== 3  || isNaN(cvv))  {
                Swal.fire({ icon: 'error', title: 'Invalid CVV', text: 'Please enter a valid 3-digit CVV.', confirmButtonColor: '#ef4444' });
                return false;
            }
        }
        if (method === 'BANK_TRANSFER' && document.querySelector('.pay-no-bank')) {
            Swal.fire({ icon: 'warning', title: 'Unavailable', text: 'This tutor has no bank details. Please choose Card or Cash.', confirmButtonColor: '#f59e0b' });
            return false;
        }
        return true;
    }

</script>

</body>
</html>
