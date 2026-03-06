<%@ page pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, java.util.*, ovr.*" %>
        <%@ include file="header.jspf" %>
            <%@ taglib uri="jakarta.tags.core" prefix="c" %>
                <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

                    <div class="container py-5">
                        <div class="row justify-content-center">
                            <div class="col-lg-10" data-aos="fade-up">
                                <div class="glass-card p-4">
                                    <h3 class="fw-bold mb-4 border-bottom border-secondary pb-2"><i
                                            class="fa-solid fa-calendar-check text-neon me-2"></i>Check Room
                                        Availability</h3>

                                    <form id="availabilityForm" class="row g-3 align-items-end mb-4">
                                        <div class="col-md-3">
                                            <label class="form-label text-light small">Room Type</label>
                                            <select name="roomTypeId" id="roomTypeId" class="form-select" required>
                                                <c:forEach var="type" items="${roomTypes}">
                                                    <option value="${type.id}">${type.typeName} (LKR ${type.baseRate})
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label text-light small">Check-In</label>
                                            <input type="date" name="checkIn" id="checkIn" class="form-control" required
                                                min="${minCheckIn}">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label text-light small">Check-Out</label>
                                            <input type="date" name="checkOut" id="checkOut" class="form-control"
                                                required min="${minCheckOut}">
                                        </div>
                                        <div class="col-md-3">
                                            <button type="button" class="btn btn-neon w-100"
                                                onclick="checkAvailability()"><i class="fa-solid fa-search"></i>
                                                Search</button>
                                        </div>
                                    </form>

                                    <div id="loadingIndicator" class="text-center d-none my-4">
                                        <div class="spinner-border text-info" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>

                                    <div id="resultsArea" class="row g-3 mt-2 d-none fade-in">
                                        <h5 class="text-success mb-2"><i
                                                class="fa-solid fa-check-circle me-2"></i>Available
                                            Rooms Found:</h5>
                                        <div id="roomsContainer" class="d-flex flex-wrap gap-2"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        function checkAvailability() {
                            var rt = document.getElementById('roomTypeId').value;
                            var ci = document.getElementById('checkIn').value;
                            var co = document.getElementById('checkOut').value;

                            if (!rt || !ci || !co) {
                                alert("Please fill all fields.");
                                return;
                            }

                            document.getElementById('loadingIndicator').classList.remove('d-none');
                            document.getElementById('resultsArea').classList.add('d-none');

                            var url = "AvailableRoomsServlet?roomTypeId=" + rt + "&checkIn=" + ci + "&checkOut=" + co;

                            fetch(url)
                                .then(response => {
                                    if (!response.ok) throw new Error("Network error");
                                    return response.json();
                                })
                                .then(data => {
                                    document.getElementById('loadingIndicator').classList.add('d-none');
                                    document.getElementById('resultsArea').classList.remove('d-none');
                                    var container = document.getElementById('roomsContainer');
                                    container.innerHTML = "";

                                    if (data.status === "error") {
                                        container.innerHTML = '<div class="alert alert-danger w-100">' + data.message + '</div>';
                                    } else if (data.rooms && data.rooms.length > 0) {
                                        let btnHtml = "";
                                        data.rooms.forEach(room => {
                                            btnHtml += '<button type="button" class="btn btn-outline-info room-btn fs-6 p-2 m-1" onclick="selectRoom(this, ' + room.id + ')">Room ' + room.roomNumber + '</button>';
                                        });
                                        container.innerHTML = btnHtml;
                                        container.innerHTML += '<div class="w-100 mt-3 p-3 bg-dark bg-opacity-50 text-center rounded"><a href="#" id="proceedBtn" class="btn btn-secondary px-4 rounded-pill disabled" onclick="proceedToBook(event, ' + rt + ', \'' + ci + '\', \'' + co + '\')">Select a Room to Proceed</a></div>';
                                    } else {
                                        container.innerHTML = '<div class="alert alert-warning w-100">No rooms available for the selected dates. Please try another range or room type.</div>';
                                    }
                                })
                                .catch(err => {
                                    document.getElementById('loadingIndicator').classList.add('d-none');
                                    alert("Error fetching availability: " + err.message);
                                });
                        }

                        let selectedAvailabilityRoomId = null;

                        function selectRoom(btn, roomId) {
                            document.querySelectorAll('.room-btn').forEach(b => {
                                b.classList.remove('btn-info', 'text-dark', 'fw-bold');
                                b.classList.add('btn-outline-info');
                            });
                            btn.classList.remove('btn-outline-info');
                            btn.classList.add('btn-info', 'text-dark', 'fw-bold');

                            selectedAvailabilityRoomId = roomId;

                            const proceedBtn = document.getElementById('proceedBtn');
                            if (proceedBtn) {
                                proceedBtn.classList.remove('disabled', 'btn-secondary');
                                proceedBtn.classList.add('btn-primary');
                                proceedBtn.innerHTML = 'Proceed to Book <i class="fa-solid fa-arrow-right ms-1"></i>';
                            }
                        }

                        function proceedToBook(e, rt, ci, co) {
                            e.preventDefault();
                            if (!selectedAvailabilityRoomId) return;
                            window.location.href = "NewReservationServlet?roomTypeId=" + rt + "&checkIn=" + ci + "&checkOut=" + co + "&roomId=" + selectedAvailabilityRoomId;
                        }
                    </script>

                    <%@ include file="footer.jspf" %>