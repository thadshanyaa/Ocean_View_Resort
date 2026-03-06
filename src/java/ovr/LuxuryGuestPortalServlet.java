package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "LuxuryGuestPortalServlet", urlPatterns = {"/luxury-guest-portal", "/luxury-action-guest"})
public class LuxuryGuestPortalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"Guest".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) view = "dashboard";
        
        request.setAttribute("view", view);

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            LuxuryDAO dao = new LuxuryDAO(db.getConnection());
            dao.initializeTables(); // ensure tables exist

            // Fetch data based on view
            if ("reservations".equals(view)) {
                List<LuxuryModels.Reservation> list = dao.getReservationsByEmail(user.getEmail());
                request.setAttribute("items", list);
            } else if ("dashboard".equals(view)) {
                List<LuxuryModels.Reservation> list = dao.getReservationsByEmail(user.getEmail());
                request.setAttribute("recentStays", list);
            }

            String target = "LuxuryGuestDashboard.jsp";
            switch(view) {
                case "reservations": target = "LuxuryGuestReservations.jsp"; break;
                case "services": target = "LuxuryGuestServices.jsp"; break;
                case "payments": target = "LuxuryGuestPayments.jsp"; break;
                case "profile": target = "LuxuryGuestProfile.jsp"; break;
                case "menu": target = "LuxuryGuestMenu.jsp"; break;
                case "online-pay": target = "LuxuryGuestOnlinePay.jsp"; break;
                case "offline-pay": target = "LuxuryGuestOfflinePay.jsp"; break;
            }
            
            request.getRequestDispatcher(target).forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Luxury System Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("request-service".equals(action)) {
            handleServiceRequest(request, response);
        } else if ("book-elite".equals(action)) {
            handleBooking(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void handleServiceRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        try {
            LuxuryModels.ServiceRequest req = new LuxuryModels.ServiceRequest();
            req.setGuestName(user.getUsername());
            req.setRoomNumber(request.getParameter("roomNumber"));
            req.setServiceType(request.getParameter("serviceType"));
            req.setDetails(request.getParameter("details"));
            req.setStatus("Pending");

            DBConnectionManager db = DBConnectionManager.getInstance();
            LuxuryDAO dao = new LuxuryDAO(db.getConnection());
            dao.saveRequest(req);
            
            response.sendRedirect("luxury-guest-portal?view=services&msg=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("luxury-guest-portal?view=services&msg=error");
        }
    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            LuxuryModels.Reservation res = new LuxuryModels.Reservation();
            res.setReservationNumber("LUX-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
            res.setGuestName(request.getParameter("name"));
            res.setGuestEmail(request.getParameter("email"));
            res.setGuestPhone(request.getParameter("phone"));
            res.setRoomType(request.getParameter("roomType"));
            res.setCheckIn(Date.valueOf(request.getParameter("checkIn")));
            res.setCheckOut(Date.valueOf(request.getParameter("checkOut")));
            res.setGuests(Integer.parseInt(request.getParameter("guests")));
            res.setSpecialRequests(request.getParameter("requests"));
            res.setTotalAmount(new BigDecimal(request.getParameter("total")));
            res.setStatus("Pending");

            DBConnectionManager db = DBConnectionManager.getInstance();
            LuxuryDAO dao = new LuxuryDAO(db.getConnection());
            dao.saveReservation(res);
            
            response.sendRedirect("luxury-guest-portal?view=reservations&msg=booked");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("luxury-guest-portal?view=dashboard&msg=error");
        }
    }
}
