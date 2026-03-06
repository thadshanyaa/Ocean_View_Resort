<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>Financial Report - Ocean View Resort</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap"
                        rel="stylesheet">
                    <style>
                        body {
                            font-family: 'Outfit', sans-serif;
                            background-color: #f8fafc;
                            color: #1e293b;
                            padding: 2rem;
                        }

                        .report-paper {
                            background: #fff;
                            padding: 3rem;
                            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
                            border-radius: 0.5rem;
                            min-height: 29.7cm;
                            /* A4 height */
                            margin: auto;
                            max-width: 21cm;
                            /* A4 width */
                        }

                        .header-accent {
                            border-bottom: 4px solid #0ea5e9;
                            padding-bottom: 1.5rem;
                            margin-bottom: 2rem;
                        }

                        .luxury-brand {
                            font-weight: 800;
                            color: #0a1128;
                            letter-spacing: -1px;
                        }

                        .luxury-brand span {
                            color: #0ea5e9;
                        }

                        .table thead {
                            background-color: #0f172a;
                            color: #fff;
                        }

                        .table-stripey tbody tr:nth-child(even) {
                            background-color: #f1f5f9;
                        }

                        @media print {
                            body {
                                background: none;
                                padding: 0;
                            }

                            .report-paper {
                                box-shadow: none;
                                border-radius: 0;
                                padding: 0;
                                width: 100%;
                                max-width: 100%;
                            }

                            .no-print {
                                display: none !important;
                            }
                        }
                    </style>
                </head>

                <body onload="window.print()">

                    <div class="report-paper">
                        <div class="header-accent d-flex justify-content-between align-items-end">
                            <div>
                                <h2 class="luxury-brand mb-1">Ocean<span>View</span> Resort</h2>
                                <p class="text-muted small mb-0">Financial Operations & Intelligence Unit</p>
                            </div>
                            <div class="text-end">
                                <h5 class="fw-bold text-uppercase mb-1">Financial Performance Report</h5>
                                <p class="small mb-0">Period: <span class="fw-bold">${startDate}</span> to <span
                                        class="fw-bold">${endDate}</span></p>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-8">
                                <h6 class="text-uppercase text-muted fw-bold extra-small mb-3"
                                    style="letter-spacing: 1px;">Scope of Analysis</h6>
                                <p class="small">This document provides a detailed breakdown of all successfully
                                    processed payments within the specified timeframe. All values are in Sri Lankan
                                    Rupees (LKR).</p>
                            </div>
                            <div class="col-4 text-end">
                                <h6 class="text-uppercase text-muted fw-bold extra-small mb-3"
                                    style="letter-spacing: 1px;">Report Metadata</h6>
                                <p class="small mb-0">Printed on:
                                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMM yyyy, HH:mm" />
                                </p>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-stripey align-middle small">
                                <thead>
                                    <tr>
                                        <th class="ps-3">Date</th>
                                        <th>Res #</th>
                                        <th>Guest</th>
                                        <th>Method</th>
                                        <th class="text-end pe-3">Amount (LKR)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="grandTotal" value="0" />
                                    <c:forEach var="p" items="${payments}">
                                        <tr>
                                            <td class="ps-3">
                                                <fmt:formatDate value="${p.paidAt}" pattern="dd-MM-yyyy" />
                                            </td>
                                            <td class="fw-bold">${p.resNo}</td>
                                            <td>${p.guestName}</td>
                                            <td class="text-uppercase small">${p.method}</td>
                                            <td class="text-end fw-bold pe-3">
                                                <fmt:formatNumber value="${p.amount}" type="number" />
                                            </td>
                                        </tr>
                                        <c:set var="grandTotal" value="${grandTotal + p.amount}" />
                                    </c:forEach>
                                    <c:if test="${empty payments}">
                                        <tr>
                                            <td colspan="5" class="text-center py-5 text-muted">No data points found for
                                                this selection.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                                <tfoot class="border-top border-dark">
                                    <tr>
                                        <td colspan="4" class="text-end fw-bold text-uppercase py-3">Aggregate
                                            Collection Value</td>
                                        <td class="text-end fw-bold text-primary fs-5 pe-3 py-3">
                                            <fmt:formatNumber value="${grandTotal}" type="number" />
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="mt-5 pt-5 border-top">
                            <div class="row">
                                <div class="col-6">
                                    <div class="border-bottom border-dark mb-2" style="height: 40px; width: 200px;">
                                    </div>
                                    <p class="small fw-bold mb-0">Accountant Signature</p>
                                    <p class="extra-small text-muted text-uppercase">${sessionScope.user.username}</p>
                                </div>
                                <div class="col-6 text-end">
                                    <div class="border-bottom border-dark mb-2 ms-auto"
                                        style="height: 40px; width: 200px;"></div>
                                    <p class="small fw-bold mb-0">System Validation Seal</p>
                                    <p class="extra-small text-muted">GENERATED VIA OVR INTELLIGENCE</p>
                                </div>
                            </div>
                        </div>

                        <div class="mt-5 text-center no-print">
                            <button class="btn btn-secondary btn-sm rounded-pill px-4" onclick="window.close()">Close
                                Window</button>
                        </div>
                    </div>

                    <style>
                        .extra-small {
                            font-size: 0.65rem;
                        }
                    </style>

                </body>

                </html>