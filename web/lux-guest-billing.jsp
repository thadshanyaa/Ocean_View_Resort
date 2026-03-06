<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Billing & Payments | Elite Guest</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@500;700&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/lux-guest-pages.css">
        <link rel="stylesheet" href="css/lux-guest-sidebar.css">
    </head>

    <body class="lux-guest-theme">

        <div class="d-flex">
            <%@ include file="lux-guest-sidebar.jspf" %>

                <main class="lux-main-content">
                    <header class="mb-5 lux-animate">
                        <h1 class="font-heading fw-bold mb-1">Financial <span class="text-gold">Portfolio</span></h1>
                        <p class="text-white-50">Manage your resort billing, invoices, and secure payment records.</p>
                    </header>

                    <div class="row g-4 mb-5">
                        <!-- Outstanding Balance Card -->
                        <div class="col-lg-5 lux-animate">
                            <div class="lux-card h-100"
                                style="background: linear-gradient(135deg, rgba(2, 6, 23, 0.8), rgba(15, 23, 42, 0.9));">
                                <h6 class="text-gold small fw-bold text-uppercase mb-4">Account Summary</h6>
                                <div class="mb-4">
                                    <h5 class="text-white-50 small mb-1">Current Outstanding</h5>
                                    <h1 class="font-heading fw-bold">LKR 12,500.00</h1>
                                </div>
                                <div class="d-grid gap-3">
                                    <button class="btn btn-lux-primary">Settle Balance Now</button>
                                    <button class="btn btn-lux-outline">Download Summary</button>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Payment Info -->
                        <div class="col-lg-7 lux-animate" style="animation-delay: 0.1s;">
                            <div class="lux-card h-100">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h6 class="text-gold small fw-bold text-uppercase mb-0">Active Cards</h6>
                                    <button class="btn btn-link text-gold small p-0 text-decoration-none">+ Add
                                        New</button>
                                </div>
                                <div
                                    class="p-4 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-brands fa-cc-visa fa-2x me-3 text-info"></i>
                                        <div>
                                            <h6 class="fw-bold mb-0">Visa Signature</h6>
                                            <small class="text-white-50">•••• 8842</small>
                                        </div>
                                    </div>
                                    <span class="badge bg-gold text-dark small">Primary</span>
                                </div>
                                <div
                                    class="p-4 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-brands fa-cc-mastercard fa-2x me-3 text-warning"></i>
                                        <div>
                                            <h6 class="fw-bold mb-0">Mastercard Elite</h6>
                                            <small class="text-white-50">•••• 1109</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Invoices -->
                    <div class="lux-card lux-animate" style="animation-delay: 0.2s;">
                        <h5 class="font-heading fw-bold mb-4">Recent Invoices</h5>
                        <div class="table-responsive">
                            <table class="table table-dark table-hover align-middle mb-0">
                                <thead>
                                    <tr class="text-gold small text-uppercase">
                                        <th class="border-0 pb-3">Bill ID</th>
                                        <th class="border-0 pb-3">Service Description</th>
                                        <th class="border-0 pb-3">Date</th>
                                        <th class="border-0 pb-3">Amount</th>
                                        <th class="border-0 pb-3">Status</th>
                                        <th class="border-0 pb-3 text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="border-top border-white border-opacity-10">
                                    <tr>
                                        <td class="small fw-bold">INV-精英-9901</td>
                                        <td>Gourmet Dining: Blue Horizon</td>
                                        <td>Mar 06, 2026</td>
                                        <td class="fw-bold text-gold">LKR 8,500</td>
                                        <td><span
                                                class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-3">Pending</span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-link text-gold p-0"><i
                                                    class="fa-solid fa-file-pdf"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="small fw-bold">INV-精英-9852</td>
                                        <td>Spa & Wellness: Ayur Ritual</td>
                                        <td>Mar 04, 2026</td>
                                        <td class="fw-bold text-gold">LKR 12,000</td>
                                        <td><span
                                                class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3">Paid</span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-link text-gold p-0"><i
                                                    class="fa-solid fa-file-pdf"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="small fw-bold">INV-精英-9810</td>
                                        <td>Airport Limo Service</td>
                                        <td>Mar 02, 2026</td>
                                        <td class="fw-bold text-gold">LKR 4,500</td>
                                        <td><span
                                                class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3">Paid</span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-link text-gold p-0"><i
                                                    class="fa-solid fa-file-pdf"></i></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/lux-guest-billing.js"></script>
    </body>

    </html>