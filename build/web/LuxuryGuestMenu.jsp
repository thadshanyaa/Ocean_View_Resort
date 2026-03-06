<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Restaurant Menu | Ocean View Luxury</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-core.css">
    </head>

    <body>
        <%@ include file="luxury-sidebar-guest.jspf" %>

            <main class="lux-main">
                <header class="d-flex justify-content-between align-items-end mb-5">
                    <div>
                        <h1 class="fw-bold mb-1 text-gold">Gastronomy <span class="text-white">Art</span></h1>
                        <p class="text-white-50">Curated culinary delights from our master chefs.</p>
                    </div>
                    <div class="d-flex gap-3">
                        <button class="lux-btn lux-btn-outline border-secondary text-white small py-2 px-3">Download
                            PDF</button>
                        <button class="lux-btn lux-btn-gold py-2 px-3">Call Server</button>
                    </div>
                </header>

                <section class="mb-5">
                    <h3 class="fw-bold mb-4 border-start border-gold border-4 ps-3">Chef's Signature</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="lux-card h-100 d-flex gap-4">
                                <img src="https://images.unsplash.com/photo-1544003385-a49689269448?auto=format&fit=crop&w=300&q=80"
                                    style="width: 120px; height: 120px; object-fit: cover; border-radius: 16px;">
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between">
                                        <h5 class="fw-bold text-gold">Truffle Lobster Risotto</h5>
                                        <span class="fw-bold">LKR 8,500</span>
                                    </div>
                                    <p class="small text-white-50 mt-2">Slow-cooked Arborio rice with fresh blue
                                        lobster, black winter truffles, and aged parmesan.</p>
                                    <button class="btn btn-link text-cyan p-0 small text-decoration-none">+ Add to
                                        Order</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="lux-card h-100 d-flex gap-4">
                                <img src="https://images.unsplash.com/photo-1606471191009-63994c53433b?auto=format&fit=crop&w=300&q=80"
                                    style="width: 120px; height: 120px; object-fit: cover; border-radius: 16px;">
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between">
                                        <h5 class="fw-bold text-gold">Blackened Sea Bass</h5>
                                        <span class="fw-bold">LKR 6,200</span>
                                    </div>
                                    <p class="small text-white-50 mt-2">Sustainable sea bass with a spicy Cajun crust,
                                        lemon butter sauce, and roasted asparagus.</p>
                                    <button class="btn btn-link text-cyan p-0 small text-decoration-none">+ Add to
                                        Order</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="mb-5">
                    <div class="d-flex align-items-center gap-4 mb-4">
                        <h4 class="fw-bold m-0">Menu Categories</h4>
                        <div class="flex-grow-1 border-top border-white opacity-10"></div>
                        <div class="btn-group">
                            <button class="btn btn-dark active">All</button>
                            <button class="btn btn-dark">Main</button>
                            <button class="btn btn-dark">Desserts</button>
                            <button class="btn btn-dark">Drinks</button>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- Apperizers -->
                        <div class="col-md-4">
                            <div class="lux-card">
                                <div class="d-flex justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0">Wagyu Beef Carpaccio</h6>
                                    <span class="small fw-bold">4,800</span>
                                </div>
                                <p class="small text-white-50 mb-0">Caper berries, parmesan crisps, truffle oil.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="lux-card">
                                <div class="d-flex justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0">Octopus Griddle</h6>
                                    <span class="small fw-bold">3,900</span>
                                </div>
                                <p class="small text-white-50 mb-0">Spanish octopus, paprika, lemon crème.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="lux-card">
                                <div class="d-flex justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0">Tuna Tartare</h6>
                                    <span class="small fw-bold">4,200</span>
                                </div>
                                <p class="small text-white-50 mb-0">Avo-mousse, soy-lime dressing, ginger.</p>
                            </div>
                        </div>
                        <!-- Desserts -->
                        <div class="col-md-4">
                            <div class="lux-card border-cyan border-opacity-25">
                                <div class="d-flex justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0 text-cyan">Golden Soufflé</h6>
                                    <span class="small fw-bold">2,400</span>
                                </div>
                                <p class="small text-white-50 mb-0">Dark chocolate hot soufflé, gold leaf.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="lux-card border-cyan border-opacity-25">
                                <div class="d-flex justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0 text-cyan">Coconut Mousse</h6>
                                    <span class="small fw-bold">1,800</span>
                                </div>
                                <p class="small text-white-50 mb-0">Island coconut, mango purée, mint.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="lux-card border-cyan border-opacity-25">
                                <div class="d-flex justify-content-between mb-2">
                                    <h6 class="fw-bold mb-0 text-cyan">Exotic Platter</h6>
                                    <span class="small fw-bold">2,100</span>
                                </div>
                                <p class="small text-white-50 mb-0">Chef's choice of seasonal tropical fruits.</p>
                            </div>
                        </div>
                    </div>
                </section>

                <div class="lux-card text-center py-5 border-dashed border-secondary">
                    <h5 class="fw-bold">Need something off-menu?</h5>
                    <p class="text-white-50">Our kitchen is at your service. Tell us your preference.</p>
                    <button class="lux-btn lux-btn-gold px-5"
                        onclick="alert('Our concierge has been notified to discuss your custom dish.')">Request Special
                        Dish</button>
                </div>
            </main>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>