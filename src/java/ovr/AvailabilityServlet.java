package ovr;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AvailabilityServlet")
public class AvailabilityServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            RoomTypeDAO rtDao = new RoomTypeDAO(db.getConnection());
            
            List<RoomType> types = rtDao.getAll();
            request.setAttribute("roomTypes", types);
            
            // Generate minimum dates for UI
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
            java.sql.Date tomorrow = new java.sql.Date(System.currentTimeMillis() + 86400000L); // +1 day
            
            request.setAttribute("minCheckIn", today);
            request.setAttribute("minCheckOut", tomorrow);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading room types.");
        }

        request.getRequestDispatcher("availability.jsp").forward(request, response);
    }
}
