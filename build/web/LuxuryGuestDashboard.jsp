<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Guest Dashboard | Ocean View Luxury</title>
                <!-- Bootstrap & Icons -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <div class="lux-bg-glow" style="top: -100px; right: -100px;"></div>
                <div class="lux-bg-glow"
                    style="bottom: -100px; left: -100px; background: radial-gradient(circle, rgba(6, 182, 212, 0.05) 0%, transparent 70%);">
                </div>

                <%@ include file="luxury-sidebar-guest.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-0">Welcome back, <span class="text-gold">${user.username}</span>
                                </h1>
                                <p class="text-white-50">Your requested luxury sanctuary at Ocean View Resort is ready.
                                </p>
                            </div>
                            <div class="d-flex align-items-center gap-3 glass-card p-2 px-3">
                                <div class="text-end">
                                    <div class="fw-bold text-white">Elite Member</div>
                                    <div class="small text-gold"><i class="fa-solid fa-star small"></i> 4,250 Points
                                    </div>
                                </div>
                                <div class="rounded-circle bg-gold text-navy p-2 d-flex align-items-center justify-content-center"
                                    style="width: 48px; height: 48px; box-shadow: 0 0 15px rgba(234, 179, 8, 0.4);">
                                    <i class="fa-solid fa-crown"></i>
                                </div>
                            </div>
                        </header>

                        <!-- KPI Cards -->
                        <div class="row g-4 mb-5">
                            <div class="col-md-3">
                                <div class="lux-card text-center">
                                    <div class="text-white-50 small text-uppercase mb-2">Upcoming Stays</div>
                                    <h2 class="fw-bold mb-0">02</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card text-center">
                                    <div class="text-white-50 small text-uppercase mb-2">Service Requests</div>
                                    <h2 class="fw-bold mb-0 text-cyan">01</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card text-center">
                                    <div class="text-white-50 small text-uppercase mb-2">Unpaid Dues</div>
                                    <h2 class="fw-bold mb-0">LKR 0.00</h2>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card text-center"
                                    style="background: var(--lux-gold-dim); border-color: var(--lux-gold);">
                                    <div class="text-navy small text-uppercase mb-2 fw-bold">Member Tier</div>
                                    <h2 class="fw-bold mb-0 text-gold">ELITE</h2>
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <!-- Recent Activity -->
                            <div class="col-lg-8">
                                <div class="lux-card h-100">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h4 class="fw-bold mb-0"><i
                                                class="fa-solid fa-clock-rotate-left text-gold me-2"></i> Recent
                                            Activity</h4>
                                        <a href="luxury-guest-portal?view=reservations"
                                            class="text-gold small text-decoration-none">View All History</a>
                                    </div>

                                    <c:choose>
                                        <c:when test="${not empty recentStays}">
                                            <div class="table-responsive">
                                                <table class="table table-dark lux-table m-0">
                                                    <thead>
                                                        <tr>
                                                            <th>Ref #</th>
                                                            <th>Resort Suite</th>
                                                            <th>Arrival</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="res" items="${recentStays}" end="4">
                                                            <tr>
                                                                <td class="fw-bold text-gold">${res.reservationNumber}
                                                                </td>
                                                                <td>${res.roomType}</td>
                                                                <td>
                                                                    <fmt:formatDate value="${res.checkIn}"
                                                                        pattern="dd MMM yyyy" />
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="lux-badge ${res.status == 'Pending' ? 'lux-badge-pending' : 'lux-badge-success'}">
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
                                                <i class="fa-solid fa-hotel fa-3x text-white-25 mb-3"></i>
                                                <p class="text-white-50">You have no recorded stays at this time.</p>
                                                <a href="luxury-guest-portal?view=reservations"
                                                    class="lux-btn lux-btn-gold">Plan Your First Stay</a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Quick Actions & Offers -->
                            <div class="col-lg-4">
                                <div class="lux-card mb-4 bg-gradient"
                                    style="background: linear-gradient(135deg, rgba(234, 179, 8, 0.1) 0%, rgba(15, 23, 42, 0.9) 100%);">
                                    <h5 class="fw-bold mb-3 text-gold">Exclusive Offer</h5>
                                    <p class="small text-white-50 mb-4">Upgrade to the Azure Penthouse this weekend and
                                        receive a private yacht excursion for two.</p>
                                    <button class="lux-btn lux-btn-gold w-100">Claim Upgrade</button>
                                </div>

                                <div class="lux-card">
                                    <h5 class="fw-bold mb-4">Express Services</h5>
                                    <div class="d-grid gap-3">
                                        <a href="luxury-guest-portal?view=services"
                                            class="lux-btn lux-btn-outline w-100">
                                            <i class="fa-solid fa-bell-concierge"></i> Order Room Service
                                        </a>
                                        <a href="luxury-guest-portal?view=payments"
                                            class="lux-btn lux-btn-outline w-100">
                                            <i class="fa-solid fa-receipt"></i> Settle Account
                                        </a>
                                        <a href="luxury-guest-portal?view=menu" class="lux-btn lux-btn-outline w-100">
                                            <i class="fa-solid fa-utensils"></i> View Dining Menu
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Resort Highlights -->
                        <div class="mt-5">
                            <h4 class="fw-bold mb-4">Current Resort Highlights</h4>
                            <div class="row g-4">
                                <div class="col-md-4">
                                    <div class="lux-card p-0 overflow-hidden border-0">
                                        <img src="https://images.unsplash.com/photo-1544161515-436cefb65794?auto=format&fit=crop&w=800&q=80"
                                            class="w-100" style="height: 200px; object-fit: cover; opacity: 0.6;">
                                        <div class="p-4">
                                            <h6 class="fw-bold text-gold">Eternal Wellness Spa</h6>
                                            <p class="small text-white-50 mb-0">Experience traditional Ayurvedic
                                                rejuvenation.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="lux-card p-0 overflow-hidden border-0">
                                        <img src="https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80"
                                            class="w-100" style="height: 200px; object-fit: cover; opacity: 0.6;">
                                        <div class="p-4">
                                            <h6 class="fw-bold text-gold">Horizon Deck Lounge</h6>
                                            <p class="small text-white-50 mb-0">Sunset cocktails with 360-degree ocean
                                                views.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="lux-card p-0 overflow-hidden border-0">
                                        <img src="https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=800&q=80"
                                            class="w-100" style="height: 200px; object-fit: cover; opacity: 0.6;">
                                        <div class="p-4">
                                            <h6 class="fw-bold text-gold">Blue Horizon Grill</h6>
                                            <p class="small text-white-50 mb-0">Fresh seafood caught daily and grilled
                                                to perfection.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>