package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/DashboardServlet", "/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String search = request.getParameter("search");
        
        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            User user = (User) session.getAttribute("user");

            if ("Guest".equals(user.getRole())) {
                // GUEST FLOW
                GuestDAO guestDAO = new GuestDAO(conn);
                Guest guest = guestDAO.getByUserId(user.getId());
                
                if (guest != null) {
                    request.setAttribute("guest", guest);
                    request.setAttribute("stats", reservationDAO.getExtendedGuestStats(guest.getId()));
                    request.setAttribute("reservations", reservationDAO.getReservationsByGuest(guest.getId()));
                } else {
                    request.setAttribute("dbError", "Guest profile not found. Please contact support.");
                }
                request.getRequestDispatcher("guestDashboard.jsp").forward(request, response);
            } else {
                // STAFF FLOW (Unchanged output)
                // Fetch summary stats
                Map<String, Object> stats = reservationDAO.getSummaryStats();
                request.setAttribute("stats", stats);

                // Fetch recent reservations (last 20)
                List<Map<String, Object>> recentReservations = reservationDAO.getRecentReservations(20, search);
                request.setAttribute("reservations", recentReservations);

                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dbError", "System encountered a database error: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
