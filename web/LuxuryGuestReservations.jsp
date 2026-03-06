<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Stays | Ocean View Luxury</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <%@ include file="luxury-sidebar-guest.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-0 text-gold">My Luxury <span class="text-white">Portfolio</span>
                                </h1>
                                <p class="text-white-50">Manage your past experiences and upcoming escapes.</p>
                            </div>
                            <button class="lux-btn lux-btn-gold" data-bs-toggle="modal" data-bs-target="#bookingModal">
                                <i class="fa-solid fa-plus"></i> New Reservation
                                </a>
                        </header>

                        <c:if test="${param.msg == 'booked'}">
                            <div class="lux-card mb-5 border-success bg-success bg-opacity-10 py-3 px-4">
                                <i class="fa-solid fa-circle-check text-success me-2"></i>
                                <span class="text-success fw-bold">Success! Your reservation has been placed and is
                                    currently awaiting front-desk confirmation.</span>
                            </div>
                        </c:if>

                        <div class="lux-card">
                            <c:choose>
                                <c:when test="${not empty items}">
                                    <div class="table-responsive">
                                        <table class="table table-dark lux-table align-middle">
                                            <thead>
                                                <tr>
                                                    <th>Booking Ref</th>
                                                    <th>Resort Suite</th>
                                                    <th>Stay Dates</th>
                                                    <th>Guests</th>
                                                    <th>Total Value</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="res" items="${items}">
                                                    <tr>
                                                        <td class="fw-bold text-gold">${res.reservationNumber}</td>
                                                        <td>${res.roomType}</td>
                                                        <td>
                                                            <div class="small fw-bold">
                                                                <fmt:formatDate value="${res.checkIn}"
                                                                    pattern="dd MMM" /> -
                                                                <fmt:formatDate value="${res.checkOut}"
                                                                    pattern="dd MMM, yyyy" />
                                                            </div>
                                                        </td>
                                                        <td>${res.guests} Adults</td>
                                                        <td class="fw-bold">LKR
                                                            <fmt:formatNumber value="${res.totalAmount}"
                                                                pattern="#,##0.00" />
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="lux-badge ${res.status == 'Pending' ? 'lux-badge-pending' : 'lux-badge-success'}">
                                                                ${res.status}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <button class="lux-btn lux-btn-outline p-2 px-3"
                                                                title="View Details">
                                                                <i class="fa-solid fa-eye m-0"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-5">
                                        <div class="mb-4 opacity-25">
                                            <i class="fa-solid fa-map-location-dot fa-5x"></i>
                                        </div>
                                        <h4 class="fw-bold">No Records Found</h4>
                                        <p class="text-white-50 mb-4">Your travel history with Ocean View is currently
                                            empty. Change that today.</p>
                                        <button class="lux-btn lux-btn-gold px-5" data-bs-toggle="modal"
                                            data-bs-target="#bookingModal">Book Your First Suite</button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </main>

                    <!-- Booking Modal -->
                    <div class="modal fade" id="bookingModal" tabindex="-1">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content lux-card p-0 border-0 bg-navy shadow-lg"
                                style="background: #020617;">
                                <div class="modal-header border-white border-opacity-10 p-4">
                                    <h4 class="modal-title fw-bold text-gold"><i
                                            class="fa-solid fa-calendar-plus me-2"></i> Elite Reservation</h4>
                                    <button type="button" class="btn-close btn-close-white"
                                        data-bs-dismiss="modal"></button>
                                </div>
                                <form action="luxury-action-guest" method="POST" id="bookingForm">
                                    <input type="hidden" name="action" value="book-elite">
                                    <input type="hidden" name="total" id="hiddenTotal" value="0">
                                    <div class="modal-body p-4">
                                        <div class="row g-4">
                                            <div class="col-md-6">
                                                <label class="small text-white-50 text-uppercase mb-2 d-block">Full
                                                    Name</label>
                                                <input type="text" name="name"
                                                    class="form-control bg-dark text-white border-white border-opacity-10 p-3"
                                                    value="${user.username}" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="small text-white-50 text-uppercase mb-2 d-block">Email
                                                    Contact</label>
                                                <input type="email" name="email"
                                                    class="form-control bg-dark text-white border-white border-opacity-10 p-3"
                                                    value="${user.email}" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="small text-white-50 text-uppercase mb-2 d-block">Suite
                                                    Category</label>
                                                <select name="roomType" id="roomSelect"
                                                    class="form-select bg-dark text-white border-white border-opacity-10 p-3"
                                                    required>
                                                    <option value="" disabled selected>Choose experience...</option>
                                                    <option value="Standard Ocean View" data-price="25000">Standard
                                                        Ocean View (LKR 25k)</option>
                                                    <option value="Deluxe Beachside" data-price="45000">Deluxe Beachside
                                                        (LKR 45k)</option>
                                                    <option value="Executive Pool Villa" data-price="85000">Executive
                                                        Pool Villa (LKR 85k)</option>
                                                    <option value="Azure Penthouse" data-price="150000">Azure Penthouse
                                                        (LKR 150k)</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="small text-white-50 text-uppercase mb-2 d-block">Number of
                                                    Guests</label>
                                                <input type="number" name="guests"
                                                    class="form-control bg-dark text-white border-white border-opacity-10 p-3"
                                                    min="1" max="5" value="1">
                                            </div>
                                            <div class="col-md-6">
                                                <label
                                                    class="small text-white-50 text-uppercase mb-2 d-block">Check-In</label>
                                                <input type="date" name="checkIn" id="checkIn"
                                                    class="form-control bg-dark text-white border-white border-opacity-10 p-3"
                                                    required>
                                            </div>
                                            <div class="col-md-6">
                                                <label
                                                    class="small text-white-50 text-uppercase mb-2 d-block">Check-Out</label>
                                                <input type="date" name="checkOut" id="checkOut"
                                                    class="form-control bg-dark text-white border-white border-opacity-10 p-3"
                                                    required>
                                            </div>
                                            <div class="col-12">
                                                <div
                                                    class="p-3 rounded-3 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center">
                                                    <span class="fw-bold">Estimated Total</span>
                                                    <h3 class="fw-bold text-gold mb-0">LKR <span
                                                            id="displayTotal">0.00</span></h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-white border-opacity-10 p-4">
                                        <button type="submit" class="lux-btn lux-btn-gold w-100 py-3">Confirm Luxury
                                            Booking</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        const roomSelect = document.getElementById('roomSelect');
                        const checkIn = document.getElementById('checkIn');
                        const checkOut = document.getElementById('checkOut');
                        const displayTotal = document.getElementById('displayTotal');
                        const hiddenTotal = document.getElementById('hiddenTotal');

                        function updatePrice() {
                            if (roomSelect.value && checkIn.value && checkOut.value) {
                                const price = parseInt(roomSelect.options[roomSelect.selectedIndex].dataset.price);
                                const start = new Date(checkIn.value);
                                const end = new Date(checkOut.value);
                                const diff = (end - start) / (1000 * 60 * 60 * 24);

                                if (diff > 0) {
                                    const total = price * diff;
                                    displayTotal.textContent = total.toLocaleString();
                                    hiddenTotal.value = total;
                                }
                            }
                        }

                        [roomSelect, checkIn, checkOut].forEach(el => el.addEventListener('change', updatePrice));
                    </script>
            </body>

            </html>