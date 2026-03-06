package ovr;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Date;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;







@WebFilter("/*")
public class AuthFilter implements Filter {

    public void init(FilterConfig fConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        
        // Exclude public paths
        // We allow css, js, images to pass.
        if (uri.endsWith("login.jsp") || uri.endsWith("register.jsp") || uri.endsWith("otp.jsp") 
            || uri.endsWith("AuthServlet") || uri.endsWith("RegisterServlet") 
            || uri.endsWith("GenerateOtpServlet") || uri.endsWith("OtpVerifyServlet") || uri.endsWith("ResendOtpServlet")
            || uri.endsWith("AvailableRoomsServlet") || uri.contains("/api/guests/save")
            || uri.endsWith("index.jsp") || uri.equals(req.getContextPath() + "/") || uri.endsWith(".css") || uri.endsWith(".js")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("user") != null;

        if (!loggedIn) {
            String targetURL = req.getRequestURI();
            String queryString = req.getQueryString();
            if (queryString != null) {
                targetURL += "?" + queryString;
            }
            session = req.getSession(true); // Ensure session exists to store target
            session.setAttribute("targetURL", targetURL);
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // --- Advanced Role-Based Path Protection Matrix ---
        String r = user.getRole();
        
        boolean isAdminPath = uri.endsWith("adminPanel.jsp") || uri.endsWith("AdminCrudServlet") || uri.endsWith("AdminPanelServlet");
        boolean isOperationalPath = uri.endsWith("newReservation.jsp") || uri.endsWith("availability.jsp") 
                                 || uri.endsWith("searchReservation.jsp") || uri.endsWith("ReservationServlet")
                                 || uri.endsWith("NewReservationServlet") || uri.endsWith("AvailabilityServlet") 
                                 || uri.endsWith("ReservationDetailsServlet") || uri.endsWith("AvailableRoomsServlet");
        boolean isBillingPath = uri.endsWith("billingInvoice.jsp") || uri.endsWith("BillingServlet") 
                             || uri.endsWith("PaymentServlet") || uri.endsWith("BillingInvoiceServlet");

        // 1. MANAGER: God Mode. Bypass all path restrictions.
        if ("Manager".equals(r)) {
            chain.doFilter(request, response);
            return;
        }

        // 2. ADMIN: Full Operational & Billing access + exclusive Admin Panel access
        if ("Admin".equals(r)) {
            // Admins can go anywhere.
            chain.doFilter(request, response);
            return;
        }

        // 3. RESTRICT NON-ADMINS FROM ADMIN PATHS
        if (isAdminPath) {
            res.sendRedirect(req.getContextPath() + "/DashboardServlet?error=Access+Denied.+Requires+Admin.");
            return;
        }

        // 4. ACCOUNTANT: Restricted against Operational booking paths
        if ("Accountant".equals(r)) {
            if (isOperationalPath) {
                res.sendRedirect(req.getContextPath() + "/DashboardServlet?error=Access+Denied.+Accountants+manage+finance.");
                return;
            }
        }

        // 4. RECEPTIONIST: Operational & Billing allowed. (No finance PDFs checked later in Servlet)
        // (Handled implicitly since Admin paths are blocked above)

        // 5. GUEST: Restrict cross-guest data viewing (mostly handled in Servlets),
        // but broadly we can let them access basic endpoints. Wait, Guests shouldn't access "searchReservation.jsp" which is for staff.
        // 5. GUEST: Restrict cross-guest data viewing (mostly handled in Servlets),
        // but broadly we can let them access basic endpoints. Wait, Guests shouldn't access "searchReservation.jsp" which is for staff.
        if ("Guest".equals(r)) {
            if (uri.endsWith("searchReservation.jsp")) {
                 res.sendRedirect(req.getContextPath() + "/DashboardServlet?error=Access+Denied.+Staff+Only.");
                 return;
            }
        }

        chain.doFilter(request, response);
    }

    public void destroy() {}
}
