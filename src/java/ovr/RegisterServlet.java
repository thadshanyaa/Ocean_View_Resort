package ovr;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");
        
        String requestedRole = request.getParameter("role");
        String authCode = request.getParameter("authCode");
        String roleParam = "Guest"; // Fallback default
        
        // Strict Role Constraints
        if (requestedRole != null && (requestedRole.equals("Admin") || requestedRole.equals("Manager") || 
            requestedRole.equals("Receptionist") || requestedRole.equals("Accountant"))) {
            
            // Backend Enforcement of Authorization Code
            if (!"OVR1234".equals(authCode)) {
                response.sendRedirect("register.jsp?error=Invalid+Authorization+Code+for+Role");
                return;
            }
            roleParam = requestedRole; // Upgrade role if authorized
        }
        
        String fullName = request.getParameter("fullName");
        String contact = request.getParameter("contactNumber");
        String address = request.getParameter("address");

        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            UserDAO userDAO = new UserDAO(db.getConnection());
            
            // Backend Security Policy Enforcement
            if (!SecurityUtils.isValidPassword(passParam)) {
                response.sendRedirect("register.jsp?error=Password+must+be+at+least+8+characters+and+include+uppercase,+lowercase,+number,+and+special+symbol.+No+weak+passwords.");
                return;
            }

            if (userDAO.getByUsername(userParam) != null) {
                response.sendRedirect("register.jsp?error=Username+Already+Exists");
                return;
            }

            // Create User Document
            User user = new User();
            user.setUsername(userParam);
            user.setPasswordHash(SecurityUtils.hashPassword(passParam)); // Uses BCrypt now!
            user.setRole(roleParam);
            user.setVerified(false); // MUST verify via OTP on first login
            userDAO.create(user);

            // Create Guest Profile dynamically to prevent NOT NULL Exceptions if fields are empty
            GuestDAO guestDAO = new GuestDAO(db.getConnection());
            Guest guest = new Guest();
            guest.setUserId(user.getId());
            guest.setFullName(fullName != null && !fullName.trim().isEmpty() ? fullName : userParam);
            guest.setContactNumber(contact != null && !contact.trim().isEmpty() ? contact : "0000000000");
            guest.setAddress(address != null && !address.trim().isEmpty() ? address : "System User");
            guestDAO.create(guest);

            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            auditDAO.log(user.getId(), "USER_REGISTERED", "User registered: " + userParam);

            // Per new requirements: Redirect directly to login with success message. Let the Login
            // flow handle the OTP generation and verification modal.
            response.sendRedirect("login.jsp?msg=Registration+Successful.+Please+login+to+continue.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=System+Error");
        }
    }
}
