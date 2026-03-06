<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <div class="row g-4">
                <div class="col-12">
                    <div class="finance-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-receipt me-2 text-info"></i>Payment
                                Ledger</h5>
                            <button class="btn btn-outline-dark btn-sm rounded-pill px-3" onclick="window.print()">
                                <i class="fa-solid fa-print me-2"></i>Print Ledger
                            </button>
                        </div>

                        <div class="table-responsive">
                            <table class="table finance-table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>DateTime</th>
                                        <th>ID</th>
                                        <th>Res #</th>
                                        <th>Guest Profile</th>
                                        <th>Method</th>
                                        <th class="text-end">Amount</th>
                                        <th class="text-center">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${fullHistory}">
                                        <tr>
                                            <td class="text-muted small">
                                                <fmt:formatDate value="${p.paidAt}" pattern="dd MMM YYYY, HH:mm" />
                                            </td>
                                            <td class="small">#TRX-${p.id}</td>
                                            <td><span class="badge bg-light text-dark border px-2">${p.resNo}</span>
                                            </td>
                                            <td class="fw-bold text-dark">${p.guestName}</td>
                                            <td class="small text-uppercase"><i
                                                    class="fa-solid fa-landmark-dome me-1 text-muted"></i> ${p.method}
                                            </td>
                                            <td class="text-end fw-bold text-dark">
                                                <fmt:formatNumber value="${p.amount}" type="number" />
                                            </td>
                                            <td class="text-center">
                                                <span
                                                    class="badge ${p.status == 'PAID' ? 'bg-success' : 'bg-warning'} bg-opacity-10 text-${p.status == 'PAID' ? 'success' : 'warning'} rounded-pill px-3">
                                                    ${p.status}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>