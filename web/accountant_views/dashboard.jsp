<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!-- Financial KPI Widgets -->
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="finance-card">
                        <div class="d-flex justify-content-between mb-3">
                            <div class="bg-success bg-opacity-10 p-2 rounded-3 text-success">
                                <i class="fa-solid fa-money-bill-trend-up fa-lg"></i>
                            </div>
                            <span class="text-success small fw-bold">+12% <i
                                    class="fa-solid fa-arrow-trend-up"></i></span>
                        </div>
                        <h6 class="text-muted small text-uppercase">Total Revenue</h6>
                        <h3 class="fw-bold text-dark mb-0">
                            <fmt:formatNumber value="${kpis.totalRevenue}" type="currency" currencyCode="LKR" />
                        </h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="finance-card">
                        <div class="d-flex justify-content-between mb-3">
                            <div class="bg-warning bg-opacity-10 p-2 rounded-3 text-warning">
                                <i class="fa-solid fa-clock-rotate-left fa-lg"></i>
                            </div>
                            <span class="text-warning small fw-bold">${kpis.pendingCount} Bills</span>
                        </div>
                        <h6 class="text-muted small text-uppercase">Pending Review</h6>
                        <h3 class="fw-bold text-dark mb-0">
                            <fmt:formatNumber value="${kpis.pendingRevenue}" type="currency" currencyCode="LKR" />
                        </h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="finance-card">
                        <div class="d-flex justify-content-between mb-3">
                            <div class="bg-info bg-opacity-10 p-2 rounded-3 text-info">
                                <i class="fa-solid fa-file-invoice fa-lg"></i>
                            </div>
                        </div>
                        <h6 class="text-muted small text-uppercase">Total Invoices</h6>
                        <h3 class="fw-bold text-dark mb-0">${kpis.totalInvoices}</h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="finance-card bg-primary text-white">
                        <div class="d-flex justify-content-between mb-3">
                            <div class="bg-white bg-opacity-20 p-2 rounded-3">
                                <i class="fa-solid fa-cash-register fa-lg"></i>
                            </div>
                        </div>
                        <h6 class="text-white opacity-75 small text-uppercase">Today's Cash</h6>
                        <h3 class="fw-bold text-white mb-0">
                            <fmt:formatNumber value="${kpis.todayRevenue}" type="currency" currencyCode="LKR" />
                        </h3>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="finance-card mb-4" style="height: 400px;">
                        <h6 class="fw-bold text-dark mb-4">Quick Financial Pulse</h6>
                        <canvas id="dashboardTrendChart"></canvas>
                    </div>

                    <div class="finance-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h6 class="fw-bold text-dark mb-0">Recent Activity</h6>
                            <a href="AccountantDashboardServlet?view=history"
                                class="text-accent small text-decoration-none fw-bold">View History</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table finance-table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Time</th>
                                        <th>Res #</th>
                                        <th>Guest</th>
                                        <th class="text-end">Amount</th>
                                        <th class="text-center">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${recentPayments}">
                                        <tr>
                                            <td class="text-muted small">
                                                <fmt:formatDate value="${p.paidAt}" pattern="HH:mm" />
                                            </td>
                                            <td><span class="badge bg-light text-dark border">${p.resNo}</span></td>
                                            <td class="fw-bold text-dark">${p.guestName}</td>
                                            <td class="text-end fw-bold text-dark">
                                                <fmt:formatNumber value="${p.amount}" type="number" />
                                            </td>
                                            <td class="text-center">
                                                <span
                                                    class="status-indicator ${p.status == 'PAID' ? 'status-paid' : 'status-pending'}"></span>
                                                <span class="small fw-bold">${p.status}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="finance-card bg-dark text-white mb-4">
                        <h6 class="fw-bold mb-3">Treasury Actions</h6>
                        <div class="d-grid gap-2">
                            <button class="btn btn-info btn-sm text-dark fw-bold py-2" data-bs-toggle="modal"
                                data-bs-target="#refundModal">
                                <i class="fa-solid fa-rotate-left me-2"></i>New Refund
                            </button>
                            <button class="btn btn-outline-light btn-sm border-0 text-start py-2"
                                onclick="location.href='AccountantDashboardServlet?view=billing'">
                                <i class="fa-solid fa-plus me-2"></i>Create Invoice
                            </button>
                        </div>
                    </div>

                    <div class="finance-card">
                        <h6 class="fw-bold text-dark mb-3 text-uppercase small">Outstanding Collection</h6>
                        <div class="list-group list-group-flush">
                            <c:forEach var="item" items="${pendingBalances}" end="4">
                                <div class="list-group-item px-0 py-2 border-0">
                                    <div class="d-flex justify-content-between">
                                        <span class="small fw-bold text-dark">${item.resNo}</span>
                                        <span class="small text-danger fw-bold">
                                            <fmt:formatNumber value="${item.balance}" type="number" />
                                        </span>
                                    </div>
                                    <div class="small text-muted">${item.guestName}</div>
                                </div>
                            </c:forEach>
                        </div>
                        <a href="AccountantDashboardServlet?view=billing"
                            class="btn btn-light w-100 mt-3 btn-sm text-accent fw-bold">Manage All Queue</a>
                    </div>
                </div>
            </div>