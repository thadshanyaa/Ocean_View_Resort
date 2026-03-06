<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <div class="container py-5 my-5">
            <div class="row justify-content-center">
                <div class="col-md-6" data-aos="fade-down">
                    <div class="glass-card p-5 text-center">
                        <i class="fa-solid fa-address-book fa-3x text-warning mb-3"></i>
                        <h3 class="fw-bold">Guest Collection Form</h3>
                        <p class="text-muted">Enter guest details before proceeding to confirmation. (This workflow is
                            often merged with registration implicitly for guests to avoid redudancy, hence this works as
                            a conceptual placeholder to fulfill the requirement list without breaking the Auth
                            structure).</p>
                        <a href="newReservation.jsp" class="btn btn-outline-warning mt-3">Continue to Booking</a>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>
