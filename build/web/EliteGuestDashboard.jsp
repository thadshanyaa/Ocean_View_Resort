<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Elite Dashboard | Ocean View Resort</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-guest.jspf" %>

                    <main class="elite-content">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h2 class="fw-bold mb-0">Welcome Back, <span class="text-gold">${user.username}</span>
                                </h2>
                                <p class="text-white-50">Explore your elite resort privileges and managed stays.</p>
                            </div>
                            <div class="elite-card py-2 px-4 d-flex align-items-center">
                                <i class="fa-solid fa-crown text-gold me-3 fa-lg"></i>
                                <div>
                                    <div class="small text-white-50">Member Status</div>
                                    <div class="fw-bold">Platinum Elite</div>
                                </div>
                            </div>
                        </header>

                        <div class="row g-4 mb-5">
                            <div class="col-md-3">
                                <div class="elite-card text-center">
                                    <div class="text-white-50 small mb-1">Active Stays</div>
                                    <h2 class="fw-bold text-gold mb-0">01</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="elite-card text-center">
                                    <div class="text-white-50 small mb-1">Total Bookings</div>
                                    <h2 class="fw-bold text-gold mb-0">08</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="elite-card text-center">
                                    <div class="text-white-50 small mb-1">Loyalty Points</div>
                                    <h2 class="fw-bold text-gold mb-0">4,250</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="elite-card text-center">
                                    <div class="text-white-50 small mb-1">Unpaid Balance</div>
                                    <h2 class="fw-bold text-gold mb-0">LKR 0.00</h2>
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-lg-8">
                                <div class="elite-card h-100">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h5 class="fw-bold m-0"><i
                                                class="fa-solid fa-clock-rotate-left text-gold me-2"></i> Recent
                                            Activity</h5>
                                        <a href="elite-guest-portal?view=reservations"
                                            class="text-gold small text-decoration-none">View All</a>
                                    </div>

                                    <c:choose>
                                        <c:when test="${not empty reservations}">
                                            <div class="table-responsive">
                                                <table class="table table-dark elite-table">
                                                    <thead>
                                                        <tr class="text-white-50 small">
                                                            <th>Ref #</th>
                                                            <th>Room Type</th>
                                                            <th>Date</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="res" items="${reservations}" end="4">
                                                            <tr>
                                                                <td class="fw-bold">${res.reservationNumber}</td>
                                                                <td>${res.roomType}</td>
                                                                <td>
                                                                    <fmt:formatDate value="${res.checkInDate}"
                                                                        pattern="dd MMM yyyy" />
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="badge ${res.status == 'Pending' ? 'bg-warning' : 'bg-success'} bg-opacity-10 ${res.status == 'Pending' ? 'text-warning' : 'text-success'} border ${res.status == 'Pending' ? 'border-warning' : 'border-success'} border-opacity-25 px-3">
                                                                        ${res.status}
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-5">
                                                <i class="fa-solid fa-calendar-xmark fa-3x text-white-25 mb-3"></i>
                                                <p class="text-white-50">No recent reservations found.</p>
                                                <a href="elite-guest-portal?view=availability"
                                                    class="btn elite-btn-primary btn-sm">Make your first booking</a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="elite-card mb-4"
                                    style="background: linear-gradient(135deg, rgba(234, 179, 8, 0.1), rgba(15, 23, 42, 0.9));">
                                    <h5 class="fw-bold mb-3">Resort Promotion</h5>
                                    <p class="small text-white-50 mb-4">Book a Spa suite this weekend and receive a
                                        complimentary 3-course dinner at the Blue Horizon grill.</p>
                                    <button class="btn elite-btn-primary w-100">Claim Offer</button>
                                </div>

                                <div class="elite-card">
                                    <h5 class="fw-bold mb-3">Quick Actions</h5>
                                    <div class="d-grid gap-2">
                                        <a href="elite-guest-portal?view=availability"
                                            class="btn btn-outline-light border-secondary text-start p-3 rounded-4">
                                            <i class="fa-solid fa-plus-circle text-gold me-2"></i> New Reservation
                                        </a>
                                        <a href="elite-guest-portal?view=billing"
                                            class="btn btn-outline-light border-secondary text-start p-3 rounded-4">
                                            <i class="fa-solid fa-receipt text-gold me-2"></i> Pay Bills
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>