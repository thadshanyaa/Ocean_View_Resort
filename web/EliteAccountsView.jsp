<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Accounts - Elite Revenue Monitoring</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-staff.jspf" %>

                    <main class="elite-content">
                        <header class="mb-5">
                            <h2 class="fw-bold mb-1">Elite <span class="text-gold">Financial Ledger</span></h2>
                            <p class="text-white-50">Monitoring billing cycles and transaction amounts for luxury
                                bookings.</p>
                        </header>

                        <div class="elite-card mb-5 bg-gold bg-opacity-5">
                            <div class="row align-items-center">
                                <div class="col-md-3 border-end border-white border-opacity-10">
                                    <div class="small text-white-50">Total Potential Revenue</div>
                                    <h3 class="fw-bold text-gold m-0">LKR 1,840,000</h3>
                                </div>
                                <div class="col-md-3 border-end border-white border-opacity-10 ps-md-4">
                                    <div class="small text-white-50">Average Transaction</div>
                                    <h3 class="fw-bold m-0">LKR 92,000</h3>
                                </div>
                                <div class="col-md-6 text-end">
                                    <button class="btn elite-btn-primary"><i class="fa-solid fa-file-excel me-2"></i>
                                        Export Financials</button>
                                </div>
                            </div>
                        </div>

                        <div class="elite-card">
                            <h5 class="fw-bold mb-4">Elite Billing Status</h5>
                            <div class="table-responsive">
                                <table class="table table-dark elite-table">
                                    <thead>
                                        <tr class="text-white-50 small">
                                            <th>Invoice Ref</th>
                                            <th>Guest Account</th>
                                            <th>Stay Value</th>
                                            <th>Payment Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="res" items="${reservations}">
                                            <tr>
                                                <td class="fw-bold">INV-${res.reservationNumber}</td>
                                                <td>${res.guestName}</td>
                                                <td class="font-monospace fw-bold">LKR
                                                    <fmt:formatNumber value="${res.totalAmount}" pattern="#,##0.00" />
                                                </td>
                                                <td>
                                                    <span
                                                        class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 px-3">
                                                        DUE AT CHECK-OUT
                                                    </span>
                                                </td>
                                                <td>
                                                    <button class="btn btn-outline-gold btn-sm"><i
                                                            class="fa-solid fa-receipt me-1"></i> Preview</button>
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