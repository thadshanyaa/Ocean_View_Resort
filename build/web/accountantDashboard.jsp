<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <div class="container-fluid py-5">
                        <div class="row g-4">
                            <!-- Sidebar -->
                            <div class="col-md-3 col-lg-2" data-aos="fade-right">
                                <%@ include file="sidebar.jspf" %>
                            </div>

                            <!-- Main Content -->
                            <div class="col-md-9 col-lg-10" data-aos="fade-left">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h2 class="fw-bold mb-1">Financial Overview</h2>
                                        <p class="text-muted mb-0">Today's collection and pending business balances</p>
                                    </div>
                                    <div class="text-end">
                                        <button class="btn btn-outline-info" data-bs-toggle="modal"
                                            data-bs-target="#reportModal">
                                            <i class="fa-solid fa-file-invoice-dollar me-2"></i>Generate Report
                                        </button>
                                        <button class="btn btn-primary ms-2" data-bs-toggle="modal"
                                            data-bs-target="#refundModal">
                                            <i class="fa-solid fa-hand-holding-dollar me-2"></i>Process Refund
                                        </button>
                                    </div>
                                </div>

                                <!-- KPI Cards -->
                                <div class="row g-4 mb-4">
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-success">
                                            <h6 class="text-muted small text-uppercase mb-2">Today's Payments</h6>
                                            <h3 class="fw-bold mb-0 text-success">
                                                <small class="fs-6">LKR</small>
                                                <fmt:formatNumber value="${kpis.todayRevenue}" type="number" />
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-warning">
                                            <h6 class="text-muted small text-uppercase mb-2">Pending Payments</h6>
                                            <h3 class="fw-bold mb-0 text-warning">${kpis.pendingCount}</h3>
                                            <p class="small text-muted mb-0 mt-1">Active reservations with balance</p>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-info">
                                            <h6 class="text-muted small text-uppercase mb-2">Total Revenue</h6>
                                            <h3 class="fw-bold mb-0 text-info">
                                                <small class="fs-6">LKR</small>
                                                <fmt:formatNumber value="${kpis.totalRevenue}" type="number" />
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-primary">
                                            <h6 class="text-muted small text-uppercase mb-2">Invoices Issued</h6>
                                            <h3 class="fw-bold mb-0 text-primary">${kpis.totalInvoices}</h3>
                                            <p class="small text-muted mb-0 mt-1">Digital records generated</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4 mb-4">
                                    <!-- Revenue Chart -->
                                    <div class="col-lg-8">
                                        <div class="glass-card p-4 h-100">
                                            <h5 class="fw-bold mb-4"><i
                                                    class="fa-solid fa-chart-line me-2 text-success"></i>Daily Income
                                                Trend</h5>
                                            <canvas id="revenueChart" height="220"></canvas>
                                        </div>
                                    </div>

                                    <!-- Pending Balances Quick View -->
                                    <div class="col-lg-4">
                                        <div class="glass-card p-4 h-100">
                                            <h5 class="fw-bold mb-4"><i
                                                    class="fa-solid fa-clock-rotate-left me-2 text-warning"></i>Recent
                                                Pending</h5>
                                            <div class="table-responsive">
                                                <table class="table table-dark table-hover table-sm align-middle small">
                                                    <thead>
                                                        <tr>
                                                            <th>Res #</th>
                                                            <th class="text-end">Balance</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="item" items="${pendingBalances}" end="5">
                                                            <tr>
                                                                <td>${item.resNo}</td>
                                                                <td class="text-end fw-bold text-danger">
                                                                    <fmt:formatNumber value="${item.balance}"
                                                                        type="number" />
                                                                </td>
                                                                <td>
                                                                    <a href="searchReservation.jsp?res=${item.resNo}"
                                                                        class="btn btn-link btn-sm p-0 text-info"><i
                                                                            class="fa-solid fa-eye"></i></a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <a href="#" class="btn btn-sm btn-outline-secondary w-100 mt-2">View All
                                                Pending</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Refund Modal -->
                    <div class="modal fade" id="refundModal" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content bg-dark border-secondary">
                                <div class="modal-header border-secondary">
                                    <h5 class="modal-title"><i
                                            class="fa-solid fa-hand-holding-dollar me-2 text-primary"></i>Process Refund
                                    </h5>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <form action="RefundServlet" method="POST">
                                    <div class="modal-body p-4">
                                        <div class="mb-3">
                                            <label
                                                class="form-label small text-muted text-uppercase fw-bold">Reservation
                                                ID</label>
                                            <input type="number" name="reservationId"
                                                class="form-control bg-dark text-white border-secondary" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small text-muted text-uppercase fw-bold">Refund
                                                Amount (LKR)</label>
                                            <input type="number" step="0.01" name="amount"
                                                class="form-control bg-dark text-white border-secondary" required>
                                        </div>
                                        <div class="mb-3">
                                            <label
                                                class="form-label small text-muted text-uppercase fw-bold">Reason</label>
                                            <textarea name="reason"
                                                class="form-control bg-dark text-white border-secondary" rows="3"
                                                required></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-secondary">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary px-4 fw-bold">Confirm
                                            Refund</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Report Modal -->
                    <div class="modal fade" id="reportModal" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content bg-dark border-secondary">
                                <div class="modal-header border-secondary">
                                    <h5 class="modal-title"><i
                                            class="fa-solid fa-file-export me-2 text-info"></i>Financial Reports</h5>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <form action="AccountantReportServlet" method="GET">
                                    <div class="modal-body p-4">
                                        <div class="row g-3">
                                            <div class="col-6">
                                                <label class="form-label small text-muted text-uppercase fw-bold">Start
                                                    Date</label>
                                                <input type="date" name="startDate"
                                                    class="form-control bg-dark text-white border-secondary" required>
                                            </div>
                                            <div class="col-6">
                                                <label class="form-label small text-muted text-uppercase fw-bold">End
                                                    Date</label>
                                                <input type="date" name="endDate"
                                                    class="form-control bg-dark text-white border-secondary" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-secondary justify-content-between">
                                        <button type="submit" name="type" value="excel" class="btn btn-outline-success">
                                            <i class="fa-solid fa-file-excel me-2"></i>Download Excel
                                        </button>
                                        <button type="submit" name="type" value="pdf" class="btn btn-outline-info">
                                            <i class="fa-solid fa-print me-2"></i>Print Report
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const rawData = '${revenueTrendJson}';
                            const revenueData = rawData ? JSON.parse(rawData) : [];
                            new Chart(document.getElementById('revenueChart'), {
                                type: 'line',
                                data: {
                                    labels: revenueData.map(d => d.date),
                                    datasets: [{
                                        label: 'Daily Collection (LKR)',
                                        data: revenueData.map(d => d.revenue),
                                        borderColor: '#198754',
                                        backgroundColor: 'rgba(25, 135, 84, 0.1)',
                                        fill: true,
                                        tension: 0.4,
                                        borderWidth: 3,
                                        pointBackgroundColor: '#198754'
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        y: { grid: { color: 'rgba(255, 255, 255, 0.1)' }, ticks: { color: '#94a3b8' } },
                                        x: { grid: { display: false }, ticks: { color: '#94a3b8' } }
                                    },
                                    plugins: { legend: { display: false } }
                                }
                            });
                        });
                    </script>

                    <%@ include file="footer.jspf" %>