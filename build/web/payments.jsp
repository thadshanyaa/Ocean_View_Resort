<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <div class="container py-5 my-5">
            <div class="row justify-content-center">
                <div class="col-md-6" data-aos="flip-left">
                    <div class="glass-card p-5">
                        <div class="text-center mb-4">
                            <i class="fa-solid fa-credit-card fa-3x text-success mb-3"
                                style="filter: drop-shadow(0 0 10px rgba(25, 135, 84, 0.5));"></i>
                            <h3 class="fw-bold m-0">Secure Checkout</h3>
                            <p class="text-muted small mt-1">Settle your outstanding balance safely</p>
                        </div>

                        <form action="PaymentServlet" method="POST">
                            <input type="hidden" name="billId" value="<%= request.getParameter(" billId") %>">

                            <div class="mb-4 text-center p-3 bg-dark bg-opacity-50 border border-secondary rounded">
                                <span class="text-muted text-uppercase small fw-bold">Amount Due</span>
                                <h2 class="text-danger m-0 fw-bold">$<%= request.getParameter("due") !=null ?
                                        request.getParameter("due") : "0.00" %>
                                </h2>
                                <input type="hidden" name="amountPaid" value="<%= request.getParameter(" due") %>">
                            </div>

                            <div class="mb-4">
                                <label class="form-label text-light">Select Payment Method</label>
                                <select name="paymentMethod" class="form-select border-info" required>
                                    <option value="Online">Online Gateway (Credit/Debit instantly)</option>
                                    <option value="Card">Pay at Reception (Card Reader)</option>
                                    <option value="Cash">Pay at Reception (Cash)</option>
                                </select>
                            </div>

                            <div id="cardDetails" class="mb-4 fade-in">
                                <div class="row g-2">
                                    <div class="col-12">
                                        <input type="text" class="form-control" placeholder="Card Number (Dummy)"
                                            maxlength="16">
                                    </div>
                                    <div class="col-6">
                                        <input type="text" class="form-control" placeholder="MM/YY">
                                    </div>
                                    <div class="col-6">
                                        <input type="text" class="form-control" placeholder="CVV" maxlength="3">
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-success w-100 py-2 fw-bold"
                                style="letter-spacing: 1px;"><i class="fa-solid fa-lock me-2"></i>PAY NOW</button>
                            <p class="text-center text-muted small mt-3 m-0"><i
                                    class="fa-solid fa-shield-halved me-1"></i> Transaction is secured via SSL/TLS and
                                Gateway Adapter pattern.</p>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.querySelector('select[name="paymentMethod"]').addEventListener('change', function (e) {
                if (e.target.value === 'Online') {
                    document.getElementById('cardDetails').classList.remove('d-none');
                } else {
                    document.getElementById('cardDetails').classList.add('d-none');
                }
            });
        </script>

        <%@ include file="footer.jspf" %>
