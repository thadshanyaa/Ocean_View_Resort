<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <body class="accountant-theme">
                        <div class="container-fluid py-4">
                            <div class="row g-4">
                                <!-- Sidebar -->
                                <div class="col-md-3 col-lg-2" data-aos="fade-right">
                                    <%@ include file="sidebar.jspf" %>
                                </div>

                                <!-- Main Content -->
                                <div class="col-md-9 col-lg-10" data-aos="fade-left">
                                    <!-- Header -->
                                    <div
                                        class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                                        <div>
                                            <nav aria-label="breadcrumb">
                                                <ol class="breadcrumb mb-1">
                                                    <li class="breadcrumb-item"><a href="AccountantDashboardServlet"
                                                            class="text-decoration-none text-muted small">Ocean View</a>
                                                    </li>
                                                    <li class="breadcrumb-item active small" aria-current="page">
                                                        Treasury Intelligence</li>
                                                </ol>
                                            </nav>
                                            <h4 class="fw-bold mb-0 text-dark">
                                                <c:choose>
                                                    <c:when test="${currentView == 'dashboard'}">Financial Operations
                                                        Hub</c:when>
                                                    <c:when test="${currentView == 'billing'}">Billing & Invoice Console
                                                    </c:when>
                                                    <c:when test="${currentView == 'history'}">Payment Transaction
                                                        Ledger</c:when>
                                                    <c:when test="${currentView == 'expenses'}">Operational Expense
                                                        Tracker</c:when>
                                                    <c:when test="${currentView == 'analytics'}">Revenue Growth
                                                        Analytics</c:when>
                                                    <c:when test="${currentView == 'statements'}">Financial Statement
                                                        Repository</c:when>
                                                    <c:otherwise>Accountant Workspace</c:otherwise>
                                                </c:choose>
                                            </h4>
                                        </div>
                                        <div class="text-end">
                                            <button class="btn btn-outline-dark btn-sm rounded-pill px-3 shadow-sm"
                                                data-bs-toggle="modal" data-bs-target="#reportModal">
                                                <i class="fa-solid fa-file-invoice-dollar me-2"></i>Quick Report
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Alert for Errors -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger alert-dismissible fade show rounded-4"
                                            role="alert">
                                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                        </div>
                                    </c:if>

                                    <!-- Dynamic View Content -->
                                    <c:choose>
                                        <c:when test="${currentView == 'dashboard'}">
                                            <jsp:include page="accountant_views/dashboard.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'billing'}">
                                            <jsp:include page="accountant_views/billing.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'history'}">
                                            <jsp:include page="accountant_views/history.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'expenses'}">
                                            <jsp:include page="accountant_views/expenses.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'analytics'}">
                                            <jsp:include page="accountant_views/analytics.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'statements'}">
                                            <jsp:include page="accountant_views/statements.jsp" />
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- Modals (Simplified) -->
                        <jsp:include page="accountant_views/modals.jsp" />

                        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const ctx = document.getElementById('dashboardTrendChart');
                                const ctxAnalytics = document.getElementById('analyticsBarChart');

                                if (ctx || ctxAnalytics) {
                                    const rawData = '${revenueTrendJson}';
                                    const revenueData = rawData ? JSON.parse(rawData) : [];

                                    if (ctx) {
                                        new Chart(ctx.getContext('2d'), {
                                            type: 'line',
                                            data: {
                                                labels: revenueData.slice(-7).map(d => d.date),
                                                datasets: [{
                                                    label: 'Revenue',
                                                    data: revenueData.slice(-7).map(d => d.revenue),
                                                    borderColor: '#0ea5e9',
                                                    backgroundColor: 'rgba(14, 165, 233, 0.1)',
                                                    fill: true,
                                                    tension: 0.4
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: { legend: { display: false } }
                                            }
                                        });
                                    }

                                    if (ctxAnalytics) {
                                        new Chart(ctxAnalytics.getContext('2d'), {
                                            type: 'bar',
                                            data: {
                                                labels: revenueData.map(d => d.date),
                                                datasets: [{
                                                    label: 'LKR Revenue',
                                                    data: revenueData.map(d => d.revenue),
                                                    backgroundColor: '#0ea5e9',
                                                    borderRadius: 5
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                scales: {
                                                    y: { beginAtZero: true }
                                                }
                                            }
                                        });
                                    }
                                }
                            });
                        </script>

                        <%@ include file="footer.jspf" %>
                    </body>