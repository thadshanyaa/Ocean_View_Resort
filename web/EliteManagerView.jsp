<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manager - Elite Performance Hub</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-staff.jspf" %>

                    <main class="elite-content">
                        <header class="mb-5">
                            <h2 class="fw-bold mb-1">Elite <span class="text-gold">Operational Hub</span></h2>
                            <p class="text-white-50">Strategic data overview of luxury reservations and guest volume.
                            </p>
                        </header>

                        <div class="row g-4 mb-5">
                            <div class="col-md-3">
                                <div class="elite-card h-100">
                                    <i class="fa-solid fa-chart-line text-gold mb-3 fa-2x"></i>
                                    <h5 class="fw-bold">12.5% Gain</h5>
                                    <p class="small text-white-50 mb-0">Elite Volume Growth</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="elite-card h-100">
                                    <i class="fa-solid fa-users text-gold mb-3 fa-2x"></i>
                                    <h5 class="fw-bold">42 Guests</h5>
                                    <p class="small text-white-50 mb-0">Monthly Luxury Traffic</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="elite-card h-100">
                                    <i class="fa-solid fa-star text-gold mb-3 fa-2x"></i>
                                    <h5 class="fw-bold">98% Satisfy</h5>
                                    <p class="small text-white-50 mb-0">Elite Guest Feedback</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="elite-card h-100">
                                    <i class="fa-solid fa-shield-heart text-gold mb-3 fa-2x"></i>
                                    <h5 class="fw-bold">Active Station</h5>
                                    <p class="small text-white-50 mb-0">Network Operational</p>
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="elite-card">
                                    <h5 class="fw-bold mb-4">Tactical Reservation Feed</h5>
                                    <div class="table-responsive">
                                        <table class="table table-dark elite-table">
                                            <thead>
                                                <tr class="text-white-50 small">
                                                    <th>Ref</th>
                                                    <th>Guest</th>
                                                    <th>Room Scope</th>
                                                    <th>Volume Analysis</th>
                                                    <th>Logistics Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="res" items="${reservations}">
                                                    <tr>
                                                        <td class="text-gold">${res.reservationNumber}</td>
                                                        <td class="fw-bold">${res.guestName}</td>
                                                        <td>${res.roomType}</td>
                                                        <td>
                                                            <div class="progress bg-white bg-opacity-5"
                                                                style="height: 6px;">
                                                                <div class="progress-bar bg-gold" style="width: 75%">
                                                                </div>
                                                            </div>
                                                            <small
                                                                class="text-white-50 mt-1 d-block">${res.numberOfGuests}
                                                                Guests</small>
                                                        </td>
                                                        <td>
                                                            <span class="text-gold"><i
                                                                    class="fa-solid fa-circle-dot me-1"></i> Tracking
                                                                Active</span>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>