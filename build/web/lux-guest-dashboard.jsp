<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Elite Guest Dashboard | Ocean View Resort</title>
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
                    <!-- Header section -->
                    <header class="d-flex justify-content-between align-items-end mb-5 lux-animate">
                        <div>
                            <h5 class="text-gold text-uppercase fw-bold small mb-1" style="letter-spacing: 2px;">Welcome
                                Home</h5>
                            <h1 class="font-heading fw-bold mb-0">Mr. Alexander Noble</h1>
                        </div>
                        <div class="text-end">
                            <div class="small text-white-50">Local Time</div>
                            <div class="fw-bold text-gold" id="lux-clock">06:30 PM</div>
                        </div>
                    </header>

                    <!-- Hero Section -->
                    <div class="lux-card mb-5 lux-animate"
                        style="background: linear-gradient(rgba(2, 6, 23, 0.7), rgba(2, 6, 23, 0.8)), url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1200&q=80'); background-size: cover; background-position: center; border: 1px solid rgba(234, 179, 8, 0.2);">
                        <div class="row align-items-center py-4">
                            <div class="col-lg-8">
                                <span class="badge bg-gold text-dark mb-3 px-3 rounded-pill fw-bold">Active Stay</span>
                                <h2 class="font-heading fw-bold text-white mb-3">Room #402: Deluxe Ocean Suite</h2>
                                <p class="text-white-50 mb-4">Your personalized butler is currently preparing for your
                                    sunset dinner. Is there anything else you require for your evening?</p>
                                <div class="d-flex gap-3">
                                    <button class="btn btn-lux-primary">Request Amenities</button>
                                    <button class="btn btn-lux-outline">View Itinerary</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Stats Grid -->
                    <div class="row g-4 mb-5">
                        <div class="col-md-3 lux-animate" style="animation-delay: 0.1s;">
                            <div class="lux-card text-center h-100">
                                <div class="text-gold small fw-bold text-uppercase mb-2">Upcoming</div>
                                <h2 class="font-heading fw-bold mb-0">02</h2>
                                <div class="text-white-50 small mt-1">Confirmed Bookings</div>
                            </div>
                        </div>
                        <div class="col-md-3 lux-animate" style="animation-delay: 0.2s;">
                            <div class="lux-card text-center h-100">
                                <div class="text-gold small fw-bold text-uppercase mb-2">Rewards</div>
                                <h2 class="font-heading fw-bold mb-0">4,850</h2>
                                <div class="text-white-50 small mt-1">Tier Points</div>
                            </div>
                        </div>
                        <div class="col-md-3 lux-animate" style="animation-delay: 0.3s;">
                            <div class="lux-card text-center h-100">
                                <div class="text-gold small fw-bold text-uppercase mb-2">Pending</div>
                                <h2 class="font-heading fw-bold mb-0">LKR 12.5k</h2>
                                <div class="text-white-50 small mt-1">Bill Balance</div>
                            </div>
                        </div>
                        <div class="col-md-3 lux-animate" style="animation-delay: 0.4s;">
                            <div class="lux-card text-center h-100">
                                <div class="text-gold small fw-bold text-uppercase mb-2">Nights</div>
                                <h2 class="font-heading fw-bold mb-0">15</h2>
                                <div class="text-white-50 small mt-1">Total Resort Stays</div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-5">
                        <!-- Activity Feed -->
                        <div class="col-lg-7 lux-animate" style="animation-delay: 0.5s;">
                            <div class="lux-card h-100">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="font-heading fw-bold mb-0">Resort Activity</h4>
                                    <a href="#" class="text-gold small text-decoration-none">View All History</a>
                                </div>
                                <div class="lux-timeline">
                                    <div class="d-flex mb-4">
                                        <div class="bg-gold bg-opacity-10 text-gold rounded-4 p-3 me-3 h-100">
                                            <i class="fa-solid fa-utensils"></i>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold mb-1">Fine Dining Reservation</h6>
                                            <p class="text-white-50 small mb-0">Your table at Blue Horizon is confirmed
                                                for tonight at 8:00 PM.</p>
                                            <small class="text-gold fw-bold mt-2 d-block">LKR 2,500 Deposit</small>
                                        </div>
                                    </div>
                                    <div class="d-flex mb-4">
                                        <div class="bg-primary bg-opacity-10 text-primary rounded-4 p-3 me-3 h-100">
                                            <i class="fa-solid fa-bell-concierge"></i>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold mb-1">Room Service Delivered</h6>
                                            <p class="text-white-50 small mb-0">Fresh tropical fruit basket delivered to
                                                Room #402.</p>
                                            <small class="text-white-50 mt-1 d-block">Today, 11:30 AM</small>
                                        </div>
                                    </div>
                                    <div class="d-flex">
                                        <div class="bg-success bg-opacity-10 text-success rounded-4 p-3 me-3 h-100">
                                            <i class="fa-solid fa-calendar-check"></i>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold mb-1">New Booking Confirmed</h6>
                                            <p class="text-white-50 small mb-0">Executive Villa with Private Pool for
                                                April 20-25.</p>
                                            <small class="text-white-50 mt-1 d-block">Yesterday</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Personal Butler / Assistance -->
                        <div class="col-lg-5 lux-animate" style="animation-delay: 0.6s;">
                            <div class="lux-card mb-4" style="background: rgba(234, 179, 8, 0.05);">
                                <div class="d-flex align-items-center mb-4">
                                    <img src="https://ui-avatars.com/api/?name=Butler+James&background=eab308&color=020617"
                                        class="rounded-circle me-3" width="60" alt="Butler">
                                    <div>
                                        <h6 class="fw-bold mb-1">Personal Butler: James</h6>
                                        <span class="badge bg-success small">On Duty</span>
                                    </div>
                                </div>
                                <p class="text-white-50 small mb-4">"Greetings Mr. Noble. I am at your service until
                                    11:00 PM. Tap below to reach me instantly."</p>
                                <button class="btn btn-lux-primary w-100">Contact via WhatsApp</button>
                            </div>

                            <div class="lux-card">
                                <h6 class="font-heading fw-bold text-gold mb-3">Quick Actions</h6>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-lux-outline btn-sm text-start"><i
                                            class="fa-solid fa-key me-2"></i>Digital Room Key</button>
                                    <button class="btn btn-lux-outline btn-sm text-start"><i
                                            class="fa-solid fa-spa me-2"></i>Book Spa Session</button>
                                    <button class="btn btn-lux-outline btn-sm text-start"><i
                                            class="fa-solid fa-car me-2"></i>Airport Transfer</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/lux-guest-dashboard.js"></script>
    </body>

    </html>