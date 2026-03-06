<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <div class="container py-5">
            <div class="row justify-content-center text-center mb-5" data-aos="fade-down">
                <div class="col-lg-8">
                    <h1 class="display-4 fw-bold text-neon mb-3">About OceanView Resort</h1>
                    <p class="lead text-muted">A sanctuary of luxury where the horizon meets your dreams. Discover the
                        story behind our paradise.</p>
                    <div class="mx-auto mt-2" style="width: 80px; height: 4px; background: var(--neon-accent);"></div>
                </div>
            </div>

            <div class="row align-items-center mb-5 pb-5">
                <div class="col-md-6" data-aos="fade-right">
                    <img src="${pageContext.request.contextPath}/assets/images/lobby.png"
                        class="img-fluid rounded-4 shadow-lg border border-secondary"
                        style="object-fit: cover; width: 100%; height: auto;" alt="Resort Lobby"
                        onerror="this.src='https://via.placeholder.com/800x600?text=Lobby+View'">
                </div>
                <div class="col-md-6 ps-md-5" data-aos="fade-left">
                    <h2 class="fw-bold mb-4">Who <span class="text-neon">We Are</span></h2>
                    <p class="text-muted fs-5">Founded in 2010, OceanView Resort was born from a vision to create a
                        sustainable yet ultra-luxurious escape on the pristine coast of the Indian Ocean. We pride
                        ourselves on blending world-class hospitality with the raw beauty of nature.</p>
                    <p class="text-muted">Our resort spans 15 acres of tropical gardens and private beaches, offering
                        120 meticulously designed suites that cater to families, couples, and solo travelers alike.</p>
                </div>
            </div>

            <div class="row align-items-center mb-5 pb-5 flex-md-row-reverse">
                <div class="col-md-6" data-aos="fade-left">
                    <img src="${pageContext.request.contextPath}/assets/images/pool.png"
                        class="img-fluid rounded-4 shadow-lg border border-secondary"
                        style="object-fit: cover; width: 100%; height: auto;" alt="Resort Pool"
                        onerror="this.src='https://via.placeholder.com/800x600?text=Pool+View'">
                </div>
                <div class="col-md-6 pe-md-5" data-aos="fade-right">
                    <h2 class="fw-bold mb-4">Our <span class="text-neon">Facilities</span></h2>
                    <ul class="list-unstyled text-muted fs-5">
                        <li class="mb-3"><i class="fa-solid fa-check-circle text-neon me-2"></i> Infinity Pool
                            overlooking the horizon</li>
                        <li class="mb-3"><i class="fa-solid fa-check-circle text-neon me-2"></i> World-class Spa &
                            Wellness Center</li>
                        <li class="mb-3"><i class="fa-solid fa-check-circle text-neon me-2"></i> 3 Signature Fine Dining
                            Restaurants</li>
                        <li class="mb-3"><i class="fa-solid fa-check-circle text-neon me-2"></i> Fully Equipped
                            Ocean-Front Gym</li>
                        <li class="mb-3"><i class="fa-solid fa-check-circle text-neon me-2"></i> Private Beach Access &
                            Water Sports</li>
                    </ul>
                </div>
            </div>

            <div class="glass-card p-5 mt-5 text-center" data-aos="zoom-in">
                <h2 class="fw-bold mb-4">Get In <span class="text-neon">Touch</span></h2>
                <div class="row g-4 mt-2">
                    <div class="col-md-4">
                        <i class="fa-solid fa-location-dot fa-2x text-neon mb-3"></i>
                        <h5 class="fw-bold">Our Location</h5>
                        <p class="text-muted">123 Ocean Drive,<br>Paradise Cove, Sri Lanka</p>
                    </div>
                    <div class="col-md-4">
                        <i class="fa-solid fa-phone fa-2x text-neon mb-3"></i>
                        <h5 class="fw-bold">Phone</h5>
                        <p class="text-muted">+94 11 234 5678<br>+94 77 123 4567</p>
                    </div>
                    <div class="col-md-4">
                        <i class="fa-solid fa-envelope fa-2x text-neon mb-3"></i>
                        <h5 class="fw-bold">Email</h5>
                        <p class="text-muted">stay@oceanview.com<br>events@oceanview.com</p>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>