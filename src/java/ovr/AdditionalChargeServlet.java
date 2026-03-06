package ovr;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdditionalChargeServlet")
public class AdditionalChargeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resNum = request.getParameter("reservationNumber");
        
        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            String category = request.getParameter("category");
            String itemName = request.getParameter("itemName");
            BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
            int qty = Integer.parseInt(request.getParameter("qty"));
            
            if (qty <= 0) {
                sendError(response, "Quantity must be greater than zero.");
                return;
            }
            if (unitPrice.compareTo(BigDecimal.ZERO) < 0) {
                sendError(response, "Unit price cannot be negative.");
                return;
            }
            
            BigDecimal totalPrice = unitPrice.multiply(new BigDecimal(qty));
            
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            try {
                // 1. Insert Charge
                AdditionalCharge charge = new AdditionalCharge();
                charge.setReservationId(reservationId);
                charge.setCategory(category);
                charge.setItemName(itemName);
                charge.setUnitPrice(unitPrice);
                charge.setQty(qty);
                charge.setTotalPrice(totalPrice);
                
                AdditionalChargeDAO chargeDAO = new AdditionalChargeDAO(conn);
                chargeDAO.create(charge);
                
                // 2. Update Bill Total
                BillDAO billDAO = new BillDAO(conn);
                Bill bill = billDAO.getByReservationId(reservationId);
                if (bill != null) {
                    BigDecimal newTotal = bill.getTotalAmount().add(totalPrice);
                    bill.setTotalAmount(newTotal);
                    billDAO.update(bill);
                    
                    // If Payment was PAID, it is now PARTIAL since new charges were added
                    PaymentDAO paymentDAO = new PaymentDAO(conn);
                    java.util.List<Payment> payments = paymentDAO.getByBillId(bill.getId());
                    if (!payments.isEmpty()) {
                        Payment payment = payments.get(0);
                        if ("PAID".equals(payment.getPaymentStatus())) {
                            payment.setPaymentStatus("PARTIAL");
                            paymentDAO.update(payment);
                        }
                    }
                }
                
                // 3. Log Audit
                User u = (User) request.getSession().getAttribute("user");
                int userId = u != null ? u.getId() : 0;
                new AuditLogDAO(conn).log(userId, "SERVICE_ADDED", "Added " + qty + "x " + itemName + " to Res " + resNum + " (+" + totalPrice + ")");
                
                conn.commit();
                
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Service added successfully!\"}");
                
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                sendError(response, "Database transaction failed: " + e.getMessage());
            } finally {
                conn.setAutoCommit(true);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Invalid input parameters.");
        }
    }
    
    private void sendError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"status\":\"error\", \"message\":\"" + message.replace("\"", "\\\"") + "\"}");
    }
}
