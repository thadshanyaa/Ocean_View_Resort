<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <%@ include file="header.jspf" %>

                <style>
                    /* Full-height container to center the card vertically if content is short */
                    .summary-page-container {
                        min-height: 70vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding-top: 40px;
                        padding-bottom: 60px;
                    }

                    /* Override any conflicting container sizing */
                    .summary-glass-card {
                        background: rgba(15, 23, 42, 0.8) !important;
                        backdrop-filter: blur(20px);
                        -webkit-backdrop-filter: blur(20px);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 20px;
                        padding: 45px;
                        width: 100%;
                        max-width: 700px;
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
                        margin: auto;
                    }

                    .alert-top-summary {
                        background: rgba(16, 185, 129, 0.1);
                        border: 1px solid rgba(16, 185, 129, 0.2);
                        color: #34d399;
                        padding: 12px;
                        border-radius: 10px;
                        text-align: center;
                        font-size: 0.95rem;
                        margin-bottom: 30px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 10px;
                    }

                    .summary-header {
                        text-align: center;
                        margin-bottom: 40px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                        padding-bottom: 25px;
                    }

                    .summary-header h2 {
                        margin: 0;
                        font-weight: 600;
                        letter-spacing: 0.5px;
                        font-size: 1.75rem;
                        color: #0ea5e9;
                    }

                    .details-grid {
                        display: grid;
                        grid-template-columns: 1fr 1.2fr;
                        gap: 20px 30px;
                        margin-bottom: 40px;
                        padding-bottom: 20px;
                    }

                    .label-col {
                        color: #94a3b8;
                        font-size: 1rem;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        font-weight: 400;
                    }

                    .label-col i {
                        color: #0ea5e9;
                        width: 20px;
                        text-align: center;
                    }

                    .value-col {
                        font-size: 1.1rem;
                        font-weight: 600;
                        text-align: right;
                        color: #f8f9fa;
                    }

                    .badge-paid {
                        background: rgba(16, 185, 129, 0.2);
                        color: #10b981;
                        border: 1px solid rgba(16, 185, 129, 0.3);
                        padding: 6px 16px;
                        border-radius: 50px;
                        font-weight: 700;
                        font-size: 0.85rem;
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        text-transform: uppercase;
                    }

                    .badge-pending {
                        background: rgba(245, 158, 11, 0.2);
                        color: #f59e0b;
                        border: 1px solid rgba(245, 158, 11, 0.3);
                        padding: 6px 16px;
                        border-radius: 50px;
                        font-weight: 700;
                        font-size: 0.85rem;
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        text-transform: uppercase;
                        transition: all 0.3s ease;
                    }

                    .badge-pending:hover {
                        background: rgba(245, 158, 11, 0.3);
                        box-shadow: 0 0 10px rgba(245, 158, 11, 0.4);
                    }

                    /* Modal Styles */
                    .summary-backdrop {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100vw;
                        height: 100vh;
                        background: rgba(0, 0, 0, 0.7);
                        backdrop-filter: blur(5px);
                        -webkit-backdrop-filter: blur(5px);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        z-index: 10000;
                        opacity: 0;
                        pointer-events: none;
                        transition: opacity 0.3s ease;
                    }

                    .summary-backdrop.show {
                        opacity: 1;
                        pointer-events: auto;
                    }

                    .summary-modal {
                        background: rgba(15, 23, 42, 0.95);
                        border: 1px solid rgba(14, 165, 233, 0.2);
                        border-radius: 20px;
                        width: 90%;
                        max-width: 450px;
                        padding: 30px;
                        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
                        transform: scale(0.9);
                        transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        text-align: center;
                    }

                    .summary-backdrop.show .summary-modal {
                        transform: scale(1);
                    }

                    .summary-modal h4 {
                        color: #fff;
                        font-weight: 600;
                        margin-bottom: 10px;
                    }

                    .summary-modal p {
                        color: #94a3b8;
                        font-size: 0.95rem;
                        margin-bottom: 25px;
                    }

                    .modal-icon-bg {
                        width: 70px;
                        height: 70px;
                        background: rgba(14, 165, 233, 0.1);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin: 0 auto 20px auto;
                    }

                    .modal-icon-bg i {
                        font-size: 2rem;
                        color: #0ea5e9;
                    }

                    .modal-actions {
                        display: flex;
                        gap: 15px;
                        justify-content: center;
                    }

                    .btn-modal-confirm {
                        background: #10b981;
                        color: #fff;
                        border: none;
                        padding: 10px 20px;
                        border-radius: 10px;
                        font-weight: 600;
                        transition: all 0.2s;
                    }

                    .btn-modal-confirm:hover {
                        background: #34d399;
                    }

                    .btn-modal-cancel {
                        background: transparent;
                        color: #94a3b8;
                        border: 1px solid rgba(255, 255, 255, 0.2);
                        padding: 10px 20px;
                        border-radius: 10px;
                        font-weight: 600;
                        transition: all 0.2s;
                    }

                    .btn-modal-cancel:hover {
                        background: rgba(255, 255, 255, 0.05);
                        color: #fff;
                    }

                    .amount-highlight-box {
                        background: rgba(15, 23, 42, 0.9);
                        border: 1px solid rgba(14, 165, 233, 0.3);
                        border-radius: 15px;
                        padding: 25px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-top: 20px;
                        margin-bottom: 45px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                    }

                    .amount-highlight-box .label-col {
                        color: #fff;
                        font-size: 1.15rem;
                        font-weight: 500;
                    }

                    .amount-highlight-box .value-col {
                        font-size: 2rem;
                        color: #0ea5e9;
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
                                        <span class="badge-paid"><i class="fa-solid fa-circle-check"></i> PAID</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-pending" onclick="openPaymentModal()" style="cursor:pointer;"
                                            title="Click to mark as PAID">
                                            <i class="fa-solid fa-clock"></i> PENDING
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="amount-highlight-box">
                            <div class="label-col"><i class="fa-solid fa-money-bill-wave"></i> Total Amount Due</div>
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
                            <select id="quickPaymentMethod" class="form-select bg-dark text-light border-secondary mb-3"
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
                                    <label class="text-info small d-block mb-1"><i class="fa-solid fa-magic me-1"></i>
                                        Auto-Generated Reference</label>
                                    <span class="text-light fw-bold" id="autoGeneratedRef">TXN-REF-STUB</span>
                                </div>
                            </div>
                        </div>

                        <div class="modal-actions">
                            <button class="btn-modal-cancel" onclick="closePaymentModal()">Cancel</button>
                            <button class="btn-modal-confirm" id="btnConfirmQuickPay" onclick="processQuickPayment()">
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