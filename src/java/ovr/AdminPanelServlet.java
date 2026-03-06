package ovr;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminPanelServlet")
public class AdminPanelServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRole()) && !"Manager".equals(user.getRole())) {
            response.sendRedirect("dashboard.jsp?error=Access+Denied");
            return;
        }

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) view = "dashboard";
        request.setAttribute("currentView", view);

        try {
            Connection conn = DBConnectionManager.getInstance().getConnection();
            RoomDAO roomDao = new RoomDAO(conn);
            UserDAO userDao = new UserDAO(conn);
            ReservationDAO resDao = new ReservationDAO(conn);
            AuditLogDAO auditDao = new AuditLogDAO(conn);

            if ("dashboard".equals(view)) {
                request.setAttribute("totalRooms", roomDao.getTotalRooms());
                request.setAttribute("totalStaff", userDao.getStaffCount());
                
                Map<String, Object> stats = resDao.getSummaryStats();
                request.setAttribute("totalBookings", stats.get("activeCount"));
                request.setAttribute("totalRevenue", stats.get("totalPaid"));
                
                request.setAttribute("monthlyRevenue", resDao.getMonthlyRevenue());
                request.setAttribute("monthlyBookings", resDao.getMonthlyBookings());
                request.setAttribute("recentLogs", auditDao.getRecentLogs(10));
            } else if ("rooms".equals(view)) {
                request.setAttribute("rooms", roomDao.getAll());
                request.setAttribute("roomTypes", new RoomTypeDAO(conn).getAll());
            } else if ("staff".equals(view)) {
                request.setAttribute("staffList", userDao.getAllStaff());
            } else if ("reservations".equals(view)) {
                request.setAttribute("reservations", resDao.getRecentReservations(50, null));
            } else if ("guests".equals(view)) {
                // Fetching guests via a custom query or limit in GuestDAO
                List<java.util.Map<String, Object>> guests = new java.util.ArrayList<>();
                try (java.sql.PreparedStatement stmt = conn.prepareStatement("SELECT g.*, u.username FROM guests g JOIN users u ON g.user_id = u.id ORDER BY g.full_name")) {
                    try (java.sql.ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            java.util.Map<String, Object> g = new java.util.HashMap<>();
                            g.put("id", rs.getInt("id"));
                            g.put("name", rs.getString("full_name"));
                            g.put("contact", rs.getString("contact_number"));
                            g.put("username", rs.getString("username"));
                            guests.add(g);
                        }
                    }
                }
                request.setAttribute("guestList", guests);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load admin context: " + e.getMessage());
        }

        request.getRequestDispatcher("adminPanel.jsp").forward(request, response);
    }
}
