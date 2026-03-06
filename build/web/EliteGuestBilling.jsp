<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Billing & Payments | Elite Portal</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-guest.jspf" %>

                    <main class="elite-content">
                        <header class="mb-5">
                            <h2 class="fw-bold mb-1">Billing <span class="text-gold">& Payments</span></h2>
                            <p class="text-white-50">Securely manage your invoices and transaction history.</p>
                        </header>

                        <div class="row g-4 mb-5">
                            <div class="col-md-4">
                                <div class="elite-card h-100 border-start border-gold border-4">
                                    <div class="small text-white-50 mb-2">Total Outstanding</div>
                                    <h2 class="fw-bold text-gold">LKR 0.00</h2>
                                    <p class="small text-white-50 mb-0">All current invoices are settled.</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="elite-card h-100">
                                    <div class="small text-white-50 mb-2">Lifetime Spent</div>
                                    <h2 class="fw-bold">LKR 425,000</h2>
                                    <p class="small text-white-50 mb-0">Across 8 verified stays.</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="elite-card h-100">
                                    <div class="small text-white-50 mb-2">Active Method</div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="fa-brands fa-cc-visa fa-2x me-3 text-white-50"></i>
                                        <div>
                                            <div class="fw-bold">Visa Ending 4421</div>
                                            <div class="small text-white-50">Expires 12/26</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="elite-card">
                            <h5 class="fw-bold mb-4">Payment History</h5>
                            <div class="table-responsive">
                                <table class="table table-dark elite-table">
                                    <thead>
                                        <tr class="text-white-50 small">
                                            <th>Invoice #</th>
                                            <th>Description</th>
                                            <th>Date</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="res" items="${reservations}">
                                            <tr>
                                                <td class="text-gold fw-bold">INV-${res.reservationNumber}</td>
                                                <td>Room Booking: ${res.roomType}</td>
                                                <td>
                                                    <fmt:formatDate value="${res.createdAt}" pattern="dd MMM yyyy" />
                                                </td>
                                                <td class="font-monospace">LKR
                                                    <fmt:formatNumber value="${res.totalAmount}" pattern="#,##0.00" />
                                                </td>
                                                <td>
                                                    <span
                                                        class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 px-3">
                                                        Settled at Front
                                                    </span>
                                                </td>
                                                <td>
                                                    <button class="btn btn-outline-light btn-sm border-secondary"><i
                                                            class="fa-solid fa-file-pdf"></i></button>
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