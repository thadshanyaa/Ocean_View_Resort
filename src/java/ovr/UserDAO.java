package ovr;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO implements GenericDAO<User> {
    private final Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void create(User user) {
        String sql = "INSERT INTO users (username, email, password_hash, role, is_verified) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getRole());
            stmt.setBoolean(5, user.isVerified());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE users SET username=?, email=?, password_hash=?, role=?, is_verified=?, locked_until=?, failed_attempts=? WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getRole());
            stmt.setBoolean(5, user.isVerified());
            stmt.setTimestamp(6, user.getLockedUntil());
            stmt.setInt(7, user.getFailedAttempts());
            stmt.setInt(8, user.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM users WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public int getStaffCount() {
        String sql = "SELECT COUNT(*) FROM users WHERE role != 'Guest'";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<User> getAllStaff() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role != 'Guest' ORDER BY role, username";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapRowToUser(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return users;
    }

    public List<Map<String, Object>> getStaffSchedule() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.full_name, s.position, s.department, sc.shift_start, sc.shift_end " +
                     "FROM staff s " +
                     "JOIN staff_schedules sc ON s.id = sc.staff_id " +
                     "WHERE sc.shift_date >= CURDATE() " +
                     "ORDER BY sc.shift_date, sc.shift_start";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("full_name"));
                map.put("role", rs.getString("position"));
                map.put("dept", rs.getString("department"));
                map.put("start", rs.getTime("shift_start"));
                map.put("end", rs.getTime("shift_end"));
                list.add(map);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getAttendanceLogs() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.full_name, a.check_in, a.check_out, a.status " +
                     "FROM staff s " +
                     "JOIN staff_attendance a ON s.id = a.staff_id " +
                     "ORDER BY a.check_in DESC LIMIT 100";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("full_name"));
                map.put("checkIn", rs.getTimestamp("check_in"));
                map.put("checkOut", rs.getTimestamp("check_out"));
                map.put("status", rs.getString("status"));
                list.add(map);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<java.util.Map<String, Object>> getLiveReceptionistStatus() {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.full_name, a.check_in, a.status, sc.shift_start, sc.shift_end " +
                     "FROM staff s " +
                     "JOIN staff_attendance a ON s.id = a.staff_id " +
                     "LEFT JOIN staff_schedules sc ON s.id = sc.staff_id AND sc.shift_date = CURDATE() " +
                     "WHERE s.position = 'Receptionist' AND a.check_out IS NULL " +
                     "ORDER BY a.check_in DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("name", rs.getString("full_name"));
                map.put("checkIn", rs.getTimestamp("check_in"));
                map.put("status", rs.getString("status"));
                map.put("shiftStart", rs.getTime("shift_start"));
                map.put("shiftEnd", rs.getTime("shift_end"));
                list.add(map);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setRole(rs.getString("role"));
        user.setVerified(rs.getBoolean("is_verified"));
        user.setLockedUntil(rs.getTimestamp("locked_until"));
        user.setFailedAttempts(rs.getInt("failed_attempts"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }
}
