<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <style>
            .auth-bg {
                background-color: #0d1117;
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

            /* Premium Modal Styling */
            .modal-content.glass-dark {
                background: rgba(13, 17, 23, 0.95);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(14, 165, 233, 0.3);
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.8);
            }

            /* Toast positioning */
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 9999;
            }
        </style>

        <div class="auth-bg w-100">
            <div class="container">
                <div class="row justify-content-center" data-aos="zoom-in" data-aos-duration="600">
                    <div class="col-md-6 col-lg-5">
                        <div class="glass-card p-5 text-center">

                            <% String errorMsg=request.getParameter("error"); %>
                                <% if (errorMsg !=null) { %>
                                    <div
                                        class="alert alert-danger bg-danger text-white border-0 py-2 animate__animated animate__headShake">
                                        <i class="fa-solid fa-circle-exclamation me-2"></i>
                                        <%= errorMsg %>
                                    </div>
                                    <% } %>

                                        <div class="mb-4">
                                            <i class="fa-solid fa-shield-halved fa-4x text-info mb-3"
                                                style="filter: drop-shadow(0 0 15px rgba(14, 165, 233, 0.6));"></i>
                                            <h3 class="fw-bold mb-1 text-white">Verify Identity</h3>
                                            <p class="text-muted small">
                                                A secure, hidden verification code was sent to your contact number
                                                <% String contactParam=request.getParameter("contact"); %>
                                                    <% if(contactParam !=null && !contactParam.trim().isEmpty()) { %>
                                                        <br><strong class="text-info fs-5 tracking-widest">
                                                            <%= contactParam %>
                                                        </strong>
                                                        <% } %>
                                            </p>
                                        </div>

                                        <form action="OtpVerifyServlet" method="POST" id="verifyForm">
                                            <div class="mb-4">
                                                <!-- Hidden OTP field, rendered readonly with dots -->
                                                <input type="text" name="otp" id="otpInput"
                                                    class="form-control form-control-lg text-center fw-bold fs-3 border-info text-white"
                                                    required placeholder="Waiting for generation..." autocomplete="off"
                                                    readonly
                                                    style="letter-spacing: 0.8rem; background: rgba(0,0,0,0.4); box-shadow: inset 0 0 10px rgba(0,0,0,0.5);">
                                                <small class="text-secondary mt-2 d-block mx-auto"><i
                                                        class="fa-solid fa-lock"></i> OTP is securely managed in the
                                                    server session.</small>
                                            </div>
                                            <button type="submit" id="verifyBtn"
                                                class="btn btn-primary w-100 fw-bold py-2 mb-3 shadow-lg"
                                                style="letter-spacing: 1px;" disabled>
                                                <i class="fa-solid fa-lock-open me-2"></i> VERIFY & LOGIN
                                            </button>
                                        </form>

                                        <p class="text-muted small mb-0 mt-3">Didn't receive the code?</p>
                                        <button type="button" id="resendModalBtn"
                                            class="btn btn-link text-info text-decoration-none fw-bold p-0"
                                            onclick="showPasswordModal()">
                                            <i class="fa-solid fa-rotate-right me-1"></i> Resend OTP
                                        </button>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Password Verification Modal -->
        <div class="modal fade" id="passwordModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content glass-dark text-white">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title fw-bold"><i class="fa-solid fa-user-lock text-info me-2"></i> Security
                            Verification</h5>
                    </div>
                    <div class="modal-body p-4">
                        <p class="text-light small mb-4">Please confirm your account password to generate and send a new
                            One-Time Password.</p>

                        <div id="modalError"
                            class="alert alert-danger bg-danger text-white border-0 py-2 d-none animate__animated animate__shakeX">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> <span id="modalErrorText"></span>
                        </div>

                        <form id="generateOtpForm">
                            <div class="mb-4">
                                <label class="form-label text-light small fw-bold tracking-wider">PASSWORD</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-dark border-secondary text-info"><i
                                            class="fa-solid fa-key"></i></span>
                                    <input type="password" id="confirmPassword"
                                        class="form-control bg-dark border-secondary text-white" required
                                        placeholder="Enter password to generate OTP">
                                </div>
                            </div>
                            <button type="submit" id="generateBtn" class="btn btn-info w-100 fw-bold text-dark">
                                GENERATE SECURE OTP <i class="fa-solid fa-paper-plane ms-1"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Toast Notification -->
        <div class="toast-container">
            <div id="successToast" class="toast align-items-center text-white bg-success border-0" role="alert"
                aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-bold">
                        <i class="fa-solid fa-circle-check me-2"></i> OTP generated successfully!
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                        aria-label="Close"></button>
                </div>
            </div>
        </div>

        <script>
            let pwdModal;
            let toastInstance;

            document.addEventListener("DOMContentLoaded", function () {
                pwdModal = new bootstrap.Modal(document.getElementById('passwordModal'));
                toastInstance = new bootstrap.Toast(document.getElementById('successToast'));
        
        <% if (request.getParameter("error") == null) { %>
                    // Auto open the modal on first visit if an error wasn't already returned by the VerifyServlet
                    pwdModal.show();
        <% } %>

                    // Handle the Fetch API Generation
                    document.getElementById('generateOtpForm').addEventListener('submit', function (e) {
                        e.preventDefault();

                        const btn = document.getElementById('generateBtn');
                        const pwd = document.getElementById('confirmPassword').value;
                        const errorBox = document.getElementById('modalError');
                        const errorText = document.getElementById('modalErrorText');

                        btn.disabled = true;
                        btn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin me-2"></i> GENERATING...';
                        errorBox.classList.add('d-none');

                        // Form data mapping
                        const formData = new URLSearchParams();
                        formData.append('password', pwd);

                        fetch('GenerateOtpServlet', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: formData.toString()
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    // It worked!
                                    pwdModal.hide();
                                    toastInstance.show();
                                    document.getElementById('confirmPassword').value = '';

                                    // Setup UI to reflect generated state
                                    const otpInput = document.getElementById('otpInput');
                                    otpInput.value = '••••••';
                                    otpInput.classList.add('text-success');

                                    document.getElementById('verifyBtn').disabled = false;
                                } else {
                                    // Show error inside modal
                                    errorText.textContent = data.message;
                                    errorBox.classList.remove('d-none');
                                }
                            })
                            .catch(err => {
                                errorText.textContent = "System error contacting server.";
                                errorBox.classList.remove('d-none');
                            })
                            .finally(() => {
                                btn.disabled = false;
                                btn.innerHTML = 'GENERATE SECURE OTP <i class="fa-solid fa-paper-plane ms-1"></i>';
                            });
                    });
            });

            function showPasswordModal() {
                // Reset state and show
                document.getElementById('confirmPassword').value = '';
                document.getElementById('modalError').classList.add('d-none');
                pwdModal.show();
            }
        </script>

        <%@ include file="footer.jspf" %>