package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/ServiceOrderServlet")
public class ServiceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"Guest".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String resIdStr = request.getParameter("reservationId");
        String category = request.getParameter("category"); // 'Resort Service' or 'Restaurant'
        String itemName = request.getParameter("itemName");
        String unitPriceStr = request.getParameter("unitPrice");
        String qtyStr = request.getParameter("qty");

        if (resIdStr == null || itemName == null || unitPriceStr == null || category == null) {
            response.sendRedirect("DashboardServlet?error=Missing+order+details");
            return;
        }

        try {
            int resId = Integer.parseInt(resIdStr);
            BigDecimal unitPrice = new BigDecimal(unitPriceStr);
            int qty = (qtyStr != null && !qtyStr.isEmpty()) ? Integer.parseInt(qtyStr) : 1;
            BigDecimal totalPrice = unitPrice.multiply(new BigDecimal(qty));

            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            
            // Security Check: Ensure reservation belongs to this guest
            GuestDAO guestDAO = new GuestDAO(conn);
            Guest guest = guestDAO.getByUserId(user.getId());
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            Reservation res = reservationDAO.getById(resId);

            if (res == null || guest == null || res.getGuestId() != guest.getId()) {
                response.sendRedirect("DashboardServlet?error=Unauthorized+order");
                return;
            }

            if ("CANCELLED".equals(res.getStatus())) {
                response.sendRedirect("DashboardServlet?error=Cannot+add+services+to+cancelled+reservation");
                return;
            }

            AdditionalCharge charge = new AdditionalCharge();
            charge.setReservationId(resId);
            charge.setCategory(category);
            charge.setItemName(itemName);
            charge.setUnitPrice(unitPrice);
            charge.setQty(qty);
            charge.setTotalPrice(totalPrice);

            AdditionalChargeDAO chargeDAO = new AdditionalChargeDAO(conn);
            chargeDAO.create(charge);

            AuditLogDAO auditDAO = new AuditLogDAO(conn);
            auditDAO.log(user.getId(), "SERVICE_ORDERED", "Guest ordered " + itemName + " (" + category + ")");

            String redirectPage = "DashboardServlet";
            if ("Restaurant".equals(category)) {
                redirectPage = "restaurant.jsp";
            } else if ("Resort Service".equals(category)) {
                redirectPage = "services.jsp";
            }

            response.sendRedirect(redirectPage + "?msg=ordered&item=" + java.net.URLEncoder.encode(itemName, "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("DashboardServlet?error=System+Error+processing+order");
        }
    }
}
