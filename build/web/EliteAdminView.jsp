<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Admin - Elite Reservation Control</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-staff.jspf" %>

                    <main class="elite-content">
                        <header class="mb-5">
                            <h2 class="fw-bold mb-1">Elite <span class="text-gold">Admin Oversight</span></h2>
                            <p class="text-white-50">Complete visibility across all guest-facing luxury reservations.
                            </p>
                        </header>

                        <div class="elite-card">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="fw-bold m-0 text-gold">Master Reservation List</h5>
                                <span
                                    class="badge bg-gold bg-opacity-10 text-gold border border-gold border-opacity-25 px-3 py-2">System
                                    Wide</span>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-dark elite-table">
                                    <thead>
                                        <tr class="text-white-50 small">
                                            <th>Ref #</th>
                                            <th>Guest Details</th>
                                            <th>Stay Context</th>
                                            <th>Financials</th>
                                            <th>System Status</th>
                                            <th>Actions</th>
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
                                                        <fmt:formatDate value="${res.checkInDate}" pattern="MMM dd" /> -
                                                        <fmt:formatDate value="${res.checkOutDate}" pattern="MMM dd" />
                                                    </div>
                                                </td>
                                                <td class="font-monospace fw-bold">LKR
                                                    <fmt:formatNumber value="${res.totalAmount}" pattern="#,##0.00" />
                                                </td>
                                                <td>
                                                    <span
                                                        class="badge ${res.status == 'Pending' ? 'bg-warning' : 'bg-success'} bg-opacity-10 ${res.status == 'Pending' ? 'text-warning' : 'text-success'} border ${res.status == 'Pending' ? 'border-warning' : 'border-success'} border-opacity-25">
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
                                                                        class="fa-solid fa-check me-2"></i> Confirm</a>
                                                            </li>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="fa-solid fa-trash me-2"></i> Delete</a>
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