package ovr;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ResendOtpServlet")
public class ResendOtpServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer pendingUserId = (Integer) session.getAttribute("pendingUserId");

        if (pendingUserId == null) {
            response.sendRedirect("login.jsp?error=Session+Expired.+Please+login+again.");
            return;
        }

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            UserDAO userDAO = new UserDAO(db.getConnection());
            User user = userDAO.getById(pendingUserId);

            if (user == null || (user.getLockedUntil() != null && user.getLockedUntil().after(new Timestamp(System.currentTimeMillis())))) {
                response.sendRedirect("login.jsp?error=Account+Unavailable.");
                return;
            }

            // Generate new OTP
            String rawOtp = SecurityUtils.generateOTP();
            String hashedOtp = SecurityUtils.hashPassword(rawOtp);
            Timestamp expiry = new Timestamp(System.currentTimeMillis() + (5 * 60 * 1000)); // 5 mins

            OTPTokenDAO tokenDAO = new OTPTokenDAO(db.getConnection());
            tokenDAO.saveOTP(user.getId(), hashedOtp, expiry); // This marks previous tokens as used

            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            auditDAO.log(user.getId(), "OTP_RESENT", "A new OTP was explicitly requested and sent.");

            System.out.println("\n=======================================================");
            System.out.println(">>> [OFFLINE SMS SIMULATOR - RESEND] <<<");
            System.out.println("To: User ID " + user.getId() + " (" + user.getUsername() + ")");
            System.out.println("Message: Your NEW Ocean View Resort Verification Code is: " + rawOtp);
            System.out.println("=======================================================\n");

            response.sendRedirect("otp.jsp?msg=A+new+OTP+has+been+sent!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("otp.jsp?error=System+Error");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
