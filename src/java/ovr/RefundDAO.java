package ovr;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class RefundDAO {
    private final Connection conn;

    public RefundDAO(Connection conn) { this.conn = conn; }

    public void processRefund(int reservationId, BigDecimal amount, String reason) throws SQLException {
        String sql = "INSERT INTO refunds (reservation_id, amount, reason, refund_status, processed_at) VALUES (?, ?, ?, 'PROCESSED', NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reservationId);
            stmt.setBigDecimal(2, amount);
            stmt.setString(3, reason);
            stmt.executeUpdate();
        }
    }

    public List<Map<String, Object>> getRefundHistory() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT r.*, res.reservation_number, g.full_name " +
                     "FROM refunds r " +
                     "JOIN reservations res ON r.reservation_id = res.id " +
                     "JOIN guests g ON res.guest_id = g.id " +
                     "ORDER BY r.created_at DESC";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("resNo", rs.getString("reservation_number"));
                map.put("guestName", rs.getString("full_name"));
                map.put("amount", rs.getBigDecimal("amount"));
                map.put("reason", rs.getString("reason"));
                map.put("status", rs.getString("refund_status"));
                map.put("processedAt", rs.getTimestamp("processed_at"));
                list.add(map);
            }
        }
        return list;
    }
}
