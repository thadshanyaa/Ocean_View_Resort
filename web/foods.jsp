<%@ page pageEncoding="UTF-8" %>
    <%@ page import="ovr.*" %>
        <%@ include file="header.jspf" %>

            <% if(session.getAttribute("user")==null){ response.sendRedirect("login.jsp"); return; } %>

                <div class="container py-5">
                    <div class="row g-4">
                        <!-- Sidebar -->
                        <div class="col-md-4 col-lg-3" data-aos="fade-right">
                            <%@ include file="sidebar.jspf" %>
                        </div>

                        <!-- Main Content -->
                        <div class="col-md-8 col-lg-9" data-aos="fade-left">
                            <div
                                class="glass-card p-5 text-center h-100 d-flex flex-column justify-content-center align-items-center">
                                <div class="mb-4">
                                    <i class="fa-solid fa-burger fa-5x text-primary"
                                        style="filter: drop-shadow(0 0 10px rgba(234, 179, 8, 0.5));"></i>
                                </div>
                                <h2 class="fw-bold mb-3 text-dark">Room Service & Snacks</h2>
                                <p class="text-muted fs-5">Craving a midnight snack? Browse our 24/7 room service menu
                                    and order additional comfort foods directly to your door.</p>
                                <div class="mt-4">
                                    <button class="btn btn-neon px-4 py-2"
                                        onclick="alert('Menu catalog opening soon!')">View Menu</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="footer.jspf" %>