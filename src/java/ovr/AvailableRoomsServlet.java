package ovr;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AvailableRoomsServlet")
public class AvailableRoomsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Print received parameters for debugging
        System.out.println("[AvailableRoomsServlet] Received Request");
        String roomTypeIdStr = request.getParameter("roomTypeId");
        if (roomTypeIdStr != null) roomTypeIdStr = roomTypeIdStr.trim();
        
        String checkInStr = request.getParameter("checkIn");
        if (checkInStr != null) checkInStr = checkInStr.trim();
        
        String checkOutStr = request.getParameter("checkOut");
        if (checkOutStr != null) checkOutStr = checkOutStr.trim();
        
        System.out.println("[AvailableRoomsServlet] roomTypeId=" + roomTypeIdStr + ", checkIn=" + checkInStr + ", checkOut=" + checkOutStr);

        if (roomTypeIdStr == null || roomTypeIdStr.isEmpty() || 
            checkInStr == null || checkInStr.isEmpty() || 
            checkOutStr == null || checkOutStr.isEmpty()) {
            
            String errMsg = "Missing params - type: '" + roomTypeIdStr + "', ci: '" + checkInStr + "', co: '" + checkOutStr + "'";
            System.out.println("[AvailableRoomsServlet] Error: " + errMsg);
            out.print("{\"status\":\"error\", \"message\":\"" + errMsg + "\"}");
            out.flush();
            return;
        }

        try {
            int roomTypeId = Integer.parseInt(roomTypeIdStr);
            Date checkIn = Date.valueOf(checkInStr);
            Date checkOut = Date.valueOf(checkOutStr);

            // Server-side validation
            if (!checkIn.before(checkOut)) {
                String errMsg = "Check-out date must be after check-in date.";
                System.out.println("[AvailableRoomsServlet] Validation Error: " + errMsg);
                out.print("{\"status\":\"error\", \"message\":\"" + errMsg + "\"}");
                out.flush();
                return;
            }

            DBConnectionManager db = DBConnectionManager.getInstance();
            RoomDAO roomDao = new RoomDAO(db.getConnection());
            
            // Execute the newly added rigorous availability check
            List<Room> availableRooms = roomDao.findAvailableRooms(roomTypeId, checkIn, checkOut);
            System.out.println("[AvailableRoomsServlet] SQL execute successful. Found " + availableRooms.size() + " rooms for Type ID: " + roomTypeId + " from " + checkIn + " to " + checkOut);

            StringBuilder json = new StringBuilder();
            json.append("{\"status\":\"ok\", \"message\":\"Success\", \"rooms\":[");
            for (int i = 0; i < availableRooms.size(); i++) {
                Room r = availableRooms.get(i);
                json.append("{\"id\":").append(r.getId()).append(",\"roomNumber\":\"").append(r.getRoomNumber()).append("\"}");
                if (i < availableRooms.size() - 1) json.append(",");
            }
            json.append("]}");
            
            out.print(json.toString());
        } catch (IllegalArgumentException e) {
            System.out.println("[AvailableRoomsServlet] Error: Invalid date format or numeric parsing.");
            out.print("{\"status\":\"error\", \"message\":\"Invalid parameter format.\"}");
        } catch (Exception e) {
            System.out.println("[AvailableRoomsServlet] Server Exception:");
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Internal Server Error.\"}");
        } finally {
            out.flush();
        }
    }
}
