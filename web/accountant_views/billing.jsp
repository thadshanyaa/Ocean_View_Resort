<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <div class="row g-4">
                <div class="col-12">
                    <div class="finance-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold mb-0 text-dark"><i
                                    class="fa-solid fa-file-invoice me-2 text-primary"></i>Billing Console</h5>
                            <div class="d-flex gap-2">
                                <input type="text" class="form-control form-control-sm rounded-pill px-3"
                                    placeholder="Search Reservation #..." id="billSearch">
                                <button class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table finance-table table-hover align-middle">
                                <thead class="bg-light">
                                    <tr>
                                        <th>Res #</th>
                                        <th>Guest Profile</th>
                                        <th>Stay Period</th>
                                        <th class="text-end">Balance Due</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${pendingBalances}">
                                        <tr>
                                            <td class="fw-bold text-dark">${item.resNo}</td>
                                            <td>
                                                <div class="fw-bold">${item.guestName}</div>
                                                <div class="extra-small text-muted">ID: 8829-${item.resNo}</div>
                                            </td>
                                            <td class="small text-muted">
                                                <i class="fa-regular fa-calendar me-1"></i> Active Stay
                                            </td>
                                            <td class="text-end fw-bold text-danger">
                                                <fmt:formatNumber value="${item.balance}" type="number" />
                                                <small>LKR</small>
                                            </td>
                                            <td class="text-center">
                                                <button class="btn btn-sm btn-outline-primary rounded-pill px-3 fw-bold"
                                                    onclick="location.href='BillingInvoiceServlet?resNo=${item.resNo}'">
                                                    Generate Invoice
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty pendingBalances}">
                                        <tr>
                                            <td colspan="5" class="text-center py-5">
                                                <i
                                                    class="fa-solid fa-circle-check fa-3x text-success opacity-25 mb-3"></i>
                                                <p class="text-muted">No pending balances found. All accounts are
                                                    settled.</p>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>