package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "DeleteReservationServlet", urlPatterns = {"/DeleteReservationServlet"})
public class DeleteReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resIdParam = request.getParameter("reservationId");
        
        if (resIdParam == null || resIdParam.trim().isEmpty()) {
            response.sendRedirect("DashboardServlet?error=Missing+Reservation+ID");
            return;
        }

        Connection conn = null;
        try {
            int reservationId = Integer.parseInt(resIdParam);
            
            DBConnectionManager db = DBConnectionManager.getInstance();
            conn = db.getConnection();
            
            // Start manual transaction to ensure all or nothing deletes
            conn.setAutoCommit(false);
            
            // 1. Delete Payments associated with Bills belonging to this Reservation
            String deletePayments = "DELETE FROM payments WHERE bill_id IN (SELECT id FROM bills WHERE reservation_id = ?)";
            try(PreparedStatement stmt = conn.prepareStatement(deletePayments)) {
                stmt.setInt(1, reservationId);
                stmt.executeUpdate();
            }
            
            // 2. Delete Bills associated with this Reservation
            String deleteBills = "DELETE FROM bills WHERE reservation_id = ?";
            try(PreparedStatement stmt = conn.prepareStatement(deleteBills)) {
                stmt.setInt(1, reservationId);
                stmt.executeUpdate();
            }
            
            // 3. Delete Additional Charges associated with this Reservation
            String deleteCharges = "DELETE FROM additional_charges WHERE reservation_id = ?";
            try(PreparedStatement stmt = conn.prepareStatement(deleteCharges)) {
                stmt.setInt(1, reservationId);
                stmt.executeUpdate();
            }
            
            // 4. Finally Delete the Reservation itself
            String deleteRes = "DELETE FROM reservations WHERE id = ?";
            try(PreparedStatement stmt = conn.prepareStatement(deleteRes)) {
                stmt.setInt(1, reservationId);
                stmt.executeUpdate();
            }
            
            // Commit transaction
            conn.commit();
            
            // Redirect with success message
            response.sendRedirect("DashboardServlet?msg=deleted");
            
        } catch (Exception e) {
            if(conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect("DashboardServlet?error=Delete+Failed:+" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        } finally {
            if(conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
