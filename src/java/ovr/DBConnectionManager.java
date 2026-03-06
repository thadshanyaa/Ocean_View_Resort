package ovr;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Design Pattern: Singleton
 * Purpose: Ensures only one database connection pool/configuration manager exists.
 */
public class DBConnectionManager {
    private static DBConnectionManager instance;
    private Connection connection;

    private static final String URL = "jdbc:mysql://localhost:3306/ovr_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private DBConnectionManager() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("MySQL Driver not found in classpath.", ex);
        }
    }

    public static synchronized DBConnectionManager getInstance() throws SQLException {
        if (instance == null || instance.getConnection() == null || instance.getConnection().isClosed()) {
            instance = new DBConnectionManager();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}
