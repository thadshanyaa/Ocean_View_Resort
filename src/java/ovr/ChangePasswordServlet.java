package ovr;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please+login+to+change+password");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null) {
            response.sendRedirect("changePassword.jsp?error=All+fields+are+required.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("changePassword.jsp?error=New+passwords+do+not+match.");
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            UserDAO userDAO = new UserDAO(db.getConnection());
            
            // Get fresh user from DB to ensure we have latest hash
            User user = userDAO.getById(sessionUser.getId());
            
            if (user == null) {
                response.sendRedirect("login.jsp?error=User+not+found.");
                return;
            }

            // Verify current password
            if (!SecurityUtils.checkPassword(currentPassword, user.getPasswordHash())) {
                response.sendRedirect("changePassword.jsp?error=Current+password+is+incorrect.");
                return;
            }

            // Enforce New Strict Security Policy
            if (!SecurityUtils.isValidPassword(newPassword)) {
                response.sendRedirect("changePassword.jsp?error=New+password+must+be+at+least+8+characters+and+include+uppercase,+lowercase,+number,+and+special+symbol.+No+weak+passwords.");
                return;
            }

            // Update Password
            String newHash = SecurityUtils.hashPassword(newPassword);
            user.setPasswordHash(newHash);
            userDAO.update(user);

            // Log Action
            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            auditDAO.log(user.getId(), "PASSWORD_CHANGED", "User successfully changed their password.");

            response.sendRedirect("dashboard.jsp?msg=Password+updated+successfully.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("changePassword.jsp?error=System+Error");
        }
    }
}
