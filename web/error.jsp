<%@ include file="header.jspf" %>
    <div class="container py-5 min-vh-100 d-flex align-items-center justify-content-center">
        <div class="glass-card p-5 text-center shadow-lg" style="max-width: 600px;" data-aos="zoom-in">
            <div class="text-danger mb-4">
                <i class="fa-solid fa-circle-exclamation fa-5x animate__animated animate__pulse animate__infinite"></i>
            </div>
            <h1 class="display-4 fw-bold text-white mb-3">Oops! Something Went Wrong</h1>
            <p class="lead text-muted mb-4">
                We encountered an unexpected error while processing your request. Our system administrators have been
                notified.
            </p>
            <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                <a href="index.jsp" class="btn btn-neon px-5 py-2">
                    <i class="fa-solid fa-house me-2"></i> Return Home
                </a>
                <button onclick="window.history.back()" class="btn btn-outline-warning px-5 py-2">
                    <i class="fa-solid fa-arrow-left me-2"></i> Go Back
                </button>
            </div>
            <div class="mt-5 pt-3 border-top border-secondary">
                <p class="small text-secondary mb-0">Error Code: ${pageContext.errorData.statusCode != null ?
                    pageContext.errorData.statusCode : '500'}</p>
            </div>
        </div>
    </div>
    <%@ include file="footer.jspf" %>