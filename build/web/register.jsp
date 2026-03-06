<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <style>
            .auth-bg {
                /* Solid dark theme, no image */
                min-height: calc(100vh - 76px);
                display: flex;
                align-items: center;
                padding: 4rem 0;
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
                    <div class="col-md-8 col-lg-7">
                        <div class="glass-card p-5">

                            <% String errorMsg=request.getParameter("error"); %>
                                <% if (errorMsg !=null) { %>
                                    <div
                                        class="alert alert-danger bg-danger text-white border-0 py-2 animate__animated animate__headShake">
                                        <i class="fa-solid fa-circle-exclamation me-2"></i>
                                        <%= errorMsg %>
                                    </div>
                                    <% } %>

                                        <div class="text-center mb-4">
                                            <i class="fa-solid fa-user-plus fa-3x text-info mb-3"
                                                style="filter: drop-shadow(0 0 10px rgba(14, 165, 233, 0.5));"></i>
                                            <h2 class="fw-bold mb-1 text-white">Create an Account</h2>
                                            <p class="text-muted small">Securely register to experience seamless
                                                automated bookings</p>
                                        </div>

                                        <form action="RegisterServlet" method="POST" id="registerForm">
                                            <div class="row g-3">
                                                <div class="col-md-6 mb-2">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">USERNAME</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-user"></i></span>
                                                        <input type="text" name="username"
                                                            class="form-control bg-dark border-secondary text-white"
                                                            required placeholder="Choose a username">
                                                    </div>
                                                </div>

                                                <div class="col-md-6 mb-2">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">EMAIL
                                                        ADDRESS</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-envelope"></i></span>
                                                        <input type="email" name="email"
                                                            class="form-control bg-dark border-secondary text-white"
                                                            required placeholder="Enter your email">
                                                    </div>
                                                </div>

                                                <!-- Password Output & Requirements -->
                                                <div class="col-md-6 mb-2">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">PASSWORD</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-lock"></i></span>
                                                        <input type="password" name="password" id="regPassword"
                                                            class="form-control bg-dark border-secondary text-white"
                                                            required placeholder="Create a strong password"
                                                            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%&*!])[A-Za-z\d@#$%&*!]{8,}$"
                                                            title="Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character (@#$%&*!). No spaces allowed.">
                                                        <button class="btn btn-outline-secondary border-start-0"
                                                            type="button" id="togglePasswordBtn"
                                                            style="background: rgba(255,255,255,0.05); border-color: var(--card-border);">
                                                            <i class="fa-regular fa-eye text-muted"
                                                                id="togglePasswordIcon"></i>
                                                        </button>
                                                    </div>
                                                    <!-- Password Rules Checklist popup -->
                                                    <div class="mt-2 glass-card p-2 px-3 small d-none" id="pwdRulesBox"
                                                        style="border: 1px solid rgba(255,100,100,0.5);">
                                                        <h6 class="text-white mb-2"
                                                            style="font-size: 0.8rem; text-transform:uppercase;"><i
                                                                class="fa-solid fa-shield-halved text-info me-1"></i>
                                                            Security Requirements:</h6>
                                                        <div class="row g-1 text-muted" style="font-size: 0.75rem;">
                                                            <div class="col-6" id="rule-len"><i
                                                                    class="fa-solid fa-xmark text-danger me-1"></i>
                                                                8+
                                                                Characters</div>
                                                            <div class="col-6" id="rule-up"><i
                                                                    class="fa-solid fa-xmark text-danger me-1"></i>
                                                                Uppercase (A-Z)</div>
                                                            <div class="col-6" id="rule-low"><i
                                                                    class="fa-solid fa-xmark text-danger me-1"></i>
                                                                Lowercase (a-z)</div>
                                                            <div class="col-6" id="rule-num"><i
                                                                    class="fa-solid fa-xmark text-danger me-1"></i>
                                                                Number (0-9)</div>
                                                            <div class="col-6" id="rule-spc"><i
                                                                    class="fa-solid fa-xmark text-danger me-1"></i>
                                                                Symbol (@#$%&*!)</div>
                                                            <div class="col-6" id="rule-nospace"><i
                                                                    class="fa-solid fa-check text-success me-1"></i> No
                                                                Spaces</div>
                                                        </div>
                                                        <div class="w-100 mt-2 text-danger fw-bold d-none text-center"
                                                            id="weakWarning" style="font-size: 0.75rem;">
                                                            <i class="fa-solid fa-triangle-exclamation"></i> Password is
                                                            too common/weak.
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-12 mb-2">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">FULL
                                                        NAME</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-id-card"></i></span>
                                                        <input type="text" name="fullName"
                                                            class="form-control bg-dark border-secondary text-white"
                                                            required placeholder="John Doe">
                                                    </div>
                                                </div>

                                                <div class="col-md-6 mb-2">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">CONTACT
                                                        NUMBER</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-phone"></i></span>
                                                        <input type="text" name="contactNumber"
                                                            class="form-control bg-dark border-secondary text-white"
                                                            required placeholder="e.g. 0771234567">
                                                    </div>
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">ADDRESS</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-map-location-dot"></i></span>
                                                        <input type="text" name="address"
                                                            class="form-control bg-dark border-secondary text-white"
                                                            required placeholder="Your address">
                                                    </div>
                                                </div>

                                                <div class="col-12 mb-3 mt-3">
                                                    <label
                                                        class="form-label text-light small fw-bold tracking-wider">ACCOUNT
                                                        ROLE</label>
                                                    <div class="input-group">
                                                        <span
                                                            class="input-group-text bg-dark border-secondary text-info"><i
                                                                class="fa-solid fa-id-badge"></i></span>
                                                        <select name="role" id="roleSelect"
                                                            class="form-select bg-dark border-secondary text-white"
                                                            style="cursor: pointer;">
                                                            <option value="Guest" selected>Guest (Default)</option>
                                                            <option value="Receptionist">Receptionist</option>
                                                            <option value="Manager">Manager</option>
                                                            <option value="Accountant">Accountant</option>
                                                            <option value="Admin">System Admin</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <!-- Hidden Auth Code Field -->
                                                <div class="col-12 mb-4 d-none" id="authCodeContainer">
                                                    <div class="glass-card p-3" id="authCodeBox"
                                                        style="border: 1px solid rgba(14, 165, 233, 0.4); background: rgba(0,0,0,0.2);">
                                                        <label
                                                            class="form-label text-warning small fw-bold tracking-wider"
                                                            id="authCodeLabel"><i class="fa-solid fa-key me-1"></i>
                                                            Authorization Code</label>
                                                        <div class="input-group">
                                                            <span
                                                                class="input-group-text bg-dark border-warning text-warning"><i
                                                                    class="fa-solid fa-shield-cat"></i></span>
                                                            <input type="password" name="authCode" id="authCodeInput"
                                                                class="form-control bg-dark border-warning text-white"
                                                                placeholder="Enter secure override code">
                                                        </div>
                                                        <div class="text-danger small mt-2 d-none fw-bold"
                                                            id="authCodeError"><i
                                                                class="fa-solid fa-triangle-exclamation"></i> Invalid
                                                            Authorization Code!</div>
                                                    </div>
                                                </div>

                                            </div>

                                            <button type="submit"
                                                class="btn btn-primary w-100 fw-bold py-2 mt-2 mb-3 shadow-lg"
                                                style="letter-spacing: 1px;">
                                                REGISTER ACCOUNT <i class="fa-solid fa-arrow-right ms-2"></i>
                                            </button>

                                            <div class="text-center mt-3 pt-3 border-top border-secondary">
                                                <span class="text-muted small">Already have an account?</span>
                                                <a href="login.jsp"
                                                    class="text-info text-decoration-none ms-1 fw-bold small">Login
                                                    here</a>
                                            </div>
                                        </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const passwordInput = document.getElementById('regPassword');
                const togglePasswordBtn = document.getElementById('togglePasswordBtn');
                const togglePasswordIcon = document.getElementById('togglePasswordIcon');
                const registerForm = document.getElementById('registerForm');

                // Rules UI Elements
                const rulesBox = document.getElementById('pwdRulesBox');
                const rLen = document.getElementById('rule-len');
                const rUp = document.getElementById('rule-up');
                const rLow = document.getElementById('rule-low');
                const rNum = document.getElementById('rule-num');
                const rSpc = document.getElementById('rule-spc');
                const rNospace = document.getElementById('rule-nospace');
                const weakWarn = document.getElementById('weakWarning');

                const weakPatterns = ["password", "12345678", "qwerty", "admin123", "guest123", "123456789", "iloveyou"];

                togglePasswordBtn.addEventListener('click', function () {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    togglePasswordIcon.classList.toggle('fa-eye');
                    togglePasswordIcon.classList.toggle('fa-eye-slash');
                    togglePasswordIcon.classList.toggle('text-info');
                    togglePasswordIcon.classList.toggle('text-muted');
                });

                // Helper to cleanly toggle rule checks visually
                function updateRule(elem, isValid) {
                    const icon = elem.querySelector('i');
                    if (isValid) {
                        elem.classList.remove('text-muted', 'text-danger');
                        elem.classList.add('text-success');
                        icon.className = 'fa-solid fa-check text-success me-1';
                    } else {
                        elem.classList.remove('text-success');
                        elem.classList.add('text-muted');
                        icon.className = 'fa-solid fa-xmark text-danger me-1';
                    }
                }

                // Dynamic keyup checking
                passwordInput.addEventListener('input', function () {
                    const val = passwordInput.value;
                    if (val.length > 0) {
                        rulesBox.classList.remove('d-none');
                    } else {
                        rulesBox.classList.add('d-none');
                    }

                    // Checks
                    const len = val.length >= 8;
                    const up = /[A-Z]/.test(val);
                    const low = /[a-z]/.test(val);
                    const num = /[0-9]/.test(val);
                    const spc = /[@#$%&*!]/.test(val);
                    const nospace = !/\s/.test(val);

                    let isWeak = false;
                    const lowerVal = val.toLowerCase();
                    weakPatterns.forEach(w => {
                        if (lowerVal.includes(w)) isWeak = true;
                    });

                    updateRule(rLen, len);
                    updateRule(rUp, up);
                    updateRule(rLow, low);
                    updateRule(rNum, num);
                    updateRule(rSpc, spc);
                    updateRule(rNospace, nospace);

                    if (isWeak && val.length > 0) {
                        weakWarn.classList.remove('d-none');
                    } else {
                        weakWarn.classList.add('d-none');
                    }

                    // Change box color based on total validity
                    if (len && up && low && num && spc && nospace && !isWeak) {
                        rulesBox.style.borderColor = 'rgba(25, 135, 84, 0.8)'; // Success green
                        rulesBox.style.boxShadow = '0 0 10px rgba(25, 135, 84, 0.3)';
                    } else {
                        rulesBox.style.borderColor = 'rgba(220, 53, 69, 0.5)'; // Danger red
                        rulesBox.style.boxShadow = 'none';
                    }
                });

                // Dynamic Role Selection Logic
                const roleSelect = document.getElementById('roleSelect');
                const authCodeContainer = document.getElementById('authCodeContainer');
                const authCodeBox = document.getElementById('authCodeBox');
                const authCodeLabel = document.getElementById('authCodeLabel');
                const authCodeInput = document.getElementById('authCodeInput');
                const authCodeError = document.getElementById('authCodeError');

                roleSelect.addEventListener('change', function () {
                    const role = this.value;
                    if (role === 'Guest') {
                        authCodeContainer.classList.add('d-none');
                        authCodeContainer.classList.remove('animate__animated', 'animate__fadeInDown');
                        authCodeInput.required = false;
                        authCodeInput.value = ''; // clear on hide
                        authCodeError.classList.add('d-none'); // hide error if previously shown
                        authCodeBox.style.borderColor = 'rgba(14, 165, 233, 0.4)'; // reset border
                        authCodeBox.style.boxShadow = 'none'; // reset shadow
                    } else {
                        // Dynamically update label
                        if (role === 'Admin') authCodeLabel.innerHTML = '<i class="fa-solid fa-key me-1"></i> Admin Authorization Code';
                        else if (role === 'Manager') authCodeLabel.innerHTML = '<i class="fa-solid fa-key me-1"></i> Department Authorization Code';
                        else if (role === 'Receptionist') authCodeLabel.innerHTML = '<i class="fa-solid fa-key me-1"></i> Branch Authorization Code';
                        else if (role === 'Accountant') authCodeLabel.innerHTML = '<i class="fa-solid fa-key me-1"></i> Finance Authorization Code';

                        authCodeContainer.classList.remove('d-none');
                        authCodeContainer.classList.add('animate__animated', 'animate__fadeInDown');
                        authCodeInput.required = true;
                    }
                });

                // Prevent submission if invalid
                registerForm.addEventListener('submit', function (e) {
                    const val = passwordInput.value;
                    const isValid = val.length >= 8 && /[A-Z]/.test(val) && /[a-z]/.test(val) && /[0-9]/.test(val) && /[@#$%&*!]/.test(val) && !/\s/.test(val);

                    let isWeak = false;
                    weakPatterns.forEach(w => { if (val.toLowerCase().includes(w)) isWeak = true; });

                    let authValid = true;
                    if (roleSelect.value !== 'Guest') {
                        // Frontend Enforcement of OVR1234
                        if (authCodeInput.value !== 'OVR1234') {
                            authValid = false;
                            authCodeError.classList.remove('d-none');
                            authCodeBox.style.borderColor = 'rgba(220, 53, 69, 0.8)'; // Red
                            authCodeBox.style.boxShadow = '0 0 15px rgba(220, 53, 69, 0.5)';
                            authCodeBox.classList.remove('animate__animated', 'animate__shakeX'); // reset animation
                            void authCodeBox.offsetWidth; // trigger reflow
                            authCodeBox.classList.add('animate__animated', 'animate__shakeX');
                            authCodeInput.focus();
                        } else {
                            authCodeError.classList.add('d-none');
                            authCodeBox.style.borderColor = 'rgba(25, 135, 84, 0.8)'; // Green
                            authCodeBox.style.boxShadow = 'none';
                        }
                    }

                    if (!isValid || isWeak || !authValid) {
                        e.preventDefault();
                        if (!isValid || isWeak) {
                            rulesBox.classList.remove('d-none');
                            rulesBox.classList.remove('animate__animated', 'animate__headShake');
                            void rulesBox.offsetWidth;
                            rulesBox.classList.add('animate__animated', 'animate__headShake');
                            if (authValid) passwordInput.focus();
                        }
                    }
                });
            });
        </script>

        <%@ include file="footer.jspf" %>