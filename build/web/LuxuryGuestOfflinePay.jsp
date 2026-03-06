<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manual Settlement | Ocean View Luxury</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-core.css">
    </head>

    <body>
        <%@ include file="luxury-sidebar-guest.jspf" %>

            <main class="lux-main">
                <header class="mb-5">
                    <a href="luxury-guest-portal?view=payments"
                        class="text-white-50 text-decoration-none mb-3 d-inline-block small">
                        <i class="fa-solid fa-arrow-left me-1"></i> Back to Hub
                    </a>
                    <h1 class="fw-bold mb-1 text-gold">Manual <span class="text-white">Settlement</span></h1>
                    <p class="text-white-50">Guidelines for bank transfers and lobby payments.</p>
                </header>

                <div class="row g-4">
                    <div class="col-lg-7">
                        <div class="lux-card mb-4">
                            <h5 class="fw-bold mb-4 text-gold"><i class="fa-solid fa-university me-2"></i> Bank Transfer
                                Details</h5>
                            <div class="table-responsive">
                                <table class="table table-dark table-borderless m-0">
                                    <tr>
                                        <td class="text-white-50 ps-0">Bank Name</td>
                                        <td class="fw-bold">Elite National Bank (ENB)</td>
                                    </tr>
                                    <tr>
                                        <td class="text-white-50 ps-0">Account Number</td>
                                        <td class="fw-bold font-monospace">88102-33421-992</td>
                                    </tr>
                                    <tr>
                                        <td class="text-white-50 ps-0">Swift Code</td>
                                        <td class="fw-bold font-monospace">ENB-LKLX-101</td>
                                    </tr>
                                    <tr>
                                        <td class="text-white-50 ps-0">Beneficiary</td>
                                        <td class="fw-bold">Ocean View Resort PVT LTD</td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div class="lux-card">
                            <h5 class="fw-bold mb-4 text-cyan"><i class="fa-solid fa-cloud-arrow-up me-2"></i> Upload
                                Receipt</h5>
                            <p class="small text-white-50 mb-4">Please upload a clear screenshot or scan of your bank
                                transfer slip for manual verification by our accounts department.</p>
                            <form
                                onsubmit="event.preventDefault(); alert('Receipt uploaded. Verification usually takes 1-2 business hours.'); window.location.href='luxury-guest-portal?view=payments';">
                                <div class="mb-4">
                                    <input type="file"
                                        class="form-control bg-dark border-white border-opacity-10 text-white p-3"
                                        required>
                                </div>
                                <button type="submit" class="lux-btn lux-btn-gold">Confirm Submission</button>
                            </form>
                        </div>
                    </div>

                    <div class="col-lg-5">
                        <div class="lux-card bg-gold bg-opacity-5 h-100">
                            <h5 class="fw-bold mb-4">Lobby Payment</h5>
                            <p class="text-white-50 mb-5">You may visit the Front Desk at any time to settle your
                                account via Cash or Corporate Credit Card through our secure POS terminals.</p>

                            <div class="d-flex align-items-center gap-3 mb-4">
                                <div class="rounded-circle bg-gold bg-opacity-10 p-3">
                                    <i class="fa-solid fa-location-dot text-gold"></i>
                                </div>
                                <div>
                                    <div class="fw-bold">Main Lobby</div>
                                    <div class="small text-white-50">Ground Level, East Wing</div>
                                </div>
                            </div>

                            <div class="d-flex align-items-center gap-3 mb-4">
                                <div class="rounded-circle bg-gold bg-opacity-10 p-3">
                                    <i class="fa-solid fa-clock text-gold"></i>
                                </div>
                                <div>
                                    <div class="fw-bold">Available 24/7</div>
                                    <div class="small text-white-50">Full-service concierge present.</div>
                                </div>
                            </div>

                            <hr class="border-white opacity-10 my-4">
                            <p class="small text-white-50">Note: Room charges and service requests must be cleared at
                                least 2 hours prior to scheduled checkout.</p>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>