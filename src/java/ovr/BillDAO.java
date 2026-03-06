package ovr;
import java.sql.*;
import java.math.BigDecimal;

public class BillDAO implements GenericDAO<Bill> {
    private final Connection connection;

    public BillDAO(Connection connection) {
        this.connection = connection;
    }

    public BillDAO() {
        this.connection = null;
    }

    @Override
    public void create(Bill bill) {
        String sql = "INSERT INTO bills (reservation_id, nights, subtotal, tax, service_fee, total_amount) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, bill.getReservationId());
            stmt.setInt(2, bill.getNights());
            stmt.setBigDecimal(3, bill.getSubtotal());
            stmt.setBigDecimal(4, bill.getTax());
            stmt.setBigDecimal(5, bill.getServiceFee());
            stmt.setBigDecimal(6, bill.getTotalAmount());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    bill.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("DB Insert failed: " + e.getMessage(), e);
        }
    }

    @Override
    public Bill getById(int id) {
        String sql = "SELECT * FROM bills WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToBill(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Bill getByReservationId(int resId) {
        String sql = "SELECT * FROM bills WHERE reservation_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, resId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToBill(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Bill bill) {
        String sql = "UPDATE bills SET reservation_id=?, nights=?, subtotal=?, tax=?, service_fee=?, total_amount=? WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bill.getReservationId());
            stmt.setInt(2, bill.getNights());
            stmt.setBigDecimal(3, bill.getSubtotal());
            stmt.setBigDecimal(4, bill.getTax());
            stmt.setBigDecimal(5, bill.getServiceFee());
            stmt.setBigDecimal(6, bill.getTotalAmount());
            stmt.setInt(7, bill.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM bills WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Bill mapRowToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setId(rs.getInt("id"));
        bill.setReservationId(rs.getInt("reservation_id"));
        bill.setNights(rs.getInt("nights"));
        bill.setSubtotal(rs.getBigDecimal("subtotal"));
        bill.setTax(rs.getBigDecimal("tax"));
        bill.setServiceFee(rs.getBigDecimal("service_fee"));
        bill.setTotalAmount(rs.getBigDecimal("total_amount"));
        bill.setIssuedAt(rs.getTimestamp("issued_at"));
        return bill;
    }

}
