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
                                        <h2 class="fw-bold mb-1">Manager Overview</h2>
                                        <p class="text-muted mb-0">Analytics & performance reports for Ocean View Resort
                                        </p>
                                    </div>
                                    <div class="text-end">
                                        <div class="btn-group shadow-sm">
                                            <a href="ManagerReportServlet?type=pdf&startDate=${startDate}&endDate=${endDate}&roomType=${selectedRoomType}&status=${selectedStatus}&payStatus=${selectedPayStatus}"
                                                target="_blank" class="btn btn-outline-info">
                                                <i class="fa-solid fa-file-pdf me-2"></i>Export PDF
                                            </a>
                                            <a href="ManagerReportServlet?type=excel&startDate=${startDate}&endDate=${endDate}&roomType=${selectedRoomType}&status=${selectedStatus}&payStatus=${selectedPayStatus}"
                                                class="btn btn-outline-success">
                                                <i class="fa-solid fa-file-excel me-2"></i>Export Excel
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Filter Panel -->
                                <div class="glass-card p-4 mb-4">
                                    <form action="ManagerDashboardServlet" method="GET" class="row g-3 align-items-end">
                                        <div class="col-md-2">
                                            <label class="form-label small text-muted text-uppercase fw-bold">From
                                                Date</label>
                                            <input type="date" name="startDate"
                                                class="form-control bg-dark text-white border-secondary"
                                                value="${startDate}">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label small text-muted text-uppercase fw-bold">To
                                                Date</label>
                                            <input type="date" name="endDate"
                                                class="form-control bg-dark text-white border-secondary"
                                                value="${endDate}">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label small text-muted text-uppercase fw-bold">Room
                                                Type</label>
                                            <select name="roomType"
                                                class="form-select bg-dark text-white border-secondary">
                                                <option value="">All Types</option>
                                                <c:forEach var="rt" items="${roomTypes}">
                                                    <option value="${rt.id}" ${selectedRoomType==rt.id ? 'selected' : ''
                                                        }>${rt.typeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label
                                                class="form-label small text-muted text-uppercase fw-bold">Status</label>
                                            <select name="status"
                                                class="form-select bg-dark text-white border-secondary">
                                                <option value="">All Status</option>
                                                <option value="Confirmed" ${selectedStatus=='Confirmed' ? 'selected'
                                                    : '' }>Confirmed</option>
                                                <option value="Completed" ${selectedStatus=='Completed' ? 'selected'
                                                    : '' }>Completed</option>
                                                <option value="Cancelled" ${selectedStatus=='Cancelled' ? 'selected'
                                                    : '' }>Cancelled</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label small text-muted text-uppercase fw-bold">Quick
                                                Periods</label>
                                            <div class="btn-group w-100">
                                                <button type="submit" name="period" value="thisMonth"
                                                    class="btn btn-sm ${selectedPeriod == 'thisMonth' ? 'btn-info' : 'btn-outline-secondary'}">This
                                                    Month</button>
                                                <button type="submit" name="period" value="thisYear"
                                                    class="btn btn-sm ${selectedPeriod == 'thisYear' ? 'btn-info' : 'btn-outline-secondary'}">This
                                                    Year</button>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <button type="submit" class="btn btn-primary w-100 fw-bold">
                                                <i class="fa-solid fa-filter me-2"></i>Apply Filters
                                            </button>
                                        </div>
                                    </form>
                                </div>

                                <!-- KPI Cards -->
                                <div class="row g-4 mb-4">
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-info">
                                            <h6 class="text-muted small text-uppercase mb-2">Occupancy Rate</h6>
                                            <h3 class="fw-bold mb-0">
                                                <fmt:formatNumber value="${kpis.occupancyRate}" pattern="#0.0" />%
                                            </h3>
                                            <div class="progress mt-2" style="height: 5px;">
                                                <div class="progress-bar bg-info" style="width: ${kpis.occupancyRate}%">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-success">
                                            <h6 class="text-muted small text-uppercase mb-2">Total Revenue</h6>
                                            <h3 class="fw-bold mb-0 text-success">
                                                <small class="fs-6">LKR</small>
                                                <fmt:formatNumber value="${kpis.totalRevenue}" type="number" />
                                            </h3>
                                            <p class="small text-muted mb-0 mt-1">From settled bills & services</p>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-warning">
                                            <h6 class="text-muted small text-uppercase mb-2">Total Bookings</h6>
                                            <h3 class="fw-bold mb-0 text-warning">${kpis.totalBookings}</h3>
                                            <p class="small text-muted mb-0 mt-1">${kpis.cancelledBookings} Cancelled
                                            </p>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="glass-card p-3 border-start border-4 border-danger">
                                            <h6 class="text-muted small text-uppercase mb-2">Avg. Stay Length</h6>
                                            <h3 class="fw-bold mb-0 text-danger">
                                                <fmt:formatNumber value="${kpis.avgStay}" pattern="#0.0" /> <small
                                                    class="fs-6">Nights</small>
                                            </h3>
                                            <p class="small text-muted mb-0 mt-1">Per reservation</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Charts Row 1 -->
                                <div class="row g-4 mb-4">
                                    <div class="col-lg-7">
                                        <div class="glass-card p-4 h-100">
                                            <h5 class="fw-bold mb-4"><i
                                                    class="fa-solid fa-chart-line me-2 text-info"></i>Revenue Trend</h5>
                                            <canvas id="revenueChart" height="300"></canvas>
                                        </div>
                                    </div>
                                    <div class="col-lg-5">
                                        <div class="glass-card p-4 h-100">
                                            <h5 class="fw-bold mb-4"><i
                                                    class="fa-solid fa-chart-pie me-2 text-warning"></i>Room Performance
                                            </h5>
                                            <canvas id="roomPerformanceChart" height="300"></canvas>
                                        </div>
                                    </div>
                                </div>

                                <!-- Charts Row 2 -->
                                <div class="row g-4">
                                    <div class="col-lg-6">
                                        <div class="glass-card p-4">
                                            <h5 class="fw-bold mb-4"><i
                                                    class="fa-solid fa-bed me-2 text-success"></i>Occupancy Trend</h5>
                                            <canvas id="occupancyChart" height="250"></canvas>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="glass-card p-4">
                                            <h5 class="fw-bold mb-4"><i
                                                    class="fa-solid fa-users me-2 text-info"></i>Guest Statistics</h5>
                                            <div class="row text-center mt-4">
                                                <div class="col-6 border-end border-secondary">
                                                    <h2 class="fw-bold text-info">${guestStats.newGuests}</h2>
                                                    <p class="text-muted small text-uppercase">New Guests</p>
                                                </div>
                                                <div class="col-6">
                                                    <h2 class="fw-bold text-success">${guestStats.returningGuests}</h2>
                                                    <p class="text-muted small text-uppercase">Returning</p>
                                                </div>
                                            </div>
                                            <div class="mt-4 pt-2">
                                                <div class="d-flex justify-content-between mb-1 small">
                                                    <span>Returning Rate</span>
                                                    <span>
                                                        <fmt:formatNumber
                                                            value="${(guestStats.returningGuests * 100.0) / (guestStats.newGuests + guestStats.returningGuests + 0.0001)}"
                                                            pattern="#0.0" />%
                                                    </span>
                                                </div>
                                                <div class="progress" style="height: 10px;">
                                                    <div class="progress-bar bg-success"
                                                        style="width: ${(guestStats.returningGuests * 100.0) / (guestStats.newGuests + guestStats.returningGuests + 0.0001)}%">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Chart.js -->
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const primaryColor = '#0dcaf0';
                            const successColor = '#198754';
                            const warningColor = '#ffc107';
                            const dangerColor = '#dc3545';
                            const gridColor = 'rgba(255, 255, 255, 0.1)';

                            // 1. Revenue Chart
                            const revenueData = ${ empty revenueTrend ?'[]': revenueTrend };
                            new Chart(document.getElementById('revenueChart'), {
                                type: 'line',
                                data: {
                                    labels: revenueData.map(d => d.date || d.label),
                                    datasets: [{
                                        label: 'Revenue (LKR)',
                                        data: revenueData.map(d => d.value),
                                        borderColor: primaryColor,
                                        backgroundColor: 'rgba(13, 202, 240, 0.1)',
                                        fill: true,
                                        tension: 0.4,
                                        borderWidth: 3,
                                        pointBackgroundColor: primaryColor
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        y: { grid: { color: gridColor }, ticks: { color: '#94a3b8' } },
                                        x: { grid: { display: false }, ticks: { color: '#94a3b8' } }
                                    },
                                    plugins: { legend: { display: false } }
                                }
                            });

                            // 2. Room Performance Chart
                            const perfData = ${ empty roomPerformance ?'[]': roomPerformance };
                            new Chart(document.getElementById('roomPerformanceChart'), {
                                type: 'doughnut',
                                data: {
                                    labels: perfData.map(d => d.type),
                                    datasets: [{
                                        data: perfData.map(d => d.revenue),
                                        backgroundColor: [primaryColor, successColor, warningColor, dangerColor, '#6610f2'],
                                        borderWidth: 0
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: { position: 'bottom', labels: { color: '#94a3b8', usePointStyle: true, padding: 20 } }
                                    }
                                }
                            });

                            // 3. Occupancy Trend (Bar)
                            const occData = ${ empty occupancyTrend ?'[]': occupancyTrend };
                            new Chart(document.getElementById('occupancyChart'), {
                                type: 'bar',
                                data: {
                                    labels: occData.map(d => d.date || d.label),
                                    datasets: [{
                                        label: 'Bookings',
                                        data: occData.map(d => d.value),
                                        backgroundColor: successColor,
                                        borderRadius: 5
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    scales: {
                                        y: { grid: { color: gridColor }, ticks: { color: '#94a3b8', precision: 0 } },
                                        x: { grid: { display: false }, ticks: { color: '#94a3b8' } }
                                    },
                                    plugins: { legend: { display: false } }
                                }
                            });
                        });
                    </script>

                    <%@ include file="footer.jspf" %>