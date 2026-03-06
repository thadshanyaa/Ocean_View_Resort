<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Settings | Elite Portal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/elite-theme.css">
    </head>

    <body class="elite-theme">

        <%@ include file="elite-sidebar-guest.jspf" %>

            <main class="elite-content">
                <header class="mb-5">
                    <h2 class="fw-bold mb-1">Profile <span class="text-gold">Customization</span></h2>
                    <p class="text-white-50">Manage your identity and preference within the resort system.</p>
                </header>

                <div class="row g-4">
                    <div class="col-xl-4">
                        <div class="elite-card text-center py-5">
                            <div class="position-relative d-inline-block mb-4">
                                <div class="rounded-circle bg-gold text-navy d-flex align-items-center justify-content-center fw-bold"
                                    style="width: 120px; height: 120px; font-size: 3rem;">
                                    ${user.username.substring(0,1)}
                                </div>
                                <button
                                    class="btn btn-sm btn-dark position-absolute bottom-0 start-100 translate-middle rounded-circle border border-secondary shadow">
                                    <i class="fa-solid fa-camera"></i>
                                </button>
                            </div>
                            <h4 class="fw-bold mb-1 text-gold">${user.username}</h4>
                            <p class="text-white-50 small mb-4">Member since ${user.createdAt}</p>
                            <div class="d-grid px-4">
                                <span
                                    class="badge bg-gold bg-opacity-10 text-gold border border-gold border-opacity-25 py-2 mb-2">Verified
                                    Account</span>
                                <span
                                    class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 py-2">Frequent
                                    Guest</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-8">
                        <div class="elite-card">
                            <h5 class="fw-bold mb-4">Account Information</h5>
                            <form class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Username</label>
                                    <input type="text"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        value="${user.username}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Email</label>
                                    <input type="email"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        value="${user.email}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Phone
                                        Number</label>
                                    <input type="tel"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        placeholder="+94 77 XXX XXXX">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Language
                                        Preference</label>
                                    <select class="form-select bg-dark text-white border-secondary p-3 rounded-3">
                                        <option value="en">English (US)</option>
                                        <option value="si">Sinhala</option>
                                        <option value="ta">Tamil</option>
                                    </select>
                                </div>
                                <div class="col-12 mt-4">
                                    <hr class="border-secondary opacity-25">
                                    <h5 class="fw-bold mb-4 mt-2">Security</h5>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">New
                                        Password</label>
                                    <input type="password"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        placeholder="Leave blank to keep current">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Confirm New
                                        Password</label>
                                    <input type="password"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3">
                                </div>
                                <div class="col-12 text-end mt-5">
                                    <button type="button" class="btn elite-btn-primary px-5 py-3">Update Profile
                                        Credentials</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>