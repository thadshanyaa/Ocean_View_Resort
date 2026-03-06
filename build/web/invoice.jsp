<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Receipt - ${reservation.reservationNumber}</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700;800&family=Playfair+Display:wght@700&display=swap"
                    rel="stylesheet">

                <style>
                    :root {
                        --ocean-primary: #0a192f;
                        --ocean-accent: #0ea5e9;
                        --receipt-text: #1e293b;
                        --receipt-muted: #64748b;
                    }

                    body {
                        background: #f1f5f9;
                        font-family: 'Montserrat', sans-serif;
                        color: var(--receipt-text);
                        padding: 40px 0;
                    }

                    .receipt-container {
                        max-width: 850px;
                        margin: auto;
                        background: white;
                        border-radius: 0;
                        /* Clean edge for printing */
                        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                        position: relative;
                        overflow: hidden;
                        padding: 60px;
                    }

                    .receipt-border-top {
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 8px;
                        background: linear-gradient(90deg, var(--ocean-primary), var(--ocean-accent));
                    }

                    .brand-header {
                        font-family: 'Playfair Display', serif;
                        font-size: 2.2rem;
                        color: var(--ocean-primary);
                        letter-spacing: 1px;
                        margin-bottom: 5px;
                    }

                    .receipt-label {
                        font-size: 0.8rem;
                        text-transform: uppercase;
                        letter-spacing: 1.5px;
                        color: var(--receipt-muted);
                        font-weight: 700;
                        margin-bottom: 5px;
                    }

                    .data-point {
                        font-weight: 600;
                        color: var(--receipt-text);
                    }

                    .table-custom {
                        margin-top: 40px;
                    }

                    .table-custom thead {
                        background: #f8fafc;
                    }

                    .table-custom th {
                        border: none;
                        padding: 15px;
                        font-size: 0.85rem;
                        color: var(--receipt-muted);
                        text-transform: uppercase;
                    }

                    .table-custom td {
                        padding: 20px 15px;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .total-wrapper {
                        margin-top: 40px;
                        padding: 30px;
                        background: #f8fafc;
                        border-radius: 12px;
                    }

                    .grand-total {
                        font-size: 2rem;
                        font-weight: 800;
                        color: var(--ocean-primary);
                    }

                    .paid-stamp {
                        position: absolute;
                        top: 150px;
                        right: 100px;
                        border: 5px solid #10b981;
                        color: #10b981;
                        padding: 10px 30px;
                        font-size: 2.5rem;
                        font-weight: 900;
                        text-transform: uppercase;
                        transform: rotate(-15deg);
                        opacity: 0.2;
                        border-radius: 15px;
                        pointer-events: none;
                    }

                    .no-print {
                        margin-bottom: 20px;
                        display: flex;
                        justify-content: center;
                        gap: 15px;
                    }

                    @media print {
                        body {
                            background: white;
                            padding: 0;
                        }

                        .receipt-container {
                            box-shadow: none;
                            width: 100%;
                            max-width: 100%;
                            border: none;
                        }

                        .no-print {
                            display: none;
                        }

                        .paid-stamp {
                            opacity: 0.3;
                        }
                    }
                </style>
            </head>

            <body>

                <div class="no-print">
                    <button onclick="window.print()" class="btn btn-dark btn-lg shadow-sm">
                        <i class="fa-solid fa-print me-2"></i> Print Receipt
                    </button>
                    <button onclick="history.back()" class="btn btn-outline-secondary btn-lg shadow-sm">
                        <i class="fa-solid fa-arrow-left me-2"></i> Return
                    </button>
                </div>

                <div class="receipt-container">
                    <div class="receipt-border-top"></div>

                    <div class="paid-stamp">PAID</div>

                    <div class="row mb-5">
                        <div class="col-7">
                            <div class="brand-header">OceanView Resort</div>
                            <p class="text-muted small mb-0">Elite Coastal Living & Luxury Stays</p>
                            <p class="text-muted small">Marine Drive, Southern Coast, Sri Lanka</p>
                        </div>
                        <div class="col-5 text-end">
                            <h3 class="fw-bold text-dark">OFFICIAL RECEIPT</h3>
                            <div class="receipt-label">Invoice Reference</div>
                            <div class="data-point">#INV-${bill.id} / ${reservation.reservationNumber}</div>
                            <div class="receipt-label mt-3">Issue Date</div>
                            <div class="data-point">
                                <fmt:formatDate value="${now}" pattern="dd MMMM yyyy" />
                            </div>
                        </div>
                    </div>

                    <div class="row mb-5">
                        <div class="col-6">
                            <div class="receipt-label">Guest Information</div>
                            <div class="data-point fs-5">${guest.fullName}</div>
                            <div class="text-muted small">${guest.contactNumber}</div>
                            <div class="text-muted small">${guest.address}</div>
                        </div>
                        <div class="col-6 text-end">
                            <div class="receipt-label">Stay Period</div>
                            <div class="data-point">
                                <fmt:formatDate value="${reservation.checkIn}" pattern="dd MMM" /> -
                                <fmt:formatDate value="${reservation.checkOut}" pattern="dd MMM yyyy" />
                            </div>
                            <div class="text-muted small mb-2">${bill.nights} Night(s) Accommodation</div>
                            <div class="receipt-label">Room Allocation</div>
                            <div class="data-point">${room.roomNumber} (${roomType.typeName})</div>
                        </div>
                    </div>

                    <table class="table table-custom">
                        <thead>
                            <tr>
                                <th>Service Description</th>
                                <th class="text-center">Rate</th>
                                <th class="text-center">Qty/Nights</th>
                                <th class="text-end">Total (LKR)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Room Charge -->
                            <tr>
                                <td>
                                    <div class="fw-bold">Suite Accommodation</div>
                                    <div class="text-muted small">Standard Resort Stay</div>
                                </td>
                                <td class="text-center">
                                    <fmt:formatNumber value="${bill.subtotal / bill.nights}" type="number" />
                                </td>
                                <td class="text-center">${bill.nights}</td>
                                <td class="text-end fw-bold">
                                    <fmt:formatNumber value="${bill.subtotal}" type="number" />
                                </td>
                            </tr>

                            <!-- Additional Charges -->
                            <c:if test="${not empty charges}">
                                <c:forEach var="chk" items="${charges}">
                                    <tr>
                                        <td>
                                            <div class="fw-bold">${chk.itemName}</div>
                                            <div class="text-muted small">${chk.category}</div>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatNumber value="${chk.unitPrice}" type="number" />
                                        </td>
                                        <td class="text-center">${chk.qty}</td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber value="${chk.totalPrice}" type="number" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>

                    <div class="row">
                        <div class="col-md-5">
                            <div class="mt-4 p-3 border-start border-4 border-info bg-light small">
                                <h6 class="fw-bold">Note:</h6>
                                This is a computer-generated receipt for your records. No physical signature is
                                required. We hope you enjoyed your time with us at OceanView Resort.
                            </div>
                        </div>
                        <div class="col-md-6 offset-md-1">
                            <div class="total-wrapper">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Subtotal (Inclusive Add-ons)</span>
                                    <span class="fw-bold">LKR
                                        <fmt:formatNumber value="${bill.subtotal + additionalTotal}" type="number" />
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Levy & Taxes (10%)</span>
                                    <span class="fw-bold">LKR
                                        <fmt:formatNumber value="${bill.tax}" type="number" />
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between mb-3 pb-3 border-bottom">
                                    <span class="text-muted">Service Component</span>
                                    <span class="fw-bold">LKR
                                        <fmt:formatNumber value="${bill.serviceFee}" type="number" />
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="fw-bold fs-5">Amount Settled</div>
                                    <div class="grand-total">LKR
                                        <fmt:formatNumber value="${grandTotal}" type="number" />
                                    </div>
                                </div>
                            </div>
                            <div class="text-end mt-2">
                                <small class="text-success fw-bold"><i class="fa-solid fa-shield-halved me-1"></i>
                                    Verified Merchant Transaction</small>
                            </div>
                        </div>
                    </div>

                    <div class="mt-5 text-center text-muted border-top pt-4">
                        <p class="small mb-0">Follow us on Social Media @OceanViewResort</p>
                        <p class="small">www.oceanviewresort.com | support@oceanviewresort.com</p>
                    </div>
                </div>

            </body>

            </html>