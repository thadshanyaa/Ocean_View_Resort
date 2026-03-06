<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <%@ include file="header.jspf" %>

                <style>
                    :root {
                        --summary-bg: #050a14;
                        --card-bg: rgba(16, 32, 58, 0.75);
                        --accent-glow: #64ffda;
                        --text-bright: #e6f1ff;
                        --text-dim: #8892b0;
                    }

                    .summary-wrapper {
                        min-height: 80vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 40px 20px;
                        background: radial-gradient(circle at center, #0a192f 0%, #020c1b 100%);
                    }

                    .glass-summary-card {
                        background: var(--card-bg);
                        backdrop-filter: blur(20px);
                        -webkit-backdrop-filter: blur(20px);
                        border: 1px solid rgba(100, 255, 218, 0.1);
                        border-radius: 30px;
                        padding: 50px;
                        width: 100%;
                        max-width: 600px;
                        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
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

                    .summary-header {
                        text-align: center;
                        margin-bottom: 40px;
                    }

                    .summary-header i {
                        font-size: 3rem;
                        color: var(--accent-glow);
                        margin-bottom: 15px;
                        filter: drop-shadow(0 0 10px rgba(100, 255, 218, 0.3));
                    }

                    .summary-header h2 {
                        color: var(--text-bright);
                        font-weight: 800;
                        letter-spacing: -0.5px;
                    }

                    .detail-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 20px;
                        margin-bottom: 40px;
                        background: rgba(0, 0, 0, 0.2);
                        padding: 30px;
                        border-radius: 20px;
                        border: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    .detail-label {
                        color: var(--text-dim);
                        font-weight: 600;
                        font-size: 0.85rem;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .detail-label i {
                        font-size: 1rem;
                        color: var(--accent-glow);
                    }

                    .detail-value {
                        color: var(--text-bright);
                        font-weight: 700;
                        text-align: right;
                        font-size: 1.05rem;
                    }

                    .badge-status {
                        padding: 4px 12px;
                        border-radius: 50px;
                        font-size: 0.75rem;
                        font-weight: 800;
                    }

                    .badge-paid {
                        background: rgba(16, 185, 129, 0.1);
                        color: #10b981;
                        border: 1px solid rgba(16, 185, 129, 0.2);
                    }

                    .badge-pending {
                        background: rgba(245, 158, 11, 0.1);
                        color: #f59e0b;
                        border: 1px solid rgba(245, 158, 11, 0.2);
                    }

                    .btn-dashboard {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 10px;
                        background: var(--accent-glow);
                        color: #050a14;
                        padding: 16px;
                        border-radius: 15px;
                        font-weight: 700;
                        text-decoration: none;
                        transition: all 0.3s;
                        box-shadow: 0 10px 20px rgba(100, 255, 218, 0.2);
                    }

                    .btn-dashboard:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 15px 30px rgba(100, 255, 218, 0.4);
                        background: #4deacf;
                        color: #050a14;
                    }

                    .total-highlight {
                        grid-column: span 2;
                        border-top: 1px solid rgba(255, 255, 255, 0.1);
                        margin-top: 10px;
                        padding-top: 20px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .total-label {
                        color: var(--accent-glow);
                        font-size: 1rem;
                        font-weight: 800;
                    }

                    .total-value {
                        color: #fff;
                        font-size: 1.5rem;
                        font-weight: 800;
                    }
                </style>

                <div class="summary-wrapper">
                    <div class="glass-summary-card">
                        <div class="summary-header">
                            <i class="fa-solid fa-hotel"></i>
                            <h2>Reservation Details</h2>
                            <p class="text-white-50">Quick overview of your booking</p>
                        </div>

                        <div class="detail-grid">
                            <div class="detail-label"><i class="fa-solid fa-hashtag"></i> ID</div>
                            <div class="detail-value">${res.reservationNumber}</div>

                            <div class="detail-label"><i class="fa-solid fa-user"></i> Guest</div>
                            <div class="detail-value">${guest.fullName}</div>

                            <div class="detail-label"><i class="fa-solid fa-calendar"></i> Check-in</div>
                            <div class="detail-value">
                                <fmt:formatDate value="${res.checkIn}" pattern="dd MMM yyyy" />
                            </div>

                            <div class="detail-label"><i class="fa-solid fa-calendar"></i> Check-out</div>
                            <div class="detail-value">
                                <fmt:formatDate value="${res.checkOut}" pattern="dd MMM yyyy" />
                            </div>

                            <div class="detail-label"><i class="fa-solid fa-bed"></i> Room</div>
                            <div class="detail-value">${room.roomNumber} (${roomType.typeName})</div>

                            <div class="detail-label"><i class="fa-solid fa-shield-halved"></i> Status</div>
                            <div class="detail-value">
                                <span class="badge-status ${paymentStatus == 'PAID' ? 'badge-paid' : 'badge-pending'}">
                                    ${paymentStatus}
                                </span>
                            </div>

                            <div class="total-highlight">
                                <span class="total-label">Total Due</span>
                                <span class="total-value">LKR
                                    <fmt:formatNumber value="${amountDue}" type="number" minFractionDigits="2" />
                                </span>
                            </div>
                        </div>

                        <a href="DashboardServlet" class="btn-dashboard">
                            <i class="fa-solid fa-house"></i> Return to Dashboard
                        </a>
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