package ovr;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SettingDAO {
    private final Connection connection;

    public SettingDAO(Connection connection) {
        this.connection = connection;
    }

    public String getValue(String key, String defaultValue) {
        String sql = "SELECT setting_value FROM settings WHERE setting_key = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, key);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("setting_value");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return defaultValue;
    }

    public void setValue(String key, String value) {
        String sql = "INSERT INTO settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, key);
            stmt.setString(2, value);
            stmt.setString(3, value);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Setting> getAll() {
        List<Setting> list = new ArrayList<>();
        String sql = "SELECT * FROM settings";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Setting(rs.getString("setting_key"), rs.getString("setting_value")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
