<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, java.util.*, ovr.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ include file="header.jspf" %>

                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-8" data-aos="fade-up">

                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger bg-dark border-danger shadow text-start mx-auto p-3 mb-4 rounded d-flex align-items-center"
                                    style="max-width: 800px;">
                                    <i class="fa-solid fa-triangle-exclamation fa-2x text-danger me-3"></i>
                                    <div>
                                        <h6 class="text-danger fw-bold mb-1">Payment Failed</h6>
                                        <p class="mb-0 text-light small">
                                            <c:out value="${param.error}" />
                                        </p>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Title & Success Message -->
                            <div class="text-center mb-4">
                                <div class="d-inline-flex align-items-center justify-content-center bg-success bg-opacity-10 text-success rounded-circle mb-3 shadow-sm border border-success"
                                    style="width: 80px; height: 80px;">
                                    <i class="fa-solid fa-check-circle fa-3x"></i>
                                </div>
                                <h2 class="text-white fw-bold">Booking Confirmed!</h2>
                                <p class="text-light-50">Your reservation has been successfully placed. Here are your
                                    details.</p>
                            </div>

                            <!-- Main Reservation Card -->
                            <div class="glass-card p-4 p-md-5 mx-auto border-top border-info border-3">
                                <div class="row g-4 mb-4">
                                    <div
                                        class="col-md-6 border-end border-secondary border-opacity-50 text-center text-md-start">
                                        <small class="text-info fw-bold text-uppercase d-block mb-1">Reservation
                                            No</small>
                                        <h4 class="text-white m-0">
                                            <c:out
                                                value="${empty res.reservationNumber ? 'N/A' : res.reservationNumber}" />
                                        </h4>
                                    </div>
                                    <div class="col-md-6 text-center text-md-start ps-md-4">
                                        <small class="text-info fw-bold text-uppercase d-block mb-1">Guest Name</small>
                                        <h5 class="text-white m-0 m-md-1">
                                            <c:out value="${empty guest.fullName ? 'N/A' : guest.fullName}" />
                                        </h5>
                                    </div>
                                </div>

                                <div class="row g-3 bg-dark bg-opacity-25 rounded p-3 mb-4">
                                    <div class="col-6 col-md-3">
                                        <small class="text-light-50 d-block"><i
                                                class="fa-regular fa-calendar-check me-1"></i> Check-in</small>
                                        <span class="text-light fw-bold">
                                            <c:out value="${empty res.checkIn ? 'N/A' : res.checkIn}" />
                                        </span>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <small class="text-light-50 d-block"><i
                                                class="fa-solid fa-arrow-right-from-bracket me-1"></i> Check-out</small>
                                        <span class="text-light fw-bold">
                                            <c:out value="${empty res.checkOut ? 'N/A' : res.checkOut}" />
                                        </span>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <small class="text-light-50 d-block"><i class="fa-solid fa-bed me-1"></i>
                                            Room</small>
                                        <span class="text-light fw-bold">
                                            <c:out value="${empty room.roomNumber ? 'N/A' : room.roomNumber}" /> (
                                            <c:out value="${empty roomType.typeName ? 'N/A' : roomType.typeName}" />)
                                        </span>
                                    </div>
                                    <div class="col-6 col-md-3">
                                        <small class="text-light-50 d-block"><i class="fa-solid fa-moon me-1"></i>
                                            Nights</small>
                                        <span class="text-light fw-bold">
                                            <c:out value="${empty bill.nights ? '0' : bill.nights}" />
                                        </span>
                                    </div>
                                </div>



                                <!-- Billing Summary -->
                                <div class="bg-dark p-3 rounded border border-secondary mb-4 shadow-sm">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-light fw-bold fs-5">Total Amount Due</span>
                                        <span class="text-success fw-bold fs-4">LKR
                                            <c:out value="${empty amountDue ? '0.00' : amountDue}" />
                                        </span>
                                    </div>
                                </div>

                                <!-- Payment Portal UI -->
                                <c:choose>
                                    <c:when test="${paymentStatus == 'PAID'}">
                                        <div class="alert alert-success bg-dark bg-opacity-75 border border-success d-flex align-items-center mb-4 p-4 shadow-sm"
                                            role="alert" style="border-radius: 12px;">
                                            <i class="fa-solid fa-circle-check fa-3x text-success me-4"></i>
                                            <div>
                                                <h4 class="text-success fw-bold mb-1">Payment Successful ✅</h4>
                                                <p class="mb-0 text-light-50">The bill for this reservation has been
                                                    fully settled.</p>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when
                                                test="${sessionScope.user.role == 'Receptionist' || sessionScope.user.role == 'Admin'}">
                                                <!-- Receptionist Manual Payment Confirmation Form -->
                                                <div class="accordion mb-4 shadow-sm" id="paymentPortalAccordion">
                                                    <div class="accordion-item bg-dark border-info bg-opacity-50"
                                                        style="border-radius: 12px;">
                                                        <h2 class="accordion-header" id="headingPayment">
                                                            <button
                                                                class="accordion-button bg-transparent text-info fw-bold"
                                                                type="button" data-bs-toggle="collapse"
                                                                data-bs-target="#collapsePayment" aria-expanded="true"
                                                                aria-controls="collapsePayment"
                                                                style="box-shadow: none;">
                                                                <i class="fa-solid fa-file-invoice-dollar me-2"></i>
                                                                Manual Payment Confirmation (Receptionist)
                                                            </button>
                                                        </h2>
                                                        <div id="collapsePayment"
                                                            class="accordion-collapse collapse show"
                                                            aria-labelledby="headingPayment"
                                                            data-bs-parent="#paymentPortalAccordion">
                                                            <div class="accordion-body text-light px-4 pb-4">
                                                                <p class="small text-light-50 mb-4">Please collect the
                                                                    payment from the guest via Cash or Bank Transfer and
                                                                    record the details below.</p>

                                                                <form action="PaymentConfirmServlet" method="POST"
                                                                    id="manualPaymentForm">
                                                                    <input type="hidden" name="reservationNumber"
                                                                        value="${res.reservationNumber}">
                                                                    <input type="hidden" name="billId"
                                                                        value="${bill.id}">
                                                                    <input type="hidden" name="amount"
                                                                        value="${amountDue}">

                                                                    <div class="row g-3">
                                                                        <div class="col-md-12 mb-3">
                                                                            <label
                                                                                class="form-label text-info small fw-bold">Payment
                                                                                Method</label>
                                                                            <select
                                                                                class="form-select bg-dark text-white border-secondary"
                                                                                id="paymentMethod" name="paymentMethod"
                                                                                required onchange="togglePaymentMode()">
                                                                                <option value="Online">Online Gateway
                                                                                    (Card/Bank)</option>
                                                                                <option value="Offline" selected>Offline
                                                                                    / Manual Payment</option>
                                                                            </select>
                                                                        </div>

                                                                        <!-- ONLINE WRAPPER -->
                                                                        <div id="onlineModeWrapper"
                                                                            class="col-12 row g-3 m-0 p-0 d-none">
                                                                            <div class="col-md-6 mt-0">
                                                                                <label
                                                                                    class="form-label text-info small fw-bold">Payer
                                                                                    Name</label>
                                                                                <input type="text"
                                                                                    class="form-control bg-dark text-white border-secondary"
                                                                                    id="payerName" name="payerName"
                                                                                    placeholder="Name of person paying"
                                                                                    oninput="validatePaymentForm()">
                                                                            </div>
                                                                            <div class="col-md-6 mt-0">
                                                                                <label
                                                                                    class="form-label text-info small fw-bold">Reference
                                                                                    Number (8 Digits Required)</label>
                                                                                <input type="text"
                                                                                    class="form-control bg-dark text-white border-secondary"
                                                                                    id="referenceNo" name="referenceNo"
                                                                                    placeholder="e.g. 12345678 or leave empty for Auto-TXN"
                                                                                    maxlength="8"
                                                                                    oninput="validatePaymentForm()">
                                                                                <div id="refError"
                                                                                    class="text-danger small mt-1 d-none">
                                                                                    <i
                                                                                        class="fa-solid fa-triangle-exclamation"></i>
                                                                                    Must be exactly 8 digits if
                                                                                    provided.
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div
                                                                            class="col-12 mt-4 text-center border-top border-secondary pt-3">
                                                                            <div class="form-check d-inline-block text-start"
                                                                                style="transform: scale(1.1);">
                                                                                <input
                                                                                    class="form-check-input border-info"
                                                                                    type="checkbox" id="paymentReceived"
                                                                                    name="paymentReceived" value="true"
                                                                                    required
                                                                                    onchange="validatePaymentForm()">
                                                                                <label
                                                                                    class="form-check-label text-white fw-bold ms-2"
                                                                                    for="paymentReceived"
                                                                                    style="cursor: pointer;">
                                                                                    I confirm that the full payment of
                                                                                    LKR ${amountDue} has been received.
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="text-center mt-4 pt-2">
                                                                        <button type="submit" id="btnConfirmPayment"
                                                                            class="btn btn-success px-5 py-2 fw-bold"
                                                                            disabled>
                                                                            <i
                                                                                class="fa-solid fa-check-double me-2"></i>
                                                                            Confirm Payment Now
                                                                        </button>
                                                                    </div>
                                                                </form>

                                                                <script>
                                                                    function togglePaymentMode() {
                                                                        const method = document.getElementById('paymentMethod').value;
                                                                        const wrapper = document.getElementById('onlineModeWrapper');
                                                                        const payerName = document.getElementById('payerName');
                                                                        const referenceNo = document.getElementById('referenceNo');

                                                                        if (method === 'Online') {
                                                                            wrapper.classList.remove('d-none');
                                                                            payerName.required = true;
                                                                        } else {
                                                                            wrapper.classList.add('d-none');
                                                                            payerName.required = false;
                                                                            referenceNo.required = false;
                                                                            payerName.value = '';
                                                                            referenceNo.value = '';
                                                                        }
                                                                        validatePaymentForm();
                                                                    }

                                                                    function validatePaymentForm() {
                                                                        const method = document.getElementById('paymentMethod').value;
                                                                        const name = document.getElementById('payerName').value.trim();
                                                                        let ref = document.getElementById('referenceNo').value.trim();
                                                                        const checked = document.getElementById('paymentReceived').checked;
                                                                        const btn = document.getElementById('btnConfirmPayment');
                                                                        const refError = document.getElementById('refError');

                                                                        // Enforce digits only for ref
                                                                        document.getElementById('referenceNo').value = ref.replace(/\D/g, '');
                                                                        ref = document.getElementById('referenceNo').value;

                                                                        let isRefValid = true;
                                                                        if (method === 'Online') {
                                                                            // if they typed something, it MUST be 8 digits. If empty, generate later.
                                                                            if (ref.length > 0 && ref.length !== 8) {
                                                                                isRefValid = false;
                                                                                refError.classList.remove('d-none');
                                                                            } else {
                                                                                refError.classList.add('d-none');
                                                                            }

                                                                            btn.disabled = !(name.length > 0 && isRefValid && checked);
                                                                        } else {
                                                                            // Offline only needs checkbox
                                                                            btn.disabled = !checked;
                                                                        }
                                                                    }

                                                                    // add submit listener to generate random TXN if online and ref is empty
                                                                    document.getElementById('manualPaymentForm').addEventListener('submit', function (e) {
                                                                        const method = document.getElementById('paymentMethod').value;
                                                                        const refInput = document.getElementById('referenceNo');
                                                                        if (method === 'Online' && refInput.value.trim() === '') {
                                                                            // Generate random 8 digit txn
                                                                            refInput.value = Math.floor(10000000 + Math.random() * 90000000).toString();
                                                                        }
                                                                    });
                                                                </script>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Lock Screen for Guests / Standard Users -->
                                                <div class="glass-card mb-4 p-4 text-center border border-secondary"
                                                    style="border-radius: 12px; background: rgba(0,0,0,0.4);">
                                                    <div
                                                        class="d-inline-block p-3 rounded-circle bg-dark border border-secondary mb-3 shadow">
                                                        <i class="fa-solid fa-lock fa-2x text-secondary"></i>
                                                    </div>
                                                    <h5 class="text-white">Receptionist Only</h5>
                                                    <p class="text-light-50 small mx-auto" style="max-width: 400px;">
                                                        Manual payment confirmations can only be processed by an
                                                        authorized Front Desk Receptionist. Please approach the desk to
                                                        settle this bill.
                                                        <br><br>Mention your ID: <strong class="text-info fs-5">
                                                            <c:out
                                                                value="${empty res.reservationNumber ? 'N/A' : res.reservationNumber}" />
                                                        </strong>.
                                                    </p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Action Buttons Footer -->
                            <div class="text-center mt-5">
                                <c:if test="${paymentStatus == 'PAID'}">
                                    <a href="BillingInvoiceServlet?reservationId=${res.id}"
                                        class="btn btn-outline-info px-4 me-2 bg-dark bg-opacity-50 border-info text-info">
                                        <i class="fa-solid fa-file-pdf me-2"></i>Download Receipt (PDF)
                                    </a>
                                </c:if>

                                <c:choose>
                                    <c:when test="${paymentStatus == 'PAID'}">
                                        <a href="ReservationDetailsServlet?reservationNumber=${res.reservationNumber}"
                                            class="btn btn-neon px-4 me-2">
                                            <i class="fa-solid fa-eye me-2"></i>View Full Itinerary
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-outline-secondary px-4 me-2 disabled"
                                            style="opacity:0.6; cursor:not-allowed;" title="Payment Pending">
                                            <i class="fa-solid fa-lock me-2"></i>Payment Pending (Itinerary Locked)
                                        </button>
                                    </c:otherwise>
                                </c:choose>

                                <a href="DashboardServlet" class="btn btn-outline-secondary px-4">
                                    <i class="fa-solid fa-house me-2"></i>Back to Home
                                </a>
                            </div>

                        </div>
                    </div>
                </div>

                <style>
                    /* Styling adjustments to match the theme */
                    .nav-pills .nav-link {
                        color: #fff;
                        opacity: 0.6;
                        transition: all 0.3s ease;
                        margin: 0 5px;
                        border-radius: 8px;
                    }

                    .nav-pills .nav-link:hover {
                        opacity: 1;
                        background-color: rgba(255, 255, 255, 0.05);
                    }

                    .nav-pills .nav-link.active {
                        opacity: 1;
                        background-color: #0dcaf0;
                        color: #000;
                        font-weight: bold;
                    }
                </style>

                <%@ include file="footer.jspf" %>