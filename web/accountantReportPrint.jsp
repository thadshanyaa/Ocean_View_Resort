<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Financial Report - Ocean View Resort</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <style>
                        @media print {
                            .no-print {
                                display: none !important;
                            }

                            body {
                                background: #fff !important;
                                color: #000 !important;
                            }
                        }

                        body {
                            padding: 40px;
                        }

                        .report-header {
                            border-bottom: 2px solid #333;
                            padding-bottom: 20px;
                            margin-bottom: 30px;
                        }
                    </style>
                </head>

                <body onload="window.print()">

                    <div class="container">
                        <div class="report-header d-flex justify-content-between">
                            <div>
                                <h1 class="fw-bold">Ocean View Resort</h1>
                                <p class="text-muted">Financial Performance Report</p>
                            </div>
                            <div class="text-end">
                                <h4 class="text-uppercase">Accountant Copy</h4>
                                <p>Period: ${startDate} to ${endDate}</p>
                            </div>
                        </div>

                        <table class="table table-bordered align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Res #</th>
                                    <th>Guest</th>
                                    <th>Method</th>
                                    <th>Reference</th>
                                    <th class="text-end">Amount (LKR)</th>
                                    <th>Paid At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="total" value="0" />
                                <c:forEach var="p" items="${payments}">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td>${p.resNo}</td>
                                        <td>${p.guestName}</td>
                                        <td>${p.method}</td>
                                        <td>${p.ref}</td>
                                        <td class="text-end fw-bold">
                                            <fmt:formatNumber value="${p.amount}" type="number" />
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${p.paidAt}" pattern="dd MMM yyyy HH:mm" />
                                        </td>
                                    </tr>
                                    <c:set var="total" value="${total + p.amount}" />
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr class="table-info">
                                    <td colspan="5" class="text-end fw-bold text-uppercase">Total Collections</td>
                                    <td class="text-end fw-bold text-primary fs-5">
                                        <fmt:formatNumber value="${total}" type="number" />
                                    </td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>

                        <div class="mt-5 text-center text-muted small no-print">
                            <button class="btn btn-secondary" onclick="window.close()">Close Window</button>
                        </div>
                    </div>

                </body>

                </html>