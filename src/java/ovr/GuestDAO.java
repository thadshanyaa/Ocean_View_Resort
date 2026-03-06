package ovr;
import java.sql.*;

public class GuestDAO implements GenericDAO<Guest> {
    private final Connection connection;

    public GuestDAO(Connection connection) {
        this.connection = connection;
    }

    public GuestDAO() {
        this.connection = null;
    }

    @Override
    public void create(Guest guest) {
        String sql = "INSERT INTO guests (user_id, full_name, address, contact_number) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, guest.getUserId());
            stmt.setString(2, guest.getFullName());
            stmt.setString(3, guest.getAddress());
            stmt.setString(4, guest.getContactNumber());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    guest.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Guest DB Insert failed: " + e.getMessage(), e);
        }
    }

    @Override
    public Guest getById(int id) {
        String sql = "SELECT * FROM guests WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToGuest(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Guest getByUserId(int userId) {
        String sql = "SELECT * FROM guests WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToGuest(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Guest getByContactNumber(String contactNumber) {
        String sql = "SELECT * FROM guests WHERE contact_number = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, contactNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToGuest(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Guest guest) {
        String sql = "UPDATE guests SET full_name=?, address=?, contact_number=? WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, guest.getFullName());
            stmt.setString(2, guest.getAddress());
            stmt.setString(3, guest.getContactNumber());
            stmt.setInt(4, guest.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM guests WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Guest mapRowToGuest(ResultSet rs) throws SQLException {
        return new Guest(
            rs.getInt("id"),
            rs.getInt("user_id"),
            rs.getString("full_name"),
            rs.getString("address"),
            rs.getString("contact_number")
        );
    }

}
