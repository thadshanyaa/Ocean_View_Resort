<%@ page pageEncoding="UTF-8" %>
    <%@ page import="ovr.*, java.sql.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <% User user=(User) session.getAttribute("user"); if (user==null) {
                        response.sendRedirect("login.jsp"); return; } DBConnectionManager
                        db=DBConnectionManager.getInstance(); Connection conn=db.getConnection(); GuestDAO guestDAO=new
                        GuestDAO(conn); Guest guest=guestDAO.getByUserId(user.getId()); ReservationDAO resDAO=new
                        ReservationDAO(conn); Map<String, Object> stats = (guest != null) ?
                        resDAO.getExtendedGuestStats(guest.getId()) : null;
                        Integer activeResId = (stats != null) ? (Integer) stats.get("activeResId") : null;
                        %>

                        <div class="container py-5">
                            <div class="row g-4">
                                <!-- Sidebar -->
                                <div class="col-md-4 col-lg-3" data-aos="fade-right">
                                    <%@ include file="sidebar.jspf" %>
                                </div>

                                <!-- Main Content -->
                                <div class="col-md-8 col-lg-9" data-aos="fade-left">

                                    <c:if test="${param.msg == 'ordered'}">
                                        <div
                                            class="alert alert-success bg-success bg-opacity-10 border-success text-success mb-4 shadow animate__animated animate__fadeIn">
                                            <i class="fa-solid fa-circle-check me-2"></i> ${param.item} activated
                                            successfully! It has been added to your reservation bill.
                                        </div>
                                    </c:if>

                                    <div class="glass-card p-4 mb-4">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h2 class="fw-bold mb-1 text-white"><i
                                                        class="fa-solid fa-concierge-bell me-2 text-primary"></i> Resort
                                                    Services</h2>
                                                <p class="text-muted mb-0">Enhance your stay with our premium amenities.
                                                    Services are automatically billed to your room.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <% if (activeResId==null) { %>
                                        <div class="glass-card p-5 text-center text-muted">
                                            <i class="fa-solid fa-calendar-xmark fa-3x mb-3 opacity-25"></i>
                                            <h5>No Active Reservation Found</h5>
                                            <p class="small">You need an active check-in to request resort services.
                                                Please <a href="NewReservationServlet" class="text-info fw-bold">Book a
                                                    room</a> first.</p>
                                        </div>
                                        <% } else { %>
                                            <div class="row g-4">
                                                <!-- Spa Card -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-primary bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i
                                                                class="fa-solid fa-spa fa-4x text-primary opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Luxury Spa</h5>
                                                            <p class="text-muted smaller mb-3">Full body massage,
                                                                aromatherapy, and facial treatments.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-info">LKR 4,500</span>
                                                                <span
                                                                    class="badge bg-secondary bg-opacity-25 px-2 py-1 smaller">Per
                                                                    Session</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category"
                                                                    value="Resort Service">
                                                                <input type="hidden" name="itemName"
                                                                    value="Luxury Spa Session">
                                                                <input type="hidden" name="unitPrice" value="4500.00">
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-primary w-100">Activate
                                                                    Service</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Gym Card -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-success bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i
                                                                class="fa-solid fa-dumbbell fa-4x text-success opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Fitness Center</h5>
                                                            <p class="text-muted smaller mb-3">24/7 access to our
                                                                state-of-the-art gym and trainers.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-success">LKR 1,200</span>
                                                                <span
                                                                    class="badge bg-secondary bg-opacity-25 px-2 py-1 smaller">Daily
                                                                    Pass</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category"
                                                                    value="Resort Service">
                                                                <input type="hidden" name="itemName"
                                                                    value="Gym Day Pass">
                                                                <input type="hidden" name="unitPrice" value="1200.00">
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-success w-100">Activate
                                                                    Service</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Laundry Card -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-warning bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i
                                                                class="fa-solid fa-shirt fa-4x text-warning opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Express Laundry</h5>
                                                            <p class="text-muted smaller mb-3">Professional cleaning and
                                                                pressing with same-day return.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-warning">LKR 850</span>
                                                                <span
                                                                    class="badge bg-secondary bg-opacity-25 px-2 py-1 smaller">Per
                                                                    Load</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category"
                                                                    value="Resort Service">
                                                                <input type="hidden" name="itemName"
                                                                    value="Laundry Service">
                                                                <input type="hidden" name="unitPrice" value="850.00">
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-warning w-100">Activate
                                                                    Service</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Airport Pickup -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-info bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i class="fa-solid fa-car fa-4x text-info opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Airport Transfer</h5>
                                                            <p class="text-muted smaller mb-3">Premium taxi service for
                                                                seamless airport commutes.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-info">LKR 3,500</span>
                                                                <span
                                                                    class="badge bg-secondary bg-opacity-25 px-2 py-1 smaller">One
                                                                    Way</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category"
                                                                    value="Resort Service">
                                                                <input type="hidden" name="itemName"
                                                                    value="Airport Transfer">
                                                                <input type="hidden" name="unitPrice" value="3500.00">
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-info w-100">Activate
                                                                    Service</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } %>
                                </div>
                            </div>
                        </div>

                        <style>
                            .smaller {
                                font-size: 0.75rem;
                            }

                            .hover-translate {
                                transition: transform 0.3s;
                            }

                            .hover-translate:hover {
                                transform: translateY(-5px);
                            }
                        </style>

                        <%@ include file="footer.jspf" %>