package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "ManagerDashboardServlet", urlPatterns = {"/ManagerDashboardServlet", "/manager-dashboard"})
public class ManagerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"Manager".equals(user.getRole()) && !"Admin".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Managers only.");
            return;
        }

        // 1. Get Filters
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String roomType = request.getParameter("roomType");
        String bookingStatus = request.getParameter("status");
        String paymentStatus = request.getParameter("payStatus");
        String period = request.getParameter("period"); // thisMonth, lastMonth, etc.

        // Default period to this month if nothing is provided
        if (period == null || period.isEmpty()) period = "thisMonth";

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
            if ("lastMonth".equals(period)) {
                cal.add(Calendar.MONTH, -1);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                startDate = sdf.format(cal.getTime());
                cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                endDate = sdf.format(cal.getTime());
            } else if ("thisYear".equals(period)) {
                cal.set(Calendar.DAY_OF_YEAR, 1);
                startDate = sdf.format(cal.getTime());
                cal.set(Calendar.MONTH, 11);
                cal.set(Calendar.DAY_OF_MONTH, 31);
                endDate = sdf.format(cal.getTime());
            } else {
                // Default: thisMonth
                period = "thisMonth";
                cal.set(Calendar.DAY_OF_MONTH, 1);
                startDate = sdf.format(cal.getTime());
                cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                endDate = sdf.format(cal.getTime());
            }
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO(conn);

            // Fetch Room Types for dropdown
            request.setAttribute("roomTypes", roomTypeDAO.getAll());

            // 2. Fetch Aggregated KPIs
            Map<String, Object> kpis = reservationDAO.getManagerKPIs(startDate, endDate, roomType, bookingStatus, paymentStatus);
            request.setAttribute("kpis", kpis);

            // 3. Fetch Trend Data for Charts
            List<Map<String, Object>> occupancyTrend = reservationDAO.getOccupancyTrend(startDate, endDate);
            List<Map<String, Object>> revenueTrend = reservationDAO.getRevenueTrend(startDate, endDate);
            List<Map<String, Object>> roomPerformance = reservationDAO.getRoomTypePerformance(startDate, endDate);
            Map<String, Object> guestStats = reservationDAO.getGuestStats(startDate, endDate);

            request.setAttribute("occupancyTrend", toJson(occupancyTrend));
            request.setAttribute("revenueTrend", toJson(revenueTrend));
            request.setAttribute("roomPerformance", toJson(roomPerformance));
            request.setAttribute("guestStats", guestStats);

            // Pass filters back to JSP
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("selectedRoomType", roomType);
            request.setAttribute("selectedStatus", bookingStatus);
            request.setAttribute("selectedPayStatus", paymentStatus);
            request.setAttribute("selectedPeriod", period);

            // 4. Fetch Recent Activity
            List<Map<String, Object>> recentStats = reservationDAO.getRecentReservations(10, null);
            request.setAttribute("recentReservations", recentStats);

            request.getRequestDispatcher("managerDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("managerDashboard.jsp").forward(request, response);
        }
    }

    private String toJson(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            sb.append("{");
            int j = 0;
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                sb.append("\"").append(entry.getKey()).append("\":");
                if (entry.getValue() instanceof Number) {
                    sb.append(entry.getValue());
                } else {
                    sb.append("\"").append(entry.getValue()).append("\"");
                }
                if (++j < map.size()) sb.append(",");
            }
            sb.append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
