package ovr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class AdditionalChargeDAO {
    private final Connection conn;

    public AdditionalChargeDAO(Connection conn) {
        this.conn = conn;
    }

    public void create(AdditionalCharge charge) throws SQLException {
        // Create table if not exists ensuring reliability during insert
        String createTable = "CREATE TABLE IF NOT EXISTS additional_charges (" +
                             "id INT AUTO_INCREMENT PRIMARY KEY, " +
                             "reservation_id INT NOT NULL, " +
                             "category VARCHAR(50), " +
                             "item_name VARCHAR(100), " +
                             "unit_price DECIMAL(10,2), " +
                             "qty INT, " +
                             "total_price DECIMAL(10,2), " +
                             "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                             ")";
        try (PreparedStatement stmt1 = conn.prepareStatement(createTable)) {
            stmt1.execute();
        }

        String sql = "INSERT INTO additional_charges (reservation_id, category, item_name, unit_price, qty, total_price) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, charge.getReservationId());
            stmt.setString(2, charge.getCategory());
            stmt.setString(3, charge.getItemName());
            stmt.setBigDecimal(4, charge.getUnitPrice());
            stmt.setInt(5, charge.getQty());
            stmt.setBigDecimal(6, charge.getTotalPrice());
            stmt.executeUpdate();
        }
    }

    public List<AdditionalCharge> getByReservationId(int reservationId) throws SQLException {
        List<AdditionalCharge> list = new ArrayList<>();
        // If table doesn't exist, we must prevent crashing by checking first. 
        // We'll safely just try to select
        String sql = "SELECT * FROM additional_charges WHERE reservation_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reservationId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    AdditionalCharge c = new AdditionalCharge();
                    c.setId(rs.getInt("id"));
                    c.setReservationId(rs.getInt("reservation_id"));
                    c.setCategory(rs.getString("category"));
                    c.setItemName(rs.getString("item_name"));
                    c.setUnitPrice(rs.getBigDecimal("unit_price"));
                    c.setQty(rs.getInt("qty"));
                    c.setTotalPrice(rs.getBigDecimal("total_price"));
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            // Table might not exist yet if no inserts have been made
            if (e.getMessage().toLowerCase().contains("doesn't exist")) {
                return list;
            }
            throw e;
        }
        return list;
    }
}
