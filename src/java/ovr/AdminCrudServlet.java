package ovr;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.Date;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;






@WebServlet("/AdminCrudServlet")
public class AdminCrudServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || (!"Admin".equals(admin.getRole()) && !"Manager".equals(admin.getRole()))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DBConnectionManager.getInstance().getConnection();
            RoomDAO roomDao = new RoomDAO(conn);
            UserDAO userDao = new UserDAO(conn);
            AuditLogDAO auditDao = new AuditLogDAO(conn);

            if ("addRoomType".equals(action)) {
                RoomType rt = new RoomType();
                rt.setTypeName(request.getParameter("typeName"));
                rt.setBaseRate(new java.math.BigDecimal(request.getParameter("baseRate")));
                rt.setCapacity(Integer.parseInt(request.getParameter("capacity")));
                rt.setDescription(request.getParameter("description"));
                
                new RoomTypeDAO(conn).create(rt);
                auditDao.log(admin.getId(), "ADD_ROOM_TYPE", "Created type: " + rt.getTypeName());
                response.sendRedirect("AdminPanelServlet?view=rooms&msg=Room+Type+Added");
            } 
            else if ("addRoom".equals(action)) {
                Room r = new Room();
                r.setRoomNumber(request.getParameter("roomNumber"));
                r.setRoomTypeId(Integer.parseInt(request.getParameter("roomTypeId")));
                r.setAvailable(true);
                
                roomDao.create(r);
                auditDao.log(admin.getId(), "ADD_ROOM", "Created room: " + r.getRoomNumber());
                response.sendRedirect("AdminPanelServlet?view=rooms&msg=Room+Added");
            }
            else if ("updateSetting".equals(action)) {
                String key = request.getParameter("settingKey");
                String val = request.getParameter("settingValue");
                new SettingDAO(conn).setValue(key, val);
                auditDao.log(admin.getId(), "UPDATE_SETTING", "Updated " + key + " to " + val);
                response.sendRedirect("AdminPanelServlet?view=dashboard&msg=Setting+Updated");
            }
            else if ("resetStaffPassword".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newPass = request.getParameter("newPassword");
                // In a real app, use BCrypt. Here we follow the project's existing UserDAO.update pattern if available.
                // Assuming UserDAO has a way to update password.
                User target = userDao.getById(userId);
                if (target != null) {
                    target.setPasswordHash(newPass); // UserDAO.update should handle this
                    userDao.update(target);
                    auditDao.log(admin.getId(), "RESET_PASSWORD", "Reset password for: " + target.getUsername());
                    response.sendRedirect("AdminPanelServlet?view=staff&msg=Password+Reset+Success");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminPanelServlet?view=dashboard&error=Operation+Failed");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || (!"Admin".equals(admin.getRole()) && !"Manager".equals(admin.getRole()))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = DBConnectionManager.getInstance().getConnection();
            RoomDAO roomDao = new RoomDAO(conn);
            UserDAO userDao = new UserDAO(conn);
            AuditLogDAO auditDao = new AuditLogDAO(conn);

            if ("deleteRoom".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Room r = roomDao.getById(id);
                if (roomDao.hasFutureBookings(id)) {
                    response.sendRedirect("AdminPanelServlet?view=rooms&error=Cannot+delete+room+with+future+bookings");
                } else {
                    roomDao.delete(id);
                    auditDao.log(admin.getId(), "DELETE_ROOM", "Deleted room: " + (r != null ? r.getRoomNumber() : id));
                    response.sendRedirect("AdminPanelServlet?view=rooms&msg=Room+Deleted");
                }
            }
            else if ("toggleStaffStatus".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("id"));
                User target = userDao.getById(userId);
                if (target != null) {
                    target.setVerified(!target.isVerified());
                    userDao.update(target);
                    auditDao.log(admin.getId(), "TOGGLE_STAFF", (target.isVerified() ? "Enabled" : "Disabled") + " account: " + target.getUsername());
                    response.sendRedirect("AdminPanelServlet?view=staff&msg=Staff+Status+Updated");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminPanelServlet?view=dashboard&error=Operation+Failed");
        }
    }
}
