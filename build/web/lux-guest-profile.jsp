<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Settings | Elite Guest</title>
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
                        <h1 class="font-heading fw-bold mb-1">Elite <span class="text-gold">Membership</span></h1>
                        <p class="text-white-50">Manage your personal details, secure your account, and personalize your
                            resort experience.</p>
                    </header>

                    <div class="row g-5">
                        <!-- Profile Identity Card -->
                        <div class="col-lg-4 lux-animate">
                            <div class="lux-card text-center">
                                <div class="position-relative d-inline-block mb-4">
                                    <img src="https://ui-avatars.com/api/?name=Alexander+Noble&background=eab308&color=020617&size=180"
                                        class="rounded-circle border border-gold border-4 p-1" alt="Profile">
                                    <span
                                        class="position-absolute bottom-0 end-0 bg-success border border-white border-4 rounded-circle p-3 shadow-lg"
                                        title="Elite Status Active"></span>
                                </div>
                                <h3 class="font-heading fw-bold text-white mb-1">Alexander Noble</h3>
                                <p class="text-gold small text-uppercase fw-bold mb-4" style="letter-spacing: 2px;">
                                    Silver Tier Member</p>

                                <div
                                    class="p-3 mb-4 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10 text-start">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span class="text-white-50 small">Membership ID</span>
                                        <span class="text-white small fw-bold">#OVR-8821-ELITE</span>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <span class="text-white-50 small">Since</span>
                                        <span class="text-white small fw-bold">Nov 2024</span>
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button class="btn btn-lux-outline btn-sm">Upgrade Membership</button>
                                    <button class="btn btn-link text-white-50 small text-decoration-none">Privacy
                                        Settings</button>
                                </div>
                            </div>
                        </div>

                        <!-- Profile Editing Form -->
                        <div class="col-lg-8 lux-animate" style="animation-delay: 0.2s;">
                            <div class="lux-card">
                                <h5 class="font-heading fw-bold mb-4">Account Details</h5>
                                <form id="luxProfileForm">
                                    <div class="row g-4 mb-5">
                                        <div class="col-md-6">
                                            <label class="text-gold small fw-bold text-uppercase mb-2 d-block">Full
                                                Legal Name</label>
                                            <input type="text"
                                                class="form-control bg-transparent border-lux text-white p-3"
                                                value="Alexander Noble" style="border-radius: 12px;" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="text-gold small fw-bold text-uppercase mb-2 d-block">Email
                                                Address</label>
                                            <input type="email"
                                                class="form-control bg-transparent border-lux text-white p-3"
                                                value="alex.noble@elite-stays.com" style="border-radius: 12px;"
                                                required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="text-gold small fw-bold text-uppercase mb-2 d-block">Primary
                                                Phone</label>
                                            <input type="tel"
                                                class="form-control bg-transparent border-lux text-white p-3"
                                                value="+94 77 123 4567" style="border-radius: 12px;">
                                        </div>
                                        <div class="col-md-6">
                                            <label
                                                class="text-gold small fw-bold text-uppercase mb-2 d-block">Nationality</label>
                                            <select class="form-select bg-transparent border-lux text-white p-3"
                                                style="border-radius: 12px;">
                                                <option value="SL" selected class="bg-dark">Sri Lankan</option>
                                                <option value="UK" class="bg-dark">British</option>
                                                <option value="US" class="bg-dark">American</option>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label class="text-gold small fw-bold text-uppercase mb-2 d-block">Home
                                                Address</label>
                                            <textarea class="form-control bg-transparent border-lux text-white p-3"
                                                rows="3"
                                                style="border-radius: 12px;">The Residences at Ocean Point, Suite 902, Colombo 03, Sri Lanka</textarea>
                                        </div>
                                    </div>

                                    <h5 class="font-heading fw-bold mb-4">Newsletter & Notifications</h5>
                                    <div class="row g-4 mb-5">
                                        <div class="col-md-6">
                                            <div class="form-check form-switch py-2">
                                                <input class="form-check-input" type="checkbox" id="luxEmailCheck"
                                                    checked>
                                                <label class="form-check-label text-white-50 ms-2"
                                                    for="luxEmailCheck">Elite Experience Updates</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-check form-switch py-2">
                                                <input class="form-check-input" type="checkbox" id="luxSMSCheck">
                                                <label class="form-check-label text-white-50 ms-2"
                                                    for="luxSMSCheck">Concierge SMS Alerts</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-end gap-3">
                                        <button type="reset" class="btn btn-lux-outline">Reset Changes</button>
                                        <button type="submit" class="btn btn-lux-primary">Update Profile</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/lux-guest-profile.js"></script>
    </body>

    </html>