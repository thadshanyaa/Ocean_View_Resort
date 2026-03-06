package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.Calendar;

@WebServlet("/CancelReservationServlet")
public class CancelReservationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"Guest".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String resIdStr = request.getParameter("reservationId");
        if (resIdStr == null || resIdStr.isEmpty()) {
            response.sendRedirect("DashboardServlet?error=Invalid+Reservation");
            return;
        }

        try {
            int resId = Integer.parseInt(resIdStr);
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            GuestDAO guestDAO = new GuestDAO(conn);
            AuditLogDAO auditDAO = new AuditLogDAO(conn);

            Guest guest = guestDAO.getByUserId(user.getId());
            if (guest == null) {
                response.sendRedirect("DashboardServlet?error=Guest+Profile+Missing");
                return;
            }

            Reservation res = reservationDAO.getById(resId);
            if (res == null || res.getGuestId() != guest.getId()) {
                response.sendRedirect("DashboardServlet?error=Access+Denied");
                return;
            }

            // Get Today (Time truncated to 00:00:00)
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            long todayMillis = cal.getTimeInMillis();
            
            // Check-in date truncation just in case
            long checkInMillis = res.getCheckIn().getTime();
            
            // If check-in date is today or in the past, cannot cancel
            if (checkInMillis <= todayMillis) {
                response.sendRedirect("DashboardServlet?error=Check-in+has+already+started.+Cannot+cancel.");
                return;
            }

            if ("CANCELLED".equals(res.getStatus())) {
                response.sendRedirect("DashboardServlet?error=Already+Cancelled");
                return;
            }

            // Perform Cancellation
            if (reservationDAO.updateStatus(resId, "CANCELLED")) {
                auditDAO.log(user.getId(), "RESERVATION_CANCELLED", "Guest cancelled reservation: " + res.getReservationNumber());
                response.sendRedirect("DashboardServlet?msg=cancelled");
            } else {
                response.sendRedirect("DashboardServlet?error=Cancellation+failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DashboardServlet?error=System+Error");
        }
    }
}
