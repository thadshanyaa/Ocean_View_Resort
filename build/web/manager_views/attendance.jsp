<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

        <div class="manager-card border-0 shadow-sm" data-aos="fade-up">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="fw-bold mb-1 manager-accent-text"><i
                            class="fa-solid fa-clipboard-user me-2"></i>Attendance Logs</h5>
                    <p class="text-muted small mb-0">Daily staff check-in/out records</p>
                </div>
                <div class="small text-muted border-start ps-3 border-info border-2">Showing last 100 sessions</div>
            </div>

            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle mb-0">
                    <thead class="bg-dark bg-opacity-50">
                        <tr class="text-muted small text-uppercase" style="letter-spacing: 1px;">
                            <th class="ps-4 border-0">Staff Name</th>
                            <th class="border-0">Check-In Time</th>
                            <th class="border-0">Check-Out Time</th>
                            <th class="border-0">Status</th>
                            <th class="border-0 text-center">Reference</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${attendanceLogs}">
                            <tr class="border-bottom border-light border-opacity-5">
                                <td class="ps-4 py-3">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3"
                                            style="width: 32px; height: 32px;">
                                            <i class="fa-solid fa-user-check" style="font-size: 0.8rem;"></i>
                                        </div>
                                        <span class="fw-bold text-light">${a.name}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="small fw-bold">
                                        <fmt:formatDate value="${a.checkIn}" pattern="MMM dd, yyyy" />
                                    </div>
                                    <div class="extra-small text-muted">
                                        <fmt:formatDate value="${a.checkIn}" pattern="HH:mm:ss" />
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty a.checkOut}">
                                            <div class="small fw-bold">
                                                <fmt:formatDate value="${a.checkOut}" pattern="HH:mm:ss" />
                                            </div>
                                            <div class="extra-small text-info opacity-75">Completed</div>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning bg-opacity-10 text-warning px-2 py-1"
                                                style="font-size: 0.65rem;">
                                                <i class="fa-solid fa-spinner fa-spin me-1"></i> ACTIVE
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span
                                        class="badge ${a.status == 'Active' ? 'bg-success' : 'bg-secondary'} bg-opacity-10 ${a.status == 'Active' ? 'text-success' : 'text-secondary'} rounded-pill px-3">
                                        ${a.status}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-link text-info p-0"><i
                                            class="fa-solid fa-circle-info"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty attendanceLogs}">
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <i class="fa-solid fa-user-slash fa-3x text-muted opacity-25 mb-3"></i>
                                    <p class="text-muted">No attendance logs found for today.</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>