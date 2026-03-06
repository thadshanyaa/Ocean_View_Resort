package ovr;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/OtpVerifyServlet")
public class OtpVerifyServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer pendingUserId = (Integer) session.getAttribute("pendingUserId");

        if (pendingUserId == null) {
            response.sendRedirect("login.jsp?error=Session+Expired.+Please+login+again.");
            return;
        }

        // We completely ignore the dummy HTML input parameter "otp" 
        // string passed from the UI (which is just '••••••' dots anyway).
        
        // Fetch the REAL plain text OTP from the backend server session
        String hiddenSessionOtp = (String) session.getAttribute("otp_plain_for_session");
        if (hiddenSessionOtp == null || hiddenSessionOtp.trim().isEmpty()) {
             response.sendRedirect("otp.jsp?error=No+OTP+generated.+Please+click+Resend+to+verify+password.");
             return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            OTPTokenDAO tokenDAO = new OTPTokenDAO(db.getConnection());
            UserDAO userDAO = new UserDAO(db.getConnection());
            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            
            User user = userDAO.getById(pendingUserId);
            if (user == null) {
                response.sendRedirect("login.jsp?error=Invalid+User");
                return;
            }

            // Check if user is locked
            if (user.getLockedUntil() != null && user.getLockedUntil().after(new Timestamp(System.currentTimeMillis()))) {
                response.sendRedirect("login.jsp?error=Account+Locked.+Too+many+failed+OTP+attempts.");
                return;
            }

            OTPToken token = tokenDAO.getLatestUnusedToken(pendingUserId);

            if (token == null) {
                response.sendRedirect("otp.jsp?error=No+active+OTP+found.+Please+generate+a+new+one.");
                return;
            }

            // Check expiry
            if (token.getExpiresAt().before(new Timestamp(System.currentTimeMillis()))) {
                response.sendRedirect("otp.jsp?error=OTP+Expired.+Please+request+a+new+one.");
                return;
            }

            // Verify BCrypt hash against the HIDDEN SESSION OTP, not user input
            if (SecurityUtils.checkPassword(hiddenSessionOtp, token.getOtpHash())) {
                // Success!
                token.setUsed(true);
                tokenDAO.updateToken(token);

                if (!user.isVerified()) {
                    user.setVerified(true);
                }
                user.setFailedAttempts(0);
                user.setLockedUntil(null);
                userDAO.update(user);

                auditDAO.log(user.getId(), "OTP_SUCCESS", "Hidden Session OTP successfully verified.");

                // Actual Login
                session.removeAttribute("pendingUserId");
                session.removeAttribute("otp_plain_for_session"); // Clean up sensitive var!
                
                // The dashboard and header JSPs expect the full User object in the session!
                session.setAttribute("user", user);
                // Also setting these for legacy support if any other older pages expected them
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());

                auditDAO.log(user.getId(), "USER_LOGIN", "User logged in after hidden OTP verification.");
                
                String targetURL = (String) session.getAttribute("targetURL");
                if (targetURL != null) {
                    session.removeAttribute("targetURL");
                    response.sendRedirect(targetURL);
                } else {
                    // Role-Based Redirection
                    String role = user.getRole();
                    if ("Manager".equals(role)) {
                        response.sendRedirect("ManagerDashboardServlet");
                    } else if ("Accountant".equals(role)) {
                        response.sendRedirect("AccountantDashboardServlet");
                    } else if ("Admin".equals(role)) {
                        response.sendRedirect("AdminPanelServlet?view=dashboard");
                    } else if ("Guest".equals(role)) {
                        response.sendRedirect("DashboardServlet");
                    } else {
                        response.sendRedirect("DashboardServlet");
                    }
                }
            } else {
                // Fail
                int fails = token.getAttempts() + 1;
                token.setAttempts(fails);
                
                if (fails >= 3) {
                    token.setUsed(true); // Invalidate token
                    user.setLockedUntil(new Timestamp(System.currentTimeMillis() + (10 * 60 * 1000))); // 10 min lock
                    userDAO.update(user);
                    auditDAO.log(user.getId(), "OTP_LOCKOUT", "User locked out due to 3 failed OTP attempts.");
                    tokenDAO.updateToken(token);
                    session.removeAttribute("otp_plain_for_session");
                    response.sendRedirect("login.jsp?error=Account+Locked+for+10+minutes.");
                } else {
                    auditDAO.log(user.getId(), "OTP_FAILED", "Failed OTP attempt (" + fails + "/3).");
                    tokenDAO.updateToken(token);
                    session.removeAttribute("otp_plain_for_session"); // Force re-gen on failure
                    response.sendRedirect("otp.jsp?error=Invalid+Internal+OTP.+Attempt+" + fails + "+of+3.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("otp.jsp?error=System+Error");
        }
    }
}
