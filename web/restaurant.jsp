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
                                            <i class="fa-solid fa-utensils me-2"></i> Your order for ${param.item} has
                                            been placed! It has been added to your reservation bill.
                                        </div>
                                    </c:if>

                                    <div class="glass-card p-4 mb-4">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h2 class="fw-bold mb-1 text-white"><i
                                                        class="fa-solid fa-utensils me-2 text-primary"></i> Ocean View
                                                    Restaurant</h2>
                                                <p class="text-muted mb-0">Experience world-class culinary delights. All
                                                    orders are charged to your room.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <% if (activeResId==null) { %>
                                        <div class="glass-card p-5 text-center text-muted">
                                            <i class="fa-solid fa-calendar-xmark fa-3x mb-3 opacity-25"></i>
                                            <h5>No Active Reservation Found</h5>
                                            <p class="small">You need an active check-in to order food. Please <a
                                                    href="NewReservationServlet" class="text-info fw-bold">Book a
                                                    room</a> first.</p>
                                        </div>
                                        <% } else { %>
                                            <div class="row g-4">
                                                <!-- Fried Rice -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-warning bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i
                                                                class="fa-solid fa-bowl-rice fa-4x text-warning opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Seafood Fried Rice</h5>
                                                            <p class="text-muted smaller mb-3">Savory rice with fresh
                                                                ocean catch and aromatic spices.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-info">LKR 1,800</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category" value="Restaurant">
                                                                <input type="hidden" name="itemName"
                                                                    value="Seafood Fried Rice">
                                                                <input type="hidden" name="unitPrice" value="1800.00">
                                                                <div class="input-group input-group-sm mb-2">
                                                                    <span
                                                                        class="input-group-text bg-dark border-secondary text-muted">Qty</span>
                                                                    <input type="number" name="qty" value="1" min="1"
                                                                        class="form-control bg-dark border-secondary text-white text-center">
                                                                </div>
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-primary w-100">Order
                                                                    Now</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Kothu -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-danger bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i
                                                                class="fa-solid fa-fire-burner fa-4x text-danger opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Cheese Kothu</h5>
                                                            <p class="text-muted smaller mb-3">Traditional shredded
                                                                paratha with chicken and melting cheese.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-success">LKR 1,500</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category" value="Restaurant">
                                                                <input type="hidden" name="itemName"
                                                                    value="Cheese Kothu">
                                                                <input type="hidden" name="unitPrice" value="1500.00">
                                                                <div class="input-group input-group-sm mb-2">
                                                                    <span
                                                                        class="input-group-text bg-dark border-secondary text-muted">Qty</span>
                                                                    <input type="number" name="qty" value="1" min="1"
                                                                        class="form-control bg-dark border-secondary text-white text-center">
                                                                </div>
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-success w-100">Order
                                                                    Now</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Noodles -->
                                                <div class="col-md-6 col-lg-4">
                                                    <div
                                                        class="glass-card h-100 p-0 overflow-hidden border border-secondary border-opacity-25 hover-translate">
                                                        <div class="service-img-placeholder bg-info bg-opacity-10 d-flex align-items-center justify-content-center"
                                                            style="height: 150px;">
                                                            <i
                                                                class="fa-solid fa-wheat-awn fa-4x text-info opacity-50"></i>
                                                        </div>
                                                        <div class="p-3">
                                                            <h5 class="fw-bold text-white mb-1">Spicy Noodles</h5>
                                                            <p class="text-muted smaller mb-3">Stir-fried noodles with
                                                                crisp vegetables and chili oil.</p>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <span class="fw-bold text-warning">LKR 1,200</span>
                                                            </div>
                                                            <form action="ServiceOrderServlet" method="POST">
                                                                <input type="hidden" name="reservationId"
                                                                    value="<%= activeResId %>">
                                                                <input type="hidden" name="category" value="Restaurant">
                                                                <input type="hidden" name="itemName"
                                                                    value="Spicy Noodles">
                                                                <input type="hidden" name="unitPrice" value="1200.00">
                                                                <div class="input-group input-group-sm mb-2">
                                                                    <span
                                                                        class="input-group-text bg-dark border-secondary text-muted">Qty</span>
                                                                    <input type="number" name="qty" value="1" min="1"
                                                                        class="form-control bg-dark border-secondary text-white text-center">
                                                                </div>
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-info w-100">Order
                                                                    Now</button>
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