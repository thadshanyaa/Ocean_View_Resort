package ovr;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

/**
 * Data Access Object for the Elite Guest Module.
 * Uses a dedicated 'elite_reservations' table (or similar logic) 
 * to ensure all panels read the same data source.
 */
public class EliteReservationDAO {
    private final Connection connection;

    public EliteReservationDAO(Connection connection) {
        this.connection = connection;
    }

    /**
     * Creates the table if it doesn't exist to ensure the standalone feature works.
     */
    public void initializeTable() throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS elite_reservations (" +
                     "id INT AUTO_INCREMENT PRIMARY KEY, " +
                     "reservation_number VARCHAR(20) UNIQUE, " +
                     "guest_name VARCHAR(100), " +
                     "guest_email VARCHAR(100), " +
                     "guest_phone VARCHAR(20), " +
                     "room_type VARCHAR(50), " +
                     "check_in DATE, " +
                     "check_out DATE, " +
                     "num_guests INT, " +
                     "special_requests TEXT, " +
                     "total_amount DECIMAL(15, 2), " +
                     "status VARCHAR(20) DEFAULT 'Pending', " +
                     "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                     ")";
        try (Statement stmt = connection.createStatement()) {
            stmt.execute(sql);
        }
    }

    public boolean save(EliteReservation res) throws SQLException {
        String sql = "INSERT INTO elite_reservations (reservation_number, guest_name, guest_email, guest_phone, " +
                     "room_type, check_in, check_out, num_guests, special_requests, total_amount, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, res.getReservationNumber());
            stmt.setString(2, res.getGuestName());
            stmt.setString(3, res.getGuestEmail());
            stmt.setString(4, res.getGuestPhone());
            stmt.setString(5, res.getRoomType());
            stmt.setDate(6, res.getCheckInDate());
            stmt.setDate(7, res.getCheckOutDate());
            stmt.setInt(8, res.getNumberOfGuests());
            stmt.setString(9, res.getSpecialRequests());
            stmt.setBigDecimal(10, res.getTotalAmount());
            stmt.setString(11, res.getStatus());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<EliteReservation> getAll() throws SQLException {
        List<EliteReservation> list = new ArrayList<>();
        String sql = "SELECT * FROM elite_reservations ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public List<EliteReservation> getByEmail(String email) throws SQLException {
        List<EliteReservation> list = new ArrayList<>();
        String sql = "SELECT * FROM elite_reservations WHERE guest_email = ? ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    private EliteReservation mapRow(ResultSet rs) throws SQLException {
        EliteReservation res = new EliteReservation();
        res.setId(rs.getInt("id"));
        res.setReservationNumber(rs.getString("reservation_number"));
        res.setGuestName(rs.getString("guest_name"));
        res.setGuestEmail(rs.getString("guest_email"));
        res.setGuestPhone(rs.getString("guest_phone"));
        res.setRoomType(rs.getString("room_type"));
        res.setCheckInDate(rs.getDate("check_in"));
        res.setCheckOutDate(rs.getDate("check_out"));
        res.setNumberOfGuests(rs.getInt("num_guests"));
        res.setSpecialRequests(rs.getString("special_requests"));
        res.setTotalAmount(rs.getBigDecimal("total_amount"));
        res.setStatus(rs.getString("status"));
        res.setCreatedAt(rs.getTimestamp("created_at"));
        return res;
    }
}
