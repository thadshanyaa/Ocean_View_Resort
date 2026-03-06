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





@WebServlet("/HelpServlet")
public class HelpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Simple mock handler for contact form in Help page
        String query = request.getParameter("query");
        System.out.println(">>> HELP DESK RECEIVED: " + query);
        response.sendRedirect("help.jsp?msg=Your+request+has+been+received.");
    }
}
