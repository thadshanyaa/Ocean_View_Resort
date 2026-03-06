<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Settings | Ocean View Resort</title>
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
                        <h1 class="font-luxury fw-bold mb-1">Profile <span class="text-gold">Settings</span></h1>
                        <p class="text-muted mb-0">Personalize your luxury experience and manage account details.</p>
                    </div>

                    <div class="row g-4">
                        <!-- Profile Card -->
                        <div class="col-lg-4 animate-fade" style="animation-delay: 0.1s;">
                            <div class="glass-card text-center">
                                <div class="position-relative d-inline-block mb-4">
                                    <img src="https://ui-avatars.com/api/?name=Alexander+Noble&background=fbbf24&color=0f172a&size=150"
                                        class="rounded-circle border border-gold border-4 p-1" alt="Profile">
                                    <button class="btn btn-gold btn-sm position-absolute bottom-0 end-0 rounded-circle"
                                        style="width: 35px; height: 35px; background: var(--luxury-accent);"><i
                                            class="fa-solid fa-camera fa-xs"></i></button>
                                </div>
                                <h4 class="font-luxury fw-bold mb-1">Alexander Noble</h4>
                                <p class="text-muted small mb-4">Silver Loyalty Member</p>
                                <hr class="border-glass opacity-10">
                                <div class="text-start mt-4">
                                    <div class="mb-3">
                                        <small class="text-muted d-block mb-1 text-uppercase fw-bold"
                                            style="font-size: 0.65rem;">Email Address</small>
                                        <div class="text-white small">alexander.noble@luxury-stays.com</div>
                                    </div>
                                    <div class="mb-3">
                                        <small class="text-muted d-block mb-1 text-uppercase fw-bold"
                                            style="font-size: 0.65rem;">Phone Number</small>
                                        <div class="text-white small">+94 77 123 4567</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Settings Form -->
                        <div class="col-lg-8 animate-fade" style="animation-delay: 0.2s;">
                            <div class="glass-card">
                                <h5 class="font-luxury fw-bold mb-4">Personal Information</h5>
                                <form id="profileForm">
                                    <div class="row g-3 mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">Full Name</label>
                                            <input type="text" id="fullName"
                                                class="form-control bg-transparent border-glass text-white"
                                                value="Alexander Noble" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">Email Address</label>
                                            <input type="email" id="email"
                                                class="form-control bg-transparent border-glass text-white"
                                                value="alexander.noble@luxury-stays.com" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">Phone Number</label>
                                            <input type="tel" id="phone"
                                                class="form-control bg-transparent border-glass text-white"
                                                value="+94 77 123 4567">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small">Nationality</label>
                                            <select class="form-select bg-transparent border-glass text-white">
                                                <option value="SL" selected class="bg-dark">Sri Lankan</option>
                                                <option value="UK" class="bg-dark">British</option>
                                                <option value="US" class="bg-dark">American</option>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label text-muted small">Home Address</label>
                                            <textarea class="form-control bg-transparent border-glass text-white"
                                                rows="2">123 Ocean Drive, Colombo 03, Sri Lanka</textarea>
                                        </div>
                                    </div>

                                    <h5 class="font-luxury fw-bold mb-4">Stay Preferences</h5>
                                    <div class="row g-3 mb-5">
                                        <div class="col-md-6">
                                            <div class="form-check form-switch custom-switch">
                                                <input class="form-check-input" type="checkbox" checked id="notifCheck">
                                                <label class="form-check-label text-muted small ms-2"
                                                    for="notifCheck">Email Notifications</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-check form-switch custom-switch">
                                                <input class="form-check-input" type="checkbox" id="newsCheck">
                                                <label class="form-check-label text-muted small ms-2"
                                                    for="newsCheck">Marketing Newsletters</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-end gap-3">
                                        <button type="reset" class="btn btn-outline-gold px-4">Reset Changes</button>
                                        <button type="submit" class="btn btn-luxury px-4">Save Profile</button>
                                    </div>
                                </form>

                                <div id="statusMessage" class="mt-4 d-none">
                                    <div
                                        class="alert alert-success bg-success bg-opacity-20 border-glass text-success small mb-0">
                                        <i class="fa-solid fa-circle-check me-2"></i> Your profile has been successfully
                                        updated.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/guest-profile.js"></script>
    </body>

    </html>