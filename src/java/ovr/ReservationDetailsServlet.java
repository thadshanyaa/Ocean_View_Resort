package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@WebServlet(name = "ReservationDetailsServlet", urlPatterns = {"/ReservationDetailsServlet"})
public class ReservationDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reservationNumber = request.getParameter("reservationNumber");
        String msg = request.getParameter("msg");

        // Prepare defaults to guarantee safe rendering without crashing
        Reservation res = new Reservation();
        Guest guest = new Guest();
        Room room = new Room();
        RoomType roomType = new RoomType();
        Bill bill = new Bill();
        String paymentStatus = "PENDING";
        List<AdditionalCharge> charges = new ArrayList<>();
        double additionalTotal = 0.0;
        double amountDue = 0.0;

        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Reservation number parameter is missing.");
            forwardSafe(request, response, res, guest, room, roomType, bill, paymentStatus, charges, additionalTotal, amountDue, msg);
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            res = reservationDAO.getByReservationNumber(reservationNumber);

            if (res == null) {
                request.setAttribute("errorMessage", "Reservation Not Found");
                res = new Reservation(); // Reset to safe blank instance
                forwardSafe(request, response, res, guest, room, roomType, bill, paymentStatus, charges, additionalTotal, amountDue, msg);
                return;
            }

            // Security Check for Guests: Ensure they only see their own reservations
            User user = (User) request.getSession().getAttribute("user");
            if (user != null && "Guest".equals(user.getRole())) {
                GuestDAO guestDAO = new GuestDAO(conn);
                Guest currentGuest = guestDAO.getByUserId(user.getId());
                if (currentGuest == null || res.getGuestId() != currentGuest.getId()) {
                    request.setAttribute("errorMessage", "Access Denied: You can only view your own reservations.");
                    res = new Reservation(); // Reset
                    forwardSafe(request, response, res, guest, room, roomType, bill, paymentStatus, charges, additionalTotal, amountDue, msg);
                    return;
                }
            }

            GuestDAO guestDAO = new GuestDAO(conn);
            Guest g = guestDAO.getById(res.getGuestId());
            if (g != null) guest = g;

            RoomDAO roomDAO = new RoomDAO(conn);
            Room r = roomDAO.getById(res.getRoomId());
            if (r != null) {
                room = r;
                RoomTypeDAO roomTypeDAO = new RoomTypeDAO(conn);
                RoomType rt = roomTypeDAO.getById(room.getRoomTypeId());
                if (rt != null) roomType = rt;
            }

            double totalPaid = 0.0;
            BillDAO billDAO = new BillDAO(conn);
            Bill b = billDAO.getByReservationId(res.getId());
            if (b != null) {
                bill = b;
                PaymentDAO paymentDAO = new PaymentDAO(conn);
                List<Payment> pmts = paymentDAO.getByBillId(bill.getId());
                if (pmts != null) {
                    totalPaid = pmts.stream()
                        .filter(p -> "PAID".equals(p.getPaymentStatus()))
                        .mapToDouble(p -> p.getAmountPaid().doubleValue()).sum();
                }
            }

            AdditionalChargeDAO chargesDAO = new AdditionalChargeDAO(conn);
            List<AdditionalCharge> chList = chargesDAO.getByReservationId(res.getId());
            if (chList != null) {
                charges = chList;
                additionalTotal = charges.stream()
                        .filter(c -> c.getTotalPrice() != null)
                        .mapToDouble(c -> c.getTotalPrice().doubleValue()).sum();
            }
            
            double baseBill = (bill != null && bill.getTotalAmount() != null) ? bill.getTotalAmount().doubleValue() : 0.0;
            double grandTotal = baseBill + additionalTotal;
            amountDue = Math.max(0.0, grandTotal - totalPaid);
            
            boolean roomPaid = totalPaid >= baseBill;
            boolean servicesPaid = totalPaid >= grandTotal;
            paymentStatus = servicesPaid ? "PAID" : "PENDING";

            request.setAttribute("totalPaid", totalPaid);
            request.setAttribute("roomPaid", roomPaid);
            request.setAttribute("servicesPaid", servicesPaid);
            request.setAttribute("grandTotal", grandTotal);

            forwardSafe(request, response, res, guest, room, roomType, bill, paymentStatus, charges, additionalTotal, amountDue, msg);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database connection error: " + e.getMessage());
            forwardSafe(request, response, res, guest, room, roomType, bill, paymentStatus, charges, additionalTotal, amountDue, msg);
        }
    }

    private void forwardSafe(HttpServletRequest request, HttpServletResponse response, 
                             Reservation res, Guest guest, Room room, RoomType roomType, 
                             Bill bill, String paymentStatus, List<AdditionalCharge> charges, 
                             double additionalTotal, double amountDue, String msg) throws ServletException, IOException {
                             
        request.setAttribute("res", res);
        request.setAttribute("guest", guest);
        request.setAttribute("room", room);
        request.setAttribute("roomType", roomType);
        request.setAttribute("bill", bill);
        request.setAttribute("paymentStatus", paymentStatus);
        request.setAttribute("charges", charges);
        request.setAttribute("additionalTotal", additionalTotal);
        request.setAttribute("amountDue", amountDue);
        
        // Determine view type: Default is "full" (Reservation Details / Itinerary)
        String view = request.getParameter("view");
        String targetJsp = "reservationDetails.jsp"; // Default to Full Details
        
        if ("summary".equalsIgnoreCase(view)) {
            targetJsp = "reservationSummary.jsp";
        }
                           
        try {
            request.getRequestDispatcher(targetJsp).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Fallback HTML if JSP causes crash - simplify it to avoid multiple heads/html tags
            // Use current style if buffer not committed, otherwise plain text
            if (!response.isCommitted()) {
                response.setContentType("text/html");
                java.io.PrintWriter out = response.getWriter();
                out.println("<div style='background:#0a1128; color:#fff; font-family:sans-serif; padding:50px; text-align:center;'>");
                out.println("<h2>System Fallback: Reservation Summary</h2>");
                out.println("<p>Reservation No: " + (res != null ? res.getReservationNumber() : "N/A") + "</p>");
                out.println("<p>Guest: " + (guest != null ? guest.getFullName() : "N/A") + "</p>");
                out.println("<p>Status: " + paymentStatus + " | Total: LKR " + amountDue + "</p>");
                out.println("<hr><a href='DashboardServlet' style='color:#0dcaf0;'>Go to Dashboard</a>");
                out.println("</div>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionType = request.getParameter("actionType");
        Connection conn = null;

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            conn = db.getConnection();
            conn.setAutoCommit(false);

            if ("addService".equals(actionType)) {
                AdditionalChargeDAO chargesDAO = new AdditionalChargeDAO(conn);
                
                int reservationId = Integer.parseInt(request.getParameter("reservationId"));
                String category = request.getParameter("category");
                String itemName = request.getParameter("itemName");
                if (itemName == null || itemName.trim().isEmpty()) itemName = category;

                int qty = Integer.parseInt(request.getParameter("qty"));
                BigDecimal unitPrice = new BigDecimal(request.getParameter("unitPrice"));
                BigDecimal total = unitPrice.multiply(new BigDecimal(qty));

                AdditionalCharge charge = new AdditionalCharge();
                charge.setReservationId(reservationId);
                charge.setCategory(category);
                charge.setItemName(itemName);
                charge.setUnitPrice(unitPrice);
                charge.setQty(qty);
                charge.setTotalPrice(total);

                chargesDAO.create(charge);
                conn.commit();
                
                response.getWriter().print("Success");

            } else if ("payBill".equals(actionType)) {
                PaymentDAO paymentDAO = new PaymentDAO(conn);

                int billId = Integer.parseInt(request.getParameter("billId"));
                BigDecimal amountPaid = new BigDecimal(request.getParameter("amountPaid"));
                String method = request.getParameter("paymentMethod");

                Payment p = new Payment();
                p.setBillId(billId);
                p.setAmountPaid(amountPaid);
                p.setPaymentStatus("PAID");
                p.setPaidAt(new java.sql.Timestamp(System.currentTimeMillis()));

                if ("ONLINE".equals(method) || "BANK_TRANSFER".equals(method)) {
                    String payerName = request.getParameter("payerName");
                    String ref = request.getParameter("transactionRef");
                    
                    if (payerName == null || payerName.trim().isEmpty()) {
                        throw new Exception("Payer Name is required for " + method + ".");
                    }
                    if (ref == null || !ref.matches("\\d{8}")) {
                        throw new Exception("A valid 8-digit Reference Number is required.");
                    }
                    
                    p.setPaymentMethod(method + " (" + payerName + ")");
                    p.setTransactionRef(ref);
                } else {
                    // CASH logic
                    p.setPaymentMethod("CASH (Reception)");
                    String ref = "CASH-" + System.currentTimeMillis() / 1000;
                    p.setTransactionRef(ref);
                }

                paymentDAO.create(p);
                conn.commit();
                response.getWriter().print("Success");
            }
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            response.sendError(500, e.getMessage());
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ex) {}
        }
    }
}