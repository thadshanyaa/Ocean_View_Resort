<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room Service | Ocean View Resort</title>
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
                        <h1 class="font-luxury fw-bold mb-1">Room <span class="text-gold">Service</span></h1>
                        <p class="text-muted mb-0">Indulge in our exquisite culinary and wellness services from your
                            room.</p>
                    </div>

                    <!-- Category Filter Tabs -->
                    <div class="glass-card mb-5 p-2 animate-fade" style="animation-delay: 0.1s; border-radius: 50px;">
                        <ul class="nav nav-pills nav-fill" id="serviceTabs">
                            <li class="nav-item">
                                <button class="nav-link active rounded-pill text-gold bg-gold bg-opacity-10"
                                    data-filter="all">All Services</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link rounded-pill text-muted" data-filter="food">Food &
                                    Dining</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link rounded-pill text-muted" data-filter="wellness">Wellness &
                                    Spa</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link rounded-pill text-muted" data-filter="utility">Guest
                                    Utilities</button>
                            </li>
                        </ul>
                    </div>

                    <!-- Service Cards Grid -->
                    <div class="row g-4 mb-5" id="serviceGrid">
                        <!-- Food Item 1 -->
                        <div class="col-md-4 service-item animate-fade" data-category="food"
                            style="animation-delay: 0.2s;">
                            <div class="glass-card h-100 p-0 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80"
                                    class="img-fluid" style="height: 200px; width: 100%; object-fit: cover;"
                                    alt="Service">
                                <div class="p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="fw-bold mb-0">Tropical Seafood Platter</h6>
                                        <span class="text-gold small fw-bold">LKR 4,500</span>
                                    </div>
                                    <p class="text-muted small mb-4">Fresh seasonal seafood served with organic greens
                                        and house dressing.</p>
                                    <button class="btn btn-luxury w-100"
                                        onclick="openOrderModal('Tropical Seafood Platter', 4500)">Request
                                        Service</button>
                                </div>
                            </div>
                        </div>

                        <!-- Wellness Item 1 -->
                        <div class="col-md-4 service-item animate-fade" data-category="wellness"
                            style="animation-delay: 0.3s;">
                            <div class="glass-card h-100 p-0 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1544161515-4ae6ce6ea858?auto=format&fit=crop&w=400&q=80"
                                    class="img-fluid" style="height: 200px; width: 100%; object-fit: cover;"
                                    alt="Service">
                                <div class="p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="fw-bold mb-0">In-Room Ayurvedic Massage</h6>
                                        <span class="text-gold small fw-bold">LKR 12,000</span>
                                    </div>
                                    <p class="text-muted small mb-4">60-minute rejuvenating full body massage with warm
                                        herbal oils.</p>
                                    <button class="btn btn-luxury w-100"
                                        onclick="openOrderModal('In-Room Ayurvedic Massage', 12000)">Request
                                        Service</button>
                                </div>
                            </div>
                        </div>

                        <!-- Utility Item 1 -->
                        <div class="col-md-4 service-item animate-fade" data-category="utility"
                            style="animation-delay: 0.4s;">
                            <div class="glass-card h-100 p-0 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?auto=format&fit=crop&w=400&q=80"
                                    class="img-fluid" style="height: 200px; width: 100%; object-fit: cover;"
                                    alt="Service">
                                <div class="p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="fw-bold mb-0">Express Laundry Service</h6>
                                        <span class="text-gold small fw-bold">LKR 2,500</span>
                                    </div>
                                    <p class="text-muted small mb-4">Same-day professional cleaning and ironing service
                                        for up to 5 items.</p>
                                    <button class="btn btn-luxury w-100"
                                        onclick="openOrderModal('Express Laundry Service', 2500)">Request
                                        Service</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        </div>

        <!-- Request Modal -->
        <div class="modal fade" id="orderModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content glass-card border-glass p-0">
                    <div class="modal-header border-0 p-4 pb-0">
                        <h5 class="font-luxury fw-bold text-gold" id="modalTitle">Request Service</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <form id="serviceForm">
                            <div class="mb-3">
                                <label class="form-label text-muted small">Selected Item</label>
                                <input type="text" id="selectedItem"
                                    class="form-control bg-transparent border-glass text-white" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted small">Special Instructions</label>
                                <textarea id="instructions" class="form-control bg-transparent border-glass text-white"
                                    rows="3" placeholder="Any dietary restrictions or preferences..."></textarea>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="text-muted small">Estimated Charge:</span>
                                <span class="text-gold fw-bold" id="itemPrice">LKR 0</span>
                            </div>
                            <button type="submit" class="btn btn-luxury w-100">Confirm Order</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/guest-room-service.js"></script>
    </body>

    </html>