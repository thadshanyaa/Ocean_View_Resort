package ovr;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Design Pattern: Repository
 * Purpose: Provides a higher-level data access abstraction for Reservation search queries.
 */
public class ReservationRepository {
    private final Connection connection;

    public ReservationRepository(Connection connection) {
        this.connection = connection;
    }

    // Availability validation check without creating overlapping bookings
    public boolean isRoomAvailable(int roomId, Date checkIn, Date checkOut) {
        String sql = "SELECT COUNT(*) FROM reservations " +
                     "WHERE room_id = ? AND status IN ('Pending', 'Confirmed', 'Checked-In') " +
                     "AND (check_in <= ? AND check_out >= ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roomId);
            stmt.setDate(2, checkOut);
            stmt.setDate(3, checkIn);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; // Available if 0 overlapping
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // List all available rooms of specific type within a date range
    public List<Room> getAvailableRoomsByDateAndType(int roomTypeId, Date checkIn, Date checkOut) {
        List<Room> availableRooms = new ArrayList<>();
        // Finds room of type X, that is not in any overlapping active reservation.
        String sql = "SELECT r.* FROM rooms r WHERE r.room_type_id = ? AND r.is_available = TRUE " +
                     "AND r.id NOT IN (" +
                     "  SELECT res.room_id FROM reservations res " +
                     "  WHERE res.status IN ('Pending', 'Confirmed', 'Checked-In') " +
                     "  AND (res.check_in <= ? AND res.check_out >= ?)" +
                     ")";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roomTypeId);
            stmt.setDate(2, checkOut);
            stmt.setDate(3, checkIn);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    availableRooms.add(new Room(
                        rs.getInt("id"),
                        rs.getString("room_number"),
                        rs.getInt("room_type_id"),
                        rs.getBoolean("is_available")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return availableRooms;
    }
}
