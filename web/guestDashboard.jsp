<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <style>
                        :root {
                            --ocean-dark: #0a192f;
                            --ocean-card: rgba(16, 32, 58, 0.7);
                            --ocean-border: rgba(100, 255, 218, 0.1);
                            --ocean-glow: rgba(100, 255, 218, 0.4);
                            --accent-color: #64ffda;
                        }

                        body {
                            background-color: var(--ocean-dark);
                            color: #ccd6f6;
                        }

                        .glass-card {
                            background: var(--ocean-card);
                            backdrop-filter: blur(12px);
                            -webkit-backdrop-filter: blur(12px);
                            border: 1px solid var(--ocean-border);
                            border-radius: 20px;
                            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
                            transition: transform 0.3s ease, box-shadow 0.3s ease;
                        }

                        .glass-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 12px 40px 0 rgba(100, 255, 218, 0.1);
                        }

                        .stats-card {
                            border-bottom: 3px solid var(--accent-color);
                        }

                        .res-badge {
                            font-size: 0.75rem;
                            padding: 5px 12px;
                            border-radius: 50px;
                            font-weight: 600;
                            text-transform: uppercase;
                        }

                        .badge-paid {
                            background: rgba(16, 185, 129, 0.1);
                            color: #10b981;
                            border: 1px solid rgba(16, 185, 129, 0.3);
                        }

                        .badge-pending {
                            background: rgba(245, 158, 11, 0.1);
                            color: #f59e0b;
                            border: 1px solid rgba(245, 158, 11, 0.3);
                        }

                        .badge-partial {
                            background: rgba(59, 130, 246, 0.1);
                            color: #3b82f6;
                            border: 1px solid rgba(59, 130, 246, 0.3);
                        }

                        .btn-action {
                            border-radius: 10px;
                            padding: 8px 16px;
                            font-weight: 500;
                            transition: all 0.3s ease;
                        }

                        .btn-primary-ocean {
                            background: rgba(100, 255, 218, 0.1);
                            color: var(--accent-color);
                            border: 1px solid var(--accent-color);
                        }

                        .btn-primary-ocean:hover {
                            background: var(--accent-color);
                            color: var(--ocean-dark);
                            box-shadow: 0 0 15px var(--accent-color);
                        }

                        .empty-state {
                            padding: 60px 20px;
                            text-align: center;
                            color: #8892b0;
                        }

                        .empty-state i {
                            font-size: 4rem;
                            margin-bottom: 20px;
                            opacity: 0.3;
                        }

                        .services-list {
                            font-size: 0.85rem;
                            color: #8892b0;
                        }

                        .services-list i {
                            color: var(--accent-color);
                            margin-right: 5px;
                        }
                    </style>

                    <div class="container py-5">
                        <div class="row g-4">
                            <!-- Sidebar -->
                            <div class="col-md-4 col-lg-3 d-none d-md-block" data-aos="fade-right">
                                <%@ include file="sidebar.jspf" %>
                            </div>

                            <!-- Main Content -->
                            <div class="col-md-8 col-lg-9" data-aos="fade-left">

                                <!-- Alerts -->
                                <c:if test="${not empty dbError}">
                                    <div
                                        class="alert alert-danger bg-dark border-danger text-light mb-4 shadow-sm animate__animated animate__shakeX">
                                        <i class="fa-solid fa-triangle-exclamation me-2 text-danger"></i> ${dbError}
                                    </div>
                                </c:if>

                                <c:if test="${param.msg == 'cancelled'}">
                                    <div
                                        class="alert alert-success bg-dark border-success text-success mb-4 shadow-sm animate__animated animate__fadeIn">
                                        <i class="fa-solid fa-circle-check me-2"></i> Reservation cancelled
                                        successfully. We hope to host you again soon.
                                    </div>
                                </c:if>

                                <!-- Welcome Section -->
                                <div class="glass-card p-4 mb-5 border-0">
                                    <div class="row align-items-center">
                                        <div class="col-md-8">
                                            <h2 class="fw-bold text-white mb-2">Welcome Back, <span
                                                    style="color: var(--accent-color);">${guest.fullName}</span>!</h2>
                                            <p class="mb-0 text-muted">Your luxury escape at <span
                                                    class="text-white fw-bold">OceanView Resort</span> awaits. Manage
                                                your stays and services with ease.</p>
                                        </div>
                                        <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                            <div class="d-inline-block p-3 rounded-circle bg-dark border border-secondary border-opacity-25"
                                                style="box-shadow: 0 0 20px rgba(100, 255, 218, 0.1);">
                                                <i class="fa-solid fa-user-tie fa-2x text-info"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Stats Bar -->
                                <div class="row g-3 mb-5">
                                    <div class="col-6 col-lg-3">
                                        <div class="glass-card stats-card p-3 h-100">
                                            <small class="text-muted text-uppercase fw-bold">Stays</small>
                                            <h3 class="fw-bold mb-0 text-white">${not empty stats.activeCount ?
                                                stats.activeCount : 0}</h3>
                                        </div>
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        <div class="glass-card stats-card p-3 h-100" style="border-color: #10b981;">
                                            <small class="text-muted text-uppercase fw-bold">Settled</small>
                                            <h3 class="fw-bold mb-0 text-white">LKR
                                                <fmt:formatNumber value="${stats.totalPaid}" type="number"
                                                    minFractionDigits="0" />
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        <div class="glass-card stats-card p-3 h-100" style="border-color: #f59e0b;">
                                            <small class="text-muted text-uppercase fw-bold">Balance</small>
                                            <h3 class="fw-bold mb-0 text-white">LKR
                                                <fmt:formatNumber value="${stats.pendingTotal}" type="number"
                                                    minFractionDigits="0" />
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="col-6 col-lg-3">
                                        <div class="glass-card stats-card p-3 h-100" style="border-color: #3b82f6;">
                                            <small class="text-muted text-uppercase fw-bold">Add-ons</small>
                                            <h3 class="fw-bold mb-0 text-white">${not empty stats.serviceCount ?
                                                stats.serviceCount : 0} Items</h3>
                                        </div>
                                    </div>
                                </div>

                                <!-- Reservations List -->
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="fw-bold text-white mb-0 border-start border-4 border-info ps-3">My
                                        Reservations</h4>
                                    <a href="NewReservationServlet" class="btn btn-sm btn-action btn-primary-ocean">
                                        <i class="fa-solid fa-plus me-1"></i> New Booking
                                    </a>
                                </div>

                                <div class="row g-4">
                                    <c:choose>
                                        <c:when test="${not empty reservations}">
                                            <c:forEach var="res" items="${reservations}">
                                                <div class="col-12">
                                                    <div class="glass-card p-4">
                                                        <div class="row g-3">
                                                            <!-- Header: Res No & Status -->
                                                            <div
                                                                class="col-md-12 d-flex justify-content-between align-items-center border-bottom border-white border-opacity-10 pb-3 mb-3">
                                                                <div>
                                                                    <span class="small text-muted fw-bold">REF #</span>
                                                                    <span class="text-info fw-bold">${res.resNo}</span>
                                                                </div>
                                                                <div class="d-flex gap-2 align-items-center">
                                                                    <c:choose>
                                                                        <c:when test="${res.paymentStatus == 'PAID'}">
                                                                            <span class="res-badge badge-paid"><i
                                                                                    class="fa-solid fa-circle-check me-1"></i>
                                                                                Paid in Full</span>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${res.paymentStatus == 'PARTIALLY PAID'}">
                                                                            <span class="res-badge badge-partial"><i
                                                                                    class="fa-solid fa-clock-rotate-left me-1"></i>
                                                                                Partially Paid</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="res-badge badge-pending"><i
                                                                                    class="fa-solid fa-clock me-1"></i>
                                                                                Payment Pending</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <span
                                                                        class="badge ${res.status == 'CANCELLED' ? 'bg-danger' : 'bg-primary'} bg-opacity-10 text-${res.status == 'CANCELLED' ? 'danger' : 'primary'} rounded-pill px-3">
                                                                        ${res.status}
                                                                    </span>
                                                                </div>
                                                            </div>

                                                            <!-- Stay Details -->
                                                            <div class="col-md-4">
                                                                <div class="d-flex align-items-center mb-3">
                                                                    <div
                                                                        class="p-2 rounded bg-info bg-opacity-10 text-info me-3">
                                                                        <i class="fa-solid fa-bed"></i>
                                                                    </div>
                                                                    <div>
                                                                        <small class="text-muted d-block">Room
                                                                            Choice</small>
                                                                        <span
                                                                            class="text-white fw-bold">${res.roomInfo}</span>
                                                                    </div>
                                                                </div>
                                                                <div class="d-flex align-items-center">
                                                                    <div
                                                                        class="p-2 rounded bg-warning bg-opacity-10 text-warning me-3">
                                                                        <i class="fa-solid fa-calendar-range"></i>
                                                                    </div>
                                                                    <div>
                                                                        <small class="text-muted d-block">Stay
                                                                            Period</small>
                                                                        <span class="text-white small">
                                                                            <fmt:formatDate value="${res.checkIn}"
                                                                                pattern="dd MMM" /> -
                                                                            <fmt:formatDate value="${res.checkOut}"
                                                                                pattern="dd MMM, yyyy" />
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Guest & Services -->
                                                            <div class="col-md-4">
                                                                <div class="d-flex align-items-center mb-3">
                                                                    <div
                                                                        class="p-2 rounded bg-primary bg-opacity-10 text-primary me-3">
                                                                        <i class="fa-solid fa-concierge-bell"></i>
                                                                    </div>
                                                                    <div class="services-list">
                                                                        <small class="text-muted d-block">Additional
                                                                            Services</small>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty res.services && res.services != 'None'}">
                                                                                <span
                                                                                    class="text-white-50">${res.services}</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="text-muted italic">No
                                                                                    add-ons selected</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                                <div class="d-flex align-items-center">
                                                                    <div
                                                                        class="p-2 rounded bg-success bg-opacity-10 text-success me-3">
                                                                        <i class="fa-solid fa-money-bill-wave"></i>
                                                                    </div>
                                                                    <div>
                                                                        <small class="text-muted d-block">Total
                                                                            Due</small>
                                                                        <span class="text-white fw-bold">LKR
                                                                            <fmt:formatNumber value="${res.total}"
                                                                                type="number" minFractionDigits="2" />
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Actions -->
                                                            <div
                                                                class="col-md-4 d-flex flex-column justify-content-center gap-2">
                                                                <a href="ReservationDetailsServlet?reservationNumber=${res.resNo}"
                                                                    class="btn btn-action btn-primary-ocean w-100">
                                                                    <i class="fa-solid fa-circle-info me-2"></i> View
                                                                    Full Itinerary
                                                                </a>
                                                                <div class="d-flex gap-2">
                                                                    <c:if test="${res.paymentStatus == 'PAID'}">
                                                                        <a href="BillingInvoiceServlet?resNo=${res.resNo}"
                                                                            class="btn btn-action btn-outline-success flex-grow-1">
                                                                            <i class="fa-solid fa-file-pdf"></i> Receipt
                                                                        </a>
                                                                    </c:if>
                                                                    <c:if test="${res.status != 'CANCELLED'}">
                                                                        <button
                                                                            class="btn btn-action btn-outline-danger flex-grow-1"
                                                                            onclick="confirmCancellation('${res.resNo}', ${res.id})">
                                                                            <i class="fa-solid fa-calendar-xmark"></i>
                                                                            Cancel
                                                                        </button>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="col-12">
                                                <div class="glass-card empty-state">
                                                    <i class="fa-solid fa-umbrella-beach"></i>
                                                    <h5>Your itinerary is waiting...</h5>
                                                    <p class="mb-4">You haven't booked any experiences yet. Start your
                                                        OceanView journey today.</p>
                                                    <a href="NewReservationServlet"
                                                        class="btn btn-action btn-primary-ocean px-5">
                                                        <i class="fa-solid fa-compass me-2"></i> Book Your First Stay
                                                    </a>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- Cancellation Modal -->
                    <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content glass-card border-danger border-opacity-25"
                                style="background: var(--ocean-dark);">
                                <div class="modal-header border-0">
                                    <h5 class="modal-title fw-bold text-white">Cancel Reservation</h5>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body text-center p-4">
                                    <div class="bg-danger bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                        style="width:70px; height:70px;">
                                        <i class="fa-solid fa-triangle-exclamation fa-2x text-danger"></i>
                                    </div>
                                    <h5 class="fw-bold mb-2 text-white">Cancel Booking <span id="cancelResNo"
                                            style="color: var(--accent-color);"></span>?</h5>
                                    <p class="text-muted small">This action will release your room for other guests.
                                        This cannot be undone.</p>

                                    <form action="CancelReservationServlet" method="POST" class="mt-4">
                                        <input type="hidden" name="reservationId" id="cancelResId">
                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-danger fw-bold py-2">Confirm
                                                Cancellation</button>
                                            <button type="button" class="btn btn-outline-secondary py-2"
                                                data-bs-dismiss="modal">Keep My Booking</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        function confirmCancellation(resNo, resId) {
                            document.getElementById('cancelResNo').textContent = resNo;
                            document.getElementById('cancelResId').value = resId;
                            new bootstrap.Modal(document.getElementById('cancelModal')).show();
                        }
                    </script>

                    <%@ include file="footer.jspf" %>