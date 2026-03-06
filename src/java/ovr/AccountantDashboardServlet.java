package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/AccountantDashboardServlet")
public class AccountantDashboardServlet extends HttpServlet {
    private final Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"Accountant".equals(user.getRole()) && !"Admin".equals(user.getRole()))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnectionManager.getConnection()) {
            PaymentDAO pDao = new PaymentDAO(conn);
            ReservationDAO rDao = new ReservationDAO(conn);
            
            // 1. Fetch KPI Stats
            Map<String, Object> kpis = pDao.getAccountantKPIs();
            request.setAttribute("kpis", kpis);

            // 2. Fetch Pending Balances for display
            List<Map<String, Object>> pending = rDao.getPendingBalances();
            request.setAttribute("pendingBalances", pending);

            // 3. Fetch Daily Revenue Trend for charts (last 14 days)
            List<Map<String, Object>> revenueTrend = pDao.getDailyRevenue(14);
            request.setAttribute("revenueTrendJson", gson.toJson(revenueTrend));

            request.getRequestDispatcher("accountantDashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
