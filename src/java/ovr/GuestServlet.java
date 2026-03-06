package ovr;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/guests/save")
public class GuestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String guestName = request.getParameter("guestName");
            String guestPhone = request.getParameter("guestPhone");
            String guestAddress = request.getParameter("guestAddress");
            
            // Assume the user creating this guest is logged in (e.g., Receptionist)
            User u = (User) request.getSession().getAttribute("user");
            int userId = u != null ? u.getId() : 0;

            if (guestName == null || guestName.trim().isEmpty() || 
                guestPhone == null || guestPhone.trim().isEmpty()) {
                out.print("{\"status\":\"error\",\"message\":\"Name and Phone are required\"}");
                return;
            }

            DBConnectionManager db = DBConnectionManager.getInstance();
            GuestDAO guestDao = new GuestDAO(db.getConnection());
            
            // Validate unique contact number
            Guest existing = guestDao.getByContactNumber(guestPhone);
            if (existing != null) {
                out.print("{\"status\":\"error\",\"message\":\"A guest with this contact number already exists.\"}");
                return;
            }
            
            Guest guest = new Guest();
            guest.setUserId(userId);
            guest.setFullName(guestName);
            guest.setContactNumber(guestPhone);
            guest.setAddress(guestAddress != null ? guestAddress : "");

            guestDao.create(guest);

            if (guest.getId() > 0) {
                out.print("{\"status\":\"success\",\"guestId\":" + guest.getId() + ",\"message\":\"Guest saved successfully.\"}");
            } else {
                out.print("{\"status\":\"error\",\"message\":\"Database failed to generate Guest ID.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"Exception: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }
}
