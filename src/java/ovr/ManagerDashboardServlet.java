 package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) view = "dashboard";
        request.setAttribute("currentView", view);

        // Restore missing filter logic
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String roomType = request.getParameter("roomType");
        String bookingStatus = request.getParameter("status");
        String paymentStatus = request.getParameter("payStatus");
        String period = request.getParameter("period");

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
                period = "thisMonth";
                cal.set(Calendar.DAY_OF_MONTH, 1);
                startDate = sdf.format(cal.getTime());
                cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                endDate = sdf.format(cal.getTime());
            }
        }
        
        // Pass filters back to JSP
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("selectedRoomType", roomType);
        request.setAttribute("selectedStatus", bookingStatus);
        request.setAttribute("selectedPayStatus", paymentStatus);
        request.setAttribute("selectedPeriod", period);

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO(conn);
            UserDAO userDAO = new UserDAO(conn);
            RoomDAO roomDAO = new RoomDAO(conn);

            if ("dashboard".equals(view)) {
                // Fetch Room Types for dropdown
                request.setAttribute("roomTypes", roomTypeDAO.getAll());

                // 1. Fetch Aggregated KPIs
                Map<String, Object> kpis = reservationDAO.getManagerKPIs(startDate, endDate, roomType, bookingStatus, paymentStatus);
                request.setAttribute("kpis", kpis);

                // 2. Fetch Trend Data for Charts
                Calendar trendCal = Calendar.getInstance();
                String trendEnd = sdf.format(trendCal.getTime());
                trendCal.add(Calendar.DAY_OF_YEAR, -6);
                String trendStart = sdf.format(trendCal.getTime());
                
                List<Map<String, Object>> revenueTrend7Days = reservationDAO.getRevenueTrend(trendStart, trendEnd);
                List<Map<String, Object>> roomPerformance = reservationDAO.getRoomTypePerformance(startDate, endDate);
                
                request.setAttribute("revenueTrend7Days", toJson(revenueTrend7Days));
                request.setAttribute("roomPerformance", toJson(roomPerformance));

                // 3. Fetch Recent Activity
                List<Map<String, Object>> recentStats = reservationDAO.getRecentReservations(10, null);
                request.setAttribute("recentReservations", recentStats);

                // 4. Live Data
                request.setAttribute("receptionistStatus", userDAO.getLiveReceptionistStatus());
                request.setAttribute("roomOverview", roomDAO.getRoomStatusOverview());

                // 5. Activity Feed
                List<Map<String, Object>> activityFeed = new ArrayList<>();
                String activitySql = "SELECT a.*, u.username FROM audit_logs a LEFT JOIN users u ON a.user_id = u.id ORDER BY timestamp DESC LIMIT 10";
                try (PreparedStatement astmt = conn.prepareStatement(activitySql);
                     ResultSet ars = astmt.executeQuery()) {
                    while (ars.next()) {
                        Map<String, Object> log = new HashMap<>();
                        log.put("user", ars.getString("username") != null ? ars.getString("username") : "System");
                        log.put("action", ars.getString("action"));
                        log.put("details", ars.getString("details"));
                        log.put("time", ars.getTimestamp("timestamp"));
                        activityFeed.add(log);
                    }
                } catch (SQLException ignored) {}
                request.setAttribute("activityFeed", activityFeed);

            } else if ("schedule".equals(view)) {
                request.setAttribute("staffSchedule", userDAO.getStaffSchedule());
            } else if ("attendance".equals(view)) {
                request.setAttribute("attendanceLogs", userDAO.getAttendanceLogs());
            } else if ("oversight".equals(view)) {
                PaymentDAO pDao = new PaymentDAO(conn);
                request.setAttribute("revenueKPIs", pDao.getAccountantKPIs());
                request.setAttribute("weeklyTrendJson", toJson(pDao.getDailyRevenue(7)));
            }

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
