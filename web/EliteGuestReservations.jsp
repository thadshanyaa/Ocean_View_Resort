<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Reservations | Elite Portal</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-guest.jspf" %>

                    <main class="elite-content">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h2 class="fw-bold mb-1">My <span class="text-gold">Reservations</span></h2>
                                <p class="text-white-50">Manage your past and upcoming luxury stays.</p>
                            </div>
                            <a href="elite-guest-portal?view=availability" class="btn elite-btn-primary">
                                <i class="fa-solid fa-plus me-2"></i> New Booking
                            </a>
                        </header>

                        <c:if test="${param.msg == 'success'}">
                            <div
                                class="alert alert-success bg-success bg-opacity-10 border-success border-opacity-25 text-success rounded-4 mb-5 p-4 animate__animated animate__fadeIn">
                                <i class="fa-solid fa-circle-check me-2"></i> <strong>Success!</strong> Your reservation
                                has been placed and is currently awaiting confirmation.
                            </div>
                        </c:if>

                        <div class="elite-card">
                            <c:choose>
                                <c:when test="${not empty reservations}">
                                    <div class="table-responsive">
                                        <table class="table table-dark elite-table">
                                            <thead>
                                                <tr class="text-white-50 small">
                                                    <th>Ref ID</th>
                                                    <th>Suite Type</th>
                                                    <th>Dates</th>
                                                    <th>Guests</th>
                                                    <th>Total Amount</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="res" items="${reservations}">
                                                    <tr>
                                                        <td class="fw-bold text-gold">${res.reservationNumber}</td>
                                                        <td>${res.roomType}</td>
                                                        <td>
                                                            <div class="small">
                                                                <fmt:formatDate value="${res.checkInDate}"
                                                                    pattern="MMM dd" /> -
                                                                <fmt:formatDate value="${res.checkOutDate}"
                                                                    pattern="MMM dd, yyyy" />
                                                            </div>
                                                        </td>
                                                        <td>${res.numberOfGuests}</td>
                                                        <td class="fw-bold font-monospace">LKR
                                                            <fmt:formatNumber value="${res.totalAmount}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="badge ${res.status == 'Pending' ? 'bg-warning' : 'bg-success'} bg-opacity-10 ${res.status == 'Pending' ? 'text-warning' : 'text-success'} border ${res.status == 'Pending' ? 'border-warning' : 'border-success'} border-opacity-25 px-3">
                                                                ${res.status}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <button
                                                                class="btn btn-outline-light btn-sm rounded-3 border-secondary"
                                                                title="View Details">
                                                                <i class="fa-solid fa-eye"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-5">
                                        <i class="fa-solid fa-box-open fa-4x text-white-25 mb-4"></i>
                                        <h4 class="fw-bold">No Records Found</h4>
                                        <p class="text-white-50 mb-4">You haven't made any reservations yet. Start your
                                            journey with us today.</p>
                                        <a href="elite-guest-portal?view=availability"
                                            class="btn elite-btn-primary px-4">Book Your First Stay</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>