<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Reservations | Elite Guest</title>
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
                        <h1 class="font-heading fw-bold mb-1">My <span class="text-gold">Reservations</span></h1>
                        <p class="text-white-50">View and manage your upcoming luxury resort experiences.</p>
                    </header>

                    <!-- Active Reservation Focus -->
                    <div class="lux-card mb-5 border-gold border-opacity-25 lux-animate">
                        <div class="row align-items-center">
                            <div class="col-md-2 text-center text-md-start mb-3 mb-md-0">
                                <div class="bg-gold bg-opacity-10 text-gold rounded-circle d-flex align-items-center justify-content-center mx-auto"
                                    style="width: 80px; height: 80px;">
                                    <i class="fa-solid fa-star fa-2x"></i>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <span class="badge bg-gold text-dark mb-2">Current Stay</span>
                                <h4 class="font-heading fw-bold text-white mb-1">Deluxe Seaside Suite</h4>
                                <p class="text-white-50 small mb-0">Reservation ID: <span
                                        class="text-gold">OVR-精英-8821</span> | Check-out: March 15, 2026</p>
                            </div>
                            <div class="col-md-3 text-md-end">
                                <button class="btn btn-lux-primary btn-sm">Manage Stay</button>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Table -->
                    <div class="lux-card lux-animate" style="animation-delay: 0.2s;">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="font-heading fw-bold mb-0">Booking History</h5>
                            <div class="input-group w-auto">
                                <input type="text" id="bookingSearch"
                                    class="form-control bg-transparent border-lux text-white small"
                                    placeholder="Search ID..." style="border-radius: 10px 0 0 10px;">
                                <span class="input-group-text bg-transparent border-lux border-start-0"
                                    style="border-radius: 0 10px 10px 0;"><i
                                        class="fa-solid fa-search text-muted"></i></span>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-dark table-hover align-middle mb-0">
                                <thead>
                                    <tr class="text-gold small text-uppercase" style="letter-spacing: 1px;">
                                        <th class="border-0 pb-3">Res ID</th>
                                        <th class="border-0 pb-3">Room Category</th>
                                        <th class="border-0 pb-3">Check-In</th>
                                        <th class="border-0 pb-3">Check-Out</th>
                                        <th class="border-0 pb-3">Status</th>
                                        <th class="border-0 pb-3 text-end">Price</th>
                                    </tr>
                                </thead>
                                <tbody class="border-top border-white border-opacity-10">
                                    <tr>
                                        <td class="small fw-bold">OVR-1025</td>
                                        <td>
                                            <div class="fw-bold">Executive Pool Villa</div>
                                            <small class="text-white-50">2 Adults, 1 Child</small>
                                        </td>
                                        <td>Apr 20, 2026</td>
                                        <td>Apr 25, 2026</td>
                                        <td><span
                                                class="badge bg-success bg-opacity-20 text-success border border-success border-opacity-25 px-3">Confirmed</span>
                                        </td>
                                        <td class="text-end fw-bold text-gold">LKR 450,000</td>
                                    </tr>
                                    <tr>
                                        <td class="small fw-bold">OVR-0982</td>
                                        <td>
                                            <div class="fw-bold">Standard Garden Room</div>
                                            <small class="text-white-50">1 Adult</small>
                                        </td>
                                        <td>Feb 05, 2026</td>
                                        <td>Feb 08, 2026</td>
                                        <td><span
                                                class="badge bg-info bg-opacity-20 text-info border border-info border-opacity-25 px-3">Completed</span>
                                        </td>
                                        <td class="text-end fw-bold text-gold">LKR 55,000</td>
                                    </tr>
                                    <tr>
                                        <td class="small fw-bold">OVR-0761</td>
                                        <td>
                                            <div class="fw-bold">Luxury Penthouse</div>
                                            <small class="text-white-50">4 Adults</small>
                                        </td>
                                        <td>Jan 12, 2026</td>
                                        <td>Jan 15, 2026</td>
                                        <td><span
                                                class="badge bg-danger bg-opacity-20 text-danger border border-danger border-opacity-25 px-3">Cancelled</span>
                                        </td>
                                        <td class="text-end fw-bold text-gold">LKR 820,000</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/lux-guest-reservations.js"></script>
    </body>

    </html>