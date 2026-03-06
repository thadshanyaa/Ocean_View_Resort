package ovr;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO implements GenericDAO<Room> {
    private final Connection connection;

    public RoomDAO(Connection connection) {
        this.connection = connection;
    }

    public RoomDAO() {
        this.connection = null;
    }

    @Override
    public void create(Room room) {
        String sql = "INSERT INTO rooms (room_number, room_type_id, is_available) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getRoomTypeId());
            stmt.setBoolean(3, room.isAvailable());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    room.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Room getById(int id) {
        String sql = "SELECT * FROM rooms WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToRoom(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Room> getAll() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRowToRoom(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Room> getAvailableRoomsByTypeId(int typeId) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE room_type_id = ? AND is_available = TRUE";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, typeId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToRoom(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Room> findAvailableRooms(int roomTypeId, Date checkIn, Date checkOut) {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.* FROM rooms r WHERE r.room_type_id = ? AND r.is_available = TRUE " +
                     "AND NOT EXISTS (" +
                     "  SELECT 1 FROM reservations res " +
                     "  WHERE res.room_id = r.id " +
                     "  AND res.status NOT IN ('Cancelled', 'Checked-Out') " +
                     "  AND res.check_in < ? AND res.check_out > ?" +
                     ") ORDER BY r.room_number ASC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roomTypeId);
            stmt.setDate(2, checkOut); // requested checkOut
            stmt.setDate(3, checkIn);  // requested checkIn
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToRoom(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void update(Room room) {
        String sql = "UPDATE rooms SET room_number=?, room_type_id=?, is_available=? WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getRoomTypeId());
            stmt.setBoolean(3, room.isAvailable());
            stmt.setInt(4, room.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM rooms WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Room mapRowToRoom(ResultSet rs) throws SQLException {
        return new Room(
            rs.getInt("id"),
            rs.getString("room_number"),
            rs.getInt("room_type_id"),
            rs.getBoolean("is_available")
        );
    }

    public int getTotalRooms() {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public boolean hasFutureBookings(int roomId) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE room_id = ? AND check_out >= CURDATE() AND status != 'CANCELLED'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roomId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}
