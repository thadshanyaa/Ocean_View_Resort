<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Reservations | Ocean View Resort</title>
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
                    <div class="d-flex justify-content-between align-items-center mb-5 animate-fade">
                        <div>
                            <h1 class="font-luxury fw-bold mb-1">My <span class="text-gold">Reservations</span></h1>
                            <p class="text-muted mb-0">Manage your upcoming and past luxury experiences.</p>
                        </div>
                        <div>
                            <button class="btn btn-luxury"><i class="fa-solid fa-plus me-2"></i>New Reservation</button>
                        </div>
                    </div>

                    <!-- Search & Filter UI -->
                    <div class="glass-card mb-4 animate-fade" style="animation-delay: 0.1s;">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text bg-transparent border-end-0 border-glass"
                                        style="border-radius: 10px 0 0 10px;">
                                        <i class="fa-solid fa-search text-muted"></i>
                                    </span>
                                    <input type="text" id="resSearch"
                                        class="form-control bg-transparent border-start-0 border-glass text-white"
                                        placeholder="Search by Res ID or Room..." style="border-radius: 0 10px 10px 0;">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select id="statusFilter" class="form-select bg-transparent border-glass text-white"
                                    style="border-radius: 10px;">
                                    <option value="all" class="bg-dark">All Status</option>
                                    <option value="confirmed" class="bg-dark text-success">Confirmed</option>
                                    <option value="pending" class="bg-dark text-warning">Pending</option>
                                    <option value="completed" class="bg-dark text-info">Completed</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-outline-gold w-100 h-100" style="border-radius: 10px;">Filter
                                    Records</button>
                            </div>
                        </div>
                    </div>

                    <!-- Reservations Table -->
                    <div class="glass-card animate-fade" style="animation-delay: 0.2s; overflow-x: auto;">
                        <table class="table table-dark table-hover align-middle mb-0">
                            <thead class="text-gold small text-uppercase">
                                <tr>
                                    <th class="border-0 pb-3">Res ID</th>
                                    <th class="border-0 pb-3">Room Type</th>
                                    <th class="border-0 pb-3">Check-In</th>
                                    <th class="border-0 pb-3">Check-Out</th>
                                    <th class="border-0 pb-3">Status</th>
                                    <th class="border-0 pb-3">Total</th>
                                    <th class="border-0 pb-3 text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody class="border-top border-glass border-opacity-20">
                                <tr>
                                    <td class="small fw-bold">OVR-8821</td>
                                    <td>
                                        <div class="fw-bold">Deluxe Ocean Suite</div>
                                        <small class="text-muted">Room #402</small>
                                    </td>
                                    <td>Mar 10, 2026</td>
                                    <td>Mar 15, 2026</td>
                                    <td><span
                                            class="badge bg-success bg-opacity-20 text-success px-3 rounded-pill">Confirmed</span>
                                    </td>
                                    <td class="fw-bold text-gold">LKR 125,000</td>
                                    <td class="text-end">
                                        <div class="btn-group">
                                            <button class="btn btn-sm btn-outline-light border-glass rounded-3 me-2"
                                                title="Download"><i class="fa-solid fa-download"></i></button>
                                            <button class="btn btn-sm btn-outline-danger border-glass rounded-3"
                                                title="Cancel"><i class="fa-solid fa-xmark"></i></button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="small fw-bold">OVR-8452</td>
                                    <td>
                                        <div class="fw-bold">Executive Villa</div>
                                        <small class="text-muted">V-12 Poolview</small>
                                    </td>
                                    <td>Feb 20, 2026</td>
                                    <td>Feb 25, 2026</td>
                                    <td><span
                                            class="badge bg-info bg-opacity-20 text-info px-3 rounded-pill">Completed</span>
                                    </td>
                                    <td class="fw-bold text-gold">LKR 340,500</td>
                                    <td class="text-end">
                                        <button class="btn btn-sm btn-outline-light border-glass rounded-3"
                                            title="View Details"><i class="fa-solid fa-eye"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="small fw-bold">OVR-7910</td>
                                    <td>
                                        <div class="fw-bold">Standard Single</div>
                                        <small class="text-muted">Room #210</small>
                                    </td>
                                    <td>Jan 05, 2026</td>
                                    <td>Jan 08, 2026</td>
                                    <td><span
                                            class="badge bg-info bg-opacity-20 text-info px-3 rounded-pill">Completed</span>
                                    </td>
                                    <td class="fw-bold text-gold">LKR 45,000</td>
                                    <td class="text-end">
                                        <button class="btn btn-sm btn-outline-light border-glass rounded-3"
                                            title="View Details"><i class="fa-solid fa-eye"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/guest-reservations.js"></script>
    </body>

    </html>