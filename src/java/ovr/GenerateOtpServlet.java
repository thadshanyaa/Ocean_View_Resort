package ovr;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/GenerateOtpServlet")
public class GenerateOtpServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        Integer pendingUserId = (Integer) session.getAttribute("pendingUserId");

        if (pendingUserId == null) {
            out.print("{\"success\": false, \"message\": \"Session expired. Please login again.\"}");
            out.flush();
            return;
        }

        String password = request.getParameter("password");
        if (password == null || password.trim().isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Password is required.\"}");
            out.flush();
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            UserDAO userDAO = new UserDAO(db.getConnection());
            User user = userDAO.getById(pendingUserId);

            if (user == null || (user.getLockedUntil() != null && user.getLockedUntil().after(new Timestamp(System.currentTimeMillis())))) {
                out.print("{\"success\": false, \"message\": \"Account unavailable or locked.\"}");
                out.flush();
                return;
            }

            // Verify the re-entered password against DB hash
            if (!SecurityUtils.checkPassword(password, user.getPasswordHash())) {
                out.print("{\"success\": false, \"message\": \"Incorrect password.\"}");
                out.flush();
                return;
            }

            // Password validated! Generate hidden OTP.
            String rawOtp = SecurityUtils.generateOTP();
            String hashedOtp = SecurityUtils.hashPassword(rawOtp);
            Timestamp expiry = new Timestamp(System.currentTimeMillis() + (5 * 60 * 1000)); // 5 mins

            OTPTokenDAO tokenDAO = new OTPTokenDAO(db.getConnection());
            tokenDAO.saveOTP(user.getId(), hashedOtp, expiry);

            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            auditDAO.log(user.getId(), "OTP_GENERATED", "OTP cleanly generated via popup verification.");

            // **CRITICAL SECURITY REQUIREMENT**
            // Store the plain OTP entirely backend in the session so the UI never sees it,
            // but the verify servlet can still crosscheck it against the hash later!
            session.setAttribute("otp_plain_for_session", rawOtp);

            // Simulation logging for Devs
            System.out.println("\n=======================================================");
            System.out.println(">>> [OFFLINE SMS SIMULATOR - POPUP GENERATED] <<<");
            System.out.println("To: User ID " + user.getId() + " (" + user.getUsername() + ")");
            System.out.println("Message: Your Ocean View Resort Hidden Code is: " + rawOtp);
            // System.out.println("Session ID mapping: " + session.getId());
            System.out.println("=======================================================\n");

            // Return success JSON to UI to trigger the masked input
            out.print("{\"success\": true, \"message\": \"OTP generated successfully.\"}");
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"System error generating OTP.\"}");
            out.flush();
        }
    }
}
