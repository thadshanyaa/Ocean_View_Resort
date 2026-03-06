<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-down">
                <h2 class="fw-bold">How can we help you?</h2>
                <div class="mx-auto mt-2" style="width: 50px; height: 3px; background: var(--neon-accent);"></div>
            </div>

            <div class="row g-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <div class="glass-card p-4 h-100">
                        <h4 class="mb-4 text-info border-bottom border-secondary pb-2"><i
                                class="fa-solid fa-circle-question me-2"></i> Frequently Asked Questions</h4>

                        <div class="accordion accordion-flush bg-transparent" id="faqAccordion">
                            <div class="accordion-item bg-transparent text-light border-secondary">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed bg-transparent text-light shadow-none"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                        How do I cancel a booking?
                                    </button>
                                </h2>
                                <div id="faq1" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body text-muted small">You can cancel your booking from your
                                        dashboard at least 24 hours prior to check-in.</div>
                                </div>
                            </div>
                            <div class="accordion-item bg-transparent text-light border-secondary">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed bg-transparent text-light shadow-none"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                        When do I pay for my reservation?
                                    </button>
                                </h2>
                                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body text-muted small">Payment is processed upon generation of
                                        the bill during check-out or can be done online anytime after reservation
                                        confirmation.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6" data-aos="fade-left">
                    <div class="glass-card p-4 h-100">
                        <h4 class="mb-4 text-info border-bottom border-secondary pb-2"><i
                                class="fa-solid fa-envelope-open-text me-2"></i> Contact Support</h4>
                        <form action="HelpServlet" method="POST">
                            <div class="mb-3">
                                <label class="form-label text-light">Email Address</label>
                                <input type="email" class="form-control" name="email" required
                                    placeholder="name@example.com">
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-light">Issue / Query</label>
                                <textarea class="form-control" name="query" rows="4" required
                                    placeholder="Describe how we can help..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-neon w-100">Send Message <i
                                    class="fa-solid fa-paper-plane ms-1"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jspf" %>
