<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Reception - Elite Check-In Control</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/elite-theme.css">
            </head>

            <body class="elite-theme">

                <%@ include file="elite-sidebar-staff.jspf" %>

                    <main class="elite-content">
                        <header class="mb-5 d-flex justify-content-between align-items-end">
                            <div>
                                <h2 class="fw-bold mb-1">Elite <span class="text-gold">Front Desk</span></h2>
                                <p class="text-white-50">Managing incoming arrivals and on-site guest logistics.</p>
                            </div>
                            <div class="text-end">
                                <div class="h4 fw-bold m-0" id="liveClock">00:00:00</div>
                                <div class="small text-white-50">Local Station Time</div>
                            </div>
                        </header>

                        <div class="elite-card">
                            <h5 class="fw-bold mb-4">Upcoming Elite Arrivals</h5>
                            <div class="table-responsive">
                                <table class="table table-dark elite-table">
                                    <thead>
                                        <tr class="text-white-50 small">
                                            <th>Guest Name</th>
                                            <th>Suite Assigned</th>
                                            <th>Check-In Window</th>
                                            <th>Special Requests</th>
                                            <th>Confirm</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="res" items="${reservations}">
                                            <tr>
                                                <td class="fw-bold text-gold">${res.guestName}</td>
                                                <td>${res.roomType}</td>
                                                <td>
                                                    <div class="fw-bold text-success">
                                                        <fmt:formatDate value="${res.checkInDate}"
                                                            pattern="EEEE, MMM dd" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="small text-white-50"
                                                        style="max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"
                                                        title="${res.specialRequests}">
                                                        ${empty res.specialRequests ? 'None' : res.specialRequests}
                                                    </div>
                                                </td>
                                                <td>
                                                    <button class="btn btn-success btn-sm rounded-pill px-3">
                                                        <i class="fa-solid fa-door-open me-1"></i> Check-In
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        function updateClock() {
                            const now = new Date();
                            document.getElementById('liveClock').textContent = now.toLocaleTimeString();
                        }
                        setInterval(updateClock, 1000);
                        updateClock();
                    </script>
            </body>

            </html>