package ovr;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/NewReservationServlet")
public class NewReservationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?msg=Please+login+to+book+a+room.");
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            RoomDAO roomDao = new RoomDAO(db.getConnection());
            RoomTypeDAO rtDao = new RoomTypeDAO(db.getConnection());
            
            List<RoomType> types = rtDao.getAll();
            request.setAttribute("roomTypes", types);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading available rooms.");
        }

        request.getRequestDispatcher("newReservation.jsp").forward(request, response);
    }
}
