<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Settle Account | Ocean View Luxury</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-core.css">
    </head>

    <body>
        <%@ include file="luxury-sidebar-guest.jspf" %>

            <main class="lux-main">
                <header class="mb-5">
                    <h1 class="fw-bold mb-1 text-gold">Seamless <span class="text-white">Transactions</span></h1>
                    <p class="text-white-50">Choose your preferred method to settle your luxury stay credentials.</p>
                </header>

                <div class="row g-4">
                    <!-- Summary Card -->
                    <div class="col-12 mb-4">
                        <div class="lux-card border-gold border-opacity-25 bg-gold bg-opacity-5">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h4 class="fw-bold mb-1">Current Outstanding Balance</h4>
                                    <p class="text-white-50 m-0">Invoices for your upcoming stay and recent service
                                        requests.</p>
                                </div>
                                <div class="col-md-4 text-md-end mt-4 mt-md-0">
                                    <h2 class="fw-bold text-gold mb-0">LKR 125,400.00</h2>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Online Payment Option -->
                    <div class="col-md-6">
                        <div class="lux-card h-100 p-5 text-center d-flex flex-column transition">
                            <div class="mb-4">
                                <i class="fa-solid fa-globe fa-4x text-cyan"></i>
                            </div>
                            <h3 class="fw-bold mb-3">Online Gateway</h3>
                            <p class="text-white-50 mb-5">Pay instantly using Credit Card, Debit Card, or Digital
                                Wallets through our secure encrypted portal.</p>
                            <a href="luxury-guest-portal?view=online-pay"
                                class="lux-btn lux-btn-gold mt-auto justify-content-center py-3 fs-5">Proceed to Secure
                                Pay</a>
                        </div>
                    </div>

                    <!-- Offline Payment Option -->
                    <div class="col-md-6">
                        <div class="lux-card h-100 p-5 text-center d-flex flex-column transition">
                            <div class="mb-4">
                                <i class="fa-solid fa-building-columns fa-4x text-white-50"></i>
                            </div>
                            <h3 class="fw-bold mb-3">Front Desk / Transfer</h3>
                            <p class="text-white-50 mb-5">Settle in person at the lobby via cash/POS, or upload a bank
                                transfer slip for manual verification.</p>
                            <a href="luxury-guest-portal?view=offline-pay"
                                class="lux-btn lux-btn-outline mt-auto justify-content-center py-3 fs-5"
                                style="border-color: #94a3b8; color: #94a3b8;">Manual Settlement</a>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>