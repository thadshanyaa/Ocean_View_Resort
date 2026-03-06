<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room Availability | Elite Guest</title>
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
                        <h1 class="font-heading fw-bold mb-1">Discover Your <span class="text-gold">Next Stay</span>
                        </h1>
                        <p class="text-white-50">Explore our exclusive suites and villas for your future visit.</p>
                    </header>

                    <!-- Availability Search -->
                    <div class="lux-card mb-5 lux-animate">
                        <form id="luxAvailForm" class="row g-4 align-items-end">
                            <div class="col-md-4">
                                <label class="text-gold small fw-bold text-uppercase mb-2 d-block">Check-In Date</label>
                                <input type="date" class="form-control bg-transparent border-lux text-white p-3"
                                    style="border-radius: 12px;" required>
                            </div>
                            <div class="col-md-4">
                                <label class="text-gold small fw-bold text-uppercase mb-2 d-block">Check-Out
                                    Date</label>
                                <input type="date" class="form-control bg-transparent border-lux text-white p-3"
                                    style="border-radius: 12px;" required>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-lux-primary w-100 py-3">Find Availability</button>
                            </div>
                        </form>
                    </div>

                    <!-- Room Showcase -->
                    <div class="row g-4 lux-animate" style="animation-delay: 0.2s;">
                        <div class="col-md-6 col-lg-4">
                            <div class="lux-card p-0 overflow-hidden h-100">
                                <img src="https://images.unsplash.com/photo-1618773928121-c32242e83f3a?auto=format&fit=crop&w=600&q=80"
                                    class="w-100" style="height: 240px; object-fit: cover;" alt="Suite">
                                <div class="p-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h5 class="fw-bold mb-0">Ocean Horizon Suite</h5>
                                        <span class="text-gold fw-bold">LKR 45k/night</span>
                                    </div>
                                    <p class="text-white-50 small mb-4">A panoramic view of the Indian Ocean with a
                                        private balcony and premium bath amenities.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span
                                            class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-20 px-3">Available</span>
                                        <button class="btn btn-lux-outline btn-sm">Reserve Now</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="lux-card p-0 overflow-hidden h-100">
                                <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80"
                                    class="w-100" style="height: 240px; object-fit: cover;" alt="Suite">
                                <div class="p-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h5 class="fw-bold mb-0">Majestic Villa</h5>
                                        <span class="text-gold fw-bold">LKR 120k/night</span>
                                    </div>
                                    <p class="text-white-50 small mb-4">Private infinity pool, personal butler service,
                                        and direct beach access.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span
                                            class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-20 px-3">Filling
                                            Fast</span>
                                        <button class="btn btn-lux-outline btn-sm">Reserve Now</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="lux-card p-0 overflow-hidden h-100">
                                <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80"
                                    class="w-100" style="height: 240px; object-fit: cover;" alt="Suite">
                                <div class="p-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <h5 class="fw-bold mb-0">Royal Garden Suite</h5>
                                        <span class="text-gold fw-bold">LKR 35k/night</span>
                                    </div>
                                    <p class="text-white-50 small mb-4">Serene garden views with minimalist Zen-inspired
                                        luxury interiors.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span
                                            class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-20 px-3">Available</span>
                                        <button class="btn btn-lux-outline btn-sm">Reserve Now</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/lux-guest-availability.js"></script>
    </body>

    </html>