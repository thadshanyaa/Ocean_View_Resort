<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Front Office Command | Ocean View Resort</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <div class="lux-bg-glow"
                    style="top: -100px; left: -100px; background: radial-gradient(circle, rgba(6, 182, 212, 0.05) 0%, transparent 70%);">
                </div>

                <%@ include file="luxury-sidebar-staff.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-0">Command <span class="text-gold">Center</span></h1>
                                <p class="text-white-50">Real-time operational overview of resort logistics and guest
                                    services.</p>
                            </div>
                            <div class="text-end">
                                <div class="h4 fw-bold m-0" id="liveTime">00:00:00</div>
                                <div class="small text-gold text-uppercase letter-spacing-1">Station 01 Active</div>
                            </div>
                        </header>

                        <!-- Operational Counters -->
                        <div class="row g-4 mb-5">
                            <div class="col-md-3">
                                <div class="lux-card border-gold border-opacity-25 bg-gold bg-opacity-5">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h2 class="fw-bold mb-0">12</h2>
                                            <div class="small text-white-50 text-uppercase">Arrivals Today</div>
                                        </div>
                                        <i class="fa-solid fa-plane-arrival fa-2x text-gold opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h2 class="fw-bold mb-0">08</h2>
                                            <div class="small text-white-50 text-uppercase">Departures Today</div>
                                        </div>
                                        <i class="fa-solid fa-plane-departure fa-2x text-white-50 opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h2 class="fw-bold mb-0">42</h2>
                                            <div class="small text-white-50 text-uppercase">Rooms Occupied</div>
                                        </div>
                                        <i class="fa-solid fa-key fa-2x text-cyan opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card border-cyan border-opacity-25 bg-cyan bg-opacity-5">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h2 class="fw-bold mb-0 text-cyan">05</h2>
                                            <div class="small text-white-50 text-uppercase">Urgent Requests</div>
                                        </div>
                                        <i class="fa-solid fa-bell fa-2x text-cyan opacity-25"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <!-- arrivals/departures feed -->
                            <div class="col-lg-7">
                                <div class="lux-card h-100">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h5 class="fw-bold mb-0"><i class="fa-solid fa-list-check text-gold me-2"></i>
                                            Immediate Actions</h5>
                                        <a href="front-office-portal?view=operations"
                                            class="small text-gold text-decoration-none">Full Manifest</a>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-dark lux-table m-0">
                                            <thead>
                                                <tr class="small text-white-50">
                                                    <th>Guest</th>
                                                    <th>Suite</th>
                                                    <th>Ref ID</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="res" items="${reservations}" end="5">
                                                    <tr>
                                                        <td>
                                                            <div class="fw-bold">${res.guestName}</div>
                                                            <div class="small text-white-50">${res.guestPhone}</div>
                                                        </td>
                                                        <td>${res.roomType}</td>
                                                        <td class="text-gold fw-bold">${res.reservationNumber}</td>
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
                                </div>
                            </div>

                            <!-- Service Queue -->
                            <div class="col-lg-5">
                                <div class="lux-card h-100">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h5 class="fw-bold mb-0"><i class="fa-solid fa-headset text-cyan me-2"></i>
                                            Active Requests</h5>
                                        <a href="front-office-portal?view=requests"
                                            class="small text-cyan text-decoration-none">Queue Manager</a>
                                    </div>

                                    <div class="d-flex flex-column gap-3">
                                        <c:forEach var="req" items="${requests}" end="3">
                                            <div
                                                class="p-3 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <div class="fw-bold text-gold">${req.serviceType}</div>
                                                    <span class="small text-white-50 mt-1">${req.roomNumber}</span>
                                                </div>
                                                <p class="small text-white-dim mb-2 text-truncate">${req.details}</p>
                                                <div class="d-flex justify-content-between align-items-center mt-3">
                                                    <div class="small text-white-50">
                                                        <fmt:formatDate value="${req.requestedAt}" pattern="HH:mm" />
                                                    </div>
                                                    <button
                                                        class="btn btn-sm btn-outline-gold py-1 px-3 fs-tiny">Dispatch</button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty requests}">
                                            <div class="text-center py-5 opacity-25">
                                                <i class="fa-solid fa-check-double fa-3x mb-3"></i>
                                                <p>No pending service alerts.</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        function updateTime() {
                            const now = new Date();
                            document.getElementById('liveTime').innerText = now.toLocaleTimeString();
                        }
                        setInterval(updateTime, 1000);
                        updateTime();
                    </script>
            </body>

            </html>