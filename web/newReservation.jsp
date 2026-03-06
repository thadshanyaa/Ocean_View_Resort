<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, java.util.*, ovr.*" %>
        <%@ include file="header.jspf" %>
            <%@ taglib uri="jakarta.tags.core" prefix="c" %>
                <style>
                    .services-disabled {
                        opacity: 0.55;
                    }

                    .custom-service-card:hover {
                        background-color: rgba(255, 255, 255, 0.05) !important;
                    }
                </style>

                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-md-8" data-aos="fade-up">
                            <div class="glass-card p-5">
                                <h3 class="fw-bold mb-4 border-bottom border-secondary pb-2 text-center">New Reservation
                                </h3>

                                <c:if test="${not empty param.error}">
                                    <div class="alert alert-danger shadow-sm"><i
                                            class="fa-solid fa-triangle-exclamation me-2"></i>${param.error}</div>
                                </c:if>

                                <form action="ReservationServlet" method="POST">
                                    <input type="hidden" name="action" value="book">
                                    <input type="hidden" name="userId" value="${sessionScope.user.id}">
                                    <input type="hidden" name="savedGuestId" id="savedGuestId" value="">

                                    <!-- Guest Details Block -->
                                    <c:choose>
                                        <c:when test="${sessionScope.user.role == 'Guest'}">
                                            <!-- Guests don't need to re-type their own details, grabbed from DB via userId -->
                                        </c:when>
                                        <c:otherwise>
                                            <div id="guestInputSection"
                                                class="row g-3 mb-4 p-3 border border-secondary rounded bg-dark bg-opacity-50 transition-all">
                                                <h6 class="text-info fw-bold mb-2"><i
                                                        class="fa-solid fa-user-pen me-2"></i>Walk-In Guest Details</h6>
                                                <div class="col-md-6 mb-2">
                                                    <label class="form-label text-light small">Full Name</label>
                                                    <input type="text" id="guestName" name="guestName"
                                                        class="form-control form-control-sm bg-dark text-light border-secondary"
                                                        placeholder="Enter guest name" required>
                                                </div>
                                                <div class="col-md-6 mb-2">
                                                    <label class="form-label text-light small">Contact Phone</label>
                                                    <input type="text" id="guestPhone" name="guestPhone"
                                                        class="form-control form-control-sm bg-dark text-light border-secondary"
                                                        placeholder="Enter phone number" required>
                                                </div>
                                                <div class="col-12 mb-2">
                                                    <label class="form-label text-light small">Address / Notes
                                                        (Optional)</label>
                                                    <input type="text" id="guestAddress" name="guestAddress"
                                                        class="form-control form-control-sm bg-dark text-light border-secondary"
                                                        placeholder="Enter address or email">
                                                </div>
                                                <div class="col-12 mt-3 text-end">
                                                    <button type="button" id="btnSaveGuest"
                                                        class="btn btn-sm btn-info px-4 fw-bold" onclick="saveGuest()">
                                                        <i class="fa-solid fa-floppy-disk me-1"></i> Save Guest
                                                    </button>
                                                </div>
                                            </div>

                                            <div id="guestSummarySection"
                                                class="row mb-4 p-3 border border-success rounded bg-dark bg-opacity-75 d-none transition-all">
                                                <div class="col-12 d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <h6 class="text-success fw-bold mb-1"><i
                                                                class="fa-solid fa-circle-check me-2"></i>Guest Saved
                                                            Successfully</h6>
                                                        <span class="text-light small" id="guestSummaryText">Name |
                                                            Phone</span>
                                                    </div>
                                                    <button type="button" class="btn btn-sm btn-outline-light"
                                                        onclick="editGuest()">
                                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                                    </button>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="row g-3">
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label text-light">Room Type</label>
                                            <select name="roomTypeId" id="roomTypeId" class="form-select" required
                                                onchange="fetchRooms()">
                                                <option value="">-- Select --</option>
                                                <c:forEach var="type" items="${roomTypes}">
                                                    <option value="${type.id}" ${param.roomTypeId==type.id ? 'selected'
                                                        : '' }>${type.typeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label text-light">Check-In</label>
                                            <input type="date" name="checkIn" id="checkIn" class="form-control" required
                                                value="${not empty param.checkIn ? param.checkIn : ''}"
                                                onchange="fetchRooms()">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label text-light">Check-Out</label>
                                            <input type="date" name="checkOut" id="checkOut" class="form-control"
                                                required value="${not empty param.checkOut ? param.checkOut : ''}"
                                                onchange="fetchRooms()">
                                        </div>
                                        <div class="col-12 mb-4">
                                            <label class="form-label text-light">Select Room</label>
                                            <select name="roomId" id="roomId" class="form-select" required>
                                                <option value="">-- Select Dates & Type --</option>
                                            </select>
                                            <div class="form-text text-muted" id="roomHelper"><i
                                                    class="fa-solid fa-circle-info mt-1"></i> Make sure to check
                                                availability first. Overlaps will be blocked by system.</div>
                                        </div>
                                    </div>



                                    <div class="text-center mt-4">
                                        <div id="confirmBtnWrapper"
                                            style="display: inline-block; transition: all 0.3s;">
                                            <button type="submit" id="btnConfirmBooking"
                                                class="btn btn-neon px-5 py-2 fs-5" ${sessionScope.user.role !='Guest'
                                                ? 'disabled' : '' }>
                                                Confirm Booking <i class="fa-solid fa-bed ms-1"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    function fetchRooms() {
                        const typeId = document.getElementById('roomTypeId').value;
                        const ci = document.getElementById('checkIn').value;
                        const co = document.getElementById('checkOut').value;
                        const roomSelect = document.getElementById('roomId');
                        const helper = document.getElementById('roomHelper');
                        const btn = document.querySelector('button[type="submit"]');

                        roomSelect.innerHTML = '<option value="">-- Loading... --</option>';
                        btn.disabled = true;

                        if (!typeId || !ci || !co) {
                            roomSelect.innerHTML = '<option value="">-- Select Dates & Type --</option>';
                            return;
                        }

                        fetch('AvailableRoomsServlet?roomTypeId=' + encodeURIComponent(typeId) + '&checkIn=' +
                            encodeURIComponent(ci) + '&checkOut=' + encodeURIComponent(co))
                            .then(response => {
                                if (!response.ok) throw new Error("Network response was not ok");
                                return response.json();
                            })
                            .then(data => {
                                roomSelect.innerHTML = '';
                                if (data.status === "error") {
                                    roomSelect.innerHTML = '<option value="">-- Cannot load rooms --</option>';
                                    helper.innerHTML = '<span class="text-danger"><i class="fa-solid fa-triangle-exclamation mt-1"></i> ' +
                                        data.message + '</span>';
                                } else if (!data.rooms || data.rooms.length === 0) {
                                    roomSelect.innerHTML = '<option value="">-- No available rooms --</option>';
                                    helper.innerHTML = '<span class="text-danger"><i class="fa-solid fa-triangle-exclamation mt-1"></i> No rooms available for selected dates</span>';
                                } else {
                                    const urlParams = new URLSearchParams(window.location.search);
                                    const targetRoomId = urlParams.get('roomId');

                                    data.rooms.forEach(room => {
                                        const opt = document.createElement('option');
                                        opt.value = room.id;
                                        opt.textContent = 'Room ' + room.roomNumber;
                                        if (targetRoomId && targetRoomId == room.id) {
                                            opt.selected = true;
                                        }
                                        roomSelect.appendChild(opt);
                                    });
                                    helper.innerHTML = '<span class="text-success"><i class="fa-solid fa-check mt-1"></i> ' +
                                        data.rooms.length + ' room(s) available.</span>';

                                    // Trigger state update
                                    updateBookingButtonState();
                                }
                            })
                            .catch(err => {
                                console.error('Error fetching rooms:', err);
                                roomSelect.innerHTML = '<option value="">-- Cannot load rooms --</option>';
                                helper.innerHTML = '<span class="text-danger"><i class="fa-solid fa-triangle-exclamation mt-1"></i> Cannot load rooms (Server Error)</span>';
                            })
                            .finally(() => {
                                // Ensure button state is updated even on error
                                updateBookingButtonState();
                            });
                    }

                    // New helper to manage button state
                    function updateBookingButtonState() {
                        const confirmBtn = document.getElementById('btnConfirmBooking');
                        const roomId = document.getElementById('roomId').value;
                        const userRole = '${sessionScope.user.role}';

                        if (userRole === 'Guest') {
                            // Guests just need a room selected
                            confirmBtn.disabled = (roomId === '');
                        } else {
                            // Staff need a room selected AND a saved guest
                            const savedGuestId = document.getElementById('savedGuestId').value;
                            confirmBtn.disabled = (roomId === '' || savedGuestId === '');
                        }
                    }

                    // Add listener for room selection change
                    document.getElementById('roomId').addEventListener('change', updateBookingButtonState);

                    document.addEventListener('DOMContentLoaded', () => {
                        const typeId = document.getElementById('roomTypeId').value;
                        if (typeId) {
                            fetchRooms();
                        }
                        // Initial button state update on page load
                        updateBookingButtonState();
                    });

                    function saveGuest() {
                        const name = document.getElementById('guestName').value;
                        const phone = document.getElementById('guestPhone').value;
                        const address = document.getElementById('guestAddress').value;
                        const btn = document.getElementById('btnSaveGuest');
                        const confirmBtn = document.getElementById('btnConfirmBooking');

                        if (!name || !phone) {
                            alert('Full Name and Phone are required to Save Guest');
                            return;
                        }

                        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin me-1"></i> Saving...';
                        btn.disabled = true;

                        const params = new URLSearchParams();
                        params.append('guestName', name);
                        params.append('guestPhone', phone);
                        params.append('guestAddress', address);

                        fetch('api/guests/save', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: params.toString()
                        })
                            .then(res => res.json())
                            .then(data => {
                                if (data.status === 'success') {
                                    document.getElementById('savedGuestId').value = data.guestId;
                                    document.getElementById('guestSummaryText').textContent = name + ' | ' + phone;

                                    document.getElementById('guestInputSection').classList.add('d-none');
                                    document.getElementById('guestSummarySection').classList.remove('d-none');

                                    // Update state
                                    updateBookingButtonState();
                                } else {
                                    alert('Error: ' + data.message);
                                }
                            })
                            .catch(err => {
                                console.error('Save Guest Error:', err);
                                alert('Network error while saving Guest');
                            })
                            .finally(() => {
                                btn.innerHTML = '<i class="fa-solid fa-floppy-disk me-1"></i> Save Guest';
                                btn.disabled = false;
                            });
                    }

                    function editGuest() {
                        document.getElementById('guestSummarySection').classList.add('d-none');
                        document.getElementById('guestInputSection').classList.remove('d-none');
                        document.getElementById('savedGuestId').value = ''; // Reset saved guest ID
                        updateBookingButtonState();
                    }
                </script>

                <%@ include file="footer.jspf" %>