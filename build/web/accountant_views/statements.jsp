<%@ page pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="finance-card">
                    <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-file-pdf me-2 text-danger"></i>Financial
                        Statement Repository</h5>
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <div class="fw-bold text-dark">Monthly Revenue Summary</div>
                                <div class="small text-muted">Format: PDF • Comprehensive breakdown of all payments
                                </div>
                            </div>
                            <a href="AccountantReportServlet?type=pdf"
                                class="btn btn-sm btn-dark rounded-pill px-3">Download</a>
                        </div>
                        <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <div class="fw-bold text-dark">Outstanding Payment Register</div>
                                <div class="small text-muted">Format: XLSX • List of pending guest balances</div>
                            </div>
                            <a href="#" class="btn btn-sm btn-outline-dark rounded-pill px-3">Export</a>
                        </div>
                        <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <div class="fw-bold text-dark">Annual Income Statement</div>
                                <div class="small text-muted">Format: PDF • FY2025 Financial Overview</div>
                            </div>
                            <a href="#" class="btn btn-sm btn-outline-dark rounded-pill px-3">View</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="finance-card bg-info bg-opacity-10 border-info border-opacity-25">
                    <h6 class="fw-bold text-dark mb-3">Intelligence Hub</h6>
                    <p class="small text-muted">Use the "Generate Reports" button at the top if you need a specific
                        custom date range for your statements.</p>
                    <i class="fa-solid fa-lightbulb text-info fa-2x opacity-50 mt-2"></i>
                </div>
            </div>
        </div>