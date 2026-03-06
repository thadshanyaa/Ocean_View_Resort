package ovr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private final Connection conn;

    public PaymentDAO(Connection conn) { this.conn = conn; }

    public void create(Payment p) throws SQLException {
        // Ensure table has paid_at column if not exists
        try (PreparedStatement check = conn.prepareStatement("ALTER TABLE payments ADD COLUMN IF NOT EXISTS paid_at TIMESTAMP NULL")) {
            check.execute();
        } catch(SQLException ignored) {}
        
        String sql = "INSERT INTO payments (bill_id, payment_method, transaction_ref, amount_paid, payment_status, paid_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, p.getBillId());
            stmt.setString(2, p.getPaymentMethod());
            stmt.setString(3, p.getTransactionRef());
            stmt.setBigDecimal(4, p.getAmountPaid());
            stmt.setString(5, p.getPaymentStatus());
            if (p.getPaidAt() != null) {
                stmt.setTimestamp(6, p.getPaidAt());
            } else {
                stmt.setNull(6, java.sql.Types.TIMESTAMP);
            }
            stmt.executeUpdate();
        }
    }

    public void update(Payment p) throws SQLException {
        // Ensure table has paid_at column if not exists
        try (PreparedStatement check = conn.prepareStatement("ALTER TABLE payments ADD COLUMN IF NOT EXISTS paid_at TIMESTAMP NULL")) {
            check.execute();
        } catch(SQLException ignored) {}
        
        String sql = "UPDATE payments SET bill_id=?, payment_method=?, transaction_ref=?, amount_paid=?, payment_status=?, paid_at=? WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, p.getBillId());
            stmt.setString(2, p.getPaymentMethod());
            stmt.setString(3, p.getTransactionRef());
            stmt.setBigDecimal(4, p.getAmountPaid());
            stmt.setString(5, p.getPaymentStatus());
            if (p.getPaidAt() != null) {
                stmt.setTimestamp(6, p.getPaidAt());
            } else {
                stmt.setNull(6, java.sql.Types.TIMESTAMP);
            }
            stmt.setInt(7, p.getId());
            stmt.executeUpdate();
        }
    }

    public Payment getById(int id) throws SQLException {
        // Ensure table has paid_at column if not exists
        try (PreparedStatement check = conn.prepareStatement("ALTER TABLE payments ADD COLUMN IF NOT EXISTS paid_at TIMESTAMP NULL")) {
            check.execute();
        } catch(SQLException ignored) {}
        
        String sql = "SELECT * FROM payments WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Payment p = new Payment();
                    p.setId(rs.getInt("id"));
                    p.setBillId(rs.getInt("bill_id"));
                    p.setPaymentMethod(rs.getString("payment_method"));
                    p.setTransactionRef(rs.getString("transaction_ref"));
                    p.setAmountPaid(rs.getBigDecimal("amount_paid"));
                    p.setPaymentStatus(rs.getString("payment_status"));
                    
                    try {
                        p.setPaidAt(rs.getTimestamp("paid_at"));
                    } catch (SQLException ignored) {} // Just in case column still doesn't exist
                    
                    return p;
                }
            }
        }
        return null;
    }

    public List<Payment> getByBillId(int billId) throws SQLException {
        ensurePaidAtColumn();
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM payments WHERE bill_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Payment p = new Payment();
                    p.setId(rs.getInt("id"));
                    p.setBillId(billId);
                    p.setPaymentMethod(rs.getString("payment_method"));
                    p.setTransactionRef(rs.getString("transaction_ref"));
                    p.setAmountPaid(rs.getBigDecimal("amount_paid"));
                    p.setPaymentStatus(rs.getString("payment_status"));
                    p.setPaidAt(rs.getTimestamp("paid_at"));
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            if (e.getMessage().toLowerCase().contains("doesn't exist")) return list;
            throw e;
        }
        return list;
    }

    private void ensurePaidAtColumn() {
        try (PreparedStatement check = conn.prepareStatement("ALTER TABLE payments ADD COLUMN IF NOT EXISTS paid_at TIMESTAMP NULL")) {
            check.execute();
        } catch (SQLException ignored) {
        }
    }

    public java.util.Map<String, Object> getAccountantKPIs() throws SQLException {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();

        String sql = "SELECT " +
                     " (SELECT IFNULL(SUM(amount_paid), 0) FROM payments WHERE DATE(paid_at) = CURDATE() AND payment_status='PAID') as today_revenue, " +
                     " (SELECT COUNT(*) FROM reservations WHERE status='Pending' OR id IN (SELECT reservation_id FROM bills b LEFT JOIN payments p ON b.id=p.bill_id GROUP BY b.id HAVING SUM(IFNULL(p.amount_paid,0)) < b.total_amount)) as pending_count, " +
                     " (SELECT IFNULL(SUM(amount_paid), 0) FROM payments WHERE payment_status='PAID') as total_revenue, " +
                     " (SELECT COUNT(*) FROM bills) as total_invoices";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("todayRevenue", rs.getBigDecimal("today_revenue"));
                stats.put("pendingCount", rs.getInt("pending_count"));
                stats.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                stats.put("totalInvoices", rs.getInt("total_invoices"));
            }
        }
        return stats;
    }

    public List<java.util.Map<String, Object>> searchPayments(String start, String end, String method, String status, String resNo) throws SQLException {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, b.reservation_id, r.reservation_number, g.full_name " +
            "FROM payments p " +
            "JOIN bills b ON p.bill_id = b.id " +
            "JOIN reservations r ON b.reservation_id = r.id " +
            "JOIN guests g ON r.guest_id = g.id " +
            "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();
        if (start != null && !start.isEmpty()) { sql.append("AND DATE(p.paid_at) >= ? "); params.add(start); }
        if (end != null && !end.isEmpty()) { sql.append("AND DATE(p.paid_at) <= ? "); params.add(end); }
        if (method != null && !method.isEmpty()) { sql.append("AND p.payment_method = ? "); params.add(method); }
        if (status != null && !status.isEmpty()) { sql.append("AND p.payment_status = ? "); params.add(status); }
        if (resNo != null && !resNo.isEmpty()) { sql.append("AND r.reservation_number LIKE ? "); params.add("%" + resNo + "%"); }

        sql.append("ORDER BY p.paid_at DESC");

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) stmt.setObject(i + 1, params.get(i));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> map = new java.util.HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("resNo", rs.getString("reservation_number"));
                    map.put("guestName", rs.getString("full_name"));
                    map.put("method", rs.getString("payment_method"));
                    map.put("ref", rs.getString("transaction_ref"));
                    map.put("amount", rs.getBigDecimal("amount_paid"));
                    map.put("status", rs.getString("payment_status"));
                    map.put("paidAt", rs.getTimestamp("paid_at"));
                    list.add(map);
                }
            }
        }
        return list;
    }

    public List<java.util.Map<String, Object>> getDailyRevenue(int days) throws SQLException {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT DATE(paid_at) as date, SUM(amount_paid) as revenue " +
                     "FROM payments WHERE payment_status='PAID' AND paid_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                     "GROUP BY DATE(paid_at) ORDER BY date ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, days);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> map = new java.util.HashMap<>();
                    map.put("date", rs.getString("date"));
                    map.put("revenue", rs.getBigDecimal("revenue"));
                    list.add(map);
                }
            }
        }
        return list;
    }
}
