package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet(name = "FrontOfficePortalServlet", urlPatterns = {"/front-office-portal", "/front-office-action"})
public class FrontOfficePortalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"Receptionist".equals(user.getRole())) {
            response.sendError(403, "Access Denied: Front Office Credentials Required.");
            return;
        }

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) view = "dashboard";
        
        request.setAttribute("view", view);

        try (Connection conn = DBConnectionManager.getInstance().getConnection()) {
            ReservationDAO resDao = new ReservationDAO(conn);
            BillDAO billDao = new BillDAO(conn);
            PaymentDAO payDao = new PaymentDAO(conn);

            if ("dashboard".equals(view)) {
                // Summary Stats
                java.util.Map<String, Object> stats = resDao.getSummaryStats();
                
                // Pending Payments count
                String sqlPending = "SELECT COUNT(*) FROM bills b JOIN reservations r ON b.reservation_id = r.id " +
                                  "WHERE r.status != 'CANCELLED' AND (b.total_amount - " +
                                  "IFNULL((SELECT SUM(amount_paid) FROM payments WHERE bill_id = b.id AND payment_status='PAID'), 0)) > 0";
                try (PreparedStatement pst = conn.prepareStatement(sqlPending);
                     ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) stats.put("pendingPayments", rs.getInt(1));
                }

                // Today's Arrivals
                String sqlToday = "SELECT COUNT(*) FROM reservations WHERE check_in = CURRENT_DATE AND status != 'CANCELLED'";
                try (PreparedStatement pst = conn.prepareStatement(sqlToday);
                     ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) stats.put("todayArrivals", rs.getInt(1));
                }

                request.setAttribute("stats", stats);
                request.setAttribute("recentReservations", resDao.getRecentReservations(10, request.getParameter("search")));
            }
            
            if ("reservations".equals(view)) {
                request.setAttribute("reservations", resDao.getRecentReservations(50, request.getParameter("search")));
            }

            if ("requests".equals(view)) {
                // Keep luxury requests for now or fetch from a service table if exists
                LuxuryDAO luxDao = new LuxuryDAO(conn);
                request.setAttribute("requests", luxDao.getAllRequests());
            }

            String target = "FrontOfficeDashboard.jsp";
            switch(view) {
                case "reservations": target = "FrontOfficeReservations.jsp"; break;
                case "operations": target = "FrontOfficeOperations.jsp"; break;
                case "requests": target = "FrontOfficeRequests.jsp"; break;
                case "billing": target = "FrontOfficeBilling.jsp"; break;
            }
            
            request.getRequestDispatcher(target).forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Front Office Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Shared staff actions
        doGet(request, response);
    }
}
