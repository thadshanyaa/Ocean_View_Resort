<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book a Room | Elite Portal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/elite-theme.css">
    </head>

    <body class="elite-theme">

        <%@ include file="elite-sidebar-guest.jspf" %>

            <main class="elite-content">
                <header class="mb-5">
                    <h2 class="fw-bold mb-1">Make a <span class="text-gold">Reservation</span></h2>
                    <p class="text-white-50">Select your preferred dates and luxury accommodations.</p>
                </header>

                <div class="row justify-content-center">
                    <div class="col-xl-9">
                        <div class="elite-card">
                            <form action="elite-save-reservation" method="POST" id="bookingForm" class="row g-4">
                                <input type="hidden" name="action" value="book">
                                <input type="hidden" name="total" id="totalAmountHidden" value="0">

                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Full Name</label>
                                    <input type="text" name="name"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        value="${user.username}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Email
                                        Address</label>
                                    <input type="email" name="email"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        value="${user.email}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Contact
                                        Phone</label>
                                    <input type="tel" name="phone"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3"
                                        placeholder="+94 77 XXX XXXX" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Room
                                        Category</label>
                                    <select name="roomType" id="roomTypeSelect"
                                        class="form-select bg-dark text-white border-secondary p-3 rounded-3" required>
                                        <option value="" disabled selected>Select a suite...</option>
                                        <option value="Standard Ocean View" data-price="25000">Standard Ocean View (LKR
                                            25k/night)</option>
                                        <option value="Deluxe Beachside" data-price="45000">Deluxe Beachside (LKR
                                            45k/night)</option>
                                        <option value="Executive Pool Villa" data-price="85000">Executive Pool Villa
                                            (LKR 85k/night)</option>
                                        <option value="Presidential Penthouse" data-price="150000">Presidential
                                            Penthouse (LKR 150k/night)</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Check-In
                                        Date</label>
                                    <input type="date" name="checkIn" id="checkIn"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Check-Out
                                        Date</label>
                                    <input type="date" name="checkOut" id="checkOut"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Number of
                                        Guests</label>
                                    <input type="number" name="guests"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3" min="1"
                                        max="5" value="1" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label small text-gold fw-bold text-uppercase">Special
                                        Requests</label>
                                    <textarea name="requests"
                                        class="form-control bg-dark text-white border-secondary p-3 rounded-3" rows="3"
                                        placeholder="Airport transfer, dietary needs, honeymoon decoration..."></textarea>
                                </div>

                                <div class="col-12 mt-5">
                                    <div
                                        class="p-4 rounded-4 bg-white bg-opacity-5 border border-white border-opacity-10 d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="fw-bold mb-1">Estimated Total Amount</h5>
                                            <p class="text-white-50 small mb-0">Taxes and service charges included.</p>
                                        </div>
                                        <h3 class="fw-bold text-gold mb-0">LKR <span id="totalDisplay">0.00</span></h3>
                                    </div>
                                </div>

                                <div class="col-12 text-end">
                                    <button type="submit" class="btn elite-btn-primary px-5 py-3 fs-5">Confirm Luxury
                                        Stay</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                const roomType = document.getElementById('roomTypeSelect');
                const checkIn = document.getElementById('checkIn');
                const checkOut = document.getElementById('checkOut');
                const totalDisplay = document.getElementById('totalDisplay');
                const totalHidden = document.getElementById('totalAmountHidden');

                function calculate() {
                    if (roomType.value && checkIn.value && checkOut.value) {
                        const start = new Date(checkIn.value);
                        const end = new Date(checkOut.value);
                        const diff = (end - start) / (1000 * 60 * 60 * 24);

                        if (diff > 0) {
                            const pricePerNight = parseInt(roomType.options[roomType.selectedIndex].dataset.price);
                            const total = diff * pricePerNight;
                            totalDisplay.textContent = total.toLocaleString('en-LK', { minimumFractionDigits: 2 });
                            totalHidden.value = total;
                        } else {
                            totalDisplay.textContent = '0.00';
                            totalHidden.value = 0;
                        }
                    }
                }

                [roomType, checkIn, checkOut].forEach(el => el.addEventListener('change', calculate));
            </script>
    </body>

    </html>