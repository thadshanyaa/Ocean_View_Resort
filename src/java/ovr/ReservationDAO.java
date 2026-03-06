package ovr;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReservationDAO implements GenericDAO<Reservation> {
    private final Connection connection;

    public ReservationDAO(Connection connection) {
        this.connection = connection;
    }

    public ReservationDAO() {
        this.connection = null;
    }

    @Override
    public void create(Reservation res) {
        if (res.getGuestId() <= 0) {
            throw new RuntimeException("Guest details missing");
        }
        
        // Explicitly check if guest exists to prevent FK violation
        String checkGuestSql = "SELECT id FROM guests WHERE id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkGuestSql)) {
            checkStmt.setInt(1, res.getGuestId());
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (!rs.next()) {
                    throw new RuntimeException("Guest details missing");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error verifying guest: " + e.getMessage(), e);
        }

        String sql = "INSERT INTO reservations (reservation_number, guest_id, room_id, check_in, check_out, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, res.getReservationNumber());
            stmt.setInt(2, res.getGuestId());
            stmt.setInt(3, res.getRoomId());
            stmt.setDate(4, res.getCheckIn());
            stmt.setDate(5, res.getCheckOut());
            stmt.setString(6, res.getStatus());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    res.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB Insert failed: " + e.getMessage(), e);
        }
    }

    @Override
    public Reservation getById(int id) {
        String sql = "SELECT * FROM reservations WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToReservation(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Reservation getByReservationNumber(String resNumber) {
        if (resNumber == null || resNumber.trim().isEmpty()) return null;
        resNumber = resNumber.trim();
        System.out.println("[DAO] Querying reservation: '" + resNumber + "'");
        
        boolean isNumeric = resNumber.matches("\\d+");
        String sql = isNumeric ? 
            "SELECT * FROM reservations WHERE id = ? OR reservation_number = ?" :
            "SELECT * FROM reservations WHERE reservation_number = ?";
            
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (isNumeric) {
                stmt.setInt(1, Integer.parseInt(resNumber));
                stmt.setString(2, resNumber);
            } else {
                stmt.setString(1, resNumber);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("[DAO] Reservation found exact match: " + resNumber);
                    return mapRowToReservation(rs);
                } else {
                    System.out.println("[DAO] Reservation not found exactly for: " + resNumber);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("[DAO] Exact match not found, trying fallback LIKE");
        String fallbackSql = "SELECT * FROM reservations WHERE reservation_number LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(fallbackSql)) {
            stmt.setString(1, "%" + resNumber + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("[DAO] Reservation found via LIKE: " + resNumber);
                    return mapRowToReservation(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        System.out.println("[DAO] Reservation completely not found: " + resNumber);
        return null;
    }

    @Override
    public void update(Reservation res) {
        String sql = "UPDATE reservations SET reservation_number=?, guest_id=?, room_id=?, check_in=?, check_out=?, status=? WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, res.getReservationNumber());
            stmt.setInt(2, res.getGuestId());
            stmt.setInt(3, res.getRoomId());
            stmt.setDate(4, res.getCheckIn());
            stmt.setDate(5, res.getCheckOut());
            stmt.setString(6, res.getStatus());
            stmt.setInt(7, res.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM reservations WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Reservation mapRowToReservation(ResultSet rs) throws SQLException {
        Reservation res = new Reservation();
        res.setId(rs.getInt("id"));
        res.setReservationNumber(rs.getString("reservation_number"));
        res.setGuestId(rs.getInt("guest_id"));
        res.setRoomId(rs.getInt("room_id"));
        res.setCheckIn(rs.getDate("check_in"));
        res.setCheckOut(rs.getDate("check_out"));
        res.setStatus(rs.getString("status"));
        res.setCreatedAt(rs.getTimestamp("created_at"));
        return res;
    }

    public java.util.Map<String, Object> getSummaryStats() {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        String sqlActive = "SELECT COUNT(*) FROM reservations WHERE status != 'CANCELLED'";
        String sqlPaid = "SELECT SUM(amount_paid) FROM payments WHERE payment_status = 'PAID'";
        
        try {
            try (PreparedStatement stmt = connection.prepareStatement(sqlActive);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) stats.put("activeCount", rs.getInt(1));
            }
            try (PreparedStatement stmt = connection.prepareStatement(sqlPaid);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) stats.put("totalPaid", rs.getBigDecimal(1) != null ? rs.getBigDecimal(1) : new java.math.BigDecimal(0));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public java.util.Map<String, Object> getExtendedGuestStats(int guestId) {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        String sqlActive = "SELECT COUNT(*) FROM reservations WHERE guest_id = ? AND status != 'CANCELLED'";
        String sqlPaidTotal = "SELECT SUM(p.amount_paid) FROM payments p " +
                              "JOIN bills b ON p.bill_id = b.id " +
                              "JOIN reservations r ON b.reservation_id = r.id " +
                              "WHERE r.guest_id = ? AND p.payment_status = 'PAID'";
        
        String sqlGrandTotal = "SELECT SUM(b.total_amount + IFNULL((SELECT SUM(ac.total_price) FROM additional_charges ac WHERE ac.reservation_id = r.id), 0)) " +
                               "FROM reservations r " +
                               "JOIN bills b ON r.id = b.reservation_id " +
                               "WHERE r.guest_id = ? AND r.status != 'CANCELLED'";

        String sqlServices = "SELECT COUNT(*) FROM additional_charges ac " +
                              "JOIN reservations r ON ac.reservation_id = r.id " +
                              "WHERE r.guest_id = ? AND r.status != 'CANCELLED'";

        String sqlActiveId = "SELECT id FROM reservations WHERE guest_id = ? AND status != 'CANCELLED' ORDER BY created_at DESC LIMIT 1";
        
        try {
            // Count active
            try (PreparedStatement stmt = connection.prepareStatement(sqlActive)) {
                stmt.setInt(1, guestId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) stats.put("activeCount", rs.getInt(1));
                }
            }
            // Sum paid
            double totalPaid = 0.0;
            try (PreparedStatement stmt = connection.prepareStatement(sqlPaidTotal)) {
                stmt.setInt(1, guestId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) totalPaid = rs.getDouble(1);
                }
            }
            stats.put("totalPaid", new java.math.BigDecimal(totalPaid));

            // Sum grand total & calculate pending balance
            double grandTotal = 0.0;
            try (PreparedStatement stmt = connection.prepareStatement(sqlGrandTotal)) {
                stmt.setInt(1, guestId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) grandTotal = rs.getDouble(1);
                }
            }
            stats.put("pendingTotal", new java.math.BigDecimal(Math.max(0.0, grandTotal - totalPaid)));
            // Count services
            try (PreparedStatement stmt = connection.prepareStatement(sqlServices)) {
                stmt.setInt(1, guestId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) stats.put("serviceCount", rs.getInt(1));
                }
            }
            // Get most recent reservation ID
            try (PreparedStatement stmt = connection.prepareStatement(sqlActiveId)) {
                stmt.setInt(1, guestId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) stats.put("activeResId", rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public List<java.util.Map<String, Object>> getReservationsByGuest(int guestId) {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT r.*, rm.room_number, rt.type_name, b.total_amount as room_total, " +
                     "(b.total_amount + IFNULL((SELECT SUM(ac.total_price) FROM additional_charges ac WHERE ac.reservation_id = r.id), 0)) as grand_total, " +
                     "IFNULL((SELECT SUM(p.amount_paid) FROM payments p WHERE p.bill_id = b.id AND p.payment_status = 'PAID'), 0) as total_paid, " +
                     "(SELECT GROUP_CONCAT(ac.item_name SEPARATOR ', ') FROM additional_charges ac WHERE ac.reservation_id = r.id) as services " +
                     "FROM reservations r " +
                     "JOIN rooms rm ON r.room_id = rm.id " +
                     "JOIN room_types rt ON rm.room_type_id = rt.id " +
                     "LEFT JOIN bills b ON r.id = b.reservation_id " +
                     "WHERE r.guest_id = ? " +
                     "ORDER BY r.created_at DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, guestId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> map = new java.util.HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("resNo", rs.getString("reservation_number"));
                    map.put("checkIn", rs.getDate("check_in"));
                    map.put("checkOut", rs.getDate("check_out"));
                    map.put("roomInfo", rs.getString("type_name") + " (Room " + rs.getString("room_number") + ")");
                    double grandTotal = rs.getDouble("grand_total");
                    double roomTotal = rs.getDouble("room_total");
                    double paid = rs.getDouble("total_paid");

                    map.put("total", new java.math.BigDecimal(grandTotal));
                    map.put("status", rs.getString("status"));

                    // Granular Payment Status Logic
                    String payStatus = "PENDING";
                    if (paid >= grandTotal && grandTotal > 0) {
                        payStatus = "PAID";
                    } else if (paid >= roomTotal && roomTotal > 0) {
                        payStatus = "PARTIALLY PAID";
                    }
                    map.put("paymentStatus", payStatus);
                    map.put("services", rs.getString("services") != null ? rs.getString("services") : "None");
                    list.add(map);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE reservations SET status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<java.util.Map<String, Object>> getRecentReservations(int limit, String search) {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT r.*, g.full_name, rm.room_number, rt.type_name, b.total_amount, " +
            "(b.total_amount + IFNULL((SELECT SUM(ac.total_price) FROM additional_charges ac WHERE ac.reservation_id = r.id), 0)) as grand_total, " +
            "(SELECT p.payment_status FROM payments p WHERE p.bill_id = b.id ORDER BY p.paid_at DESC LIMIT 1) as payment_status, " +
            "(SELECT GROUP_CONCAT(ac.item_name SEPARATOR ', ') FROM additional_charges ac WHERE ac.reservation_id = r.id) as services " +
            "FROM reservations r " +
            "JOIN guests g ON r.guest_id = g.id " +
            "JOIN rooms rm ON r.room_id = rm.id " +
            "JOIN room_types rt ON rm.room_type_id = rt.id " +
            "LEFT JOIN bills b ON r.id = b.reservation_id "
        );

        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE r.reservation_number LIKE ? OR g.full_name LIKE ? ");
        }
        sql.append("ORDER BY r.created_at DESC LIMIT ?");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIdx = 1;
            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(paramIdx++, "%" + search + "%");
                stmt.setString(paramIdx++, "%" + search + "%");
            }
            stmt.setInt(paramIdx, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> map = new java.util.HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("resNo", rs.getString("reservation_number"));
                    map.put("guestName", rs.getString("full_name"));
                    map.put("checkIn", rs.getDate("check_in"));
                    map.put("checkOut", rs.getDate("check_out"));
                    map.put("roomInfo", rs.getString("type_name") + " (Room " + rs.getString("room_number") + ")");
                    map.put("total", rs.getBigDecimal("grand_total") != null ? rs.getBigDecimal("grand_total") : new java.math.BigDecimal(0));
                    map.put("status", rs.getString("payment_status") != null ? rs.getString("payment_status") : "PENDING");
                    map.put("services", rs.getString("services") != null ? rs.getString("services") : "None");
                    list.add(map);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public Map<String, Object> getManagerKPIs(String start, String end, String roomTypeId, String status, String payStatus) {
        Map<String, Object> stats = new HashMap<>();
        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "  COUNT(DISTINCT r.id) as total_bookings, " +
            "  SUM(CASE WHEN r.status = 'CANCELLED' THEN 1 ELSE 0 END) as cancelled_bookings, " +
            "  SUM(IFNULL(b.total_amount, 0) + IFNULL((SELECT SUM(ac.total_price) FROM additional_charges ac WHERE ac.reservation_id = r.id), 0)) as total_revenue, " +
            "  AVG(DATEDIFF(r.check_out, r.check_in)) as avg_stay " +
            "FROM reservations r " +
            "JOIN rooms rm ON r.room_id = rm.id " +
            "LEFT JOIN bills b ON r.id = b.reservation_id " +
            "LEFT JOIN payments p ON b.id = p.bill_id " +
            "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();
        if (start != null && !start.isEmpty()) { sql.append("AND r.check_in >= ? "); params.add(start); }
        if (end != null && !end.isEmpty()) { sql.append("AND r.check_in <= ? "); params.add(end); }
        if (roomTypeId != null && !roomTypeId.isEmpty()) { sql.append("AND rm.room_type_id = ? "); params.add(roomTypeId); }
        if (status != null && !status.isEmpty()) { sql.append("AND r.status = ? "); params.add(status); }
        if (payStatus != null && !payStatus.isEmpty()) { sql.append("AND p.payment_status = ? "); params.add(payStatus); }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) stmt.setObject(i + 1, params.get(i));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalBookings", rs.getInt("total_bookings"));
                    stats.put("cancelledBookings", rs.getInt("cancelled_bookings"));
                    stats.put("totalRevenue", rs.getBigDecimal("total_revenue") != null ? rs.getBigDecimal("total_revenue") : BigDecimal.ZERO);
                    stats.put("avgStay", rs.getBigDecimal("avg_stay") != null ? rs.getBigDecimal("avg_stay").doubleValue() : 0.0);
                }
            }
            
            // Occupancy Rate Calculation
            String occSql = "SELECT (COUNT(DISTINCT r.id) * 100.0 / (SELECT GREATEST(COUNT(*), 1) FROM rooms)) as occupancy_rate " +
                           "FROM reservations r WHERE r.status NOT IN ('Pending', 'Cancelled') ";
            if (start != null && !start.isEmpty()) occSql += "AND r.check_in >= '" + start + "' ";
            if (end != null && !end.isEmpty()) occSql += "AND r.check_in <= '" + end + "' ";
            
            try (Statement s = connection.createStatement(); ResultSet rsOcc = s.executeQuery(occSql)) {
                if (rsOcc.next()) stats.put("occupancyRate", rsOcc.getDouble(1));
                else stats.put("occupancyRate", 0.0);
            } catch (SQLException e) {
                stats.put("occupancyRate", 0.0);
            }
            
        } catch (SQLException e) { 
            e.printStackTrace(); 
            stats.put("totalBookings", 0);
            stats.put("cancelledBookings", 0);
            stats.put("totalRevenue", BigDecimal.ZERO);
            stats.put("avgStay", 0.0);
            stats.put("occupancyRate", 0.0);
        }
        return stats;
    }

    public List<Map<String, Object>> getOccupancyTrend(String start, String end) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(check_in, '%Y-%m-%d') as date, COUNT(*) as count " +
                     "FROM reservations WHERE status NOT IN ('Pending', 'Cancelled') " +
                     "AND check_in BETWEEN ? AND ? GROUP BY date ORDER BY date ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, start);
            stmt.setString(2, end);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("label", rs.getString("date"));
                    map.put("value", rs.getInt("count"));
                    list.add(map);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getRevenueTrend(String start, String end) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(p.payment_date, '%Y-%m-%d') as date, SUM(p.amount_paid) as revenue " +
                     "FROM payments p WHERE p.payment_status = 'PAID' " +
                     "AND p.payment_date BETWEEN ? AND ? GROUP BY date ORDER BY date ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(start + " 00:00:00"));
            stmt.setTimestamp(2, Timestamp.valueOf(end + " 23:59:59"));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("label", rs.getString("date"));
                    map.put("value", rs.getBigDecimal("revenue"));
                    list.add(map);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getRoomTypePerformance(String start, String end) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT rt.type_name, COUNT(r.id) as count, SUM(b.total_amount) as revenue " +
                     "FROM reservations r " +
                     "JOIN rooms rm ON r.room_id = rm.id " +
                     "JOIN room_types rt ON rm.room_type_id = rt.id " +
                     "LEFT JOIN bills b ON r.id = b.reservation_id " +
                     "WHERE r.check_in BETWEEN ? AND ? " +
                     "GROUP BY rt.type_name ORDER BY revenue DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, start);
            stmt.setString(2, end);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("type", rs.getString("type_name"));
                    map.put("count", rs.getInt("count"));
                    map.put("revenue", rs.getBigDecimal("revenue"));
                    list.add(map);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Map<String, Object> getGuestStats(String start, String end) {
        Map<String, Object> stats = new HashMap<>();
        // New Guests vs Returning
        String sql = "SELECT " +
                     "SUM(CASE WHEN visit_count = 1 THEN 1 ELSE 0 END) as new_guests, " +
                     "SUM(CASE WHEN visit_count > 1 THEN 1 ELSE 0 END) as returning_guests " +
                     "FROM (SELECT guest_id, COUNT(*) as visit_count FROM reservations " +
                     "WHERE check_in BETWEEN ? AND ? GROUP BY guest_id) as guest_counts";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, start);
            stmt.setString(2, end);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("newGuests", rs.getInt("new_guests"));
                    stats.put("returningGuests", rs.getInt("returning_guests"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return stats;
    }
    public List<Map<String, Object>> getPendingBalances() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT r.id, r.reservation_number, g.full_name, rt.type_name, b.total_amount, " +
                     "IFNULL((SELECT SUM(amount_paid) FROM payments WHERE bill_id = b.id AND payment_status='PAID'), 0) as paid_amount " +
                     "FROM reservations r " +
                     "JOIN bills b ON r.id = b.reservation_id " +
                     "JOIN guests g ON r.guest_id = g.id " +
                     "JOIN rooms rm ON r.room_id = rm.id " +
                     "JOIN room_types rt ON rm.room_type_id = rt.id " +
                     "WHERE r.status != 'Cancelled' " +
                     "HAVING (b.total_amount - paid_amount) > 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("resNo", rs.getString("reservation_number"));
                map.put("guestName", rs.getString("full_name"));
                map.put("roomType", rs.getString("type_name"));
                map.put("total", rs.getBigDecimal("total_amount"));
                map.put("paid", rs.getBigDecimal("paid_amount"));
                map.put("balance", rs.getBigDecimal("total_amount").subtract(rs.getBigDecimal("paid_amount")));
                list.add(map);
            }
        }
        return list;
    }

    public BigDecimal getMonthlyRevenue() {
        String sql = "SELECT SUM(amount_paid) FROM payments WHERE payment_status = 'PAID' AND MONTH(paid_at) = MONTH(CURRENT_DATE()) AND YEAR(paid_at) = YEAR(CURRENT_DATE())";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal(1) != null ? rs.getBigDecimal(1) : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public int getMonthlyBookings() {
        String sql = "SELECT COUNT(*) FROM reservations WHERE MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE())";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
