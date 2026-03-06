<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

        <!-- KPI Quick Row -->
        <div class="row g-3 mb-4" data-aos="fade-down">
            <div class="col-md-3">
                <div class="manager-card border-start border-info border-4">
                    <h6 class="text-muted small text-uppercase mb-2">Live Occupancy</h6>
                    <div class="d-flex align-items-end">
                        <h3 class="fw-bold mb-0">${kpis.occupancyRate}%</h3>
                        <span class="ms-2 text-success small mb-1"><i class="fa-solid fa-caret-up"></i> 2.4%</span>
                    </div>
                    <div class="progress mt-2" style="height: 4px; background: rgba(56, 189, 248, 0.1);">
                        <div class="progress-bar bg-info" style="width: ${kpis.occupancyRate}%"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="manager-card border-start border-success border-4">
                    <h6 class="text-muted small text-uppercase mb-2">Daily Revenue</h6>
                    <div class="d-flex align-items-end">
                        <h3 class="fw-bold mb-0 text-success">
                            <fmt:formatNumber value="${kpis.totalRevenue}" type="number" />
                        </h3>
                        <span class="ms-1 small mb-1 text-muted">LKR</span>
                    </div>
                    <p class="extra-small text-muted mb-0">Updated 5m ago</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="manager-card border-start border-warning border-4">
                    <h6 class="text-muted small text-uppercase mb-2">Room Status</h6>
                    <div class="d-flex justify-content-between">
                        <div>
                            <span class="d-block fw-bold text-info">${roomOverview.available}</span>
                            <span class="extra-small text-muted">Available</span>
                        </div>
                        <div class="text-end">
                            <span class="d-block fw-bold text-warning">${roomOverview.occupied}</span>
                            <span class="extra-small text-muted">Occupied</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="manager-card border-start border-danger border-4">
                    <h6 class="text-muted small text-uppercase mb-2">Active Guests</h6>
                    <h3 class="fw-bold mb-0 text-danger">${kpis.totalBookings}</h3>
                    <p class="extra-small text-muted mb-0">In-house currently</p>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left Column: Operations -->
            <div class="col-lg-8">
                <!-- Performance Analytics (Bar Chart) -->
                <div class="manager-card mb-4" style="min-height: 480px;">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h6 class="fw-bold mb-0"><i class="fa-solid fa-chart-column me-2 text-info"></i>Weekly Revenue
                            Trend</h6>
                        <div class="small text-muted">Last 7 Days (LKR)</div>
                    </div>
                    <div style="height: 350px;">
                        <canvas id="revenueBarChart"></canvas>
                    </div>
                </div>

                <!-- Guest Activity Feed -->
                <div class="manager-card">
                    <h6 class="fw-bold mb-4"><i class="fa-solid fa-bolt me-2 text-warning"></i>Live Activity Feed</h6>
                    <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                        <table class="table table-dark table-hover align-middle small border-0">
                            <tbody class="border-0">
                                <c:forEach var="log" items="${activityFeed}">
                                    <tr>
                                        <td style="width: 40px;">
                                            <div class="bg-info bg-opacity-10 text-info rounded-circle d-flex align-items-center justify-content-center"
                                                style="width: 32px; height: 32px;">
                                                <i class="fa-solid fa-user-ninja" style="font-size: 0.8rem;"></i>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-info">${log.user}</span>
                                            <span class="text-muted ms-1">${log.action}</span>
                                            <div class="extra-small text-muted">${log.details}</div>
                                        </td>
                                        <td class="text-end text-muted extra-small">
                                            <fmt:formatDate value="${log.time}" pattern="HH:mm" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Right Column: Staff & Status -->
            <div class="col-lg-4">
                <!-- Live Reception Desk -->
                <div class="manager-card mb-4"
                    style="background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9)); min-height: 300px;">
                    <h6 class="fw-bold mb-4"><i class="fa-solid fa-door-open me-2 text-success"></i>Live Reception Desk
                    </h6>
                    <c:forEach var="staff" items="${receptionistStatus}">
                        <div class="receptionist-pill d-flex align-items-center">
                            <div class="position-relative me-3">
                                <img src="https://ui-avatars.com/api/?name=${staff.name}&background=0ea5e9&color=fff&size=45"
                                    class="rounded-circle border border-info" alt="Staff">
                                <span class="live-indicator position-absolute bottom-0 end-0 m-0"
                                    style="border: 2px solid #0f172a;"></span>
                            </div>
                            <div class="flex-grow-1">
                                <div class="fw-bold small mb-0">${staff.name}</div>
                                <div class="extra-small text-info opacity-75">
                                    <i class="fa-regular fa-clock me-1"></i> Shift:
                                    <fmt:formatDate value="${staff.checkIn}" pattern="HH:mm" />
                                </div>
                            </div>
                            <div class="text-end">
                                <div class="badge bg-success bg-opacity-20 text-success extra-small mb-1">ON DUTY</div>
                                <div class="extra-small text-muted" style="font-size: 0.65rem;">Active Now</div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty receptionistStatus}">
                        <div class="text-center py-5">
                            <i class="fa-solid fa-user-slash fa-2x text-muted mb-3 opacity-25"></i>
                            <p class="text-muted small mb-0">No active staff on duty</p>
                        </div>
                    </c:if>
                </div>

                <!-- Room Performance Chart -->
                <div class="manager-card mb-4">
                    <h6 class="fw-bold mb-4"><i class="fa-solid fa-bed me-2 text-primary"></i>Utilization by Category
                    </h6>
                    <div style="height: 280px; position: relative;">
                        <canvas id="roomPerformanceChart"></canvas>
                    </div>
                </div>

                <!-- Quick Status -->
                <div class="manager-card bg-info bg-opacity-10 border-0">
                    <div class="d-flex align-items-center">
                        <div class="bg-info bg-opacity-25 rounded-3 p-3 me-3 text-info">
                            <i class="fa-solid fa-cloud-sun fa-xl"></i>
                        </div>
                        <div>
                            <div class="fw-bold small">Resort Conditions</div>
                            <div class="text-muted extra-small">Sunny • 28°C • Light Breeze</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const accentColor = '#38bdf8';
                const gridColor = 'rgba(255, 255, 255, 0.05)';
                Chart.defaults.color = '#94a3b8';
                Chart.defaults.font.family = "'Outfit', sans-serif";

                // 1. PERFORMANCE BAR CHART
                const rawRev7 = '${revenueTrend7Days}';
                const revData7 = rawRev7 ? JSON.parse(rawRev7) : [];

                const ctxBar = document.getElementById('revenueBarChart').getContext('2d');
                new Chart(ctxBar, {
                    type: 'bar',
                    data: {
                        labels: revData7.map(d => d.label),
                        datasets: [{
                            label: 'Revenue (LKR)',
                            data: revData7.map(d => d.value),
                            backgroundColor: 'rgba(56, 189, 248, 0.6)',
                            hoverBackgroundColor: accentColor,
                            borderRadius: 8,
                            borderSkipped: false,
                            barThickness: 30
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: { color: gridColor, drawBorder: false },
                                ticks: { font: { size: 10 } }
                            },
                            x: {
                                grid: { display: false },
                                ticks: { font: { size: 10 } }
                            }
                        },
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                backgroundColor: '#1e293b',
                                padding: 12,
                                callbacks: {
                                    label: function (context) {
                                        return 'LKR ' + context.parsed.y.toLocaleString();
                                    }
                                }
                            }
                        }
                    }
                });

                // 2. ROOM UTILIZATION CHART
                const rawPerf = '${roomPerformance}';
                const perfData = rawPerf ? JSON.parse(rawPerf) : [];

                new Chart(document.getElementById('roomPerformanceChart').getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: perfData.map(d => d.type),
                        datasets: [{
                            data: perfData.map(d => d.revenue),
                            backgroundColor: ['#38bdf8', '#10b981', '#f59e0b', '#ef4444', '#6366f1'],
                            borderWidth: 0,
                            hoverOffset: 20
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '65%',
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: { usePointStyle: true, padding: 25, color: '#cbd5e1' }
                            }
                        }
                    }
                });
            });
        </script>