package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/AccountantReportServlet")
public class AccountantReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || (!"Accountant".equals(user.getRole()) && !"Admin".equals(user.getRole()))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String type = request.getParameter("type");
        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");

        try (Connection conn = DBConnectionManager.getConnection()) {
            PaymentDAO pDao = new PaymentDAO(conn);
            List<Map<String, Object>> payments = pDao.searchPayments(start, end, null, "PAID", null);

            if ("excel".equals(type)) {
                response.setContentType("text/csv");
                response.setHeader("Content-Disposition", "attachment; filename=\"Financial_Report_" + start + "_to_" + end + ".csv\"");
                PrintWriter writer = response.getWriter();
                writer.println("Payment ID,Reservation,Guest,Method,Reference,Amount (LKR),Status,Paid At");
                for (Map<String, Object> p : payments) {
                    writer.printf("%s,%s,%s,%s,%s,%s,%s,%s\n",
                        p.get("id"), p.get("resNo"), p.get("guestName"), p.get("method"),
                        p.get("ref"), p.get("amount"), p.get("status"), p.get("paidAt"));
                }
            } else {
                request.setAttribute("payments", payments);
                request.setAttribute("startDate", start);
                request.setAttribute("endDate", end);
                request.getRequestDispatcher("accountantReportPrint.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
