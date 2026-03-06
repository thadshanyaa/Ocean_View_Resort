<%@ page pageEncoding="UTF-8" %>
    <%@ include file="header.jspf" %>

        <style>
            .gallery-item {
                position: relative;
                overflow: hidden;
                border-radius: 12px;
                cursor: pointer;
                transition: transform 0.4s ease;
            }

            .gallery-item:hover {
                transform: scale(1.03);
            }

            .gallery-item img {
                transition: transform 0.6s ease;
            }

            .gallery-item:hover img {
                transform: scale(1.1);
            }

            .gallery-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(to top, rgba(14, 165, 233, 0.6), transparent);
                opacity: 0;
                transition: opacity 0.4s ease;
                display: flex;
                align-items: flex-end;
                padding: 20px;
            }

            .gallery-item:hover .gallery-overlay {
                opacity: 1;
            }

            .modal-content-glass {
                background: rgba(15, 23, 42, 0.9);
                backdrop-filter: blur(10px);
                border: 1px solid var(--card-border);
            }
        </style>

        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-down">
                <h1 class="display-4 fw-bold text-neon mb-2">Our Gallery</h1>
                <p class="text-muted">Glimpses of heaven at OceanView Resort.</p>
                <div class="mx-auto mt-2" style="width: 60px; height: 4px; background: var(--neon-accent);"></div>
            </div>

            <div class="row g-4" id="galleryGrid">
                <% String contextPath=request.getContextPath(); String[][] galleryItems={ {contextPath
                    + "/assets/images/pool.png" , "Lush Pool Area" }, {contextPath + "/assets/images/room.png"
                    , "Luxury Accommodations" }, {contextPath + "/assets/images/lobby.png" , "Lobby & Reception" },
                    {contextPath + "/assets/images/restaurant.png" , "Fine Dining" }, {contextPath
                    + "/assets/images/beach.png" , "Private Beach" }, {contextPath + "/assets/images/spa.png"
                    , "Holistic Spa" } }; for(int i=0; i < galleryItems.length; i++) { %>
                    <div class="col-md-4 col-sm-6" data-aos="fade-up" data-aos-delay="<%= (i*100) %>">
                        <div class="gallery-item shadow border border-secondary"
                            onclick="openLightbox('<%= galleryItems[i][0] %>', '<%= galleryItems[i][1] %>')">
                            <img src="<%= galleryItems[i][0] %>" class="w-100 h-100"
                                style="object-fit: cover; min-height: 250px; display: block;"
                                alt="<%= galleryItems[i][1] %>"
                                onerror="this.src='https://via.placeholder.com/600x400?text=<%= galleryItems[i][1].replace(" ", "
                                +") %>'">
                            <div class="gallery-overlay">
                                <h5 class="text-white fw-bold m-0">
                                    <%= galleryItems[i][1] %>
                                </h5>
                            </div>
                        </div>
                    </div>
                    <% } %>
            </div>
        </div>

        <!-- Lightbox Modal -->
        <div class="modal fade" id="lightboxModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content modal-content-glass text-light">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title" id="lightboxTitle">Image Preview</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-0 text-center">
                        <img src="" id="lightboxImg" class="img-fluid" alt="Preview">
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