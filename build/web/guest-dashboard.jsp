<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Guest Dashboard | Ocean View Resort</title>
        <!-- Fonts & Icons -->
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@400;600;700&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom Style -->
        <link rel="stylesheet" href="css/guest-pages.css">
        <link rel="stylesheet" href="css/guest-sidebar.css">
    </head>

    <body class="guest-luxury-theme">

        <div class="guest-container">
            <!-- Sidebar Inclusion -->
            <%@ include file="guest-sidebar.jspf" %>

                <!-- Main Content Area -->
                <main class="main-content">
                    <!-- Hero Header -->
                    <div class="glass-card mb-4 animate-fade"
                        style="background: linear-gradient(rgba(15, 23, 42, 0.6), rgba(15, 23, 42, 0.8)), url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1200&q=80'); background-size: cover; background-position: center;">
                        <div class="py-4">
                            <h1 class="font-luxury fw-bold mb-1">Welcome Back, <span class="text-gold">Mr.
                                    Alexander</span></h1>
                            <p class="text-muted lead mb-0">Experience serenity and luxury in every moment of your stay.
                            </p>
                        </div>
                    </div>

                    <!-- Summary Statistics Row -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-3 animate-fade" style="animation-delay: 0.1s;">
                            <div class="glass-card text-center h-100">
                                <i class="fa-solid fa-calendar-days text-gold mb-3 fa-2x"></i>
                                <h6 class="text-muted text-uppercase small fw-bold">Upcoming</h6>
                                <h3 class="font-luxury mb-0">2</h3>
                            </div>
                        </div>
                        <div class="col-md-3 animate-fade" style="animation-delay: 0.2s;">
                            <div class="glass-card text-center h-100">
                                <i class="fa-solid fa-bed text-gold mb-3 fa-2x"></i>
                                <h6 class="text-muted text-uppercase small fw-bold">Current Stay</h6>
                                <p class="mb-0 fw-600">Deluxe #402</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-fade" style="animation-delay: 0.3s;">
                            <div class="glass-card text-center h-100">
                                <i class="fa-solid fa-receipt text-gold mb-3 fa-2x"></i>
                                <h6 class="text-muted text-uppercase small fw-bold">Pending Bill</h6>
                                <h3 class="font-luxury mb-0">LKR 12.5k</h3>
                            </div>
                        </div>
                        <div class="col-md-3 animate-fade" style="animation-delay: 0.4s;">
                            <div class="glass-card text-center h-100">
                                <i class="fa-solid fa-gem text-gold mb-3 fa-2x"></i>
                                <h6 class="text-muted text-uppercase small fw-bold">Loyalty Points</h6>
                                <h3 class="font-luxury mb-0">4,250</h3>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- Recent Activity Section -->
                        <div class="col-lg-8 animate-fade" style="animation-delay: 0.5s;">
                            <div class="glass-card h-100">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="font-luxury fw-bold mb-0">Recent Activity</h5>
                                    <a href="#" class="text-gold small text-decoration-none">View All</a>
                                </div>
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex align-items-center mb-4">
                                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 me-3">
                                            <i class="fa-solid fa-utensils"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-bold small">Breakfast Service Requested</div>
                                            <small class="text-muted">Today at 08:30 AM</small>
                                        </div>
                                        <div class="text-end text-gold small fw-bold">LKR 3,500</div>
                                    </li>
                                    <li class="d-flex align-items-center mb-4">
                                        <div class="bg-success bg-opacity-10 text-success rounded-circle p-2 me-3">
                                            <i class="fa-solid fa-check"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-bold small">Booking Confirmed: Deluxe Seaside</div>
                                            <small class="text-muted">Yesterday at 04:15 PM</small>
                                        </div>
                                    </li>
                                    <li class="d-flex align-items-center">
                                        <div class="bg-warning bg-opacity-10 text-warning rounded-circle p-2 me-3">
                                            <i class="fa-solid fa-spa"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-bold small">Spa Reservation - Ayur Bliss</div>
                                            <small class="text-muted">Mar 05, 10:00 AM</small>
                                        </div>
                                        <div class="text-end text-gold small fw-bold">LKR 8,000</div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Resort Announcements -->
                        <div class="col-lg-4 animate-fade" style="animation-delay: 0.6s;">
                            <div class="glass-card h-100">
                                <h5 class="font-luxury fw-bold mb-4">Resort News</h5>
                                <div class="mb-4">
                                    <img src="https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?auto=format&fit=crop&w=400&q=80"
                                        class="img-fluid rounded-4 mb-3" alt="Spa Offer">
                                    <h6 class="fw-bold">New Infinity Pool Opening</h6>
                                    <p class="text-muted small">Join us for the grand opening ceremony of our new sunset
                                        infinity pool this weekend.</p>
                                </div>
                                <div class="p-3 rounded-4 bg-gold bg-opacity-10 border border-gold border-opacity-20">
                                    <h6 class="text-gold fw-bold mb-1"><i class="fa-solid fa-gift me-2"></i>Special Spa
                                        Package</h6>
                                    <p class="text-muted small mb-0">Get 20% off all Ayurvedic treatments throughout
                                        March.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        </div>

        <!-- JS Files -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/guest-dashboard.js"></script>
    </body>

    </html>