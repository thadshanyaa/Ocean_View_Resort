<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Billing & Payments | Ocean View Resort</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@400;600;700&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/guest-pages.css">
        <link rel="stylesheet" href="css/guest-sidebar.css">
    </head>

    <body class="guest-luxury-theme">

        <div class="guest-container">
            <%@ include file="guest-sidebar.jspf" %>

                <main class="main-content">
                    <div class="mb-5 animate-fade">
                        <h1 class="font-luxury fw-bold mb-1">Billing & <span class="text-gold">Payments</span></h1>
                        <p class="text-muted mb-0">Securely manage your invoices and financial records.</p>
                    </div>

                    <!-- Financial Summary Cards -->
                    <div class="row g-4 mb-5">
                        <div class="col-md-4 animate-fade" style="animation-delay: 0.1s;">
                            <div class="glass-card">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-gold bg-opacity-20 text-gold p-3 rounded-4 me-3">
                                        <i class="fa-solid fa-file-invoice-dollar fa-xl"></i>
                                    </div>
                                    <div>
                                        <h6 class="text-muted small text-uppercase mb-0">Total Outstanding</h6>
                                        <h4 class="font-luxury fw-bold mb-0">LKR 12,500</h4>
                                    </div>
                                </div>
                                <button class="btn btn-luxury w-100">Pay Now</button>
                            </div>
                        </div>
                        <div class="col-md-4 animate-fade" style="animation-delay: 0.2s;">
                            <div class="glass-card">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-success bg-opacity-20 text-success p-3 rounded-4 me-3">
                                        <i class="fa-solid fa-circle-check fa-xl"></i>
                                    </div>
                                    <div>
                                        <h6 class="text-muted small text-uppercase mb-0">Recently Paid</h6>
                                        <h4 class="font-luxury fw-bold mb-0">LKR 45,000</h4>
                                    </div>
                                </div>
                                <p class="text-muted small mb-0"><i class="fa-solid fa-clock me-1"></i>Last paid on Mar
                                    04, 2026</p>
                            </div>
                        </div>
                        <div class="col-md-4 animate-fade" style="animation-delay: 0.3s;">
                            <div class="glass-card">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-info bg-opacity-20 text-info p-3 rounded-4 me-3">
                                        <i class="fa-solid fa-receipt fa-xl"></i>
                                    </div>
                                    <div>
                                        <h6 class="text-muted small text-uppercase mb-0">Total Invoices</h6>
                                        <h4 class="font-luxury fw-bold mb-0">8 Invoices</h4>
                                    </div>
                                </div>
                                <a href="#" class="text-gold small text-decoration-none fw-bold">Download All Receipts
                                    <i class="fa-solid fa-chevron-right ms-1"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Invoices Table -->
                    <div class="glass-card animate-fade" style="animation-delay: 0.4s;">
                        <h5 class="font-luxury fw-bold mb-4">Transaction History</h5>
                        <div class="table-responsive">
                            <table class="table table-dark table-hover align-middle mb-0">
                                <thead class="text-gold small text-uppercase">
                                    <tr>
                                        <th class="border-0 pb-3">Bill ID</th>
                                        <th class="border-0 pb-3">Date</th>
                                        <th class="border-0 pb-3">Description</th>
                                        <th class="border-0 pb-3">Amount</th>
                                        <th class="border-0 pb-3">Status</th>
                                        <th class="border-0 pb-3 text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="border-top border-glass border-opacity-20">
                                    <tr>
                                        <td class="small fw-bold">INV-9901</td>
                                        <td>Mar 06, 2026</td>
                                        <td>Room Service - Breakfast</td>
                                        <td>LKR 3,500</td>
                                        <td><span
                                                class="badge bg-warning bg-opacity-20 text-warning px-3 rounded-pill">Unpaid</span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-gold px-3">Pay</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="small fw-bold">INV-9852</td>
                                        <td>Mar 04, 2026</td>
                                        <td>Stay Deposit - Deluxe Ocean</td>
                                        <td>LKR 45,000</td>
                                        <td><span
                                                class="badge bg-success bg-opacity-20 text-success px-3 rounded-pill">Paid</span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-light border-glass rounded-3"
                                                title="View"><i class="fa-solid fa-eye"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="small fw-bold">INV-9810</td>
                                        <td>Mar 02, 2026</td>
                                        <td>Airport Transfer Service</td>
                                        <td>LKR 9,000</td>
                                        <td><span
                                                class="badge bg-success bg-opacity-20 text-success px-3 rounded-pill">Paid</span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-outline-light border-glass rounded-3"
                                                title="View"><i class="fa-solid fa-eye"></i></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/guest-billing.js"></script>
    </body>

    </html>