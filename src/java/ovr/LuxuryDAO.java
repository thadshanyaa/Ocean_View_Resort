package ovr;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

/**
 * Data Access Object for Luxury V4 Hub.
 * Manages separate tables for the redesign to ensure safety.
 */
public class LuxuryDAO {
    private final Connection connection;

    public LuxuryDAO(Connection connection) {
        this.connection = connection;
    }

    public void initializeTables() throws SQLException {
        String resSql = "CREATE TABLE IF NOT EXISTS luxury_reservations (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "res_number VARCHAR(20) UNIQUE, " +
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
        
        String reqSql = "CREATE TABLE IF NOT EXISTS luxury_requests (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY, " +
                        "guest_name VARCHAR(100), " +
                        "room_number VARCHAR(10), " +
                        "service_type VARCHAR(50), " +
                        "details TEXT, " +
                        "status VARCHAR(20) DEFAULT 'Pending', " +
                        "requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                        ")";

        try (Statement stmt = connection.createStatement()) {
            stmt.execute(resSql);
            stmt.execute(reqSql);
        }
    }

    // --- RESERVATION METHODS ---
    public boolean saveReservation(LuxuryModels.Reservation res) throws SQLException {
        String sql = "INSERT INTO luxury_reservations (res_number, guest_name, guest_email, guest_phone, room_type, check_in, check_out, num_guests, special_requests, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, res.getReservationNumber());
            stmt.setString(2, res.getGuestName());
            stmt.setString(3, res.getGuestEmail());
            stmt.setString(4, res.getGuestPhone());
            stmt.setString(5, res.getRoomType());
            stmt.setDate(6, res.getCheckIn());
            stmt.setDate(7, res.getCheckOut());
            stmt.setInt(8, res.getGuests());
            stmt.setString(9, res.getSpecialRequests());
            stmt.setBigDecimal(10, res.getTotalAmount());
            stmt.setString(11, res.getStatus());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<LuxuryModels.Reservation> getAllReservations() throws SQLException {
        List<LuxuryModels.Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM luxury_reservations ORDER BY created_at DESC";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapReservation(rs));
        }
        return list;
    }

    public List<LuxuryModels.Reservation> getReservationsByEmail(String email) throws SQLException {
        List<LuxuryModels.Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM luxury_reservations WHERE guest_email = ? ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) list.add(mapReservation(rs));
            }
        }
        return list;
    }

    // --- SERVICE REQUEST METHODS ---
    public boolean saveRequest(LuxuryModels.ServiceRequest req) throws SQLException {
        String sql = "INSERT INTO luxury_requests (guest_name, room_number, service_type, details, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, req.getGuestName());
            stmt.setString(2, req.getRoomNumber());
            stmt.setString(3, req.getServiceType());
            stmt.setString(4, req.getDetails());
            stmt.setString(5, req.getStatus());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<LuxuryModels.ServiceRequest> getAllRequests() throws SQLException {
        List<LuxuryModels.ServiceRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM luxury_requests ORDER BY requested_at DESC";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRequest(rs));
        }
        return list;
    }

    // --- MAPPING HELPERS ---
    private LuxuryModels.Reservation mapReservation(ResultSet rs) throws SQLException {
        LuxuryModels.Reservation res = new LuxuryModels.Reservation();
        res.setId(rs.getInt("id"));
        res.setReservationNumber(rs.getString("res_number"));
        res.setGuestName(rs.getString("guest_name"));
        res.setGuestEmail(rs.getString("guest_email"));
        res.setGuestPhone(rs.getString("guest_phone"));
        res.setRoomType(rs.getString("room_type"));
        res.setCheckIn(rs.getDate("check_in"));
        res.setCheckOut(rs.getDate("check_out"));
        res.setGuests(rs.getInt("num_guests"));
        res.setSpecialRequests(rs.getString("special_requests"));
        res.setTotalAmount(rs.getBigDecimal("total_amount"));
        res.setStatus(rs.getString("status"));
        res.setCreatedAt(rs.getTimestamp("created_at"));
        return res;
    }

    private LuxuryModels.ServiceRequest mapRequest(ResultSet rs) throws SQLException {
        LuxuryModels.ServiceRequest req = new LuxuryModels.ServiceRequest();
        req.setId(rs.getInt("id"));
        req.setGuestName(rs.getString("guest_name"));
        req.setRoomNumber(rs.getString("room_number"));
        req.setServiceType(rs.getString("service_type"));
        req.setDetails(rs.getString("details"));
        req.setStatus(rs.getString("status"));
        req.setRequestedAt(rs.getTimestamp("requested_at"));
        return req;
    }
}
