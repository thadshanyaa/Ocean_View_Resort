<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Master Reservations | Front Office</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <%@ include file="luxury-sidebar-staff.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-1">Master <span class="text-gold">Reservations</span></h1>
                                <p class="text-white-50">Global searchable database of all elite guest bookings.</p>
                            </div>
                            <div class="input-group w-auto">
                                <input type="text"
                                    class="form-control bg-dark border-white border-opacity-10 text-white"
                                    placeholder="Search Ref or Guest...">
                                <button class="btn btn-dark border-white border-opacity-10"><i
                                        class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </header>

                        <div class="lux-card">
                            <div class="table-responsive">
                                <table class="table table-dark lux-table align-middle">
                                    <thead>
                                        <tr>
                                            <th>Ref #</th>
                                            <th>Guest Identity</th>
                                            <th>Stay Context</th>
                                            <th>Financial Stake</th>
                                            <th>System Status</th>
                                            <th>Operations</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="res" items="${reservations}">
                                            <tr>
                                                <td class="fw-bold text-gold">${res.reservationNumber}</td>
                                                <td>
                                                    <div class="fw-bold">${res.guestName}</div>
                                                    <div class="small text-white-50">${res.guestEmail}</div>
                                                </td>
                                                <td>
                                                    <div class="small fw-bold">${res.roomType}</div>
                                                    <div class="small text-white-50">
                                                        <fmt:formatDate value="${res.checkIn}" pattern="dd MMM" /> -
                                                        <fmt:formatDate value="${res.checkOut}"
                                                            pattern="dd MMM, yyyy" />
                                                    </div>
                                                </td>
                                                <td class="font-monospace fw-bold">LKR
                                                    <fmt:formatNumber value="${res.totalAmount}" pattern="#,##0.00" />
                                                </td>
                                                <td>
                                                    <span
                                                        class="lux-badge ${res.status == 'Pending' ? 'lux-badge-pending' : 'lux-badge-success'}">
                                                        ${res.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-dark btn-sm rounded-3 border-secondary"
                                                            data-bs-toggle="dropdown">
                                                            <i class="fa-solid fa-ellipsis-vertical"></i>
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-dark">
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="fa-solid fa-check me-2"></i> Confirm
                                                                    Booking</a></li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="fa-solid fa-pen me-2"></i> Edit
                                                                    Details</a></li>
                                                            <li>
                                                                <hr class="dropdown-divider">
                                                            </li>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="fa-solid fa-trash me-2"></i> Cancel</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>