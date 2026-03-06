<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <style>
            .gallery-hero {
                background: linear-gradient(rgba(10, 17, 40, 0.7), rgba(10, 17, 40, 0.7)), url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=1780&auto=format&fit=crop');
                background-size: cover;
                background-position: center;
                padding: 100px 0;
                margin-bottom: 50px;
                border-bottom: 1px solid var(--card-border);
            }

            .gallery-item {
                position: relative;
                overflow: hidden;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid var(--card-border);
                aspect-ratio: 4/3;
            }

            .gallery-item:hover {
                transform: translateY(-10px);
                border-color: var(--neon-accent);
                box-shadow: var(--neon-glow);
            }

            .gallery-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.6s ease;
            }

            .gallery-item:hover img {
                transform: scale(1.1);
            }

            .gallery-overlay {
                position: absolute;
                inset: 0;
                background: linear-gradient(to top, rgba(10, 17, 40, 0.9), transparent);
                opacity: 0;
                transition: opacity 0.4s ease;
                display: flex;
                align-items: flex-end;
                padding: 30px;
            }

            .gallery-item:hover .gallery-overlay {
                opacity: 1;
            }

            .modal-content-glass {
                background: rgba(10, 17, 40, 0.95);
                backdrop-filter: blur(20px);
                border: 1px solid var(--card-border);
                border-radius: 24px;
                overflow: hidden;
            }
        </style>

        <!-- Hero Section -->
        <div class="gallery-hero text-center mb-5">
            <div class="container" data-aos="zoom-in">
                <h1 class="display-3 fw-bold text-white mb-3">The <span class="text-neon">Visual Journey</span></h1>
                <p class="lead text-white-50 mx-auto" style="max-width: 700px;">Experience the unparalleled elegance and
                    serene beauty of Ocean View Resort through our curated lens.</p>
            </div>
        </div>

        <div class="container pb-5">
            <div class="row g-4" id="galleryGrid">
                <% String contextPath=request.getContextPath(); String[][] galleryItems={ {contextPath
                    + "/assets/images/pool.png" , "The Azure Pool" }, {contextPath + "/assets/images/room.png"
                    , "Grand Suite Experience" }, {contextPath + "/assets/images/lobby.png" , "Royal Reception" },
                    {contextPath + "/assets/images/restaurant.png" , "Atmospheric Dining" }, {contextPath
                    + "/assets/images/beach.png" , "Private Sunset Sands" }, {contextPath + "/assets/images/spa.png"
                    , "Wellness Sanctuary" } }; for(int i=0; i < galleryItems.length; i++) { %>
                    <div class="col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="<%= (i*100) %>">
                        <div class="gallery-item shadow"
                            onclick="openLightbox('<%= galleryItems[i][0] %>', '<%= galleryItems[i][1] %>')">
                            <img src="<%= galleryItems[i][0] %>" alt="<%= galleryItems[i][1] %>"
                                onerror="this.src='https://via.placeholder.com/800x600?text=<%= galleryItems[i][1].replace(" ", "
                                +") %>'">
                            <div class="gallery-overlay">
                                <div>
                                    <span class="badge bg-info mb-2">Ocean View</span>
                                    <h4 class="text-white fw-bold m-0">
                                        <%= galleryItems[i][1] %>
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
            </div>
        </div>

        <!-- Lightbox Modal -->
        <div class="modal fade" id="lightboxModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content modal-content-glass text-light shadow-lg">
                    <div class="modal-header border-0 p-4">
                        <h4 class="modal-title fw-bold" id="lightboxTitle">Image Preview</h4>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-0 text-center">
                        <img src="" id="lightboxImg" class="img-fluid w-100"
                            style="max-height: 80vh; object-fit: contain;" alt="Preview">
                    </div>
                    <div class="modal-footer border-0 p-4 justify-content-center">
                        <p class="text-white-50 m-0">Ocean View Resort Experience &copy; 2026</p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function openLightbox(imgUrl, title) {
                document.getElementById('lightboxImg').src = imgUrl;
                document.getElementById('lightboxTitle').innerText = title;
                var myModal = new bootstrap.Modal(document.getElementById('lightboxModal'));
                myModal.show();
            }
        </script>

        <%@ include file="footer.jspf" %>