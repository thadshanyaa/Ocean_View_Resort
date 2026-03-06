<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, ovr.*, java.util.*" %>
        <%@ taglib uri="jakarta.tags.core" prefix="c" %>
            <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <%@ include file="header.jspf" %>

                    <div class="container py-5">
                        <div class="row g-4">
                            <!-- Sidebar -->
                            <div class="col-md-4 col-lg-3" data-aos="fade-right">
                                <%@ include file="sidebar.jspf" %>
                            </div>

                            <!-- Main Content -->
                            <div class="col-md-8 col-lg-9" data-aos="fade-left">

                                <c:if test="${not empty dbError}">
                                    <div
                                        class="alert alert-danger bg-dark border-danger text-light mb-4 shadow animate__animated animate__shakeX">
                                        <i class="fa-solid fa-triangle-exclamation me-2"></i> ${dbError}
                                    </div>
                                </c:if>

                                <div class="glass-card p-4 mb-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h3 class="fw-bold mb-1">Welcome, ${sessionScope.user.username}!</h3>
                                            <p class="text-muted mb-0">Manage your bookings, explore rooms, and settle
                                                bills from your centralized dashboard.</p>
                                        </div>
                                        <div class="text-end d-none d-md-block">
                                            <span class="badge bg-info text-dark px-3 py-2 rounded-pill fw-bold">
                                                <i class="fa-solid fa-user-shield me-1"></i> ${sessionScope.user.role}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-4 mb-4">
                                    <!-- Stat Cards -->
                                    <div class="col-md-6 col-lg-4">
                                        <div
                                            class="glass-card p-3 text-center h-100 border-start border-4 border-info shadow-sm">
                                            <h6 class="text-muted text-uppercase small fw-bold mb-2">My Reservations
                                            </h6>
                                            <h2 class="fw-bold m-0 text-info">
                                                <i class="fa-solid fa-book-open me-2 opacity-50"></i>
                                                <c:out value="${empty stats.activeCount ? '0' : stats.activeCount}" />
                                            </h2>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-4">
                                        <div
                                            class="glass-card p-3 text-center h-100 border-start border-4 border-success shadow-sm">
                                            <h6 class="text-muted text-uppercase small fw-bold mb-2">Total Paid Revenue
                                            </h6>
                                            <h2 class="fw-bold m-0 text-success">
                                                <small class="fs-6">LKR</small>
                                                <fmt:formatNumber
                                                    value="${empty stats.totalPaid ? 0.0 : stats.totalPaid}"
                                                    type="number" minFractionDigits="0" />
                                            </h2>
                                        </div>
                                    </div>
                                </div>

                                <div class="glass-card p-4">
                                    <div
                                        class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                                        <h4 class="fw-bold m-0 border-info border-start ps-3">Recent Activities</h4>

                                        <!-- Search Bar -->
                                        <div class="search-container position-relative" style="max-width: 350px;">
                                            <span
                                                class="position-absolute top-50 start-0 translate-middle-y ps-3 text-muted">
                                                <i class="fa-solid fa-magnifying-glass"></i>
                                            </span>
                                            <input type="text" id="dashboardSearch"
                                                class="form-control bg-dark text-white border-secondary ps-5"
                                                placeholder="Search ID or Customer..." onkeyup="filterDashboardTable()">
                                        </div>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table table-dark table-hover text-light mb-0 align-middle"
                                            id="resTable" style="background: transparent;">
                                            <thead class="bg-dark bg-opacity-50">
                                                <tr class="text-info small text-uppercase">
                                                    <th>Res No</th>
                                                    <th>Guest</th>
                                                    <th>Stay Dates</th>
                                                    <th>Room Info</th>
                                                    <th>Services</th>
                                                    <th class="text-center">Total</th>
                                                    <th class="text-center">Status</th>
                                                    <th class="text-end">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="res" items="${reservations}">
                                                    <tr class="border-secondary border-opacity-25">
                                                        <td class="fw-bold text-white">
                                                            <c:out value="${res.resNo}" />
                                                        </td>
                                                        <td>
                                                            <div class="fw-bold">
                                                                <c:out value="${res.guestName}" />
                                                            </div>
                                                            <small class="text-muted"><i
                                                                    class="fa-solid fa-user-circle me-1"></i>Guest</small>
                                                        </td>
                                                        <td class="small">
                                                            <fmt:formatDate value="${res.checkIn}" pattern="dd MMM" /> -
                                                            <fmt:formatDate value="${res.checkOut}" pattern="dd MMM" />
                                                        </td>
                                                        <td class="small text-light-50">
                                                            <c:out value="${res.roomInfo}" />
                                                        </td>
                                                        <td class="small">
                                                            <span class="text-truncate d-inline-block"
                                                                style="max-width: 150px;" title="${res.services}">
                                                                <c:out value="${res.services}" />
                                                            </span>
                                                        </td>
                                                        <td class="text-center fw-bold text-info">
                                                            LKR
                                                            <fmt:formatNumber value="${res.total}" type="number"
                                                                minFractionDigits="2" />
                                                        </td>
                                                        <td class="text-center">
                                                            <c:choose>
                                                                <c:when test="${res.status == 'PAID'}">
                                                                    <span
                                                                        class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-50 px-3 py-2">
                                                                        <i class="fa-solid fa-circle-check me-1"></i>
                                                                        PAID
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-50 px-3 py-2">
                                                                        <i class="fa-solid fa-clock me-1"></i> PENDING
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-end">
                                                            <div class="btn-group btn-group-sm">
                                                                <a href="ReservationDetailsServlet?reservationNumber=${res.resNo}"
                                                                    class="btn btn-outline-info" title="View Details">
                                                                    <i class="fa-solid fa-eye"></i>
                                                                </a>
                                                                <c:if test="${res.status == 'PENDING'}">
                                                                    <a href="ReservationDetailsServlet?reservationNumber=${res.resNo}&view=summary"
                                                                        class="btn btn-outline-warning"
                                                                        title="Process Payment">
                                                                        <i class="fa-solid fa-credit-card"></i>
                                                                    </a>
                                                                </c:if>
                                                                <c:if test="${res.status == 'PAID'}">
                                                                    <a href="BillingInvoiceServlet?reservationId=${res.id}"
                                                                        class="btn btn-outline-success"
                                                                        title="Download Receipt">
                                                                        <i class="fa-solid fa-file-invoice"></i>
                                                                    </a>
                                                                </c:if>
                                                                <button class="btn btn-outline-danger"
                                                                    onclick="openDeleteModal('${res.resNo}', ${res.id})"
                                                                    title="Delete Reservation">
                                                                    <i class="fa-solid fa-trash"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty reservations}">
                                                    <tr>
                                                        <td colspan="8" class="text-center text-muted py-5">
                                                            <div class="opacity-50 mb-3">
                                                                <i class="fa-solid fa-calendar-xmark fa-3x"></i>
                                                            </div>
                                                            <h5 class="fw-bold">No recent reservations found</h5>
                                                            <p class="small">New bookings will appear here
                                                                automatically.</p>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Confirmation Modal -->
                    <style>
                        .dashboard-backdrop {
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100vw;
                            height: 100vh;
                            background: rgba(0, 0, 0, 0.7);
                            backdrop-filter: blur(5px);
                            -webkit-backdrop-filter: blur(5px);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            z-index: 1050;
                            opacity: 0;
                            pointer-events: none;
                            transition: opacity 0.3s ease;
                        }

                        .dashboard-backdrop.show {
                            opacity: 1;
                            pointer-events: auto;
                        }

                        .dashboard-modal {
                            background: rgba(15, 23, 42, 0.95);
                            border: 1px solid rgba(220, 53, 69, 0.3);
                            border-radius: 20px;
                            width: 90%;
                            max-width: 450px;
                            padding: 30px;
                            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
                            transform: scale(0.9);
                            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                            text-align: center;
                        }

                        .dashboard-backdrop.show .dashboard-modal {
                            transform: scale(1);
                        }

                        .dashboard-modal h4 {
                            color: #fff;
                            font-weight: 600;
                            margin-bottom: 10px;
                        }

                        .dashboard-modal p {
                            color: #94a3b8;
                            font-size: 0.95rem;
                            margin-bottom: 25px;
                        }

                        .modal-danger-icon {
                            width: 70px;
                            height: 70px;
                            background: rgba(220, 53, 69, 0.1);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin: 0 auto 20px auto;
                        }

                        .modal-danger-icon i {
                            font-size: 2rem;
                            color: #dc3545;
                        }

                        .modal-actions {
                            display: flex;
                            gap: 15px;
                            justify-content: center;
                        }

                        .btn-modal-delete {
                            background: #dc3545;
                            color: #fff;
                            border: none;
                            padding: 10px 20px;
                            border-radius: 10px;
                            font-weight: 600;
                            transition: all 0.2s;
                        }

                        .btn-modal-delete:hover {
                            background: #bb2d3b;
                        }

                        .btn-modal-cancel {
                            background: transparent;
                            color: #94a3b8;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                            padding: 10px 20px;
                            border-radius: 10px;
                            font-weight: 600;
                            transition: all 0.2s;
                        }

                        .btn-modal-cancel:hover {
                            background: rgba(255, 255, 255, 0.05);
                            color: #fff;
                        }
                    </style>

                    <div class="dashboard-backdrop" id="deleteModal">
                        <div class="dashboard-modal">
                            <div class="modal-danger-icon">
                                <i class="fa-solid fa-triangle-exclamation"></i>
                            </div>
                            <h4>Confirm Deletion?</h4>
                            <p>Are you sure you want to delete reservation <strong id="deleteResNoDisplay"></strong>?
                                This action cannot be undone and will erase all connected bills and payments.</p>

                            <form id="deleteForm" action="DeleteReservationServlet" method="POST">
                                <input type="hidden" name="reservationId" id="deleteResIdInput" value="">
                                <div class="modal-actions">
                                    <button type="button" class="btn-modal-cancel"
                                        onclick="closeDeleteModal()">Cancel</button>
                                    <button type="submit" class="btn-modal-delete" id="btnConfirmDelete">
                                        <i class="fa-solid fa-trash me-1"></i> Confirm Delete
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        function filterDashboardTable() {
                            const input = document.getElementById("dashboardSearch");
                            const filter = input.value.toUpperCase();
                            const table = document.getElementById("resTable");
                            const tr = table.getElementsByTagName("tr");

                            for (let i = 1; i < tr.length; i++) {
                                let found = false;
                                const tdNo = tr[i].getElementsByTagName("td")[0];
                                const tdGuest = tr[i].getElementsByTagName("td")[1];

                                if (tdNo || tdGuest) {
                                    const textNo = tdNo.textContent || tdNo.innerText;
                                    const textGuest = tdGuest.textContent || tdGuest.innerText;
                                    if (textNo.toUpperCase().indexOf(filter) > -1 || textGuest.toUpperCase().indexOf(filter) > -1) {
                                        found = true;
                                    }
                                }
                                tr[i].style.display = found ? "" : "none";
                            }
                        }

                        function openDeleteModal(resNo, resId) {
                            document.getElementById('deleteResNoDisplay').textContent = resNo;
                            document.getElementById('deleteResIdInput').value = resId;
                            document.getElementById('deleteModal').classList.add('show');
                        }

                        function closeDeleteModal() {
                            document.getElementById('deleteModal').classList.remove('show');
                        }

                        // Also show a toast if msg=deleted is in URL
                        window.onload = function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            if (urlParams.get('msg') === 'deleted') {
                                // Simple fallback alert if toasts aren't fully configured
                                alert("Reservation successfully deleted.");
                            }
                        }
                    </script>

                    <%@ include file="footer.jspf" %>