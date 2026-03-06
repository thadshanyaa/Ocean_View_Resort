<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

        <div class="manager-card border-0 shadow-sm" data-aos="fade-up">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="fw-bold mb-1 manager-accent-text"><i class="fa-solid fa-calendar-days me-2"></i>Staff
                        Schedule</h5>
                    <p class="text-muted small mb-0">Upcoming shifts for resort personnel</p>
                </div>
                <div class="btn-group">
                    <button class="btn btn-sm btn-outline-info rounded-start-pill px-3">Weekly</button>
                    <button class="btn btn-sm btn-info rounded-end-pill px-3">Monthly</button>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle mb-0">
                    <thead class="bg-dark bg-opacity-50">
                        <tr class="text-muted small text-uppercase" style="letter-spacing: 1px;">
                            <th class="ps-4 border-0">Staff Name</th>
                            <th class="border-0">Role</th>
                            <th class="border-0">Department</th>
                            <th class="border-0">Shift Time</th>
                            <th class="border-0 text-center">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${staffSchedule}">
                            <tr class="border-bottom border-light border-opacity-5">
                                <td class="ps-4 py-3">
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=${s.name}&background=38bdf8&color=fff&size=32"
                                            class="rounded-circle me-3" alt="Staff">
                                        <span class="fw-bold">${s.name}</span>
                                    </div>
                                </td>
                                <td><span class="badge bg-info bg-opacity-10 text-info fw-normal">${s.role}</span></td>
                                <td class="text-muted">${s.dept}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fa-regular fa-clock me-2 text-info opacity-50"></i>
                                        <span>
                                            <fmt:formatDate value="${s.start}" pattern="HH:mm" /> -
                                            <fmt:formatDate value="${s.end}" pattern="HH:mm" />
                                        </span>
                                    </div>
                                </td>
                                <td class="text-center">
                                    <span
                                        class="badge bg-success bg-opacity-10 text-success rounded-pill px-3">Confirmed</span>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty staffSchedule}">
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <div class="opacity-25 pb-3">
                                        <i class="fa-solid fa-calendar-xmark fa-3x"></i>
                                    </div>
                                    <p class="text-muted">No schedules found for the upcoming period.</p>
                                    <button class="btn btn-sm btn-outline-info rounded-pill">Create New
                                        Schedule</button>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>