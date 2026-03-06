package ovr;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO implements GenericDAO<RoomType> {
    private final Connection connection;

    public RoomTypeDAO(Connection connection) {
        this.connection = connection;
    }

    public RoomTypeDAO() {
        this.connection = null;
    }

    @Override
    public void create(RoomType roomType) {
        String sql = "INSERT INTO room_types (type_name, base_rate, capacity, description) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, roomType.getTypeName());
            stmt.setBigDecimal(2, roomType.getBaseRate());
            stmt.setInt(3, roomType.getCapacity());
            stmt.setString(4, roomType.getDescription());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    roomType.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public RoomType getById(int id) {
        String sql = "SELECT * FROM room_types WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToRoomType(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<RoomType> getAll() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT * FROM room_types";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRowToRoomType(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void update(RoomType roomType) {
        String sql = "UPDATE room_types SET type_name=?, base_rate=?, capacity=?, description=? WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, roomType.getTypeName());
            stmt.setBigDecimal(2, roomType.getBaseRate());
            stmt.setInt(3, roomType.getCapacity());
            stmt.setString(4, roomType.getDescription());
            stmt.setInt(5, roomType.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM room_types WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private RoomType mapRowToRoomType(ResultSet rs) throws SQLException {
        return new RoomType(
            rs.getInt("id"),
            rs.getString("type_name"),
            rs.getBigDecimal("base_rate"),
            rs.getInt("capacity"),
            rs.getString("description")
        );
    }

}
