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






@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("generate".equals(action)) {
            generateBill(request, response);
        } else if ("logPrint".equals(action)) {
            logPrint(request, response);
        }
    }

    private void logPrint(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int billId = Integer.parseInt(request.getParameter("billId"));
            DBConnectionManager db = DBConnectionManager.getInstance();
            User u = (User) request.getSession().getAttribute("user");
            if(u != null) {
                 new AuditLogDAO(db.getConnection()).log(u.getId(), "PDF_DOWNLOAD", "User exported Invoice PDF for Bill ID " + billId);
            }
            response.setStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500);
        }
    }

    private void generateBill(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            
            DBConnectionManager db = DBConnectionManager.getInstance();
            ReservationDAO resDAO = new ReservationDAO(db.getConnection());
            Reservation res = resDAO.getById(reservationId);
            
            RoomDAO roomDAO = new RoomDAO(db.getConnection());
            Room room = roomDAO.getById(res.getRoomId());
            
            RoomTypeDAO typeDAO = new RoomTypeDAO(db.getConnection());
            RoomType rt = typeDAO.getById(room.getRoomTypeId());
            
            SettingDAO settingDAO = new SettingDAO(db.getConnection());
            BigDecimal taxRate = new BigDecimal(settingDAO.getValue("tax_rate", "0.10"));
            BigDecimal feeRate = new BigDecimal(settingDAO.getValue("service_fee_rate", "0.05"));

            // Calculate nights
            long diff = res.getCheckOut().getTime() - res.getCheckIn().getTime();
            int nights = (int) (diff / (1000 * 60 * 60 * 24));
            if(nights <= 0) nights = 1;

            // Strategy pattern applied for pricing
            PricingStrategy strategy = new NormalPricingStrategy(); // default to normal
            BigDecimal subtotal = strategy.calculateRate(rt.getBaseRate(), res.getCheckIn(), res.getCheckOut());

            // Builder pattern applied to construct Bill
            BillBuilder builder = new BillBuilder();
            Bill bill = builder.withReservationId(reservationId)
                               .withNights(nights)
                               .withSubtotal(subtotal)
                               .applyTaxAndFees(taxRate, feeRate)
                               .build();

            BillDAO billDAO = new BillDAO(db.getConnection());
            billDAO.create(bill);
            
            // Mark res as Checked-Out if bill generated for final checkout
            res.setStatus("Checked-Out");
            resDAO.update(res);

            User u = (User) request.getSession().getAttribute("user");
            new AuditLogDAO(db.getConnection()).log(u.getId(), "BILL_GENERATED", "Generated Bill ID " + bill.getId() + " for Reservation " + res.getReservationNumber());

            response.sendRedirect("BillingInvoiceServlet?billId=" + bill.getId() + "&msg=Bill+Generated+Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Billing+Error");
        }
    }
}
