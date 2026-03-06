<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Manager Report - Ocean View Resort</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <style>
                        @media print {
                            @page {
                                size: A4;
                                margin: 1cm;
                            }

                            .no-print {
                                display: none !important;
                            }

                            body {
                                background: #fff !important;
                                color: #000 !important;
                            }

                            .table {
                                border-color: #000 !important;
                            }

                            .badge {
                                border: 1px solid #000 !important;
                                color: #000 !important;
                            }
                        }

                        body {
                            background: #f8f9fa;
                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                            padding: 20px;
                        }

                        .report-header {
                            border-bottom: 2px solid #000;
                            padding-bottom: 20px;
                            margin-bottom: 30px;
                        }

                        .kpi-box {
                            border: 1px solid #dee2e6;
                            padding: 15px;
                            border-radius: 8px;
                            text-align: center;
                        }

                        .section-title {
                            background: #eee;
                            padding: 8px 15px;
                            font-weight: bold;
                            margin-bottom: 20px;
                            border-left: 5px solid #0dcaf0;
                        }
                    </style>
                </head>

                <body onload="window.print()">

                    <div class="container bg-white p-5 shadow-sm rounded">
                        <div class="report-header d-flex justify-content-between align-items-end">
                            <div>
                                <h1 class="fw-bold mb-0">Ocean View Resort</h1>
                                <p class="text-muted mb-0">Analytics & Performance Report</p>
                            </div>
                            <div class="text-end">
                                <h4 class="text-uppercase mb-1">Manager Report</h4>
                                <p class="small mb-0">Generated on:
                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMM yyyy, HH:mm" />
                                </p>
                            </div>
                        </div>

                        <div class="alert alert-info py-2 small mb-4">
                            <strong>Report Parameters:</strong>
                            Period: ${startDate} to ${endDate} |
                            Type: ${empty roomType ? 'All' : roomType} |
                            Status: ${empty status ? 'All' : status}
                        </div>

                        <div class="section-title">Summary KPIs</div>
                        <div class="row g-3 mb-5">
                            <div class="col-3">
                                <div class="kpi-box">
                                    <div class="small text-muted text-uppercase">Occupancy Rate</div>
                                    <h3 class="fw-bold mb-0">
                                        <fmt:formatNumber value="${kpis.occupancyRate}" pattern="#0.0" />%
                                    </h3>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="kpi-box">
                                    <div class="small text-muted text-uppercase">Total Revenue</div>
                                    <h3 class="fw-bold mb-0">
                                        <fmt:formatNumber value="${kpis.totalRevenue}" type="number" /> <small
                                            class="fs-6">LKR</small>
                                    </h3>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="kpi-box">
                                    <div class="small text-muted text-uppercase">Total Bookings</div>
                                    <h3 class="fw-bold mb-0">${kpis.totalBookings}</h3>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="kpi-box">
                                    <div class="small text-muted text-uppercase">Avg. Stay</div>
                                    <h3 class="fw-bold mb-0">
                                        <fmt:formatNumber value="${kpis.avgStay}" pattern="#0.0" /> <small
                                            class="fs-6">Nights</small>
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <div class="section-title">Room Type Performance</div>
                        <table class="table table-bordered table-striped align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Room Type</th>
                                    <th class="text-center">Bookings Count</th>
                                    <th class="text-end">Total Revenue (LKR)</th>
                                    <th class="text-end">Share (%)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${roomPerformance}">
                                    <tr>
                                        <td class="fw-bold">${row.type}</td>
                                        <td class="text-center">${row.count}</td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${row.revenue}" type="number" />
                                        </td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${(row.revenue * 100.0) / kpis.totalRevenue}"
                                                pattern="#0.0" />%
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="mt-5 text-center text-muted small border-top pt-3 no-print">
                            <button class="btn btn-secondary" onclick="window.close()">Close Report Window</button>
                        </div>
                    </div>

                </body>

                </html>