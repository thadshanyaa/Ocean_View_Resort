package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/RefundServlet")
public class RefundServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"Accountant".equals(user.getRole()) && !"Admin".equals(user.getRole()))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));
        String reason = request.getParameter("reason");

        try (Connection conn = DBConnectionManager.getConnection()) {
            RefundDAO rDao = new RefundDAO(conn);
            rDao.processRefund(reservationId, amount, reason);
            
            // Log action if AuditDAO exists (Optional based on schema)
            
            response.sendRedirect("AccountantDashboardServlet?success=Refund processed successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AccountantDashboardServlet?error=Failed to process refund: " + e.getMessage());
        }
    }
}
