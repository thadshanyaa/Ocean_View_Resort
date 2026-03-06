<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <div class="container py-5">
                        <div class="row g-4">
                            <!-- Sidebar -->
                            <div class="col-md-4 col-lg-3" data-aos="fade-right">
                                <%@ include file="sidebar.jspf" %>
                            </div>

                            <!-- Main Content -->
                            <div class="col-md-8 col-lg-9" data-aos="fade-left">

                                <c:if test="${not empty dbError}">
                                    <div
                                        class="alert alert-danger bg-dark border-danger text-light mb-4 shadow animate__animated animate__shakeX">
                                        <i class="fa-solid fa-triangle-exclamation me-2"></i> ${dbError}
                                    </div>
                                </c:if>

                                <c:if test="${param.msg == 'cancelled'}">
                                    <div
                                        class="alert alert-success bg-success bg-opacity-10 border-success text-success mb-4 shadow animate__animated animate__fadeIn">
                                        <i class="fa-solid fa-circle-check me-2"></i> Reservation cancelled
                                        successfully. The room is now available for new bookings.
                                    </div>
                                </c:if>

                                <c:if test="${not empty param.error}">
                                    <div
                                        class="alert alert-danger bg-danger bg-opacity-10 border-danger text-danger mb-4 shadow animate__animated animate__shakeX">
                                        <i class="fa-solid fa-circle-xmark me-2"></i> ${param.error}
                                    </div>
                                </c:if>

                                <!-- Welcome Card -->
                                <div class="glass-card p-4 mb-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h3 class="fw-bold mb-1 text-white">Hello, ${guest.fullName}!</h3>
                                            <p class="text-muted mb-0 small">Welcome to your OceanView Resort portal.
                                                Manage your upcoming stays and view your history.</p>
                                        </div>
                                        <div class="text-end d-none d-md-block">
                                            <span class="badge bg-primary px-3 py-2 rounded-pill fw-bold"
                                                style="box-shadow: 0 0 10px rgba(13, 110, 253, 0.5);">
                                                <i class="fa-solid fa-user-circle me-1"></i> Guest Member
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Stats Overview -->
                                <div class="row g-3 mb-4 text-center">
                                    <div class="col-6 col-md-3">
                                        <div class="glass-card p-3 border-bottom border-3 border-info h-100">
                                            <h6 class="text-muted text-uppercase smaller mb-2">My Bookings</h6>
                                            <h4 class="fw-bold text-info mb-0">${stats.activeCount}</h4>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <div class="glass-card p-3 border-bottom border-3 border-success h-100">
                                            <h6 class="text-muted text-uppercase smaller mb-2">Total Spent</h6>
                                            <h4 class="fw-bold text-success mb-0">LKR
                                                <fmt:formatNumber value="${stats.totalPaid}" type="number"
                                                    minFractionDigits="0" />
                                            </h4>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <div class="glass-card p-3 border-bottom border-3 border-warning h-100">
                                            <h6 class="text-muted text-uppercase smaller mb-2">Pending Bill</h6>
                                            <h4 class="fw-bold text-warning mb-0">LKR
                                                <fmt:formatNumber value="${stats.pendingTotal}" type="number"
                                                    minFractionDigits="0" />
                                            </h4>
                                        </div>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <div class="glass-card p-3 border-bottom border-3 border-primary h-100">
                                            <h6 class="text-muted text-uppercase smaller mb-2">Active Services</h6>
                                            <h4 class="fw-bold text-primary mb-0">${stats.serviceCount}</h4>
                                        </div>
                                    </div>
                                </div>

                                <!-- Quick Actions -->
                                <div class="glass-card p-3 mb-4">
                                    <div class="row g-3 align-items-center">
                                        <div class="col-md-3 text-center text-md-start">
                                            <h6 class="fw-bold text-white mb-0"><i
                                                    class="fa-solid fa-bolt me-2 text-warning"></i> Quick Actions</h6>
                                        </div>
                                        <div class="col-md-9 text-center text-md-end">
                                            <a href="services.jsp"
                                                class="btn btn-sm btn-outline-primary rounded-pill px-3 me-2">
                                                <i class="fa-solid fa-spa me-1"></i> Resort Services
                                            </a>
                                            <a href="restaurant.jsp"
                                                class="btn btn-sm btn-outline-success rounded-pill px-3 me-2">
                                                <i class="fa-solid fa-utensils me-1"></i> Order Food
                                            </a>
                                            <a href="DashboardServlet"
                                                class="btn btn-sm btn-outline-info rounded-pill px-3">
                                                <i class="fa-solid fa-refresh me-1"></i> Refresh Stats
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Upcoming Stays -->
                                <h4 class="fw-bold mb-3 text-white border-start border-4 border-info ps-3">Upcoming
                                    Stays</h4>
                                <div class="row g-4 mb-5">
                                    <c:set var="hasUpcoming" value="false" />
                                    <%-- Date normalization for "Today or Future" comparison --%>
                                        <% java.util.Calendar cal=java.util.Calendar.getInstance();
                                            cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
                                            cal.set(java.util.Calendar.MINUTE, 0); cal.set(java.util.Calendar.SECOND,
                                            0); cal.set(java.util.Calendar.MILLISECOND, 0);
                                            request.setAttribute("today", cal.getTime()); %>

                                            <c:forEach var="res" items="${reservations}">
                                                <c:if test="${res.status != 'CANCELLED' && res.checkIn >= today}">
                                                    <c:set var="hasUpcoming" value="true" />
                                                    <div class="col-md-6 col-lg-4">
                                                        <div
                                                            class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                            <div
                                                                class="bg-info bg-opacity-10 p-3 border-bottom border-secondary border-opacity-25 d-flex justify-content-between align-items-center">
                                                                <span
                                                                    class="small fw-bold text-info">#${res.resNo}</span>
                                                                <span
                                                                    class="badge bg-info text-dark rounded-pill shadow-sm">${res.status}</span>
                                                            </div>
                                                            <div class="p-3">
                                                                <h6 class="fw-bold text-white mb-1">${res.roomInfo}</h6>
                                                                <p class="text-muted small mb-3">
                                                                    <i class="fa-solid fa-calendar-days me-1"></i>
                                                                    <fmt:formatDate value="${res.checkIn}"
                                                                        pattern="dd MMM" /> -
                                                                    <fmt:formatDate value="${res.checkOut}"
                                                                        pattern="dd MMM YYYY" />
                                                                </p>

                                                                <div
                                                                    class="d-flex justify-content-between align-items-center mb-3">
                                                                    <div class="text-muted small">Total: <span
                                                                            class="text-white fw-bold">LKR
                                                                            <fmt:formatNumber value="${res.total}"
                                                                                type="number" minFractionDigits="2" />
                                                                        </span></div>
                                                                    <c:choose>
                                                                        <c:when test="${res.paymentStatus == 'PAID'}">
                                                                            <span
                                                                                class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1 small">
                                                                                <i
                                                                                    class="fa-solid fa-check-circle me-1"></i>
                                                                                PAID
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${res.paymentStatus == 'PARTIALLY PAID'}">
                                                                            <span
                                                                                class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 px-2 py-1 small"
                                                                                title="Room Paid + Pending Services">
                                                                                <i
                                                                                    class="fa-solid fa-clock-rotate-left me-1"></i>
                                                                                PARTIALLY PAID
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span
                                                                                class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-2 py-1 small">
                                                                                <i class="fa-solid fa-clock me-1"></i>
                                                                                PENDING
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>

                                                                <div class="btn-group w-100">
                                                                    <a href="ReservationDetailsServlet?reservationNumber=${res.resNo}"
                                                                        class="btn btn-sm btn-outline-primary">
                                                                        <i class="fa-solid fa-eye me-1"></i> Details
                                                                    </a>
                                                                    <button class="btn btn-sm btn-outline-danger"
                                                                        onclick="confirmCancellation('${res.resNo}', ${res.id})">
                                                                        <i class="fa-solid fa-trash-can me-1"></i>
                                                                        Cancel
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${!hasUpcoming}">
                                                <div class="col-12">
                                                    <div class="glass-card p-5 text-center text-muted">
                                                        <i class="fa-solid fa-calendar-xmark fa-3x mb-3 opacity-25"></i>
                                                        <h5>No upcoming stays found</h5>
                                                        <p class="small">Treat yourself to a stay at OceanView! <a
                                                                href="NewReservationServlet"
                                                                class="text-info fw-bold">Book
                                                                now</a></p>
                                                    </div>
                                                </div>
                                            </c:if>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- Cancellation Modal -->
                    <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content glass-dark text-white border-danger border-opacity-25">
                                <div class="modal-header border-0">
                                    <h5 class="modal-title fw-bold"><i
                                            class="fa-solid fa-triangle-exclamation text-danger me-2"></i> Cancel
                                        Reservation</h5>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body text-center p-4">
                                    <div class="bg-danger bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                        style="width:60px; height:60px;">
                                        <i class="fa-solid fa-calendar-xmark fa-2x text-danger"></i>
                                    </div>
                                    <h5 class="fw-bold mb-2">Are you sure?</h5>
                                    <p class="text-muted small">You are about to cancel booking <strong id="cancelResNo"
                                            class="text-info"></strong>. This will free your room for other guests and
                                        cannot be undone.</p>

                                    <form action="CancelReservationServlet" method="POST">
                                        <input type="hidden" name="reservationId" id="cancelResId">
                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-danger fw-bold py-2 shadow-sm">Confirm
                                                Cancellation</button>
                                            <button type="button" class="btn btn-outline-secondary py-2"
                                                data-bs-dismiss="modal">Keep Booking</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <style>
                        .glass-dark {
                            background: rgba(13, 17, 23, 0.95);
                            backdrop-filter: blur(10px);
                        }

                        .hover-translate {
                            transition: transform 0.3s;
                        }

                        .hover-translate:hover {
                            transform: translateY(-5px);
                        }

                        .smaller {
                            font-size: 0.75rem;
                        }
                    </style>

                    <script>
                        function confirmCancellation(resNo, resId) {
                            document.getElementById('cancelResNo').textContent = resNo;
                            document.getElementById('cancelResId').value = resId;
                            new bootstrap.Modal(document.getElementById('cancelModal')).show();
                        }
                    </script>

                    <%@ include file="footer.jspf" %>