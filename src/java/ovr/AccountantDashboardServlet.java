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
import java.util.*;

@WebServlet("/AccountantDashboardServlet")
public class AccountantDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"Accountant".equals(user.getRole()) && !"Admin".equals(user.getRole()))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) view = "dashboard";
        request.setAttribute("currentView", view);

        try {
            Connection conn = DBConnectionManager.getInstance().getConnection();
            PaymentDAO pDao = new PaymentDAO(conn);
            ReservationDAO rDao = new ReservationDAO(conn);
            
            if ("dashboard".equals(view)) {
                // 1. Fetch KPI Stats
                Map<String, Object> kpis = pDao.getAccountantKPIs();
                request.setAttribute("kpis", kpis);
                
                // Quick recent history for dashboard
                request.setAttribute("recentPayments", pDao.getRecentPayments(5));
            } else if ("billing".equals(view)) {
                // Fetch active billing records or reservations needing billing
                request.setAttribute("pendingBalances", rDao.getPendingBalances());
            } else if ("history".equals(view)) {
                // Fetch full payment history
                request.setAttribute("fullHistory", pDao.getRecentPayments(100));
            } else if ("analytics".equals(view)) {
                // Fetch Daily Revenue Trend for charts (last 30 days for analytics)
                List<Map<String, Object>> revenueTrend = pDao.getDailyRevenue(30);
                request.setAttribute("revenueTrendJson", toJson(revenueTrend));
            } else if ("expenses".equals(view)) {
                // Mock expense data as no table exists yet
                List<Map<String, Object>> expenses = new ArrayList<>();
                String[] cats = {"Utilities", "Staff Salary", "Inventory", "Maintenance", "Marketing"};
                double[] amounts = {45000, 120000, 35000, 25000, 15000};
                for(int i=0; i<cats.length; i++) {
                    Map<String, Object> e = new HashMap<>();
                    e.put("category", cats[i]);
                    e.put("amount", amounts[i]);
                    expenses.add(e);
                }
                request.setAttribute("expenseData", expenses);
            }

            request.getRequestDispatcher("accountantDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("accountantDashboard.jsp").forward(request, response);
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
