<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, java.util.*, ovr.*" %>
        <%@ include file="header.jspf" %>
            <%@ taglib uri="jakarta.tags.core" prefix="c" %>
                <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

                    <div class="container-fluid py-4 min-vh-100">
                        <div class="row">
                            <!-- Sidebar Navigation -->
                            <div class="col-lg-3 col-md-4 mb-4" data-aos="fade-right">
                                <%@ include file="sidebar.jspf" %>
                            </div>

                            <!-- Main Content Area -->
                            <div class="col-lg-9 col-md-8" data-aos="fade-up">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4"
                                        role="alert">
                                        <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty param.msg}">
                                    <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4"
                                        role="alert">
                                        <i class="fa-solid fa-circle-check me-2"></i> ${param.msg}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <c:choose>
                                    <%-- DASHBOARD VIEW --%>
                                        <c:when test="${currentView == 'dashboard'}">
                                            <div
                                                class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                <h3 class="fw-bold text-warning mb-0"><i
                                                        class="fa-solid fa-gauge-high me-2"></i>Admin Dashboard</h3>
                                                <span class="badge bg-danger px-3 py-2 rounded-pill"><i
                                                        class="fa-solid fa-user-shield me-1"></i> Full Access</span>
                                            </div>

                                            <!-- Statistics Cards -->
                                            <div class="row g-3 mb-4">
                                                <div class="col-md-3">
                                                    <div
                                                        class="glass-card p-3 text-center border-bottom border-primary border-3">
                                                        <div class="text-primary fs-3 mb-1"><i
                                                                class="fa-solid fa-door-open"></i></div>
                                                        <div class="small text-muted text-uppercase fw-bold">Total Rooms
                                                        </div>
                                                        <div class="fs-2 fw-bold text-white">${totalRooms}</div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div
                                                        class="glass-card p-3 text-center border-bottom border-success border-3">
                                                        <div class="text-success fs-3 mb-1"><i
                                                                class="fa-solid fa-calendar-check"></i></div>
                                                        <div class="small text-muted text-uppercase fw-bold">Total
                                                            Bookings</div>
                                                        <div class="fs-2 fw-bold text-white">${totalBookings}</div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div
                                                        class="glass-card p-3 text-center border-bottom border-warning border-3">
                                                        <div class="text-warning fs-3 mb-1"><i
                                                                class="fa-solid fa-sack-dollar"></i></div>
                                                        <div class="small text-muted text-uppercase fw-bold">Total
                                                            Revenue</div>
                                                        <div class="fs-2 fw-bold text-white">
                                                            <fmt:formatNumber value="${totalRevenue}" type="currency"
                                                                currencySymbol="LKR " />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div
                                                        class="glass-card p-3 text-center border-bottom border-info border-3">
                                                        <div class="text-info fs-3 mb-1"><i
                                                                class="fa-solid fa-user-tie"></i></div>
                                                        <div class="small text-muted text-uppercase fw-bold">Active
                                                            Staff</div>
                                                        <div class="fs-2 fw-bold text-white">${totalStaff}</div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Charts Row -->
                                            <div class="row g-4 mb-4">
                                                <div class="col-lg-8">
                                                    <div class="glass-card p-4 h-100">
                                                        <h5 class="text-warning mb-4"><i
                                                                class="fa-solid fa-chart-line me-2"></i>Booking &
                                                            Revenue Analytics</h5>
                                                        <canvas id="dashboardChart" style="max-height: 300px;"></canvas>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="glass-card p-4 h-100">
                                                        <h5 class="text-warning mb-4"><i
                                                                class="fa-solid fa-list-ol me-2"></i>System Status</h5>
                                                        <div class="d-grid gap-3">
                                                            <div
                                                                class="p-3 bg-dark bg-opacity-25 rounded border border-secondary">
                                                                <div class="small text-muted">Server Status</div>
                                                                <div class="text-success fw-bold"><i
                                                                        class="fa-solid fa-circle me-1 small"></i>
                                                                    Online & Healthy</div>
                                                            </div>
                                                            <div
                                                                class="p-3 bg-dark bg-opacity-25 rounded border border-secondary">
                                                                <div class="small text-muted">Database Connection</div>
                                                                <div class="text-success fw-bold"><i
                                                                        class="fa-solid fa-database me-1"></i> Connected
                                                                    (OVR_DB)</div>
                                                            </div>
                                                            <button class="btn btn-outline-warning w-100"
                                                                onclick="window.location.reload()">
                                                                <i class="fa-solid fa-sync me-2"></i> Refresh All Data
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Audit Logs Section -->
                                            <div class="glass-card p-4">
                                                <h5 class="text-warning mb-3 border-bottom border-secondary pb-2"><i
                                                        class="fa-solid fa-history me-2"></i>Recent System Activity</h5>
                                                <div class="table-responsive">
                                                    <table
                                                        class="table table-dark table-hover table-sm align-middle mb-0"
                                                        style="background: transparent;">
                                                        <thead>
                                                            <tr class="text-muted">
                                                                <th>Timestamp</th>
                                                                <th>Action</th>
                                                                <th>Details</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="l" items="${recentLogs}">
                                                                <tr>
                                                                    <td class="small text-muted">${l.timestamp}</td>
                                                                    <td><span
                                                                            class="badge bg-secondary">${l.action}</span>
                                                                    </td>
                                                                    <td>${l.details}</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </c:when>

                                        <%-- ROOMS VIEW --%>
                                            <c:when test="${currentView == 'rooms'}">
                                                <div
                                                    class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                    <h3 class="fw-bold text-warning mb-0"><i
                                                            class="fa-solid fa-door-open me-2"></i>Room Management</h3>
                                                    <button class="btn btn-neon btn-sm px-3" data-bs-toggle="modal"
                                                        data-bs-target="#addRoomModal">
                                                        <i class="fa-solid fa-plus me-1"></i> Add Room
                                                    </button>
                                                </div>

                                                <div class="glass-card p-4">
                                                    <div class="table-responsive">
                                                        <table class="table table-dark table-hover align-middle">
                                                            <thead>
                                                                <tr>
                                                                    <th>Room No</th>
                                                                    <th>Type</th>
                                                                    <th>Status</th>
                                                                    <th>Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="r" items="${rooms}">
                                                                    <tr>
                                                                        <td class="fw-bold text-neon">${r.roomNumber}
                                                                        </td>
                                                                        <td>
                                                                            <c:forEach var="rt" items="${roomTypes}">
                                                                                <c:if test="${rt.id == r.roomTypeId}">
                                                                                    ${rt.typeName}</c:if>
                                                                            </c:forEach>
                                                                        </td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when test="${r.available}"><span
                                                                                        class="badge bg-success">Active</span>
                                                                                </c:when>
                                                                                <c:otherwise><span
                                                                                        class="badge bg-danger">Inactive</span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                        <td>
                                                                            <button
                                                                                class="btn btn-sm btn-outline-danger"
                                                                                onclick="deleteRoom(${r.id})"><i
                                                                                    class="fa-solid fa-trash"></i></button>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </c:when>

                                            <%-- STAFF VIEW --%>
                                                <c:when test="${currentView == 'staff'}">
                                                    <div
                                                        class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                        <h3 class="fw-bold text-warning mb-0"><i
                                                                class="fa-solid fa-user-shield me-2"></i>Staff Accounts
                                                        </h3>
                                                    </div>
                                                    <div class="glass-card p-4">
                                                        <div class="table-responsive">
                                                            <table class="table table-dark table-hover align-middle">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Username</th>
                                                                        <th>Role</th>
                                                                        <th>Status</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="s" items="${staffList}">
                                                                        <tr>
                                                                            <td>${s.username}</td>
                                                                            <td><span
                                                                                    class="badge bg-info text-dark">${s.role}</span>
                                                                            </td>
                                                                            <td><span
                                                                                    class="badge ${s.verified ? 'bg-success' : 'bg-danger'}">${s.verified
                                                                                    ? 'Active' : 'Disabled'}</span></td>
                                                                            <td>
                                                                                <button
                                                                                    class="btn btn-sm btn-outline-warning"
                                                                                    title="Reset Password"
                                                                                    onclick="showResetModal(${s.id}, '${s.username}')">
                                                                                    <i class="fa-solid fa-key"></i>
                                                                                </button>
                                                                                <button
                                                                                    class="btn btn-sm ${s.verified ? 'btn-outline-danger' : 'btn-outline-success'}"
                                                                                    title="${s.verified ? 'Disable' : 'Enable'} User"
                                                                                    onclick="toggleStaff(${s.id})">
                                                                                    <i
                                                                                        class="fa-solid ${s.verified ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </c:when>

                                                <%-- GUESTS VIEW --%>
                                                    <c:when test="${currentView == 'guests'}">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                            <h3 class="fw-bold text-warning mb-0"><i
                                                                    class="fa-solid fa-users me-2"></i>Guest Management
                                                            </h3>
                                                        </div>
                                                        <div class="glass-card p-4">
                                                            <div class="table-responsive">
                                                                <table
                                                                    class="table table-dark table-hover align-middle">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Full Name</th>
                                                                            <th>Contact</th>
                                                                            <th>Username</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach var="g" items="${guestList}">
                                                                            <tr>
                                                                                <td class="fw-bold">${g.name}</td>
                                                                                <td>${g.contact}</td>
                                                                                <td class="text-muted small">
                                                                                    ${g.username}</td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <%-- RESERVATIONS VIEW --%>
                                                        <c:when test="${currentView == 'reservations'}">
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                                <h3 class="fw-bold text-warning mb-0"><i
                                                                        class="fa-solid fa-calendar-check me-2"></i>Reservations
                                                                </h3>
                                                            </div>
                                                            <div class="glass-card p-4">
                                                                <div class="table-responsive">
                                                                    <table
                                                                        class="table table-dark table-hover align-middle">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Res No</th>
                                                                                <th>Guest</th>
                                                                                <th>Dates</th>
                                                                                <th>Status</th>
                                                                                <th>Action</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:forEach var="res"
                                                                                items="${reservations}">
                                                                                <tr>
                                                                                    <td class="fw-bold text-neon">
                                                                                        ${res.resNo}</td>
                                                                                    <td>${res.guestName}</td>
                                                                                    <td class="small">${res.checkIn} -
                                                                                        ${res.checkOut}</td>
                                                                                    <td>
                                                                                        <span
                                                                                            class="badge ${res.status == 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">${res.status}</span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <a href="ReservationDetailsServlet?id=${res.id}"
                                                                                            class="btn btn-sm btn-outline-info"><i
                                                                                                class="fa-solid fa-eye"></i></a>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <%-- PAYMENTS VIEW --%>
                                                            <c:when test="${currentView == 'payments'}">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                                    <h3 class="fw-bold text-warning mb-0"><i
                                                                            class="fa-solid fa-file-invoice-dollar me-2"></i>Payment
                                                                        History</h3>
                                                                </div>
                                                                <div class="glass-card p-4">
                                                                    <div class="table-responsive">
                                                                        <table
                                                                            class="table table-dark table-hover align-middle">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>ID</th>
                                                                                    <th>Res No</th>
                                                                                    <th>Guest</th>
                                                                                    <th>Amount</th>
                                                                                    <th>Status</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:forEach var="p"
                                                                                    items="${paymentList}">
                                                                                    <tr>
                                                                                        <td>#${p.id}</td>
                                                                                        <td class="text-neon">${p.resNo}
                                                                                        </td>
                                                                                        <td>${p.guestName}</td>
                                                                                        <td class="fw-bold">LKR
                                                                                            ${p.amount}</td>
                                                                                        <td><span
                                                                                                class="badge ${p.status == 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">${p.status}</span>
                                                                                        </td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </c:when>

                                                            <%-- REPORTS VIEW --%>
                                                                <c:when test="${currentView == 'reports'}">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center mb-4 border-bottom border-warning pb-2">
                                                                        <h3 class="fw-bold text-warning mb-0"><i
                                                                                class="fa-solid fa-chart-pie me-2"></i>Financial
                                                                            Reports</h3>
                                                                        <button class="btn btn-neon btn-sm px-3"
                                                                            onclick="window.print()"><i
                                                                                class="fa-solid fa-download me-1"></i>
                                                                            Print Report</button>
                                                                    </div>
                                                                    <div class="row g-4 mb-4">
                                                                        <div class="col-md-6">
                                                                            <div class="glass-card p-4">
                                                                                <h5
                                                                                    class="text-info border-bottom border-secondary pb-2 mb-3">
                                                                                    Revenue Summary</h5>
                                                                                <div
                                                                                    class="d-flex justify-content-between mb-2">
                                                                                    <span class="text-muted">Total
                                                                                        Revenue:</span>
                                                                                    <span
                                                                                        class="text-neon fw-bold fs-5">LKR
                                                                                        ${totalRevenue}</span>
                                                                                </div>
                                                                                <p class="small text-muted mt-3">Total
                                                                                    revenue collected from all confirmed
                                                                                    payments.</p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="glass-card p-4">
                                                                                <h5
                                                                                    class="text-info border-bottom border-secondary pb-2 mb-3">
                                                                                    System Health</h5>
                                                                                <div class="progress bg-dark mb-2"
                                                                                    style="height: 25px;">
                                                                                    <div class="progress-bar bg-success"
                                                                                        role="progressbar"
                                                                                        style="width: 100%;">SYSTEM
                                                                                        OPTIMAL</div>
                                                                                </div>
                                                                                <p
                                                                                    class="small text-muted text-center pt-2">
                                                                                    All administrative services are
                                                                                    running normally.</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:when>

                                                                <c:otherwise>
                                                                    <div class="glass-card p-5 text-center">
                                                                        <i
                                                                            class="fa-solid fa-circle-exclamation fa-4x text-muted mb-4"></i>
                                                                        <h3 class="text-white">View Not Found</h3>
                                                                        <p class="text-muted">The requested section is
                                                                            unavailable.</p>
                                                                        <a href="AdminPanelServlet?view=dashboard"
                                                                            class="btn btn-outline-warning mt-3">Back to
                                                                            Dashboard</a>
                                                                    </div>
                                                                </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Footer Modals -->
                    <div class="modal fade" id="addRoomModal" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content glass-card bg-dark text-white border border-secondary shadow-lg">
                                <div class="modal-header border-secondary">
                                    <h5 class="modal-title text-warning">Add New Resort Room</h5>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <form action="AdminCrudServlet" method="POST">
                                    <input type="hidden" name="action" value="addRoom">
                                    <div class="modal-body p-4">
                                        <div class="mb-3">
                                            <label class="form-label small text-muted">Room Number</label>
                                            <input type="text" name="roomNumber"
                                                class="form-control bg-dark text-white border-secondary" required
                                                placeholder="e.g. 101">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small text-muted">Room Type</label>
                                            <select name="roomTypeId"
                                                class="form-select bg-dark text-white border-secondary" required>
                                                <c:forEach var="rt" items="${roomTypes}">
                                                    <option value="${rt.id}">${rt.typeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-secondary">
                                        <button type="button" class="btn btn-outline-secondary"
                                            data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-neon px-4">Save Room</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="resetPasswordModal" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content glass-card bg-dark text-white border border-secondary shadow-lg">
                                <div class="modal-header border-secondary">
                                    <h5 class="modal-title text-warning">Reset Password</h5>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <form action="AdminCrudServlet" method="POST">
                                    <input type="hidden" name="action" value="resetStaffPassword">
                                    <input type="hidden" name="userId" id="resetUserId">
                                    <div class="modal-body p-4">
                                        <p class="small text-muted mb-3">User: <span id="resetUsername"
                                                class="text-white fw-bold"></span></p>
                                        <div class="mb-3">
                                            <label class="form-label small text-muted">New Password</label>
                                            <input type="password" name="newPassword"
                                                class="form-control bg-dark text-white border-secondary" required
                                                minlength="6">
                                        </div>
                                    </div>
                                    <div class="modal-footer border-secondary">
                                        <button type="button" class="btn btn-outline-secondary"
                                            data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-warning px-4">Reset Now</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            if (document.getElementById('dashboardChart')) {
                                const ctx = document.getElementById('dashboardChart').getContext('2d');
                                const months = [];
                                const revenue = [];
                                const bookings = [];
            <c:forEach var="m" items="${monthlyRevenue}">months.unshift('${m.month}'); revenue.unshift(${m.revenue});</c:forEach>
            <c:forEach var="b" items="${monthlyBookings}">bookings.unshift(${b.count});</c:forEach>
                                new Chart(ctx, {
                                    type: 'line',
                                    data: {
                                        labels: months,
                                        datasets: [
                                            { label: 'Revenue (LKR)', data: revenue, borderColor: '#ffc107', backgroundColor: 'rgba(255, 193, 7, 0.1)', fill: true, tension: 0.3, yAxisID: 'y' },
                                            { label: 'Bookings', data: bookings, borderColor: '#0dcaf0', backgroundColor: 'transparent', borderDash: [5, 5], tension: 0.3, yAxisID: 'y1' }
                                        ]
                                    },
                                    options: {
                                        responsive: true,
                                        plugins: { legend: { labels: { color: '#fff' } } },
                                        scales: {
                                            y: { type: 'linear', display: true, position: 'left', grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#aaa' } },
                                            y1: { type: 'linear', display: true, position: 'right', grid: { drawOnChartArea: false }, ticks: { color: '#aaa' } },
                                            x: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#aaa' } }
                                        }
                                    }
                                });
                            }
                        });

                        function deleteRoom(id) {
                            if (confirm('Permanently delete this room?')) {
                                window.location.href = 'AdminCrudServlet?action=deleteRoom&id=' + id;
                            }
                        }

                        function toggleStaff(id) {
                            if (confirm('Change staff account status?')) {
                                window.location.href = 'AdminCrudServlet?action=toggleStaffStatus&id=' + id;
                            }
                        }

                        function showResetModal(id, username) {
                            document.getElementById('resetUserId').value = id;
                            document.getElementById('resetUsername').innerText = username;
                            const modal = new bootstrap.Modal(document.getElementById('resetPasswordModal'));
                            modal.show();
                        }
                    </script>

                    <%@ include file="footer.jspf" %>