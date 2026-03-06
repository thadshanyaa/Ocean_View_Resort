<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Secure Online Payment | Ocean View Luxury</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-core.css">
        <style>
            .cc-form .form-control {
                background: #1e293b;
                border: 1px solid rgba(255, 255, 255, 0.1);
                color: white;
                padding: 12px;
            }

            .cc-form .form-control:focus {
                border-color: var(--lux-gold);
                box-shadow: none;
            }
        </style>
    </head>

    <body>
        <%@ include file="luxury-sidebar-guest.jspf" %>

            <main class="lux-main">
                <header class="mb-5">
                    <a href="luxury-guest-portal?view=payments"
                        class="text-white-50 text-decoration-none mb-3 d-inline-block small">
                        <i class="fa-solid fa-arrow-left me-1"></i> Back to Hub
                    </a>
                    <h1 class="fw-bold mb-1 text-gold">Elite <span class="text-white">SecurePay</span></h1>
                    <p class="text-white-50">256-bit encrypted gateway for premium transactions.</p>
                </header>

                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-8">
                        <div class="lux-card cc-form shadow-lg">
                            <div class="d-flex justify-content-between align-items-center mb-5">
                                <h5 class="fw-bold mb-0">Payment Details</h5>
                                <div class="d-flex gap-2">
                                    <i class="fa-brands fa-cc-visa fa-2x text-white-50"></i>
                                    <i class="fa-brands fa-cc-mastercard fa-2x text-white-50"></i>
                                </div>
                            </div>

                            <form
                                onsubmit="event.preventDefault(); alert('Transaction processed successfully via secure gateway.'); window.location.href='luxury-guest-portal?view=payments';">
                                <div class="mb-4">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Cardholder
                                        Name</label>
                                    <input type="text" class="form-control" placeholder="AS APPEARS ON CARD" required>
                                </div>
                                <div class="mb-4">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Card Number</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="XXXX XXXX XXXX XXXX"
                                            maxlength="19" required>
                                        <span class="input-group-text bg-dark border-0 text-white-50"><i
                                                class="fa-solid fa-lock"></i></span>
                                    </div>
                                </div>
                                <div class="row mb-5">
                                    <div class="col-md-6">
                                        <label class="small text-white-50 text-uppercase mb-2 d-block">Expiry
                                            Date</label>
                                        <input type="text" class="form-control" placeholder="MM / YY" maxlength="5"
                                            required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="small text-white-50 text-uppercase mb-2 d-block">CVV / CVC</label>
                                        <input type="password" class="form-control" placeholder="***" maxlength="3"
                                            required>
                                    </div>
                                </div>

                                <div
                                    class="p-3 mb-4 rounded-3 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center">
                                    <span class="small">Processing Amount:</span>
                                    <h4 class="fw-bold text-gold mb-0">LKR 125,400.00</h4>
                                </div>

                                <button type="submit" class="lux-btn lux-btn-gold w-100 py-3 fs-5">Authorize
                                    Payment</button>
                            </form>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>