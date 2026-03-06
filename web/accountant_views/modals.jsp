<%@ page pageEncoding="UTF-8" %>
    <!-- Refund Modal -->
    <div class="modal fade" id="refundModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0 rounded-4">
                <div class="modal-header border-0 pb-0">
                    <h5 class="fw-bold"><i class="fa-solid fa-rotate-left me-2 text-primary"></i>Financial Refund</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="RefundServlet" method="POST">
                    <div class="modal-body p-4">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Reservation Reference</label>
                            <input type="number" name="reservationId" class="form-control rounded-3"
                                placeholder="RES-ID" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Refund Amount (LKR)</label>
                            <input type="number" step="0.01" name="amount" class="form-control rounded-3"
                                placeholder="0.00" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Reason for Refund</label>
                            <textarea name="reason" class="form-control rounded-3" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold shadow">Process Refund
                            Now</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Report Modal -->
    <div class="modal fade" id="reportModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0 rounded-4">
                <div class="modal-header border-0 pb-0">
                    <h5 class="fw-bold"><i class="fa-solid fa-file-export me-2 text-info"></i>Financial Intelligence
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="AccountantReportServlet" method="GET">
                    <div class="modal-body p-4">
                        <div class="row g-3">
                            <div class="col-6">
                                <label class="form-label small fw-bold">Period From</label>
                                <input type="date" name="startDate" class="form-control rounded-3" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label small fw-bold">Period To</label>
                                <input type="date" name="endDate" class="form-control rounded-3" required>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="submit" name="type" value="pdf"
                            class="btn btn-dark w-100 py-2 rounded-3 fw-bold shadow">
                            <i class="fa-solid fa-print me-2"></i>Generate Statement
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>