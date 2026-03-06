<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <style>
            .hero-section {
                background: linear-gradient(rgba(15, 23, 42, 0.6), rgba(15, 23, 42, 0.9)),
                    url('https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&q=80&w=2070') center/cover no-repeat;
                height: 80vh;
                display: flex;
                align-items: center;
                margin-top: -76px;
                /* Offset navbar */
            }
        </style>

        <div class="hero-section text-center">
            <div class="container animate__animated animate__zoomIn">
                <h1 class="display-3 fw-bold mb-4 text-white">Experience the Ocean's Harmony</h1>
                <p class="lead mb-5 mx-auto text-light" style="max-width: 800px;">
                    Book your dream stay at Ocean View Resort. Seamless reservations, luxury accommodations, and
                    unforgettable moments await you.
                </p>
                <div class="mt-4">
                    <a href="AvailabilityServlet"
                        class="btn btn-neon btn-lg px-5 py-3 fs-4 fw-bold shadow-lg animate__animated animate__pulse animate__infinite">
                        Login to check availability <i class="fa-solid fa-calendar-check ms-2"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="container my-5 py-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <h2 class="fw-bold">Why Choose Us</h2>
                <div class="mx-auto mt-2" style="width: 50px; height: 3px; background: var(--neon-accent);"></div>
            </div>

            <div class="row g-4">
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="glass-card p-4 text-center h-100">
                        <i class="fa-solid fa-bed fa-3x mb-3 text-info"></i>
                        <h4 class="fw-bold">Luxury Rooms</h4>
                        <p class="text-muted">Wake up to the sound of waves in our meticulously designed ocean-view
                            suites.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="glass-card p-4 text-center h-100">
                        <i class="fa-solid fa-shield-halved fa-3x mb-3 text-info"></i>
                        <h4 class="fw-bold">Secure Booking</h4>
                        <p class="text-muted">Our advanced OTP-secured platform ensures your data and reservations are
                            safe.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="glass-card p-4 text-center h-100">
                        <i class="fa-solid fa-concierge-bell fa-3x mb-3 text-info"></i>
                        <h4 class="fw-bold">24/7 Service</h4>
                        <p class="text-muted">Our dedicated staff is available round the clock to cater to your needs.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>