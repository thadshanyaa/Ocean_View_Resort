<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="finance-card">
                        <h5 class="fw-bold mb-4 text-dark"><i
                                class="fa-solid fa-hand-holding-dollar me-2 text-warning"></i>Operational Expenses</h5>
                        <div class="table-responsive">
                            <table class="table finance-table align-middle">
                                <thead>
                                    <tr>
                                        <th>Category</th>
                                        <th class="text-end">Budget Allocation (LKR)</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="e" items="${expenseData}">
                                        <tr>
                                            <td class="fw-bold"><i
                                                    class="fa-solid fa-circle-dot me-2 text-warning small"></i>
                                                ${e.category}</td>
                                            <td class="text-end fw-bold">
                                                <fmt:formatNumber value="${e.amount}" type="number" />
                                            </td>
                                            <td><span class="badge bg-light text-success border">Within Budget</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="finance-card bg-warning bg-opacity-10 border-warning border-opacity-25">
                        <h6 class="fw-bold text-dark mb-3">Expense Summary</h6>
                        <h3 class="fw-bold text-dark">LKR 240,000</h3>
                        <p class="text-muted small">Total operational cost for the current month.</p>
                        <hr>
                        <div class="small text-muted mb-2">Highest Expense: **Staff Salary**</div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-warning" style="width: 50%;"></div>
                        </div>
                    </div>
                </div>
            </div>