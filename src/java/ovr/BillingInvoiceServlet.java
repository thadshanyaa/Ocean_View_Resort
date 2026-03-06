package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/BillingInvoiceServlet")
public class BillingInvoiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"Accountant".equals(user.getRole()) && !"Admin".equals(user.getRole()) && !"Receptionist".equals(user.getRole()) && !"Guest".equals(user.getRole()))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String resNo = request.getParameter("resNo");
        if (resNo == null || resNo.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation number is required.");
            return;
        }

        try (Connection conn = DBConnectionManager.getInstance().getConnection()) {
            ReservationDAO resDao = new ReservationDAO(conn);
            Reservation res = resDao.getByReservationNumber(resNo);

            if (res == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found.");
                return;
            }

            BillDAO billDao = new BillDAO(conn);
            GuestDAO guestDao = new GuestDAO(conn);
            RoomDAO roomDao = new RoomDAO(conn);
            RoomTypeDAO roomTypeDao = new RoomTypeDAO(conn);
            AdditionalChargeDAO chargesDao = new AdditionalChargeDAO(conn);

            // Security check for Guest role
            if ("Guest".equals(user.getRole())) {
                Guest currentGuest = guestDao.getByUserId(user.getId());
                if (currentGuest == null || res.getGuestId() != currentGuest.getId()) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: You cannot view this invoice.");
                    return;
                }
            }

            Bill bill = billDao.getByReservationId(res.getId());
            Guest guest = guestDao.getById(res.getGuestId());
            Room room = roomDao.getById(res.getRoomId());
            RoomType roomType = (room != null) ? roomTypeDao.getById(room.getRoomTypeId()) : null;

            java.util.List<AdditionalCharge> charges = chargesDao.getByReservationId(res.getId());
            double additionalTotal = 0.0;
            if (charges != null) {
                additionalTotal = charges.stream()
                        .filter(c -> c.getTotalPrice() != null)
                        .mapToDouble(c -> c.getTotalPrice().doubleValue()).sum();
            }

            if (bill == null) {
                // Should not happen if data is consistent, but let's be safe
                bill = new Bill();
                bill.setTotalAmount(java.math.BigDecimal.ZERO);
                bill.setSubtotal(java.math.BigDecimal.ZERO);
                bill.setTax(java.math.BigDecimal.ZERO);
                bill.setServiceFee(java.math.BigDecimal.ZERO);
                bill.setNights(0);
            }

            request.setAttribute("reservation", res);
            request.setAttribute("bill", bill);
            request.setAttribute("guest", guest);
            request.setAttribute("room", room);
            request.setAttribute("roomType", roomType);
            request.setAttribute("charges", charges);
            request.setAttribute("additionalTotal", additionalTotal);
            request.setAttribute("grandTotal", (bill.getTotalAmount() != null ? bill.getTotalAmount().doubleValue() : 0.0) + additionalTotal);
            request.setAttribute("now", new java.util.Date());

            request.getRequestDispatcher("invoice.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage());
        }
    }
}
