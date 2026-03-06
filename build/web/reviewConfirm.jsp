<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <div class="container py-5 my-5">
            <div class="row justify-content-center">
                <div class="col-md-6" data-aos="zoom-in">
                    <div class="glass-card p-5 text-center">
                        <i class="fa-regular fa-calendar-check fa-4x text-success mb-3"></i>
                        <h3 class="fw-bold">Review and Confirm</h3>
                        <p class="text-muted mb-4">You are about to finalize your booking reservation. Please ensure all
                            details are correct.</p>
                        <div class="alert alert-secondary bg-transparent border-secondary text-light">
                            This step acts as an interception point for users to review their inputs. The actual
                            finalization pushes data through BookingFacade.
                        </div>
                        <button class="btn btn-neon px-5 fw-bold mt-3" onclick="window.history.back()">Go Back</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>
