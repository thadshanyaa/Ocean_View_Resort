package ovr;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BillingInvoiceServlet")
public class BillingInvoiceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String billIdParam = request.getParameter("billId");
        String resIdParam = request.getParameter("reservationId");
        Bill bill = null;

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            BillDAO billDAO = new BillDAO(db.getConnection());
            
            if (billIdParam != null && !billIdParam.isEmpty()) {
                bill = billDAO.getById(Integer.parseInt(billIdParam));
            } else if (resIdParam != null && !resIdParam.isEmpty()) {
                bill = billDAO.getByReservationId(Integer.parseInt(resIdParam));
            }

            if (bill != null) {
                ReservationDAO resDao = new ReservationDAO(db.getConnection());
                Reservation res = resDao.getById(bill.getReservationId());
                
                GuestDAO guestDao = new GuestDAO(db.getConnection());
                Guest guest = guestDao.getById(res.getGuestId());
                
                PaymentDAO pDao = new PaymentDAO(db.getConnection());
                List<Payment> payments = pDao.getByBillId(bill.getId());

                AdditionalChargeDAO cDao = new AdditionalChargeDAO(db.getConnection());
                List<AdditionalCharge> charges = cDao.getByReservationId(res.getId());
                BigDecimal additionalTotal = BigDecimal.ZERO;
                for(AdditionalCharge c : charges) {
                    if (c.getTotalPrice() != null) {
                        additionalTotal = additionalTotal.add(c.getTotalPrice());
                    }
                }
                
                BigDecimal totalAmountDue = bill.getTotalAmount().add(additionalTotal);
                
                BigDecimal totalPaid = BigDecimal.ZERO;
                boolean hasOnlinePayment = false;
                
                for(Payment p : payments) {
                    totalPaid = totalPaid.add(p.getAmountPaid());
                    if(p.getPaymentMethod() != null && p.getPaymentMethod().startsWith("ONLINE")) {
                        hasOnlinePayment = true;
                    }
                }
                boolean isFullyPaid = totalPaid.compareTo(totalAmountDue) >= 0;

                if (!isFullyPaid) {
                    response.setContentType("text/html");
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<html><head><title>Receipt Not Available</title>");
                    out.println("<style>body{font-family:sans-serif; background:#111; color:#eee; display:flex; justify-content:center; align-items:center; height:100vh; margin:0;} .msgBox{background:#222; padding:30px; border-radius:10px; text-align:center; border:2px solid #dc3545;} h2{color:#dc3545; margin-top:0;} </style>");
                    out.println("</head><body><div class='msgBox'>");
                    out.println("<h2>Payment Pending</h2>");
                    out.println("<p>Receipt not available. The bill for this reservation has not been fully settled yet.</p>");
                    out.println("<a href='ReservationDetailsServlet?reservationNumber=" + res.getReservationNumber() + "' style='color:#0dcaf0; text-decoration:none; margin-top:15px; display:inline-block;'>&larr; Return to details</a>");
                    out.println("</div></body></html>");
                    return;
                }

                // Authorization Check for PDF
                User currentUser = (User) session.getAttribute("user");
                boolean canDownloadPdf = true;
                if (currentUser != null) {
                    String r = currentUser.getRole();
                    if ("Admin".equals(r)) canDownloadPdf = false;
                    if ("Receptionist".equals(r) && hasOnlinePayment) canDownloadPdf = false;
                }

                request.setAttribute("bill", bill);
                request.setAttribute("res", res);
                request.setAttribute("guest", guest);
                request.setAttribute("payments", payments);
                request.setAttribute("totalPaid", totalPaid);
                request.setAttribute("hasOnlinePayment", hasOnlinePayment);
                request.setAttribute("isFullyPaid", isFullyPaid);
                request.setAttribute("canDownloadPdf", canDownloadPdf);
                request.setAttribute("balanceDue", totalAmountDue.subtract(totalPaid));
            } else {
                response.sendRedirect("searchReservation.jsp?error=Bill+not+found.+Please+verify+the+ID.");
                return;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("searchReservation.jsp?error=System+Error+Loading+Invoice: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            return;
        }

        request.getRequestDispatcher("billingInvoice.jsp").forward(request, response);
    }
}
