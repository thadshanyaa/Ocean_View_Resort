<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="row g-4">
            <div class="col-12">
                <div class="finance-card" style="min-height: 500px;">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0 text-dark"><i
                                class="fa-solid fa-chart-line me-2 text-primary"></i>Revenue Performance Analytics</h5>
                        <div class="small text-muted">Periodic Growth Index</div>
                    </div>

                    <div style="height: 400px;">
                        <canvas id="analyticsBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>