<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <%@ include file="header.jspf" %>

                <style>
                    :root {
                        --summary-bg: rgba(10, 25, 47, 0.85);
                        --accent-primary: #64ffda;
                        --accent-secondary: #0ea5e9;
                    }

                    .summary-page {
                        min-height: 80vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background: radial-gradient(circle at center, #0a192f 0%, #020c1b 100%);
                        padding: 40px 20px;
                    }

                    .summary-card {
                        background: var(--summary-bg);
                        backdrop-filter: blur(20px);
                        -webkit-backdrop-filter: blur(20px);
                        border: 1px solid rgba(100, 255, 218, 0.1);
                        border-radius: 30px;
                        padding: 50px;
                        width: 100%;
                        max-width: 600px;
                        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
                        text-align: center;
                        animation: fadeInUp 0.6s ease-out;
                    }

                    @keyframes fadeInUp {
                        from {
                            opacity: 0;
                            transform: translateY(30px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .success-icon {
                        width: 80px;
                        height: 80px;
                        background: rgba(100, 255, 218, 0.1);
                        color: var(--accent-primary);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2.5rem;
                        margin: 0 auto 30px auto;
                        box-shadow: 0 0 20px rgba(100, 255, 218, 0.1);
                    }

                    .booking-ref {
                        display: inline-block;
                        background: rgba(14, 165, 233, 0.1);
                        color: var(--accent-secondary);
                        padding: 5px 15px;
                        border-radius: 50px;
                        font-weight: 700;
                        font-size: 0.85rem;
                        margin-bottom: 20px;
                        letter-spacing: 1px;
                    }

                    .stay-details {
                        background: rgba(0, 0, 0, 0.2);
                        border-radius: 20px;
                        padding: 25px;
                        margin: 30px 0;
                        text-align: left;
                    }

                    .detail-row {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 12px;
                    }

                    .detail-row:last-child {
                        margin-bottom: 0;
                    }

                    .detail-label {
                        color: #8892b0;
                        font-size: 0.9rem;
                    }

                    .detail-value {
                        color: #e6f1ff;
                        font-weight: 600;
                    }

                    .grand-total-box {
                        border-top: 1px solid rgba(255, 255, 255, 0.05);
                        padding-top: 20px;
                        margin-top: 20px;
                        display: flex;
                        justify-content: space-between;
                        align-items: baseline;
                    }

                    .total-label {
                        color: var(--accent-primary);
                        font-weight: 700;
                        font-size: 1.1rem;
                    }

                    .total-amount {
                        color: #fff;
                        font-size: 1.8rem;
                        font-weight: 800;
                    }

                    .action-group {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 15px;
                        margin-top: 40px;
                    }

                    .btn-summary {
                        padding: 14px;
                        border-radius: 12px;
                        font-weight: 600;
                        transition: all 0.3s;
                        text-decoration: none;
                        display: block;
                    }

                    .btn-main {
                        background: var(--accent-primary);
                        color: #0a192f;
                        box-shadow: 0 10px 20px rgba(100, 255, 218, 0.2);
                    }

                    .btn-main:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 15px 30px rgba(100, 255, 218, 0.3);
                        background: #4deacf;
                    }

                    .btn-outline {
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: #ccd6f6;
                    }

                    .btn-outline:hover {
                        background: rgba(255, 255, 255, 0.05);
                        color: var(--accent-primary);
                        border-color: var(--accent-primary);
                    }

                    .status-alert {
                        padding: 10px;
                        border-radius: 10px;
                        font-size: 0.85rem;
                        margin-bottom: 25px;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .alert-paid {
                        background: rgba(16, 185, 129, 0.1);
                        color: #10b981;
                    }

                    .alert-pending {
                        background: rgba(245, 158, 11, 0.1);
                        color: #f59e0b;
                    }
                </style>

                <div class="summary-page">
                    <div class="summary-card">
                        <div class="success-icon">
                            <i class="fa-solid fa-hotel"></i>
                        </div>

                        <h2 class="text-white fw-bold mb-2">Reservation Summary</h2>
                        <div class="booking-ref">CONFIRMATION: ${res.reservationNumber}</div>

                        <div class="d-block">
                            <c:choose>
                                <c:when test="${paymentStatus == 'PAID'}">
                                    <div class="status-alert alert-paid">
                                        <i class="fa-solid fa-circle-check"></i> FULLY SETTLED
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="status-alert alert-pending">
                                        <i class="fa-solid fa-clock"></i> PAYMENT PENDING
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="stay-details">
                            <div class="detail-row">
                                <span class="detail-label">Guest</span>
                                <span class="detail-value">${guest.fullName}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Room</span>
                                <span class="detail-value">${room.roomNumber} (${roomType.typeName})</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Duration</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="${res.checkIn}" pattern="dd MMM" /> -
                                    <fmt:formatDate value="${res.checkOut}" pattern="dd MMM yyyy" />
                                </span>
                            </div>

                            <div class="grand-total-box">
                                <span class="total-label">Subtotal</span>
                                <span class="total-amount">LKR
                                    <fmt:formatNumber value="${grandTotal}" type="number" />
                                </span>
                            </div>
                        </div>

                        <p class="text-muted small">
                            Thank you for choosing OceanView Resort. You can view your full itinerary and manage
                            services in your dashboard.
                        </p>

                        <div class="action-group">
                            <a href="ReservationDetailsServlet?reservationNumber=${res.reservationNumber}"
                                class="btn-summary btn-outline">
                                <i class="fa-solid fa-list-ul me-2"></i> Itinerary
                            </a>
                            <a href="DashboardServlet" class="btn-summary btn-main">
                                <i class="fa-solid fa-house me-2"></i> Dashboard
                            </a>
                        </div>
                    </div>
                </div>

                <%@ include file="footer.jspf" %>
                    font-weight: 800;
                    text-shadow: 0 0 15px rgba(14, 165, 233, 0.4);
                    }

                    .btn-dashboard {
                    background: #0ea5e9;
                    color: #0a1128;
                    border: none;
                    border-radius: 12px;
                    padding: 16px 30px;
                    font-weight: 700;
                    font-size: 1.1rem;
                    width: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 12px;
                    transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    text-decoration: none;
                    box-shadow: 0 10px 25px rgba(14, 165, 233, 0.3);
                    }

                    .btn-dashboard:hover {
                    background: #38bdf8;
                    transform: translateY(-5px);
                    box-shadow: 0 15px 35px rgba(14, 165, 233, 0.5);
                    color: #0a1128;
                    }

                    @media (max-width: 600px) {
                    .details-grid {
                    grid-template-columns: 1fr;
                    gap: 10px;
                    }

                    .value-col {
                    text-align: left;
                    padding-left: 32px;
                    margin-bottom: 10px;
                    }

                    .summary-glass-card {
                    padding: 30px 20px;
                    }

                    .amount-highlight-box {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                    }

                    .amount-highlight-box .value-col {
                    padding-left: 0;
                    text-align: center;
                    }
                    }
                    </style>

                    <div class="container summary-page-container">
                        <div class="summary-glass-card animate__animated animate__fadeInUp">

                            <div class="alert-top-summary">
                                <i class="fa-solid fa-circle-check"></i>
                                <span>Reservation Loaded Successfully</span>
                            </div>

                            <div class="summary-header">
                                <h2>Reservation Summary</h2>
                            </div>

                            <div class="details-grid">
                                <div class="label-col"><i class="fa-solid fa-ticket"></i> Reservation No</div>
                                <div class="value-col">
                                    <c:out value="${empty res.reservationNumber ? 'N/A' : res.reservationNumber}" />
                                </div>

                                <div class="label-col"><i class="fa-solid fa-user"></i> Guest Name</div>
                                <div class="value-col">
                                    <c:out value="${empty guest.fullName ? 'N/A' : guest.fullName}" />
                                </div>

                                <div class="label-col"><i class="fa-solid fa-calendar-alt"></i> Check-in Date</div>
                                <div class="value-col">
                                    <fmt:formatDate value="${res.checkIn}" pattern="dd MMM yyyy" var="fmtCheckIn" />
                                    ${empty fmtCheckIn ? 'N/A' : fmtCheckIn}
                                </div>

                                <div class="label-col"><i class="fa-solid fa-wallet"></i> Payment Status</div>
                                <div class="value-col">
                                    <c:choose>
                                        <c:when test="${paymentStatus == 'PAID'}">
                                            <span class="badge-paid"><i class="fa-solid fa-circle-check"></i>
                                                PAID</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-pending" onclick="openPaymentModal()"
                                                style="cursor:pointer;" title="Click to mark as PAID">
                                                <i class="fa-solid fa-clock"></i> PENDING
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="amount-highlight-box">
                                <div class="label-col"><i class="fa-solid fa-money-bill-wave"></i> Total Amount Due
                                </div>
                                <div class="value-col">LKR
                                    <fmt:formatNumber value="${amountDue}" type="number" minFractionDigits="2" />
                                </div>
                            </div>

                            <a href="DashboardServlet" class="btn-dashboard">
                                <i class="fa-solid fa-house"></i> Go to Dashboard
                            </a>
                        </div>
                    </div>

                    <!-- Quick Payment Modal -->
                    <div class="summary-backdrop" id="paymentModal">
                        <div class="summary-modal">
                            <div class="modal-icon-bg">
                                <i class="fa-solid fa-money-check-dollar"></i>
                            </div>
                            <h4>Confirm Payment?</h4>
                            <p>Mark reservation <strong>
                                    <c:out value="${empty res.reservationNumber ? 'N/A' : res.reservationNumber}" />
                                </strong> as fully paid?</p>

                            <div class="mt-3 text-start">
                                <label class="text-light-50 small d-block mb-1">Select Payment Method</label>
                                <select id="quickPaymentMethod"
                                    class="form-select bg-dark text-light border-secondary mb-3"
                                    onchange="toggleQuickPaymentFields()">
                                    <option value="ONLINE">ONLINE (Card / Bank Transfer)</option>
                                    <option value="OFFLINE">OFFLINE (Cash / Manual)</option>
                                </select>

                                <!-- Online Only Fields -->
                                <div id="onlinePaymentFields">
                                    <div class="mb-3">
                                        <label class="text-light-50 small d-block mb-1">Payer Name</label>
                                        <input type="text" id="quickPayerName"
                                            class="form-control bg-dark text-light border-secondary"
                                            placeholder="Enter name">
                                    </div>
                                    <div class="mb-3">
                                        <label class="text-light-50 small d-block mb-1">External Transaction
                                            Reference</label>
                                        <input type="text" id="quickRefNumber"
                                            class="form-control bg-dark text-light border-secondary"
                                            placeholder="e.g. SLIP-12345">
                                    </div>
                                </div>

                                <!-- Offline Only Display -->
                                <div id="offlinePaymentFields" class="d-none">
                                    <div class="p-2 rounded border border-info border-opacity-25 mb-3"
                                        style="background: rgba(13, 202, 240, 0.05);">
                                        <label class="text-info small d-block mb-1"><i
                                                class="fa-solid fa-magic me-1"></i>
                                            Auto-Generated Reference</label>
                                        <span class="text-light fw-bold" id="autoGeneratedRef">TXN-REF-STUB</span>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-actions">
                                <button class="btn-modal-cancel" onclick="closePaymentModal()">Cancel</button>
                                <button class="btn-modal-confirm" id="btnConfirmQuickPay"
                                    onclick="processQuickPayment()">
                                    <i class="fa-solid fa-check me-1"></i> Confirm Payment
                                </button>
                            </div>
                        </div>
                    </div>

                    <script>
                        function openPaymentModal() {
                            document.getElementById('paymentModal').classList.add('show');
                            toggleQuickPaymentFields(); // Initial state check
                        }

                        function closePaymentModal() {
                            document.getElementById('paymentModal').classList.remove('show');
                        }

                        function toggleQuickPaymentFields() {
                            const method = document.getElementById('quickPaymentMethod').value;
                            const onlineDiv = document.getElementById('onlinePaymentFields');
                            const offlineDiv = document.getElementById('offlinePaymentFields');

                            if (method === 'ONLINE') {
                                onlineDiv.classList.remove('d-none');
                                offlineDiv.classList.add('d-none');
                            } else {
                                onlineDiv.classList.add('d-none');
                                offlineDiv.classList.remove('d-none');

                                // Generate Ref: TXN-YYYYMMDD-Random
                                const now = new Date();
                                const dateStr = now.getFullYear() +
                                    String(now.getMonth() + 1).padStart(2, '0') +
                                    String(now.getDate()).padStart(2, '0');
                                const rand = Math.floor(100 + Math.random() * 900);
                                const ref = "TXN-" + dateStr + "-" + rand;
                                document.getElementById('autoGeneratedRef').textContent = ref;
                            }
                        }

                        function processQuickPayment() {
                            const method = document.getElementById('quickPaymentMethod').value;
                            const payerName = document.getElementById('quickPayerName').value.trim();
                            const refInput = document.getElementById('quickRefNumber').value.trim();
                            const autoRef = document.getElementById('autoGeneratedRef').textContent;

                            if (method === 'ONLINE') {
                                if (!payerName || !refInput) {
                                    alert("Please enter Payer Name and Reference Number for Online payment.");
                                    return;
                                }
                            }

                            const btn = document.getElementById('btnConfirmQuickPay');
                            btn.disabled = true;
                            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin me-1"></i> Processing...';

                            const params = new URLSearchParams();
                            params.append("actionType", "payBill");
                            params.append("billId", "${bill.id}");
                            params.append("amountPaid", "${amountDue}");
                            params.append("paymentMethod", method);
                            params.append("transactionRef", method === 'ONLINE' ? refInput : autoRef);
                            params.append("payerName", method === 'ONLINE' ? payerName : "OFFLINE_CASH");
                            params.append("reservationId", "${res.id}");

                            fetch('ReservationDetailsServlet', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded'
                                },
                                body: params.toString()
                            })
                                .then(response => {
                                    if (response.ok) {
                                        window.location.reload(true);
                                    } else {
                                        response.text().then(text => {
                                            alert("Failed: " + text);
                                        }).catch(() => {
                                            alert("Failed to process payment. Please try again.");
                                        });
                                        closePaymentModal();
                                        btn.disabled = false;
                                        btn.innerHTML = '<i class="fa-solid fa-check me-1"></i> Confirm Payment';
                                    }
                                })
                                .catch(err => {
                                    console.error(err);
                                    alert("Network error processing payment.");
                                    closePaymentModal();
                                    btn.disabled = false;
                                    btn.innerHTML = '<i class="fa-solid fa-check me-1"></i> Confirm Payment';
                                });
                        }
                    </script>

                    <%@ include file="footer.jspf" %>