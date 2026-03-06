package ovr;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.*;

@WebServlet(name = "ManagerReportServlet", urlPatterns = {"/ManagerReportServlet", "/manager-report"})
public class ManagerReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String type = request.getParameter("type"); // pdf or excel
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String roomType = request.getParameter("roomType");
        String status = request.getParameter("status");
        String payStatus = request.getParameter("payStatus");

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            ReservationDAO reservationDAO = new ReservationDAO(conn);

            Map<String, Object> kpis = reservationDAO.getManagerKPIs(startDate, endDate, roomType, status, payStatus);
            List<Map<String, Object>> roomPerformance = reservationDAO.getRoomTypePerformance(startDate, endDate);

            if ("excel".equalsIgnoreCase(type)) {
                generateExcel(response, kpis, roomPerformance, startDate, endDate);
            } else {
                // PDF / Print View
                request.setAttribute("kpis", kpis);
                request.setAttribute("roomPerformance", roomPerformance);
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                request.getRequestDispatcher("managerReportPrint.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Report Generation Error: " + e.getMessage());
        }
    }

    private void generateExcel(HttpServletResponse response, Map<String, Object> kpis, List<Map<String, Object>> roomPerformance, String start, String end) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"Manager_Report_" + start + "_to_" + end + ".csv\"");
        
        PrintWriter writer = response.getWriter();
        writer.println("Ocean View Resort - Manager Report");
        writer.println("Period: " + start + " to " + end);
        writer.println();
        
        writer.println("Summary KPIs");
        writer.println("Metric,Value");
        writer.println("Occupancy Rate," + kpis.get("occupancyRate") + "%");
        writer.println("Total Revenue (LKR)," + kpis.get("totalRevenue"));
        writer.println("Total Bookings," + kpis.get("totalBookings"));
        writer.println("Cancelled Bookings," + kpis.get("cancelledBookings"));
        writer.println("Avg Stay (Nights)," + kpis.get("avgStay"));
        writer.println();
        
        writer.println("Room Type Performance");
        writer.println("Room Type,Bookings,Revenue (LKR)");
        for (Map<String, Object> row : roomPerformance) {
            writer.println(row.get("type") + "," + row.get("count") + "," + row.get("revenue"));
        }
        
        writer.flush();
        writer.close();
    }
}
