<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Billing Ledger | Front Office</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <%@ include file="luxury-sidebar-staff.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-1">Billing <span class="text-gold">Ledger</span></h1>
                                <p class="text-white-50">Audit and verify financial settlements and guest folios.</p>
                            </div>
                            <button class="lux-btn lux-btn-outline"><i class="fa-solid fa-print me-2"></i> Daily
                                Report</button>
                        </header>

                        <div class="row g-4 mb-5">
                            <div class="col-md-4">
                                <div class="lux-card">
                                    <div class="small text-white-50 text-uppercase mb-1">Total Revenue (24h)</div>
                                    <h3 class="fw-bold text-gold">LKR 842,500.00</h3>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="lux-card">
                                    <div class="small text-white-50 text-uppercase mb-1">Pending Settlements</div>
                                    <h3 class="fw-bold text-cyan">LKR 125,400.00</h3>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="lux-card">
                                    <div class="small text-white-50 text-uppercase mb-1">Manual Verifications</div>
                                    <h3 class="fw-bold">02 Priority</h3>
                                </div>
                            </div>
                        </div>

                        <div class="lux-card">
                            <h5 class="fw-bold mb-4">Unsettled Guest Folios</h5>
                            <div class="table-responsive">
                                <table class="table table-dark lux-table align-middle">
                                    <thead>
                                        <tr>
                                            <th>Guest Name</th>
                                            <th>Reservation</th>
                                            <th>Room Base</th>
                                            <th>Service Extras</th>
                                            <th>Total Due</th>
                                            <th>Settlement Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="res" items="${reservations}">
                                            <c:if test="${res.status != 'Checked-Out'}">
                                                <tr>
                                                    <td class="fw-bold">${res.guestName}</td>
                                                    <td class="text-gold fw-bold small">${res.reservationNumber}</td>
                                                    <td>LKR
                                                        <fmt:formatNumber value="${res.totalAmount}"
                                                            pattern="#,##0.00" />
                                                    </td>
                                                    <td>LKR 0.00</td>
                                                    <td class="fw-bold">LKR
                                                        <fmt:formatNumber value="${res.totalAmount}"
                                                            pattern="#,##0.00" />
                                                    </td>
                                                    <td>
                                                        <button class="lux-btn lux-btn-gold py-1 px-3 small"
                                                            onclick="alert('Folio generated for ${res.guestName}. Redirecting to POS sequence...')">Settle</button>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${empty reservations}">
                                            <tr>
                                                <td colspan="6" class="text-center py-5 text-white-50">No active billing
                                                    cycles.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>