<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

        <div class="row g-4" data-aos="fade-up">
            <!-- Main Oversight Chart -->
            <div class="col-lg-8">
                <div class="manager-card h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h6 class="fw-bold mb-0 text-info font-outfit uppercase tracking-wider">
                            <i class="fa-solid fa-chart-line me-2"></i>Weekly Revenue Pulse
                        </h6>
                        <div class="badge bg-info bg-opacity-10 text-info">Live Monitoring</div>
                    </div>
                    <div style="height: 350px;">
                        <canvas id="oversightTrendChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Summary Metrics -->
            <div class="col-lg-4">
                <div class="manager-card mb-4 bg-gradient-navy border-0">
                    <h6 class="text-muted small text-uppercase fw-bold mb-3">Total Collections</h6>
                    <h2 class="fw-bold mb-2 manager-accent-text">
                        LKR
                        <fmt:formatNumber value="${revenueKPIs.totalRevenue}" />
                    </h2>
                    <div class="progress mb-2" style="height: 4px; background: rgba(255,255,255,0.05);">
                        <div class="progress-bar bg-info" style="width: 75%"></div>
                    </div>
                    <p class="extra-small text-muted mb-0"><i class="fa-solid fa-arrow-trend-up text-success me-1"></i>
                        12% increase from last week</p>
                </div>

                <div class="manager-card border-0" style="background: rgba(30, 41, 59, 0.4);">
                    <div class="d-flex justify-content-between mb-3 pt-2">
                        <span class="text-muted small">Pending Payments</span>
                        <span class="text-warning fw-bold">${revenueKPIs.pendingCount}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted small">Completed Today</span>
                        <span class="text-success fw-bold">18</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted small">Average Value</span>
                        <span class="text-light fw-bold">LKR 12.5K</span>
                    </div>
                    <hr class="border-secondary opacity-25">
                    <button class="btn btn-sm btn-outline-info w-100 rounded-pill mt-2">Generate Financial
                        Report</button>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const trendRaw = '${weeklyTrendJson}';
                const trendData = trendRaw ? JSON.parse(trendRaw) : [];

                const ctx = document.getElementById('oversightTrendChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: trendData.map(d => d.label),
                        datasets: [{
                            label: 'Revenue (LKR)',
                            data: trendData.map(d => d.value),
                            borderColor: '#38bdf8',
                            backgroundColor: 'rgba(56, 189, 248, 0.1)',
                            borderWidth: 3,
                            pointBackgroundColor: '#38bdf8',
                            pointRadius: 4,
                            pointHoverRadius: 6,
                            fill: true,
                            tension: 0.4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: { color: 'rgba(255, 255, 255, 0.05)', drawBorder: false },
                                ticks: { color: '#94a3b8', font: { size: 10 } }
                            },
                            x: {
                                grid: { display: false },
                                ticks: { color: '#94a3b8', font: { size: 10 } }
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
            });
        </script>