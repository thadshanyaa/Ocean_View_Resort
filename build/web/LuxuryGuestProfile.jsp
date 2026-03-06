<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Settings | Ocean View Luxury</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-core.css">
    </head>

    <body>
        <%@ include file="luxury-sidebar-guest.jspf" %>

            <main class="lux-main">
                <header class="mb-5">
                    <h1 class="fw-bold mb-1 text-gold">Profile <span class="text-white">Customization</span></h1>
                    <p class="text-white-50">Manage your digital identity and resort preferences.</p>
                </header>

                <div class="row g-4">
                    <!-- Sidebar / Avatar -->
                    <div class="col-xl-4">
                        <div class="lux-card text-center py-5">
                            <div class="position-relative d-inline-block mb-4">
                                <div class="rounded-circle bg-gold d-flex align-items-center justify-content-center fw-bold text-navy"
                                    style="width: 120px; height: 120px; font-size: 3rem; box-shadow: var(--lux-gold-glow);">
                                    ${user.username.substring(0,1).toUpperCase()}
                                </div>
                                <button
                                    class="btn btn-sm btn-dark position-absolute bottom-0 start-100 translate-middle-x rounded-circle border border-secondary">
                                    <i class="fa-solid fa-camera"></i>
                                </button>
                            </div>
                            <h4 class="fw-bold mb-1">${user.username}</h4>
                            <p class="text-white-50 small mb-4">Elite Member since ${user.createdAt}</p>
                            <div class="d-flex justify-content-center gap-2">
                                <span class="lux-badge lux-badge-pending px-3">Platinum</span>
                                <span class="lux-badge lux-badge-info px-3">Verified</span>
                            </div>
                        </div>

                        <div class="lux-card mt-4 p-4">
                            <h6 class="fw-bold text-gold mb-3">Loyalty Stats</h6>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="small text-white-50">Total Nights</span>
                                <span class="fw-bold">14</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="small text-white-50">Rewards Balance</span>
                                <span class="fw-bold text-gold">4,250 Pts</span>
                            </div>
                        </div>
                    </div>

                    <!-- Form -->
                    <div class="col-xl-8">
                        <div class="lux-card">
                            <h5 class="fw-bold mb-5 border-bottom border-white border-opacity-10 pb-3">Personal
                                Information</h5>
                            <form class="row g-4">
                                <div class="col-md-6">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Username</label>
                                    <input type="text"
                                        class="form-control bg-dark border-white border-opacity-10 text-white p-3"
                                        value="${user.username}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Email Address</label>
                                    <input type="email"
                                        class="form-control bg-dark border-white border-opacity-10 text-white p-3"
                                        value="${user.email}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Contact
                                        Number</label>
                                    <input type="tel"
                                        class="form-control bg-dark border-white border-opacity-10 text-white p-3"
                                        placeholder="+94 XX XXX XXXX">
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Dining
                                        Preference</label>
                                    <select class="form-select bg-dark border-white border-opacity-10 text-white p-3">
                                        <option>Vegetarian</option>
                                        <option>Seafood Focus</option>
                                        <option selected>No Preference</option>
                                    </select>
                                </div>
                                <div class="col-12 mt-5">
                                    <h5 class="fw-bold mb-4 border-bottom border-white border-opacity-10 pb-3">Security
                                        & Access</h5>
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">New Security
                                        Pin</label>
                                    <input type="password"
                                        class="form-control bg-dark border-white border-opacity-10 text-white p-3"
                                        placeholder="••••">
                                </div>
                                <div class="col-md-6">
                                    <label class="small text-white-50 text-uppercase mb-2 d-block">Confirm Pin</label>
                                    <input type="password"
                                        class="form-control bg-dark border-white border-opacity-10 text-white p-3">
                                </div>
                                <div class="col-12 text-end mt-5">
                                    <button type="button" class="lux-btn lux-btn-outline me-3">Discard Changes</button>
                                    <button type="button" class="lux-btn lux-btn-gold px-5">Update Profile</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>