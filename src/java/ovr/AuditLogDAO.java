package ovr;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuditLogDAO {
    private final Connection connection;

    public AuditLogDAO(Connection connection) {
        this.connection = connection;
    }

    public void log(Integer userId, String action, String details) {
        String sql = "INSERT INTO audit_logs (user_id, action, details) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (userId == null) {
                stmt.setNull(1, Types.INTEGER);
            } else {
                stmt.setInt(1, userId);
            }
            stmt.setString(2, action);
            stmt.setString(3, details);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<AuditLog> getRecentLogs(int limit) {
        List<AuditLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM audit_logs ORDER BY timestamp DESC LIMIT ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    AuditLog log = new AuditLog();
                    log.setId(rs.getInt("id"));
                    int userId = rs.getInt("user_id");
                    if (rs.wasNull()) {
                        log.setUserId(null);
                    } else {
                        log.setUserId(userId);
                    }
                    log.setAction(rs.getString("action"));
                    log.setDetails(rs.getString("details"));
                    log.setTimestamp(rs.getTimestamp("timestamp"));
                    logs.add(log);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }
}
