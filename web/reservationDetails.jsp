<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <jsp:useBean id="now" class="java.util.Date" />
      <fmt:formatDate var="simTxDate" value="${now}" pattern="yyyyMMdd" />
      <%@ include file="header.jspf" %>

        <style>
          /* Full Details - Full Itinerary Styled View */
          .itinerary-container {
            padding-top: 40px;
            padding-bottom: 80px;
            max-width: 900px;
            margin: auto;
          }

          .glass-card-full {
            background: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(14, 165, 233, 0.2);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
          }

          .itinerary-heading {
            text-align: center;
            margin-bottom: 40px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding-bottom: 25px;
          }

          .itinerary-heading h2 {
            color: #0ea5e9;
            font-weight: 700;
            letter-spacing: 1px;
          }

          /* Info Grids */
          .info-section {
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(14, 165, 233, 0.1);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
          }

          .row-label {
            color: #94a3b8;
            font-size: 0.9rem;
            margin-bottom: 2px;
          }

          .row-value {
            color: #fff;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
          }

          /* Services List */
          .service-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
          }

          .service-item:last-child {
            border-bottom: none;
          }

          /* Amount Box */
          .total-amount-box {
            background: linear-gradient(135deg, rgba(14, 165, 233, 0.1) 0%, rgba(0, 0, 0, 0.3) 100%);
            border: 1.5px solid #0ea5e9;
            padding: 25px;
            border-radius: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
          }

          .total-amount-box .label {
            color: #fff;
            font-size: 1.2rem;
            font-weight: 500;
          }

          .total-amount-box .value {
            color: #0ea5e9;
            font-size: 2rem;
            font-weight: 800;
            text-shadow: 0 0 10px rgba(14, 165, 233, 0.3);
          }

          /* Status Badges */
          .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 12px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
          }

          .status-paid {
            background: rgba(16, 185, 129, 0.15);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
          }

          .status-pending {
            background: rgba(245, 158, 11, 0.15);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
            cursor: pointer;
          }

          /* Action Buttons Area */
          .itinerary-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            justify-content: center;
          }

          /* Modal Backdrop */
          .ovr-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
            z-index: 10000;
            display: none;
            align-items: center;
            justify-content: center;
          }

          .ovr-backdrop.show {
            display: flex;
          }

          .ovr-modal {
            background: #0f172a;
            width: 100%;
            max-width: 500px;
            border-radius: 18px;
            border: 1px solid rgba(14, 165, 233, 0.3);
            overflow: hidden;
            animation: scaleUp 0.3s ease;
          }

          @keyframes scaleUp {
            from {
              transform: scale(0.9);
              opacity: 0;
            }

            to {
              transform: scale(1);
              opacity: 1;
            }
          }

          .ovr-modal header {
            background: rgba(255, 255, 255, 0.03);
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
          }

          .ovr-modal .body {
            padding: 25px;
          }

          .ovr-input,
          .ovr-select {
            width: 100%;
            background: #070b16;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #fff;
            padding: 12px;
            margin-top: 8px;
          }

          .ovr-input:focus {
            border-color: #0ea5e9;
            outline: none;
          }
        </style>

        <div class="container itinerary-container animate__animated animate__fadeIn">

          <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning mb-4">
              <i class="fa-solid fa-triangle-exclamation me-2"></i> ${errorMessage}
            </div>
          </c:if>

          <div class="glass-card-full">
            <c:if test="${paymentStatus == 'PAID'}">
              <div
                class="alert alert-success bg-success bg-opacity-10 border-success d-flex align-items-center mb-4 p-3 shadow-sm"
                style="border-radius: 14px; border: 1px solid rgba(16, 185, 129, 0.3);">
                <i class="fa-solid fa-circle-check fs-4 text-success me-3"></i>
                <div class="flex-grow-1">
                  <h6 class="text-success fw-bold mb-0">Payment Successful ✅</h6>
                  <small class="text-light-50">This itinerary has been fully settled and confirmed.</small>
                </div>
              </div>
            </c:if>
            <header class="itinerary-heading">
              <h2>Full Reservation Itinerary</h2>
              <p class="text-muted small">Comprehensive stay & billing overview</p>
            </header>

            <div class="row">
              <!-- Left Side: Basic Info -->
              <div class="col-md-6 mb-4">
                <div class="info-section">
                  <h5 class="text-info mb-4 border-bottom border-secondary pb-2">Guest & Stay</h5>
                  <div class="row-label">Reservation Number</div>
                  <div class="row-value">
                    <c:out value="${empty res.reservationNumber ? 'N/A' : res.reservationNumber}" />
                  </div>

                  <div class="row-label">Primary Guest</div>
                  <div class="row-value">
                    <c:out value="${empty guest.fullName ? 'Unknown' : guest.fullName}" />
                  </div>

                  <div class="row-label">Contact Phone</div>
                  <div class="row-value">
                    <c:out value="${empty guest.contactNumber ? 'N/A' : guest.contactNumber}" />
                  </div>

                  <div class="row-label">Check-in Date</div>
                  <div class="row-value">
                    <fmt:formatDate value="${res.checkIn}" pattern="dd MMM yyyy" var="fmtCheckIn" />
                    ${empty fmtCheckIn ? 'N/A' : fmtCheckIn}
                  </div>

                  <div class="row-label">Room Allocation</div>
                  <div class="row-value">
                    <c:out value="${empty room.roomNumber ? 'N/A' : room.roomNumber}" /> -
                    <span class="small text-info">
                      <c:out value="${empty roomType.typeName ? 'Room Type' : roomType.typeName}" />
                    </span>
                  </div>
                </div>
              </div>

              <!-- Right Side: Billing & Services -->
              <div class="col-md-6 mb-4">
                <div class="info-section h-100">
                  <div
                    class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-2">
                    <h5 class="text-info m-0">Bill Detail</h5>
                    <c:if test="${not empty res.id}">
                      <button class="btn btn-sm btn-outline-info" onclick="openWindow('addBackdrop')"><i
                          class="fa-solid fa-plus"></i> Add Service</button>
                    </c:if>
                  </div>

                  <div class="d-flex justify-content-between mb-2">
                    <span class="text-light-50 small">Room & Stay Total:</span>
                    <div class="text-end">
                      <span class="text-white fw-bold d-block">LKR
                        <fmt:formatNumber value="${bill.totalAmount}" type="number" minFractionDigits="2" />
                      </span>
                      <span
                        class="badge ${roomPaid ? 'bg-success' : 'bg-warning'} bg-opacity-10 ${roomPaid ? 'text-success' : 'text-warning'} smaller border border-secondary border-opacity-25 mt-1">
                        ${roomPaid ? 'ROOM PAID' : 'ROOM PENDING'}
                      </span>
                    </div>
                  </div>

                  <div
                    class="d-flex justify-content-between mb-4 pb-2 border-bottom border-secondary border-opacity-25">
                    <span class="text-light-50 small">Additional Services:</span>
                    <div class="text-end">
                      <span class="text-info fw-bold d-block">LKR
                        <fmt:formatNumber value="${additionalTotal}" type="number" minFractionDigits="2" />
                      </span>
                      <c:if test="${additionalTotal > 0}">
                        <span
                          class="badge ${servicesPaid ? 'bg-success' : 'bg-warning'} bg-opacity-10 ${servicesPaid ? 'text-success' : 'text-warning'} smaller border border-secondary border-opacity-25 mt-1">
                          ${servicesPaid ? 'SERVICES PAID' : 'SERVICES PENDING'}
                        </span>
                      </c:if>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Highlighted Summary Block -->
            <div class="total-amount-box">
              <div class="d-flex align-items-center gap-3">
                <div class="label">Total Amount Due</div>
                <c:choose>
                  <c:when test="${amountDue <= 0}">
                    <div class="status-badge status-paid"><i class="fa-solid fa-circle-check"></i> PAID</div>
                  </c:when>
                  <c:otherwise>
                    <div class="status-badge status-pending" onclick="openWindow('payBackdrop')"><i
                        class="fa-solid fa-clock"></i> SETTLE BALANCE</div>
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="value">LKR
                <fmt:formatNumber value="${amountDue}" type="number" minFractionDigits="2" />
              </div>
            </div>

            <!-- Itinerary Footer Buttons -->
            <div class="itinerary-actions">
              <c:if test="${paymentStatus == 'PAID'}">
                <a href="BillingInvoiceServlet?reservationId=${res.id}" class="btn btn-outline-light px-4">
                  <i class="fa-solid fa-file-pdf me-2"></i>Download Receipt (PDF)
                </a>
              </c:if>
              <a href="DashboardServlet" class="btn btn-neon px-5">
                <i class="fa-solid fa-house me-2"></i>Go to Dashboard
              </a>
            </div>
          </div>
        </div>

        <%-- MODAL: ADD SERVICES --%>
          <div class="ovr-backdrop" id="addBackdrop">
            <div class="ovr-modal">
              <header>
                <strong class="text-info">Add Selected Resort Service</strong>
                <button class="btn-close btn-close-white" onclick="closeWindow('addBackdrop')"></button>
              </header>
              <div class="body">
                <form id="addSrvForm">
                  <input type="hidden" name="actionType" value="addService" />
                  <input type="hidden" name="reservationId" value="${res.id}" />
                  <input type="hidden" name="reservationNumber" value="${res.reservationNumber}" />

                  <label class="small text-light-50">Service Category</label>
                  <select class="ovr-select" name="category" id="svcCategory" required>
                    <option value="">-- Choose Category --</option>
                    <option value="Resort Services">Resort Services</option>
                    <option value="Restaurant">Restaurant</option>
                  </select>

                  <div id="itemBlock" style="display:none;" class="mt-3">
                    <label class="small text-light-50">Item Selection</label>
                    <select class="ovr-select" name="itemName" id="menuItem" required>
                      <option value="">-- Select --</option>
                    </select>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <label class="small text-light-50">Qty</label>
                      <input type="number" class="ovr-input" name="qty" id="qty" min="1" value="1" required />
                    </div>
                    <div class="col-6">
                      <label class="small text-light-50">Unit Price</label>
                      <input type="text" class="ovr-input" name="unitPrice" id="unitPrice" readonly />
                    </div>
                  </div>

                  <div class="mt-4 d-flex gap-2">
                    <button type="submit" class="btn btn-info flex-grow-1 fw-bold">Add to Itinerary</button>
                    <button type="button" class="btn btn-secondary" onclick="closeWindow('addBackdrop')">Cancel</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <%-- MODAL: PAYMENT PORTAL --%>
            <div class="ovr-backdrop" id="payBackdrop" aria-hidden="true">
              <div class="ovr-modal">
                <header>
                  <strong class="text-info">Settle Service Charges</strong>
                  <button class="btn-close btn-close-white" onclick="closeWindow('payBackdrop')"></button>
                </header>
                <div class="body">
                  <h5 class="text-center mb-4 text-white">Remaining Balance: <span class="text-success">LKR
                      <fmt:formatNumber value="${amountDue}" type="number" minFractionDigits="2" />
                    </span></h5>
                  <form id="paymentForm">
                    <input type="hidden" name="actionType" value="payBill" />
                    <input type="hidden" name="billId" value="${bill.id}" />
                    <input type="hidden" name="reservationId" value="${res.id}" />
                    <input type="hidden" name="amountPaid" value="${amountDue}" />

                    <c:choose>
                      <c:when test="${sessionScope.user.role == 'Guest'}">
                        <input type="hidden" name="paymentMethod" value="ONLINE" />
                        <div class="p-3 bg-dark bg-opacity-50 rounded border border-info border-opacity-25">
                          <label class="small text-info fw-bold mb-2"><i class="fa-solid fa-globe me-1"></i> ONLINE
                            PAYMENT ONLY</label>

                          <div class="mb-3">
                            <label class="small text-light-50">Your Full Name (as Payer)</label>
                            <input type="text" class="ovr-input validate-pay" name="payerName" id="guestPayerName"
                              required placeholder="Enter your name" />
                          </div>

                          <div>
                            <label class="small text-light-50">Transaction Reference / ID</label>
                            <input type="text" class="ovr-input validate-pay" name="transactionRef" id="guestTransRef"
                              required placeholder="Enter 8-digit ref or ID" />
                          </div>
                        </div>
                      </c:when>
                      <c:otherwise>
                        <%-- Receptionist View: Can still choose OFFLINE --%>
                          <label class="small text-light-50">Payment Method</label>
                          <select class="ovr-select" name="paymentMethod" id="payMethod" required>
                            <option value="ONLINE">ONLINE</option>
                            <option value="OFFLINE">OFFLINE - MANUAL</option>
                          </select>

                          <div id="onlineBlock" class="mt-3 text-info small">
                            <i class="fa-solid fa-circle-info me-1"></i> Auto-Generated Reference: TXN-${simTxDate}-001
                          </div>

                          <div id="offlineBlock" style="display:none;"
                            class="mt-3 p-3 bg-dark bg-opacity-50 rounded border border-secondary">
                            <label class="small text-light-50">Guest Payer Name</label>
                            <input type="text" class="ovr-input" name="payerName" id="customerName"
                              placeholder="Full name" />

                            <div class="mt-3">
                              <label class="small text-light-50">Reference No (8 Digits)</label>
                              <input type="text" class="ovr-input" name="transactionRef" id="refNo" maxlength="15"
                                placeholder="e.g. 12345678" />
                            </div>
                          </div>
                      </c:otherwise>
                    </c:choose>

                    <div class="mt-4 d-flex gap-2">
                      <button type="submit" id="confirmPayBtn" class="btn btn-success flex-grow-1 fw-bold">Confirm
                        Payment</button>
                      <button type="button" class="btn btn-secondary"
                        onclick="closeWindow('payBackdrop')">Cancel</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>

            <script>
              function openWindow(id) { document.getElementById(id).classList.add("show"); }
              function closeWindow(id) { document.getElementById(id).classList.remove("show"); }

              // Menu Logic
              const itemsData = {
                "Resort Services": { "Luxury Spa Session": 4500.00, "Gym Day Pass": 1200.00, "Laundry Service": 850.00, "Airport Transfer": 3500.00 },
                "Restaurant": { "Seafood Fried Rice": 1800.00, "Cheese Kothu": 1500.00, "Spicy Noodles": 1200.00 }
              };

              document.getElementById("svcCategory")?.addEventListener("change", function () {
                const cat = this.value;
                const itemBlock = document.getElementById("itemBlock");
                const menuItem = document.getElementById("menuItem");
                menuItem.innerHTML = '<option value="">-- Select --</option>';
                document.getElementById("unitPrice").value = '';
                if (cat && itemsData[cat]) {
                  itemBlock.style.display = "block";
                  for (const [name, price] of Object.entries(itemsData[cat])) {
                    const opt = document.createElement("option");
                    opt.value = name; opt.textContent = name + " (LKR " + price.toLocaleString() + ")";
                    menuItem.appendChild(opt);
                  }
                } else { itemBlock.style.display = "none"; }
              });

              document.getElementById("menuItem")?.addEventListener("change", function () {
                const cat = document.getElementById("svcCategory").value;
                const item = this.value;
                if (cat && item && itemsData[cat][item]) {
                  document.getElementById("unitPrice").value = itemsData[cat][item].toFixed(2);
                }
              });

              // Form Submissions
              document.getElementById("addSrvForm")?.addEventListener("submit", handleForm);
              document.getElementById("paymentForm")?.addEventListener("submit", handleForm);

              function handleForm(e) {
                e.preventDefault();
                const fd = new FormData(this);
                const params = new URLSearchParams(Array.from(fd.entries())).toString();
                fetch("ReservationDetailsServlet", {
                  method: "POST",
                  headers: { "Content-Type": "application/x-www-form-urlencoded" },
                  body: params
                }).then(() => window.location.reload());
              }

              document.getElementById("payMethod")?.addEventListener("change", function () {
                document.getElementById("offlineBlock").style.display = (this.value === "OFFLINE") ? "block" : "none";
                document.getElementById("onlineBlock").style.display = (this.value === "ONLINE") ? "block" : "none";
              });

              // Real-time Validation for Guest Portal
              const validateInputs = document.querySelectorAll(".validate-pay");
              const payBtn = document.getElementById("confirmPayBtn");

              if (validateInputs.length > 0) {
                payBtn.disabled = true;
                validateInputs.forEach(input => {
                  input.addEventListener("input", () => {
                    let allFilled = true;
                    validateInputs.forEach(i => { if (!i.value.trim()) allFilled = false; });
                    payBtn.disabled = !allFilled;
                  });
                });
              }
            </script>

            <%@ include file="footer.jspf" %>