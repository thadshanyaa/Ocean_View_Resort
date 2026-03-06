<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <jsp:useBean id="now" class="java.util.Date" />
      <fmt:formatDate var="simTxDate" value="${now}" pattern="yyyyMMdd" />
      <%@ include file="header.jspf" %>

        <style>
          :root {
            --ocean-deep: #050a14;
            --ocean-surface: rgba(16, 32, 58, 0.7);
            --ocean-border: rgba(100, 255, 218, 0.15);
            --accent-glow: #64ffda;
            --text-bright: #e6f1ff;
            --text-dim: #8892b0;
          }

          body {
            background: var(--ocean-deep);
            color: var(--text-dim);
          }

          .itinerary-wrapper {
            padding: 60px 0;
            min-height: 80vh;
          }

          .premium-itinerary {
            background: var(--ocean-surface);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--ocean-border);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
          }

          .section-border {
            border-bottom: 1px solid rgba(100, 255, 218, 0.1);
            padding-bottom: 20px;
            margin-bottom: 30px;
          }

          .accent-title {
            color: var(--accent-glow);
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.9rem;
          }

          .data-label {
            font-size: 0.75rem;
            color: var(--text-dim);
            font-weight: 600;
            text-transform: uppercase;
          }

          .data-value {
            color: var(--text-bright);
            font-weight: 600;
            font-size: 1.05rem;
          }

          .service-card {
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
            transition: transform 0.2s;
          }

          .service-card:hover {
            transform: scale(1.02);
            background: rgba(100, 255, 218, 0.03);
          }

          .summary-box {
            background: linear-gradient(145deg, rgba(100, 255, 218, 0.05), rgba(100, 255, 218, 0.01));
            border: 2px solid var(--accent-glow);
            border-radius: 20px;
            padding: 30px;
            margin-top: 40px;
            box-shadow: 0 0 30px rgba(100, 255, 218, 0.1);
          }

          .status-pill {
            padding: 6px 16px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.8rem;
            letter-spacing: 1px;
          }

          .status-paid {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
          }

          .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
          }

          .btn-premium {
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s ease;
          }

          .btn-glow {
            background: var(--accent-glow);
            color: var(--ocean-deep);
            box-shadow: 0 0 20px rgba(100, 255, 218, 0.3);
          }

          .btn-glow:hover {
            background: #4deacf;
            transform: translateY(-2px);
            box-shadow: 0 0 30px rgba(100, 255, 218, 0.5);
          }

          .btn-ghost {
            background: transparent;
            border: 1px solid var(--ocean-border);
            color: var(--text-bright);
          }

          .btn-ghost:hover {
            background: rgba(255, 255, 255, 0.05);
            color: var(--accent-glow);
          }

          .modal-glass {
            background: var(--ocean-deep);
            border: 1px solid var(--ocean-border);
            border-radius: 24px;
            overflow: hidden;
          }

          .form-control-premium {
            background: rgba(0, 0, 0, 0.4);
            border: 1px solid var(--ocean-border);
            color: var(--text-bright);
            border-radius: 10px;
            padding: 12px;
          }

          .form-control-premium:focus {
            background: rgba(0, 0, 0, 0.6);
            border-color: var(--accent-glow);
            box-shadow: 0 0 10px rgba(100, 255, 218, 0.1);
            color: #fff;
          }
        </style>

        <div class="itinerary-wrapper">
          <div class="container">
            <!-- Error Handling -->
            <c:if test="${not empty errorMessage}">
              <div
                class="alert alert-danger bg-dark border-danger text-light mb-5 shadow-sm animate__animated animate__shakeX">
                <i class="fa-solid fa-triangle-exclamation me-3"></i> ${errorMessage}
              </div>
            </c:if>

            <div class="premium-itinerary animate__animated animate__fadeInUp">
              <!-- Header Section -->
              <div class="section-border d-flex justify-content-between align-items-center">
                <div>
                  <h2 class="text-white fw-bold mb-1">Reservation Itinerary</h2>
                  <p class="mb-0">Ref: <span class="text-info fw-bold">${res.reservationNumber}</span></p>
                </div>
                <div class="text-end">
                  <c:choose>
                    <c:when test="${paymentStatus == 'PAID'}">
                      <span class="status-pill status-paid"><i class="fa-solid fa-circle-check me-2"></i>FULLY
                        SETTLED</span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-pill status-pending"><i class="fa-solid fa-clock me-2"></i>PENDING
                        SETTLEMENT</span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>

              <div class="row">
                <!-- Stay & Guest Info -->
                <div class="col-lg-7 mb-4">
                  <div class="accent-title mb-4">Core Stay Details</div>
                  <div class="row g-4">
                    <div class="col-6">
                      <label class="data-label d-block">Guest Name</label>
                      <span class="data-value">${guest.fullName}</span>
                    </div>
                    <div class="col-6">
                      <label class="data-label d-block">Room Number</label>
                      <span class="data-value">${room.roomNumber} - <span
                          class="text-info small">${roomType.typeName}</span></span>
                    </div>
                    <div class="col-6">
                      <label class="data-label d-block">Check-In</label>
                      <span class="data-value">
                        <fmt:formatDate value="${res.checkIn}" pattern="dd MMM yyyy" />
                      </span>
                    </div>
                    <div class="col-6">
                      <label class="data-label d-block">Check-Out</label>
                      <span class="data-value">
                        <fmt:formatDate value="${res.checkOut}" pattern="dd MMM yyyy" />
                      </span>
                    </div>
                  </div>

                  <div class="accent-title mt-5 mb-4">Additional Services & Dining</div>
                  <div class="services-container">
                    <c:choose>
                      <c:when test="${not empty charges}">
                        <c:forEach var="charge" items="${charges}">
                          <div class="service-card d-flex justify-content-between align-items-center">
                            <div>
                              <div class="text-white fw-bold mb-1">${charge.itemName}</div>
                              <small class="text-muted">${charge.category} • Qty: ${charge.qty}</small>
                            </div>
                            <div class="text-end">
                              <div class="text-info fw-bold">LKR
                                <fmt:formatNumber value="${charge.totalPrice}" type="number" />
                              </div>
                            </div>
                          </div>
                        </c:forEach>
                      </c:when>
                      <c:otherwise>
                        <div class="text-center py-4 border border-dashed border-secondary rounded-3 opacity-50">
                          <i class="fa-solid fa-concierge-bell fa-2x mb-2"></i>
                          <p class="small mb-0">No additional services requested yet.</p>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </div>

                  <c:if test="${paymentStatus == 'PENDING'}">
                    <button class="btn btn-sm btn-ghost mt-3 w-100"
                      onclick="bootstrap.Modal.getOrCreateInstance('#addServiceModal').show()">
                      <i class="fa-solid fa-plus me-2"></i> Add More Services
                    </button>
                  </c:if>
                </div>

                <!-- Billing Summary Side -->
                <div class="col-lg-5">
                  <div class="accent-title mb-4">Billing Statement</div>
                  <div class="glass-card p-4 border-0">
                    <div class="d-flex justify-content-between mb-3">
                      <span class="small">Room Accommodation</span>
                      <span class="text-white fw-bold">LKR
                        <fmt:formatNumber value="${bill.totalAmount}" type="number" />
                      </span>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <span class="small">Add-ons & Services</span>
                      <span class="text-white fw-bold">LKR
                        <fmt:formatNumber value="${additionalTotal}" type="number" />
                      </span>
                    </div>
                    <div
                      class="pt-3 border-top border-secondary border-opacity-25 d-flex justify-content-between align-items-center">
                      <span class="small fw-bold">Grand Total</span>
                      <span class="text-info fw-bold fs-5">LKR
                        <fmt:formatNumber value="${grandTotal}" type="number" />
                      </span>
                    </div>
                    <div class="mt-2 d-flex justify-content-between align-items-center">
                      <span class="small text-success">Amount Paid</span>
                      <span class="text-success small fw-bold">LKR
                        <fmt:formatNumber value="${totalPaid}" type="number" />
                      </span>
                    </div>
                  </div>

                  <div class="summary-box">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                      <span class="text-white fw-bold">Total Due Now</span>
                      <span class="text-info fw-bold fs-2">
                        <fmt:formatNumber value="${amountDue}" type="number" minFractionDigits="0" />
                      </span>
                    </div>
                    <c:if test="${amountDue > 0}">
                      <button class="btn btn-premium btn-glow w-100 mt-4"
                        onclick="bootstrap.Modal.getOrCreateInstance('#paymentModal').show()">
                        <i class="fa-solid fa-credit-card me-2"></i> Settle Balance
                      </button>
                    </c:if>
                  </div>

                  <div class="d-flex gap-3 mt-4">
                    <c:if test="${paymentStatus == 'PAID'}">
                      <a href="BillingInvoiceServlet?resNo=${res.reservationNumber}"
                        class="btn btn-premium btn-ghost flex-grow-1">
                        <i class="fa-solid fa-file-pdf me-2"></i> Receipt
                      </a>
                    </c:if>
                    <a href="DashboardServlet" class="btn btn-premium btn-ghost flex-grow-1">
                      <i class="fa-solid fa-house me-2"></i> Portal
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Modal: Add Services -->
        <div class="modal fade" id="addServiceModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modal-glass">
              <div class="modal-header border-0 pb-0">
                <h5 class="text-white fw-bold"><i class="fa-solid fa-utensils me-2 text-info"></i> Resort Services</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body p-4">
                <form id="addServiceForm">
                  <input type="hidden" name="actionType" value="addService" />
                  <input type="hidden" name="reservationId" value="${res.id}" />

                  <div class="mb-3">
                    <label class="data-label mb-2">Category</label>
                    <select class="form-control form-control-premium" name="category" id="svcCategory" required>
                      <option value="">Choose Service Category</option>
                      <option value="Resort Services">Wellness & Adventure</option>
                      <option value="Restaurant">Dining & Cuisine</option>
                    </select>
                  </div>

                  <div class="mb-3" id="itemBlock" style="display:none;">
                    <label class="data-label mb-2">Selection</label>
                    <select class="form-control form-control-premium" name="itemName" id="menuItem" required>
                      <option value="">Select Item</option>
                    </select>
                  </div>

                  <div class="row">
                    <div class="col-6 mb-3">
                      <label class="data-label mb-2">Units</label>
                      <input type="number" class="form-control form-control-premium" name="qty" min="1" value="1"
                        required />
                    </div>
                    <div class="col-6 mb-3">
                      <label class="data-label mb-2">Unit Cost</label>
                      <input type="text" class="form-control form-control-premium" name="unitPrice" id="unitPrice"
                        readonly />
                    </div>
                  </div>

                  <button type="submit" class="btn btn-premium btn-glow w-100 mt-4">Confirm Selection</button>
                </form>
              </div>
            </div>
          </div>
        </div>

        <!-- Modal: Payment Portal -->
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modal-glass border-info border-opacity-25">
              <div class="modal-header border-0 pb-0">
                <h5 class="text-white fw-bold"><i class="fa-solid fa-lock me-2 text-info"></i> Secure Payment</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body p-4 text-center">
                <div class="mb-4">
                  <h2 class="text-info fw-bold">LKR
                    <fmt:formatNumber value="${amountDue}" type="number" />
                  </h2>
                  <p class="small text-muted">Outstanding Balance Settlement</p>
                </div>

                <form id="paymentForm">
                  <input type="hidden" name="actionType" value="payBill" />
                  <input type="hidden" name="billId" value="${bill.id}" />
                  <input type="hidden" name="amountPaid" value="${amountDue}" />
                  <input type="hidden" name="paymentMethod" value="ONLINE" />

                  <div class="text-start mb-3">
                    <label class="data-label mb-2">Cardholder Name</label>
                    <input type="text" class="form-control form-control-premium" name="payerName" required
                      placeholder="Full Name" />
                  </div>

                  <div class="text-start mb-4">
                    <label class="data-label mb-2">Transaction Ref / Card Number</label>
                    <input type="text" class="form-control form-control-premium" name="transactionRef" required
                      placeholder="Reference Code" />
                  </div>

                  <div class="d-grid">
                    <button type="submit" class="btn btn-premium btn-glow py-3">Confirm & Pay</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>

        <script>
          const itemsData = {
            "Resort Services": {
              "Poolside Spa (Full Session)": 4500.00,
              "Resort Gym (Day Pass)": 1200.00,
              "Island Makeup Artistry": 2500.00,
              "Ocean View Massage": 3500.00
            },
            "Restaurant": {
              "Seafood Fried Rice": 1800.00,
              "Classic Beef Kothu": 1500.00,
              "Spicy Stir-fry Noodles": 1200.00,
              "Prawn Kothu Special": 1700.00
            }
          };

          document.getElementById("svcCategory")?.addEventListener("change", function () {
            const cat = this.value;
            const itemBlock = document.getElementById("itemBlock");
            const menuItem = document.getElementById("menuItem");
            menuItem.innerHTML = '<option value="">Select Item</option>';
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

          document.getElementById("addServiceForm")?.addEventListener("submit", handleForm);
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
        </script>

        <%@ include file="footer.jspf" %>