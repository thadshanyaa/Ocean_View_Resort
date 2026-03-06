package ovr;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
            return;
        }

        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            UserDAO userDAO = new UserDAO(db.getConnection());
            User user = userDAO.getByUsername(userParam);

            if (user == null) {
                response.sendRedirect("login.jsp?error=Invalid+Username+or+Password");
                return;
            }

            // Check if locked
            if (user.getLockedUntil() != null && user.getLockedUntil().after(new Timestamp(System.currentTimeMillis()))) {
                response.sendRedirect("login.jsp?error=Account+Locked.+Try+again+later.");
                return;
            }
            
            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            auditDAO.log(user.getId(), "LOGIN_ATTEMPT", "Login attempt for user: " + userParam);

            if (SecurityUtils.checkPassword(passParam, user.getPasswordHash())) {
                // Success: reset failures
                user.setFailedAttempts(0);
                user.setLockedUntil(null);
                userDAO.update(user);

                HttpSession session = request.getSession();
                // session.setAttribute("user", user); // MOVED to OtpVerifyServlet.java
                
                // Set pending state for OTP flow
                session.setAttribute("pendingUserId", user.getId());
                session.removeAttribute("otp_plain_for_session"); 
                
                // Attempt to find contact number for the OTP page display
                String contact = "";
                if ("Guest".equals(user.getRole())) {
                    Guest g = new GuestDAO(db.getConnection()).getByUserId(user.getId());
                    if (g != null) {
                        contact = g.getContactNumber();
                    }
                }
                
                String redirectUrl = "otp.jsp";
                if (!contact.isEmpty()) {
                    redirectUrl += "?contact=" + java.net.URLEncoder.encode(contact, "UTF-8");
                }
                
                response.sendRedirect(redirectUrl);
            } else {
                // Fail
                int fails = user.getFailedAttempts() + 1;
                user.setFailedAttempts(fails);
                if (fails >= 3) {
                    user.setLockedUntil(new Timestamp(System.currentTimeMillis() + (10 * 60 * 1000))); // 10 mins lockout
                    auditDAO.log(user.getId(), "LOCKOUT", "User locked out due to 3 failed login attempts.");
                } else {
                    auditDAO.log(user.getId(), "LOGIN_FAILED", "Failed login attempt (" + fails + "/3).");
                }
                userDAO.update(user);
                
                if (fails >= 3) {
                    response.sendRedirect("login.jsp?error=Account+Locked.+Too+many+attempts.");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid+Username+or+Password");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            // A more descriptive error indicating DB or Server failure
            response.sendRedirect("login.jsp?error=System+Unavailable.+Please+try+again+later.");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
