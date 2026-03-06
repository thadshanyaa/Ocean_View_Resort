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

@WebServlet("/AccountantDashboardServlet")
public class AccountantDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"Accountant".equals(user.getRole()) && !"Admin".equals(user.getRole()))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DBConnectionManager.getInstance().getConnection();
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
            request.setAttribute("revenueTrendJson", toJson(revenueTrend));

            request.getRequestDispatcher("accountantDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    private String toJson(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> map = list.get(i);
                sb.append("{");
                int j = 0;
                for (Map.Entry<String, Object> entry : map.entrySet()) {
                    sb.append("\"").append(entry.getKey()).append("\":");
                    Object val = entry.getValue();
                    if (val instanceof Number) {
                        sb.append(val);
                    } else if (val == null) {
                        sb.append("null");
                    } else {
                        sb.append("\"").append(val.toString().replace("\"", "\\\"")).append("\"");
                    }
                    if (++j < map.size()) sb.append(",");
                }
                sb.append("}");
                if (i < list.size() - 1) sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
