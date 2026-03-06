<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Service Queue | Front Office</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/luxury-core.css">
            </head>

            <body>
                <%@ include file="luxury-sidebar-staff.jspf" %>

                    <main class="lux-main">
                        <header class="d-flex justify-content-between align-items-center mb-5">
                            <div>
                                <h1 class="fw-bold mb-1"><span class="text-gold">Service</span> Queue</h1>
                                <p class="text-white-50">Manage guest requests, amenities, and concierge dispatches.</p>
                            </div>
                            <div class="d-flex gap-3">
                                <div class="lux-badge lux-badge-pending">05 Pending</div>
                                <div class="lux-badge lux-badge-success">12 Resolved</div>
                            </div>
                        </header>

                        <div class="lux-card">
                            <div class="table-responsive">
                                <table class="table table-dark lux-table align-middle">
                                    <thead>
                                        <tr>
                                            <th>Guest / Room</th>
                                            <th>Request Type</th>
                                            <th>Requirement Details</th>
                                            <th>Time Received</th>
                                            <th>Current Status</th>
                                            <th>Staff Response</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="req" items="${requests}">
                                            <tr>
                                                <td>
                                                    <div class="fw-bold">${req.guestName}</div>
                                                    <div class="small text-white-50">Room ${req.roomNumber}</div>
                                                </td>
                                                <td>
                                                    <span class="text-gold fw-bold">${req.serviceType}</span>
                                                </td>
                                                <td>
                                                    <p class="small m-0 text-white-dim" style="max-width: 300px;">
                                                        ${req.details}</p>
                                                </td>
                                                <td class="small">
                                                    <fmt:formatDate value="${req.requestedAt}"
                                                        pattern="MMM dd, HH:mm" />
                                                </td>
                                                <td>
                                                    <span
                                                        class="lux-badge ${req.status == 'Pending' ? 'lux-badge-pending' : 'lux-badge-success'}">
                                                        ${req.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${req.status == 'Pending'}">
                                                            <button
                                                                class="lux-btn lux-btn-gold py-1 px-3 small">Dispatch</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button
                                                                class="btn btn-dark btn-sm rounded-3 border-secondary"
                                                                disabled>Resolved</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty requests}">
                                            <tr>
                                                <td colspan="6" class="text-center py-5">
                                                    <div class="opacity-25 mb-3">
                                                        <i class="fa-solid fa-mug-hot fa-3x"></i>
                                                    </div>
                                                    <h5 class="text-white-50">All guests are currently catered to.</h5>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>