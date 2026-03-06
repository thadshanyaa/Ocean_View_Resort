package ovr;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.sql.Date;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;








@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("availability".equals(action)) {
            checkAvailability(request, response);
        } else if ("search".equals(action)) {
            searchReservation(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("book".equals(action)) {
            bookRoom(request, response);
        }
    }

    private void checkAvailability(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int roomTypeId = Integer.parseInt(request.getParameter("roomTypeId"));
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));

            DBConnectionManager db = DBConnectionManager.getInstance();
            ReservationRepository repo = new ReservationRepository(db.getConnection());
            List<Room> available = repo.getAvailableRoomsByDateAndType(roomTypeId, checkIn, checkOut);
            
            // Simple JSON response manually crafted or using Gson if available.
            // Using manual JSON string building to avoid missing dependency errors.
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            StringBuilder json = new StringBuilder("[");
            for (int i=0; i<available.size(); i++) {
                Room r = available.get(i);
                json.append("{\"id\":").append(r.getId()).append(",\"roomNumber\":\"").append(r.getRoomNumber()).append("\"}");
                if(i < available.size() - 1) json.append(",");
            }
            json.append("]");
            out.print(json.toString());
            out.flush();
        } catch(Exception e) {
            e.printStackTrace();
            response.sendError(500, "Server Error");
        }
    }

    private void bookRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String savedGuestIdStr = request.getParameter("savedGuestId");
            int savedGuestId = (savedGuestIdStr != null && !savedGuestIdStr.isEmpty()) ? Integer.parseInt(savedGuestIdStr) : 0;
            
            String guestName = request.getParameter("guestName");
            String guestPhone = request.getParameter("guestPhone");
            String guestAddress = request.getParameter("guestAddress");
            String[] services = request.getParameterValues("services");

            // Normalize empty strings
            if (guestName != null && guestName.trim().isEmpty()) guestName = null;

            DBConnectionManager db = DBConnectionManager.getInstance();
            BookingFacade facade = new BookingFacade(db.getConnection());
            Reservation res = facade.bookRoom(userId, savedGuestId, guestName, guestPhone, guestAddress, roomId, checkIn, checkOut, services);
            System.out.println("[ReservationServlet] Created resNum: " + res.getReservationNumber());
            String encodedResNum = java.net.URLEncoder.encode(res.getReservationNumber(), "UTF-8");
            String redirectUrl = "ReservationDetailsServlet?reservationNumber=" + encodedResNum + "&msg=Booking+Confirmed";
            System.out.println("[ReservationServlet] Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("newReservation.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private void searchReservation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String resNum = request.getParameter("reservationNumber");
        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            ReservationDAO dao = new ReservationDAO(db.getConnection());
            Reservation res = dao.getByReservationNumber(resNum);
            if (res != null) {
                response.sendRedirect("ReservationDetailsServlet?reservationNumber=" + resNum);
            } else {
                response.sendRedirect("searchReservation.jsp?error=Reservation+Not+Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("searchReservation.jsp?error=System+Error");
        }
    }
}
