<%@ page import="java.sql.*, ovr.*, java.util.*" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>DB Diagnostic Tool</title>
        <style>
            body {
                font-family: sans-serif;
                background: #0f172a;
                color: white;
                padding: 40px;
            }

            .success {
                color: #4ade80;
            }

            .error {
                color: #f87171;
                background: #450a0a;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid #7f1d1d;
            }

            pre {
                background: #000;
                padding: 15px;
                border-radius: 5px;
                overflow-x: auto;
            }
        </style>
    </head>

    <body>
        <h2>OVR System Diagnostic - Database Connection</h2>
        <hr>

        <% try { out.println("<p>Testing MySQL Driver... ");
            Class.forName("com.mysql.cj.jdbc.Driver");
            out.println("<span class='success'>FOUND</span></p>");

            out.println("<p>Checking DBConnectionManager configuration...");
                // Reflecting properties for visibility
                out.println("
            <ul>
                <li>Host: localhost:3306</li>
                <li>Database: ovr_db</li>
                <li>User: root</li>
            </ul>");

            out.println("<p>Attempting to connect to <b>ovr_db</b>...");
                DBConnectionManager db = DBConnectionManager.getInstance();
                Connection conn = db.getConnection();

                if (conn != null && !conn.isClosed()) {
                out.println("<span class='success'>CONNECTION SUCCESSFUL!</span></p>");

            out.println("<p>Verifying core tables...");
                String[] tables = {"users", "guests", "reservations", "elite_reservations"};
                for (String table : tables) {
                try (Statement stmt = conn.createStatement()) {
                stmt.executeQuery("SELECT 1 FROM " + table + " LIMIT 1");
                out.println("<li>Table <b>" + table + "</b>: <span class='success'>EXISTS</span></li>");
                } catch (SQLException e) {
                out.println("<li>Table <b>" + table + "</b>: <span class='error'
                        style='padding:2px; display:inline;'>MISSING</span> (" + e.getMessage() + ")</li>");
                }
                }
                } else {
                out.println("<span class='error'>CONNECTION FAILED (NULL)</span></p>");
            }

            } catch (ClassNotFoundException e) {
            out.println("<div class='error'>
                <h3>JDBC Driver Missing</h3>
                <p>Ensure mysql-connector-j-*.jar is in WEB-INF/lib</p>
            </div>");
            } catch (SQLException e) {
            out.println("<div class='error'>
                <h3>MySQL Connection Error</h3>
                <p><b>Error Message:</b> " + e.getMessage() + "</p>
                <p><b>Vendor Code:</b> " + e.getErrorCode() + "</p>
                <p><b>SQLState:</b> " + e.getSQLState() + "</p>
            </div>");
            out.println("<h4>Recommendations:</h4>");
            out.println("<ul>");
                out.println("<li>Ensure MySQL Server is running on port 3306.</li>");
                out.println("<li>Check if database 'ovr_db' exists. Run schema.sql if not.</li>");
                out.println("<li>Verify credentials (User: root, No Password) match your MySQL setup.</li>");
                out.println("</ul>");
            } catch (Exception e) {
            out.println("<div class='error'>
                <h3>Unexpected Error</h3>
                <pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>
            </div>");
            }
            %>

            <hr>
            <p><a href="login.jsp" style="color: #60a5fa;">Back to Login</a></p>
    </body>

    </html>