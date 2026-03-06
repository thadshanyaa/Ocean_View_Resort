package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "PaymentConfirmServlet", urlPatterns = {"/PaymentConfirmServlet"})
public class PaymentConfirmServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionType = request.getParameter("actionType");
        Connection conn = null;

        if (!"payBill".equals(actionType)) {
            response.sendError(400, "Invalid Action");
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            conn = db.getConnection();
            conn.setAutoCommit(false);

            PaymentDAO paymentDAO = new PaymentDAO(conn);

            int billId = Integer.parseInt(request.getParameter("billId"));
            BigDecimal amountPaid = new BigDecimal(request.getParameter("amountPaid"));
            String method = request.getParameter("paymentMethod");
            String reservationNumber = request.getParameter("reservationNumber");

            Payment p = new Payment();
            p.setBillId(billId);
            p.setAmountPaid(amountPaid);
            p.setPaymentStatus("PAID");
            p.setPaidAt(new java.sql.Timestamp(System.currentTimeMillis()));

            if ("ONLINE".equals(method) || "BANK_TRANSFER".equals(method)) {
                String payerName = request.getParameter("payerName");
                String ref = request.getParameter("transactionRef");
                
                if (payerName == null || payerName.trim().isEmpty()) {
                    throw new Exception("Payer Name is required.");
                }
                if (ref == null || !ref.matches("\\d{8}")) {
                    throw new Exception("A valid 8-digit Reference Number is required.");
                }
                
                p.setPaymentMethod(method + " (" + payerName + ")");
                p.setTransactionRef(ref);
            } else {
                p.setPaymentMethod("CASH (Reception)");
                String ref = "CASH-" + System.currentTimeMillis() / 1000;
                p.setTransactionRef(ref);
            }

            paymentDAO.create(p);
            conn.commit();
            
            // Redirect back with success message
            response.getWriter().print("Success");

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().print(e.getMessage());
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ex) {}
        }
    }
}
