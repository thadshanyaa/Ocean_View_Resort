<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, java.util.*, ovr.*" %>
        <%@ include file="header.jspf" %>
            <%@ taglib uri="jakarta.tags.core" prefix="c" %>
                <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                    <% if (request.getAttribute("bill")==null) {
                        response.sendRedirect("searchReservation.jsp?error=Access+Restricted.+Please+search+for+a+reservation+first.");
                        return; } %>

                        <style>
                            @media print {

                                /* Professional A4 Setup & Metadata Suppression */
                                @page {
                                    size: A4;
                                    margin: 0;
                                    /* Remove default browser headers/footers */
                                }

                                body {
                                    margin: 1.5cm;
                                    /* Content margin for standard A4 */
                                    background: #fff !important;
                                    color: #000 !important;
                                    -webkit-print-color-adjust: exact;
                                    print-color-adjust: exact;
                                }

                                /* Hide Web Elements */
                                .navbar,
                                footer,
                                .no-print,
                                .toast-container,
                                .navbar-glass,
                                #aos-styles {
                                    display: none !important;
                                }

                                /* Reset Invoice Card for High-Contrast Print */
                                #invoiceCard {
                                    position: static !important;
                                    width: 100% !important;
                                    margin: 0 !important;
                                    padding: 0 !important;
                                    background: #fff !important;
                                    color: #000 !important;
                                    border: none !important;
                                    box-shadow: none !important;
                                    backdrop-filter: none !important;
                                    -webkit-backdrop-filter: none !important;
                                }

                                /* Component Color & Visibility Overrides */
                                .text-light,
                                .text-neon,
                                .text-warning,
                                .text-info,
                                .text-success,
                                .text-danger {
                                    color: #000 !important;
                                }

                                .text-neon {
                                    font-weight: 800 !important;
                                }

                                .text-muted {
                                    color: #666 !important;
                                }

                                .table-dark {
                                    color: #000 !important;
                                    background: transparent !important;
                                }

                                .table-dark thead th,
                                .table-dark tbody td,
                                .table-dark tfoot td {
                                    border-color: #ddd !important;
                                    color: #000 !important;
                                }

                                .badge {
                                    border: 1px solid #000 !important;
                                    color: #000 !important;
                                    background: transparent !important;
                                }

                                /* Prevent logical breaks */
                                tr,
                                .row {
                                    page-break-inside: avoid;
                                }
                            }

                            /* Browser UI Tweaks */
                            #invoiceCard {
                                transition: none !important;
                                transform: none !important;
                            }
                        </style>

                        <div class="container py-5">
                            <div class="row justify-content-center">
                                <div class="col-lg-8" data-aos="fade-up">
                                    <div id="invoiceCard" class="glass-card p-5 bg-white bg-opacity-10 text-light">

                                        <c:if test="${not empty error}">
                                            <div class='alert alert-danger'>${error}</div>
                                        </c:if>
                                        <c:if test="${not empty bill}">

                                            <div
                                                class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom border-secondary">
                                                <div>
                                                    <h2 class="fw-bold m-0 text-neon"><i
                                                            class="fa-solid fa-water me-2"></i>Ocean
                                                        View Resort</h2>
                                                    <span class="text-muted small">123 Ocean Drive, Paradise Cove</span>
                                                </div>
                                                <div class="text-end">
                                                    <h4 class="text-uppercase fw-bold m-0 text-light">Invoice</h4>
                                                    <span class="text-muted small">#INV-
                                                        <fmt:formatNumber value="${bill.id}" pattern="000000" />
                                                    </span><br>
                                                    <span class="text-muted small">Date: ${bill.issuedAt}</span>
                                                </div>
                                            </div>

                                            <div class="row mb-5">
                                                <div class="col-6">
                                                    <p class="text-muted fw-bold mb-1 text-uppercase small">Billed To:
                                                    </p>
                                                    <h5 class="text-light m-0">${guest.fullName}</h5>
                                                    <div class="text-muted small mt-1">${guest.address}</div>
                                                    <div class="text-muted small">${guest.contactNumber}</div>
                                                </div>
                                                <div class="col-6 text-end">
                                                    <p class="text-muted fw-bold mb-1 text-uppercase small">Reservation
                                                        Ref:
                                                    </p>
                                                    <h6 class="text-warning">${res.reservationNumber}</h6>
                                                    <span
                                                        class="badge ${isFullyPaid ? 'bg-success' : 'bg-danger'} mt-2 fs-6">
                                                        ${isFullyPaid ? 'PAID IN FULL' : 'PAYMENT PENDING'}
                                                    </span>
                                                </div>
                                            </div>

                                            <table class="table table-dark table-borderless text-light mb-4"
                                                style="background: transparent;">
                                                <thead class="border-bottom border-secondary text-muted">
                                                    <tr>
                                                        <th>Description</th>
                                                        <th class="text-center">Nights</th>
                                                        <th class="text-end">Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="border-bottom border-secondary">
                                                    <tr>
                                                        <td>Room Stay Charge</td>
                                                        <td class="text-center">${bill.nights}</td>
                                                        <td class="text-end">LKR
                                                            <fmt:formatNumber value="${bill.subtotal}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                                <tfoot class="fw-bold">
                                                    <tr>
                                                        <td colspan="2" class="text-end text-muted fw-normal">Subtotal:
                                                        </td>
                                                        <td class="text-end">LKR
                                                            <fmt:formatNumber value="${bill.subtotal}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="text-end text-muted fw-normal">Tax:</td>
                                                        <td class="text-end">LKR
                                                            <fmt:formatNumber value="${bill.tax}" pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="text-end text-muted fw-normal">Service
                                                            Fee:
                                                        </td>
                                                        <td class="text-end">LKR
                                                            <fmt:formatNumber value="${bill.serviceFee}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="text-end text-info fs-5">Total Amount:
                                                        </td>
                                                        <td class="text-end text-info fs-5">LKR
                                                            <fmt:formatNumber value="${bill.totalAmount}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="text-end text-success">Amount Paid:</td>
                                                        <td class="text-end text-success">-LKR
                                                            <fmt:formatNumber value="${totalPaid}" pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            class="text-end text-danger fs-5 pt-3 border-top border-secondary">
                                                            Balance Due:</td>
                                                        <td
                                                            class="text-end text-danger fs-5 pt-3 border-top border-secondary">
                                                            LKR
                                                            <fmt:formatNumber value="${balanceDue}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>

                                            <!-- Action Buttons -->
                                            <div class="text-center mt-5 no-print">
                                                <c:if test="${canDownloadPdf}">
                                                    <button class="btn btn-outline-light me-2"
                                                        onclick="logAndPrint(${bill.id})"><i
                                                            class="fa-solid fa-file-pdf me-2"></i>Download PDF /
                                                        Print</button>
                                                </c:if>
                                                <c:if
                                                    test="${!canDownloadPdf and sessionScope.user.role == 'Receptionist'}">
                                                    <button class="btn btn-outline-secondary me-2" disabled
                                                        title="Only available for Offline payments"><i
                                                            class="fa-solid fa-file-pdf me-2"></i>Online PDF
                                                        Restricted</button>
                                                </c:if>

                                                <c:choose>
                                                    <c:when test="${!isFullyPaid}">
                                                        <a href="payments.jsp?billId=${bill.id}&due=${balanceDue}"
                                                            class="btn btn-neon px-4"><i
                                                                class="fa-solid fa-credit-card me-2"></i>Make
                                                            Payment</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="dashboard.jsp" class="btn btn-success px-4"><i
                                                                class="fa-solid fa-house me-2"></i>Return to
                                                            Dashboard</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <script>
                            function logAndPrint(billId) {
                                // First ping the server to log the PDF download operation
                                const formData = new URLSearchParams();
                                formData.append('action', 'logPrint');
                                formData.append('billId', billId);

                                fetch('BillingServlet', {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                    body: formData.toString()
                                }).finally(() => {
                                    // Trigger native secure print dialog after logging
                                    window.print();
                                });
                            }
                        </script>

                        <%@ include file="footer.jspf" %>