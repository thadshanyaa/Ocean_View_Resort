<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Station Manifest | Front Office</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <%@ include file="luxury-sidebar-staff.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-1">Station <span class="text-gold">Manifest</span></h1>
                                <p class="text-white-50">Priority arrivals and departures for today's operational cycle.
                                </p>
                            </div>
                            <div class="btn-group">
                                <button class="lux-btn lux-btn-gold py-2 px-3">Arrivals</button>
                                <button class="lux-btn lux-btn-outline py-2 px-3">Departures</button>
                            </div>
                        </header>

                        <div class="row g-4 mb-5">
                            <div class="col-lg-6">
                                <div class="lux-card border-gold border-opacity-25">
                                    <h5 class="fw-bold mb-4 text-gold"><i class="fa-solid fa-plane-arrival me-2"></i>
                                        Priority Arrivals</h5>
                                    <div class="d-flex flex-column gap-3">
                                        <c:forEach var="res" items="${reservations}">
                                            <c:if test="${res.status == 'Pending' || res.status == 'Confirmed'}">
                                                <div
                                                    class="p-3 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="fw-bold">${res.guestName}</div>
                                                        <div class="small text-white-50">${res.roomType} |
                                                            ${res.reservationNumber}</div>
                                                    </div>
                                                    <button class="lux-btn lux-btn-gold py-1 px-4 small"
                                                        onclick="alert('Check-in sequence initiated for ${res.guestName}')">Check-In</button>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty reservations}">
                                            <p class="text-center text-white-50 my-4">No scheduled arrivals.</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="lux-card border-cyan border-opacity-25">
                                    <h5 class="fw-bold mb-4 text-cyan"><i class="fa-solid fa-plane-departure me-2"></i>
                                        Scheduled Departures</h5>
                                    <div class="d-flex flex-column gap-3">
                                        <c:forEach var="res" items="${reservations}">
                                            <c:if test="${res.status == 'Checked-In'}">
                                                <div
                                                    class="p-3 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="fw-bold">${res.guestName}</div>
                                                        <div class="small text-white-50">Room Assigned |
                                                            ${res.reservationNumber}</div>
                                                    </div>
                                                    <button
                                                        class="lux-btn lux-btn-outline py-1 px-4 small border-cyan text-cyan"
                                                        onclick="alert('Settlement required before check-out for ${res.guestName}')">Check-Out</button>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty reservations}">
                                            <p class="text-center text-white-50 my-4">No scheduled departures.</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="lux-card bg-navy border-white border-opacity-5">
                            <h6 class="fw-bold text-white-50 mb-3 text-uppercase small">Station Activity Log</h6>
                            <div class="small text-white-dim">
                                <div class="mb-2"><span class="text-gold">[14:02]</span> Guest ID LUX-A281 checked in to
                                    Azure Penthouse.</div>
                                <div class="mb-2"><span class="text-gold">[13:45]</span> Housekeeping cleared Room 402
                                    for immediate arrival.</div>
                                <div class=""><span class="text-gold">[12:10]</span> Manager override applied to
                                    reservation LUX-C992.</div>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>