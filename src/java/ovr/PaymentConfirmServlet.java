package ovr;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentConfirmServlet")
public class PaymentConfirmServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String resNum = request.getParameter("reservationNumber");

        // Null checks for essential parameters to prevent generic 500 errors
        if (resNum == null || resNum.trim().isEmpty()) {
            response.sendRedirect("dashboard.jsp?error=" + java.net.URLEncoder.encode("Critical Error: Reservation Number is missing.", "UTF-8"));
            return;
        }

        // Role check just in case someone tries to bypass the UI
        if (user == null || (!user.getRole().equals("Receptionist") && !user.getRole().equals("Admin"))) {
            response.sendRedirect("ReservationDetailsServlet?reservationNumber=" + resNum + "&error=" + java.net.URLEncoder.encode("Unauthorized Access", "UTF-8"));
            return;
        }

        try {
            String billIdStr = request.getParameter("billId");
            String amountStr = request.getParameter("amount");
            String method = request.getParameter("paymentMethod");
            String payerName = request.getParameter("payerName");
            String refNo = request.getParameter("referenceNo");
            String confirmCheck = request.getParameter("paymentReceived");

            if (billIdStr == null || amountStr == null || method == null || payerName == null || refNo == null) {
                throw new IllegalArgumentException("One or more required payment fields are missing from the request.");
            }

            if (confirmCheck == null || !confirmCheck.equals("true")) {
                throw new IllegalArgumentException("You must confirm receipt of the full payment by checking the box.");
            }

            // Server-side strict validation for 8 digits
            if (!refNo.matches("^\\d{8}$")) {
                response.sendRedirect("ReservationDetailsServlet?reservationNumber=" + resNum + "&msg=" + java.net.URLEncoder.encode("Booking Confirmed", "UTF-8") + "&error=" + java.net.URLEncoder.encode("Invalid Reference Number. Must be exactly 8 digits.", "UTF-8"));
                return;
            }
            
            int billId;
            BigDecimal amount;
            try {
                billId = Integer.parseInt(billIdStr);
                // Remove commas if any exist before parsing
                amount = new BigDecimal(amountStr.replace(",", ""));
            } catch (NumberFormatException nfe) {
                throw new IllegalArgumentException("Invalid number format for Bill ID or Amount: " + amountStr);
            }

            DBConnectionManager db = DBConnectionManager.getInstance();
            try (Connection conn = db.getConnection()) {
                PaymentDAO paymentDAO = new PaymentDAO(conn);
                List<Payment> payments = paymentDAO.getByBillId(billId);
                Payment payment = null;
                if (payments != null && !payments.isEmpty()) {
                    payment = payments.get(0);
                }

                if (payment == null) {
                    // If there wasn't a pending payment initialized yet, create it.
                    payment = new Payment();
                    payment.setBillId(billId);
                    payment.setPaymentMethod(method);
                    payment.setTransactionRef(refNo);
                    payment.setAmountPaid(amount);
                    payment.setPaymentStatus("Paid");
                    payment.setPaidAt(new Timestamp(System.currentTimeMillis()));
                    
                    // You requested saving receptionist user id. Since there isn't a native field in Payment.java for it,
                    // we'll append it to the transactionRef safely for audit traceability if needed:
                    payment.setTransactionRef(refNo + "-R" + user.getId());
                    
                    paymentDAO.create(payment);
                } else {
                    // Update the pending payment with full details
                    payment.setPaymentMethod(method);
                    payment.setTransactionRef(refNo + "-R" + user.getId()); // Appending Receptionist ID for audit
                    payment.setAmountPaid(amount);
                    payment.setPaymentStatus("Paid");
                    payment.setPaidAt(new Timestamp(System.currentTimeMillis()));
                    paymentDAO.update(payment);
                }
            }

            // Redirect back to confirmation page successfully
            response.sendRedirect("ReservationDetailsServlet?reservationNumber=" + resNum + "&msg=" + java.net.URLEncoder.encode("Booking Confirmed", "UTF-8") + "&paymentSuccess=true");

        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendRedirect("ReservationDetailsServlet?reservationNumber=" + resNum + "&msg=" + java.net.URLEncoder.encode("Booking Confirmed", "UTF-8") + "&error=" + java.net.URLEncoder.encode("Validation Error: " + e.getMessage(), "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ReservationDetailsServlet?reservationNumber=" + resNum + "&msg=" + java.net.URLEncoder.encode("Booking Confirmed", "UTF-8") + "&error=" + java.net.URLEncoder.encode("Database/System Error: " + e.getMessage(), "UTF-8"));
        }
    }
}
