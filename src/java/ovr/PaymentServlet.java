package ovr;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Date;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;






@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(request.getParameter("billId"));
            BigDecimal amount = new BigDecimal(request.getParameter("amountPaid"));
            String method = request.getParameter("paymentMethod"); // 'Online', 'Cash', 'Card'
            String ref = request.getParameter("transactionRef"); // Provided for manual, empty for online

            String action = request.getParameter("action");
            
            String payerName = request.getParameter("payerName");
            if (payerName == null || payerName.trim().isEmpty()) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Payer Name is required.\"}");
                return;
            }

            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid payment amount.\"}");
                return;
            }

            DBConnectionManager db = DBConnectionManager.getInstance();
            PaymentDAO paymentDAO = new PaymentDAO(db.getConnection());
            
            if ("update".equals(action)) {
                int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                String resNum = request.getParameter("reservationNumber");
                
                Payment payment = paymentDAO.getById(paymentId);
                if (payment != null && "PENDING".equals(payment.getPaymentStatus())) {
                    payment.setAmountPaid(amount);

                    if ("Online".equalsIgnoreCase(method)) {
                        String contact = request.getParameter("receiptContact");
                        if (contact == null || contact.trim().isEmpty()) {
                            response.setContentType("application/json");
                            response.getWriter().write("{\"status\":\"error\", \"message\":\"Email or Phone is required for ONLINE payment.\"}");
                            return;
                        }
                        String datePart = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                        String randPart = String.format("%05d", new java.util.Random().nextInt(100000));
                        payment.setTransactionRef("TXN-" + datePart + "-" + randPart);
                        payment.setPaymentMethod("ONLINE");
                    } else if ("Offline".equalsIgnoreCase(method)) {
                        String offlineType = request.getParameter("offlineType");
                        if (offlineType == null || offlineType.trim().isEmpty()) {
                            response.setContentType("application/json");
                            response.getWriter().write("{\"status\":\"error\", \"message\":\"Offline Type (Cash/Card) is required.\"}");
                            return;
                        }
                        if (ref == null || !ref.matches("\\d{10}")) {
                            response.setContentType("application/json");
                            response.getWriter().write("{\"status\":\"error\", \"message\":\"Offline Reference No must be exactly 10 digits.\"}");
                            return;
                        }
                        payment.setPaymentMethod("OFFLINE-" + offlineType.toUpperCase());
                        payment.setTransactionRef("REF-" + ref);
                    } else {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid payment method.\"}");
                        return;
                    }
                    payment.setPaymentStatus("PAID");
                    paymentDAO.update(payment);
                    
                    User u = (User) request.getSession().getAttribute("user");
                    int userId = u != null ? u.getId() : 0;
                    new AuditLogDAO(db.getConnection()).log(userId, "PAYMENT_PAID", "Payment " + paymentId + " marked PAID via " + payment.getPaymentMethod() + " by " + payerName);
                }
                
                // Return success immediately or rely on JS
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\", \"redirect\":\"ReservationDetailsServlet?reservationNumber=" + resNum + "&msg=Payment+Successful\"}");
                return;
            }

            // For new payment rows (if any)
            Payment payment = new Payment();
            payment.setBillId(billId);
            payment.setAmountPaid(amount);
            
            if ("Online".equalsIgnoreCase(method)) {
                String datePart = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                String randPart = String.format("%05d", new java.util.Random().nextInt(100000));
                payment.setTransactionRef("TXN-" + datePart + "-" + randPart);
                payment.setPaymentMethod("ONLINE");
            } else if ("Offline".equalsIgnoreCase(method)) {
                String offlineType = request.getParameter("offlineType");
                payment.setPaymentMethod("OFFLINE-" + (offlineType != null ? offlineType.toUpperCase() : "UNKNOWN"));
                payment.setTransactionRef(ref != null && ref.matches("\\d{10}") ? "REF-" + ref : "REF-UNKNOWN");
            } else {
                payment.setPaymentMethod("UNKNOWN");
                payment.setTransactionRef("None");
            }
            
            payment.setPaymentStatus("PAID");
            paymentDAO.create(payment);

            User u = (User) request.getSession().getAttribute("user");
            int userId = u != null ? u.getId() : 0;
            new AuditLogDAO(db.getConnection()).log(userId, "PAYMENT_RECORDED", "Method: " + payment.getPaymentMethod() + ", Amount: " + amount + ", Ref: " + payment.getTransactionRef());

            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\", \"redirect\":\"BillingInvoiceServlet?billId=" + billId + "&msg=Payment+Processed+Successfully\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Payment Error: " + e.getMessage() + "\"}");
        }
    }
}
