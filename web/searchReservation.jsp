<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <div class="container py-5 my-5">
            <div class="row justify-content-center">
                <div class="col-md-6" data-aos="zoom-in">
                    <div class="glass-card p-5 text-center">
                        <i class="fa-solid fa-magnifying-glass-location fa-4x mb-4 text-info"
                            style="filter: drop-shadow(0 0 10px rgba(14, 165, 233, 0.5));"></i>
                        <h3 class="fw-bold mb-1">Find Reservation</h3>
                        <p class="text-muted mb-4 pb-2">Enter your reservation number (e.g. OVR-20260228-1234) to view
                            your booking details.</p>

                        <form action="ReservationServlet" method="GET">
                            <input type="hidden" name="action" value="search">
                            <div class="mb-4">
                                <input type="text" name="reservationNumber"
                                    class="form-control form-control-lg text-center" required
                                    placeholder="OVR-YYYYMMDD-XXXX">
                            </div>
                            <button type="submit" class="btn btn-neon w-100">Find Booking</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>
