package ovr;
import java.sql.*;

public class OTPTokenDAO {
    private final Connection connection;

    public OTPTokenDAO(Connection connection) {
        this.connection = connection;
    }

    public void saveOTP(int userId, String hash, Timestamp expiry) {
        // Mark any previous unused tokens as used to expire them immediately
        String updateSql = "UPDATE otp_tokens SET used = TRUE WHERE user_id = ? AND used = FALSE";
        try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
            updateStmt.setInt(1, userId);
            updateStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String sql = "INSERT INTO otp_tokens (user_id, otp_hash, expires_at, attempts, used) VALUES (?, ?, ?, 0, FALSE)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, hash);
            stmt.setTimestamp(3, expiry);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public OTPToken getLatestUnusedToken(int userId) {
        String sql = "SELECT * FROM otp_tokens WHERE user_id = ? AND used = FALSE ORDER BY created_at DESC LIMIT 1";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OTPToken token = new OTPToken();
                    token.setId(rs.getInt("id"));
                    token.setUserId(rs.getInt("user_id"));
                    token.setOtpHash(rs.getString("otp_hash"));
                    token.setExpiresAt(rs.getTimestamp("expires_at"));
                    token.setAttempts(rs.getInt("attempts"));
                    token.setUsed(rs.getBoolean("used"));
                    token.setCreatedAt(rs.getTimestamp("created_at"));
                    return token;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateToken(OTPToken token) {
        String sql = "UPDATE otp_tokens SET attempts = ?, used = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, token.getAttempts());
            stmt.setBoolean(2, token.isUsed());
            stmt.setInt(3, token.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByUserId(int userId) {
        String sql = "DELETE FROM otp_tokens WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
