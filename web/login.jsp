<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <style>
            .auth-bg {
                /* Solid dark theme, no image */
                min-height: calc(100vh - 76px);
                display: flex;
                align-items: center;
                position: relative;
            }

            .auth-bg::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(rgba(13, 17, 23, 0.8), rgba(13, 17, 23, 0.9)), url('https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=2070&auto=format&fit=crop') center/cover fixed;
                pointer-events: none;
            }
        </style>

        <div class="auth-bg w-100">
            <div class="container">
                <div class="row justify-content-center" data-aos="fade-up" data-aos-duration="800">
                    <div class="col-md-6 col-lg-5">
                        <div class="glass-card p-5">

                            <% String errorMsg=request.getParameter("error"); %>
                                <% if (errorMsg !=null) { %>
                                    <div
                                        class="alert alert-danger bg-danger text-white border-0 py-2 animate__animated animate__headShake">
                                        <i class="fa-solid fa-circle-exclamation me-2"></i>
                                        <%= errorMsg %>
                                    </div>
                                    <% } %>

                                        <% String successMsg=request.getParameter("msg"); %>
                                            <% if (successMsg !=null) { %>
                                                <div
                                                    class="alert alert-success bg-success text-white border-0 py-2 animate__animated animate__fadeIn">
                                                    <i class="fa-solid fa-circle-check me-2"></i>
                                                    <%= successMsg %>
                                                </div>
                                                <% } %>

                                                    <div class="text-center mb-4">
                                                        <i class="fa-solid fa-user-lock fa-3x text-info mb-3"
                                                            style="filter: drop-shadow(0 0 10px rgba(14, 165, 233, 0.5));"></i>
                                                        <h2 class="fw-bold mb-1 text-white">Welcome Back</h2>
                                                        <p class="text-muted small">Enter your credentials to access
                                                            your account</p>
                                                    </div>

                                                    <form action="AuthServlet" method="POST">
                                                        <div class="mb-3">
                                                            <label
                                                                class="form-label text-light small fw-bold tracking-wider">USERNAME</label>
                                                            <div class="input-group">
                                                                <span
                                                                    class="input-group-text bg-dark border-secondary text-info"><i
                                                                        class="fa-solid fa-user"></i></span>
                                                                <input type="text" name="username"
                                                                    class="form-control bg-dark border-secondary text-white"
                                                                    required placeholder="Enter username">
                                                            </div>
                                                        </div>

                                                        <div class="mb-4">
                                                            <label
                                                                class="form-label text-light small fw-bold tracking-wider">PASSWORD</label>
                                                            <div class="input-group">
                                                                <span
                                                                    class="input-group-text bg-dark border-secondary text-info"><i
                                                                        class="fa-solid fa-lock"></i></span>
                                                                <input type="password" name="password"
                                                                    class="form-control bg-dark border-secondary text-white"
                                                                    required placeholder="••••••••">
                                                            </div>
                                                        </div>

                                                        <button type="submit"
                                                            class="btn btn-primary w-100 fw-bold py-2 mb-3 shadow-lg"
                                                            style="letter-spacing: 1px;">
                                                            LOGIN SECURELY <i class="fa-solid fa-shield-check ms-1"></i>
                                                        </button>

                                                        <div class="text-center mt-3 pt-3 border-top border-secondary">
                                                            <span class="text-muted small">Don't have an account?</span>
                                                            <a href="register.jsp"
                                                                class="text-info text-decoration-none ms-1 fw-bold small">Register
                                                                here</a>
                                                        </div>
                                                    </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>