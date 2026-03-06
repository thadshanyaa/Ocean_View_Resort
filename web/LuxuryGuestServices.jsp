<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resort Services | Ocean View Luxury</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-core.css">
    </head>

    <body>
        <%@ include file="luxury-sidebar-guest.jspf" %>

            <main class="lux-main">
                <header class="mb-5">
                    <h1 class="fw-bold mb-1 text-gold">Tailored <span class="text-white">Experiences</span></h1>
                    <p class="text-white-50">Reserve amenities and request services with a single touch.</p>
                </header>

                <c:if test="${param.msg == 'success'}">
                    <div class="lux-card mb-4 border-cyan bg-cyan bg-opacity-10 py-3 px-4">
                        <i class="fa-solid fa-bell text-cyan me-2"></i>
                        <span class="text-cyan fw-bold">Your request has been sent to the front office. A staff member
                            will confirm shortly.</span>
                    </div>
                </c:if>

                <div class="row g-4 mb-5">
                    <!-- Spa & Wellness -->
                    <div class="col-md-6 col-lg-4">
                        <div class="lux-card h-100 p-0 overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1544161515-436cefb65794?auto=format&fit=crop&w=600&q=80"
                                class="w-100" style="height: 180px; object-fit: cover;">
                            <div class="p-4">
                                <h5 class="fw-bold text-gold mb-2">Eternal Spa</h5>
                                <p class="small text-white-50 mb-4">Therapeutic massages, facials, and traditional
                                    wellness rituals.</p>
                                <button class="lux-btn lux-btn-outline w-100 justify-content-center"
                                    onclick="openRequest('Eternal Spa Session')">Request Appointment</button>
                            </div>
                        </div>
                    </div>
                    <!-- Pool & Cabana -->
                    <div class="col-md-6 col-lg-4">
                        <div class="lux-card h-100 p-0 overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?auto=format&fit=crop&w=600&q=80"
                                class="w-100" style="height: 180px; object-fit: cover;">
                            <div class="p-4">
                                <h5 class="fw-bold text-cyan mb-2">Infinitiy Pool</h5>
                                <p class="small text-white-50 mb-4">Reserve a private cabana with premium poolside
                                    catering.</p>
                                <button class="lux-btn lux-btn-outline w-100 justify-content-center"
                                    style="border-color: var(--lux-cyan); color: var(--lux-cyan);"
                                    onclick="openRequest('Pool Cabana Reservation')">Reserve Cabana</button>
                            </div>
                        </div>
                    </div>
                    <!-- Housekeeping -->
                    <div class="col-md-6 col-lg-4">
                        <div class="lux-card h-100 p-0 overflow-hidden">
                            <img src="https://images.unsplash.com/photo-1583907659441-aaee649477e3?auto=format&fit=crop&w=600&q=80"
                                class="w-100" style="height: 180px; object-fit: cover;">
                            <div class="p-4">
                                <h5 class="fw-bold text-white mb-2">Housekeeping</h5>
                                <p class="small text-white-50 mb-4">Express laundry, linen change, or room freshening
                                    services.</p>
                                <button class="lux-btn lux-btn-outline w-100 justify-content-center"
                                    style="border-color: #f8fafc; color: #f8fafc;"
                                    onclick="openRequest('Housekeeping / Laundry')">Request Service</button>
                            </div>
                        </div>
                    </div>
                    <!-- Transport -->
                    <div class="col-md-6 col-lg-4">
                        <div class="lux-card h-100 p-4 d-flex flex-column justify-content-between">
                            <div>
                                <i class="fa-solid fa-car-side fa-3x text-gold mb-3"></i>
                                <h5 class="fw-bold mb-2">Luxury Transport</h5>
                                <p class="small text-white-50">Airport transfers, private chauffeur, or city tours in
                                    our premium fleet.</p>
                            </div>
                            <button class="lux-btn lux-btn-outline w-100 justify-content-center mt-3"
                                onclick="openRequest('Transport Chauffeur')">Book Vehicle</button>
                        </div>
                    </div>
                    <!-- Activity Booking -->
                    <div class="col-md-6 col-lg-4">
                        <div class="lux-card h-100 p-4 d-flex flex-column justify-content-between">
                            <div>
                                <i class="fa-solid fa-person-hiking fa-3x text-gold mb-3"></i>
                                <h5 class="fw-bold mb-2">Activities</h5>
                                <p class="small text-white-50">Snorkeling, guided mountain trekking, or local cultural
                                    immersions.</p>
                            </div>
                            <button class="lux-btn lux-btn-outline w-100 justify-content-center mt-3"
                                onclick="openRequest('Activity Booking')">Explore Schedule</button>
                        </div>
                    </div>
                    <!-- Dining Reservation -->
                    <div class="col-md-6 col-lg-4">
                        <div class="lux-card h-100 p-4 d-flex flex-column justify-content-between"
                            style="background: var(--lux-gold-dim);">
                            <div>
                                <i class="fa-solid fa-utensils fa-3x text-gold mb-3"></i>
                                <h5 class="fw-bold mb-2 text-gold">Fine Dining</h5>
                                <p class="small text-white-50">Reserve a table at our signature restaurants or order
                                    in-room dining.</p>
                            </div>
                            <a href="luxury-guest-portal?view=menu"
                                class="lux-btn lux-btn-gold w-100 justify-content-center mt-3">View Menu</a>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Request Modal -->
            <div class="modal fade" id="requestModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content lux-card border-0 shadow-lg" style="background: var(--lux-dark);">
                        <div class="modal-header border-white border-opacity-10 p-4">
                            <h5 class="modal-title fw-bold text-gold" id="serviceTitle">Service Request</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="luxury-action-guest" method="POST">
                            <input type="hidden" name="action" value="request-service">
                            <input type="hidden" name="serviceType" id="serviceInput">
                            <div class="modal-body p-4">
                                <div class="mb-4">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Room Number</label>
                                    <input type="text" name="roomNumber"
                                        class="form-control bg-navy text-white border-white border-opacity-10 p-3"
                                        placeholder="e.g. 402" required>
                                </div>
                                <div class="mb-0">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Additional Details /
                                        Time</label>
                                    <textarea name="details"
                                        class="form-control bg-navy text-white border-white border-opacity-10 p-3"
                                        rows="3"
                                        placeholder="Please specify time or special instructions..."></textarea>
                                </div>
                            </div>
                            <div class="modal-footer border-white border-opacity-10 p-4">
                                <button type="submit" class="lux-btn lux-btn-gold w-100 py-3">Submit Request</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function openRequest(service) {
                    document.getElementById('serviceTitle').innerText = service;
                    document.getElementById('serviceInput').value = service;
                    new bootstrap.Modal(document.getElementById('requestModal')).show();
                }
            </script>
    </body>

    </html>