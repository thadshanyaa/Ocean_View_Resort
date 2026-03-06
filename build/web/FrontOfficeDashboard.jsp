<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Front Office Command | Ocean View Resort</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --ocean-deep: #020c1b;
                        --ocean-surface: #0a192f;
                        --ocean-accent: #64ffda;
                        --ocean-glow: rgba(100, 255, 218, 0.1);
                        --glass-bg: rgba(16, 32, 60, 0.7);
                        --glass-border: rgba(100, 255, 218, 0.1);
                    }

                    body {
                        background-color: var(--ocean-deep);
                        color: #ccd6f6;
                        font-family: 'Inter', system-ui, -apple-system, sans-serif;
                        min-height: 100vh;
                        overflow-x: hidden;
                    }

                    .lux-bg-glow {
                        position: fixed;
                        width: 800px;
                        height: 800px;
                        border-radius: 50%;
                        z-index: -1;
                        filter: blur(100px);
                        pointer-events: none;
                    }

                    .lux-main {
                        padding: 40px 60px;
                        margin-left: 280px;
                        /* Sidebar offset */
                        transition: all 0.3s;
                    }

                    .lux-card {
                        background: var(--glass-bg);
                        backdrop-filter: blur(15px);
                        -webkit-backdrop-filter: blur(15px);
                        border: 1px solid var(--glass-border);
                        border-radius: 24px;
                        padding: 25px;
                        height: 100%;
                        transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
                    }

                    .lux-card:hover {
                        transform: translateY(-5px);
                        border-color: var(--ocean-accent);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
                    }

                    .stat-icon {
                        width: 50px;
                        height: 50px;
                        background: rgba(100, 255, 218, 0.1);
                        color: var(--ocean-accent);
                        border-radius: 15px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                    }

                    .search-box {
                        background: rgba(0, 0, 0, 0.2);
                        border: 1px solid var(--glass-border);
                        border-radius: 15px;
                        padding: 10px 20px;
                        color: #fff;
                        width: 350px;
                        transition: all 0.3s;
                    }

                    .search-box:focus {
                        outline: none;
                        border-color: var(--ocean-accent);
                        box-shadow: 0 0 15px var(--ocean-glow);
                    }

                    .lux-table {
                        background: transparent !important;
                        border-collapse: separate;
                        border-spacing: 0 12px;
                    }

                    .lux-table thead th {
                        border: none;
                        color: #8892b0;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 0.75rem;
                        letter-spacing: 1px;
                        padding: 0 20px;
                    }

                    .lux-table tbody tr {
                        background: rgba(255, 255, 255, 0.03);
                        transition: all 0.2s;
                    }

                    .lux-table tbody tr:hover {
                        background: rgba(100, 255, 218, 0.05);
                        transform: scale(1.01);
                    }

                    .lux-table td {
                        border: none;
                        padding: 18px 20px;
                        vertical-align: middle;
                    }

                    .lux-table td:first-child {
                        border-radius: 15px 0 0 15px;
                    }

                    .lux-table td:last-child {
                        border-radius: 0 15px 15px 0;
                    }

                    .lux-badge {
                        padding: 6px 14px;
                        border-radius: 50px;
                        font-size: 0.75rem;
                        font-weight: 700;
                        letter-spacing: 0.5px;
                    }

                    .badge-paid {
                        background: rgba(16, 185, 129, 0.15);
                        color: #10b981;
                        border: 1px solid rgba(16, 185, 129, 0.3);
                    }

                    .badge-pending {
                        background: rgba(245, 158, 11, 0.15);
                        color: #f59e0b;
                        border: 1px solid rgba(245, 158, 11, 0.3);
                    }

                    .btn-action {
                        width: 35px;
                        height: 35px;
                        border-radius: 10px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: #8892b0;
                        transition: all 0.2s;
                        text-decoration: none;
                    }

                    .btn-action:hover {
                        background: var(--ocean-accent);
                        color: var(--ocean-deep);
                        border-color: var(--ocean-accent);
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px;
                        opacity: 0.5;
                    }
                </style>
            </head>

            <body>
                <div class="lux-bg-glow"
                    style="top: -200px; right: -200px; background: radial-gradient(circle, rgba(100, 255, 218, 0.08) 0%, transparent 70%);">
                </div>

                <%@ include file="luxury-sidebar-staff.jspf" %>

                    <main class="lux-main">
                        <header
                            class="d-flex justify-content-between align-items-center mb-5 animate__animated animate__fadeIn">
                            <div>
                                <h1 class="fw-bold mb-1" style="color: #e6f1ff;">Front Office <span
                                        style="color: var(--ocean-accent);">Command</span></h1>
                                <p class="text-white-50">Real-time operational overview • <span
                                        id="liveTime">00:00:00</span></p>
                            </div>
                            <form action="front-office-portal" method="GET" class="d-flex gap-3">
                                <input type="hidden" name="view" value="dashboard">
                                <input type="text" name="search" class="search-box"
                                    placeholder="Search by Res # or Guest Name..." value="${param.search}">
                                <button type="submit" class="btn btn-outline-info rounded-3 px-4"><i
                                        class="fa-solid fa-search"></i></button>
                            </form>
                        </header>

                        <!-- Dynamic Stat Cards -->
                        <div class="row g-4 mb-5">
                            <div class="col-md-3">
                                <div class="lux-card">
                                    <div class="d-flex justify-content-between mb-3">
                                        <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
                                        <span class="text-success small">+12%</span>
                                    </div>
                                    <h2 class="fw-bold text-white mb-1">${stats.activeCount != null ? stats.activeCount
                                        : 0}</h2>
                                    <div class="small text-white-50 text-uppercase letter-spacing-1">Active Bookings
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card">
                                    <div class="d-flex justify-content-between mb-3">
                                        <div class="stat-icon"
                                            style="color: #60a5fa; background: rgba(96, 165, 250, 0.1);"><i
                                                class="fa-solid fa-sack-dollar"></i></div>
                                        <span class="text-white-50 small">LKR</span>
                                    </div>
                                    <h2 class="fw-bold text-white mb-1">
                                        <fmt:formatNumber value="${stats.totalPaid}" type="number" />
                                    </h2>
                                    <div class="small text-white-50 text-uppercase letter-spacing-1">Total Revenue</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card">
                                    <div class="d-flex justify-content-between mb-3">
                                        <div class="stat-icon"
                                            style="color: #f59e0b; background: rgba(245, 158, 11, 0.1);"><i
                                                class="fa-solid fa-clock-rotate-left"></i></div>
                                    </div>
                                    <h2 class="fw-bold text-white mb-1">${stats.pendingPayments}</h2>
                                    <div class="small text-white-50 text-uppercase letter-spacing-1">Pending Payments
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="lux-card">
                                    <div class="d-flex justify-content-between mb-3">
                                        <div class="stat-icon"
                                            style="color: #ec4899; background: rgba(236, 72, 153, 0.1);"><i
                                                class="fa-solid fa-user-check"></i></div>
                                    </div>
                                    <h2 class="fw-bold text-white mb-1">${stats.todayArrivals}</h2>
                                    <div class="small text-white-50 text-uppercase letter-spacing-1">Today's Arrivals
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Reservations Table -->
                        <div class="lux-card">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="fw-bold text-white m-0"><i class="fa-solid fa-list-ul me-2 text-info"></i>
                                    Recent Operations</h5>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-ghost text-white-50 border-0"
                                        data-bs-toggle="dropdown">
                                        <i class="fa-solid fa-ellipsis-v"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-dark">
                                        <li><a class="dropdown-item" href="front-office-portal?view=reservations">View
                                                All</a></li>
                                        <li><a class="dropdown-item" href="newReservation.jsp">New Booking</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table lux-table">
                                    <thead>
                                        <tr>
                                            <th>Guest Details</th>
                                            <th>Stay Period</th>
                                            <th>Room Info</th>
                                            <th>Total Amount</th>
                                            <th>Payment</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="res" items="${recentReservations}">
                                            <tr>
                                                <td>
                                                    <div class="fw-bold text-white">${res.guestName}</div>
                                                    <div class="small text-white-50">REF: ${res.resNo}</div>
                                                </td>
                                                <td>
                                                    <div class="small text-white fw-semibold">
                                                        <fmt:formatDate value="${res.checkIn}" pattern="dd MMM" /> -
                                                        <fmt:formatDate value="${res.checkOut}" pattern="dd MMM" />
                                                    </div>
                                                    <div class="text-white-50 x-small">${res.services}</div>
                                                </td>
                                                <td>
                                                    <div class="small text-white">${res.roomInfo}</div>
                                                </td>
                                                <td>
                                                    <div class="fw-bold" style="color: var(--ocean-accent);">LKR
                                                        <fmt:formatNumber value="${res.total}" type="number" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <span
                                                        class="lux-badge ${res.status == 'PAID' ? 'badge-paid' : 'badge-pending'}">
                                                        ${res.status}
                                                    </span>
                                                </td>
                                                <td class="text-end">
                                                    <div class="d-flex justify-content-end gap-2">
                                                        <a href="ReservationDetailsServlet?reservationNumber=${res.resNo}"
                                                            class="btn-action" title="Full Itinerary">
                                                            <i class="fa-solid fa-eye"></i>
                                                        </a>
                                                        <c:if test="${res.status != 'PAID'}">
                                                            <a href="ReservationDetailsServlet?reservationNumber=${res.resNo}#payment"
                                                                class="btn-action" title="Process Payment"
                                                                style="color: #f59e0b;">
                                                                <i class="fa-solid fa-credit-card"></i>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${res.status == 'PAID'}">
                                                            <a href="BillingInvoiceServlet?resNo=${res.resNo}"
                                                                class="btn-action" title="Download Receipt"
                                                                style="color: #10b981;">
                                                                <i class="fa-solid fa-file-invoice"></i>
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty recentReservations}">
                                            <tr>
                                                <td colspan="6">
                                                    <div class="empty-state">
                                                        <i class="fa-solid fa-folder-open fa-3x mb-3 text-white-50"></i>
                                                        <p>No reservations found in the system matching your criteria.
                                                        </p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        function updateTime() {
                            const now = new Date();
                            document.getElementById('liveTime').innerText = now.toLocaleTimeString();
                        }
                        setInterval(updateTime, 1000);
                        updateTime();
                    </script>
            </body>

            </html>