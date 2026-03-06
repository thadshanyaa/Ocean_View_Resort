<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <% if(session.getAttribute("user")==null){ response.sendRedirect("login.jsp"); return; } %>

            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-md-8 col-lg-6" data-aos="fade-up">

                        <div class="glass-card p-5">
                            <div class="text-center mb-4">
                                <div class="bg-warning bg-opacity-25 rounded-circle d-inline-flex align-items-center justify-content-center mb-3 text-white"
                                    style="width: 70px; height: 70px; box-shadow: 0 0 15px rgba(255, 193, 7, 0.5);">
                                    <i class="fa-solid fa-key fa-2x"></i>
                                </div>
                                <h3 class="fw-bold mb-1">Update Security Key</h3>
                                <p class="text-muted small">Choose a strong, unique password to protect your account.
                                </p>
                            </div>

                            <form action="ChangePasswordServlet" method="POST" id="pwdForm">

                                <div class="mb-4">
                                    <label class="form-label text-light small fw-bold tracking-wider">CURRENT
                                        PASSWORD</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark border-secondary text-warning"><i
                                                class="fa-solid fa-unlock-keyhole"></i></span>
                                        <input type="password" name="currentPassword"
                                            class="form-control bg-dark border-secondary text-white" required
                                            placeholder="Enter current password">
                                    </div>
                                </div>

                                <div class="mb-3 position-relative">
                                    <label class="form-label text-light small fw-bold tracking-wider">NEW
                                        PASSWORD</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark border-secondary text-info"><i
                                                class="fa-solid fa-lock"></i></span>
                                        <input type="password" name="newPassword" id="newPwd"
                                            class="form-control bg-dark border-secondary text-white" required
                                            placeholder="Create new strong password"
                                            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%&*!])[A-Za-z\d@#$%&*!]{8,}$"
                                            title="Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character (@#$%&*!). No spaces allowed.">
                                        <button class="btn btn-outline-secondary border-start-0" type="button"
                                            id="toggleNew"
                                            style="background: rgba(255,255,255,0.05); border-color: var(--card-border);">
                                            <i class="fa-regular fa-eye text-muted" id="iconNew"></i>
                                        </button>
                                    </div>

                                    <!-- Realtime Rules popup -->
                                    <div class="mt-2 glass-card p-2 px-3 small d-none" id="pwdRulesBox"
                                        style="border: 1px solid rgba(255,100,100,0.5);">
                                        <h6 class="text-white mb-2"
                                            style="font-size: 0.8rem; text-transform:uppercase;"><i
                                                class="fa-solid fa-shield-halved text-info me-1"></i> Security
                                            Requirements:</h6>
                                        <div class="row g-1 text-muted" style="font-size: 0.75rem;">
                                            <div class="col-6" id="rule-len"><i
                                                    class="fa-solid fa-xmark text-danger me-1"></i> 8+ Characters</div>
                                            <div class="col-6" id="rule-up"><i
                                                    class="fa-solid fa-xmark text-danger me-1"></i> Uppercase (A-Z)
                                            </div>
                                            <div class="col-6" id="rule-low"><i
                                                    class="fa-solid fa-xmark text-danger me-1"></i> Lowercase (a-z)
                                            </div>
                                            <div class="col-6" id="rule-num"><i
                                                    class="fa-solid fa-xmark text-danger me-1"></i> Number (0-9)</div>
                                            <div class="col-6" id="rule-spc"><i
                                                    class="fa-solid fa-xmark text-danger me-1"></i> Symbol (@#$%&*!)
                                            </div>
                                            <div class="col-6" id="rule-nospace"><i
                                                    class="fa-solid fa-check text-success me-1"></i> No Spaces</div>
                                        </div>
                                        <div class="w-100 mt-2 text-danger fw-bold d-none text-center" id="weakWarning"
                                            style="font-size: 0.75rem;">
                                            <i class="fa-solid fa-triangle-exclamation"></i> Password is too
                                            common/weak.
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label text-light small fw-bold tracking-wider">CONFIRM NEW
                                        PASSWORD</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark border-secondary text-info"><i
                                                class="fa-solid fa-lock"></i></span>
                                        <input type="password" name="confirmPassword" id="confirmPwd"
                                            class="form-control bg-dark border-secondary text-white" required
                                            placeholder="Re-enter new password">
                                    </div>
                                    <div class="text-danger small mt-1 d-none fw-bold" id="matchWarning"><i
                                            class="fa-solid fa-circle-xmark me-1"></i> Passwords do not match!</div>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <a href="dashboard.jsp" class="btn btn-outline-secondary px-4">Cancel</a>
                                    <button type="submit" class="btn btn-warning px-4 fw-bold shadow disabled"
                                        id="submitBtn"><i class="fa-solid fa-floppy-disk me-2"></i> UPDATE
                                        PASSWORD</button>
                                </div>

                            </form>

                        </div>
                    </div>
                </div>
            </div>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const newPwd = document.getElementById('newPwd');
                    const confirmPwd = document.getElementById('confirmPwd');
                    const submitBtn = document.getElementById('submitBtn');
                    const matchWarning = document.getElementById('matchWarning');
                    const form = document.getElementById('pwdForm');

                    // Visibility Toggle
                    document.getElementById('toggleNew').addEventListener('click', function () {
                        const type = newPwd.getAttribute('type') === 'password' ? 'text' : 'password';
                        newPwd.setAttribute('type', type);
                        document.getElementById('iconNew').classList.toggle('fa-eye');
                        document.getElementById('iconNew').classList.toggle('fa-eye-slash');
                        document.getElementById('iconNew').classList.toggle('text-info');
                    });

                    // Rules UI
                    const rulesBox = document.getElementById('pwdRulesBox');
                    const rLen = document.getElementById('rule-len');
                    const rUp = document.getElementById('rule-up');
                    const rLow = document.getElementById('rule-low');
                    const rNum = document.getElementById('rule-num');
                    const rSpc = document.getElementById('rule-spc');
                    const rNospace = document.getElementById('rule-nospace');
                    const weakWarn = document.getElementById('weakWarning');
                    const weakPatterns = ["password", "12345678", "qwerty", "admin123", "guest123", "123456789", "iloveyou"];

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

                    function checkOverallValidity() {
                        const val = newPwd.value;
                        const cVal = confirmPwd.value;

                        const isValidRegex = val.length >= 8 && /[A-Z]/.test(val) && /[a-z]/.test(val) && /[0-9]/.test(val) && /[@#$%&*!]/.test(val) && !/\s/.test(val);

                        let isWeak = false;
                        weakPatterns.forEach(w => { if (val.toLowerCase().includes(w)) isWeak = true; });

                        const isMatch = val === cVal && val.length > 0;

                        if (cVal.length > 0 && !isMatch) {
                            matchWarning.classList.remove('d-none');
                        } else {
                            matchWarning.classList.add('d-none');
                        }

                        if (isValidRegex && !isWeak && isMatch) {
                            submitBtn.classList.remove('disabled');
                        } else {
                            submitBtn.classList.add('disabled');
                        }
                    }

                    newPwd.addEventListener('input', function () {
                        const val = newPwd.value;
                        if (val.length > 0) rulesBox.classList.remove('d-none');
                        else rulesBox.classList.add('d-none');

                        const len = val.length >= 8;
                        const up = /[A-Z]/.test(val);
                        const low = /[a-z]/.test(val);
                        const num = /[0-9]/.test(val);
                        const spc = /[@#$%&*!]/.test(val);
                        const nospace = !/\s/.test(val);

                        let isWeak = false;
                        weakPatterns.forEach(w => { if (val.toLowerCase().includes(w)) isWeak = true; });

                        updateRule(rLen, len); updateRule(rUp, up); updateRule(rLow, low);
                        updateRule(rNum, num); updateRule(rSpc, spc); updateRule(rNospace, nospace);

                        if (isWeak && val.length > 0) weakWarn.classList.remove('d-none');
                        else weakWarn.classList.add('d-none');

                        if (len && up && low && num && spc && nospace && !isWeak) {
                            rulesBox.style.borderColor = 'rgba(25, 135, 84, 0.8)';
                            rulesBox.style.boxShadow = '0 0 10px rgba(25, 135, 84, 0.3)';
                        } else {
                            rulesBox.style.borderColor = 'rgba(220, 53, 69, 0.5)';
                            rulesBox.style.boxShadow = 'none';
                        }

                        checkOverallValidity();
                    });

                    confirmPwd.addEventListener('input', checkOverallValidity);

                    form.addEventListener('submit', function (e) {
                        if (submitBtn.classList.contains('disabled')) {
                            e.preventDefault();
                            rulesBox.classList.remove('d-none');
                            rulesBox.classList.add('animate__animated', 'animate__headShake');
                            setTimeout(() => rulesBox.classList.remove('animate__animated', 'animate__headShake'), 1000);
                        }
                    });
                });
            </script>

            <%@ include file="footer.jspf" %>