<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <body class="manager-theme">
                        <div class="container-fluid py-4">
                            <div class="row g-4">
                                <!-- Sidebar -->
                                <div class="col-md-3 col-lg-2" data-aos="fade-right">
                                    <%@ include file="sidebar.jspf" %>
                                </div>

                                <!-- Main Content -->
                                <div class="col-md-9 col-lg-10" data-aos="fade-left">
                                    <!-- Header -->
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <h2 class="fw-bold mb-1 manager-accent-text">
                                                <c:choose>
                                                    <c:when test="${currentView == 'schedule'}">Staff Intelligence:
                                                        Schedule</c:when>
                                                    <c:when test="${currentView == 'attendance'}">Staff Intelligence:
                                                        Attendance</c:when>
                                                    <c:when test="${currentView == 'oversight'}">Operations: Revenue
                                                        Oversight</c:when>
                                                    <c:otherwise>Operational Command</c:otherwise>
                                                </c:choose>
                                            </h2>
                                            <p class="text-muted mb-0 small">
                                                <i class="fa-solid fa-location-dot me-2"></i>Ocean View Resort •
                                                <c:choose>
                                                    <c:when test="${currentView == 'dashboard' || empty currentView}">
                                                        Executive Oversight</c:when>
                                                    <c:otherwise>${currentView} Module</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <div class="text-end">
                                            <div class="btn-group manager-card p-1">
                                                <button class="btn btn-sm btn-outline-info border-0 rounded-3"
                                                    title="Notifications">
                                                    <i class="fa-solid fa-bell"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-info border-0 rounded-3 ms-2"
                                                    title="Settings">
                                                    <i class="fa-solid fa-gear"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Error/Success Alerts -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger border-0 manager-card mb-4" role="alert">
                                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                                        </div>
                                    </c:if>

                                    <!-- Dynamic View Inclusion -->
                                    <c:choose>
                                        <c:when test="${currentView == 'schedule'}">
                                            <jsp:include page="manager_views/schedule.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'attendance'}">
                                            <jsp:include page="manager_views/attendance.jsp" />
                                        </c:when>
                                        <c:when test="${currentView == 'oversight'}">
                                            <jsp:include page="manager_views/oversight.jsp" />
                                        </c:when>
                                        <c:otherwise>
                                            <jsp:include page="manager_views/dashboard.jsp" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- Global Chart.js (Loaded once) -->
                        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                        <script>
                            // Global Chart Defaults
                            Chart.defaults.color = '#94a3b8';
                            Chart.defaults.font.family = "'Outfit', sans-serif";
                        </script>

                        <%@ include file="footer.jspf" %>
                    </body>