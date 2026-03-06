package ovr;

import org.junit.Test;
import org.junit.BeforeClass;
import static org.junit.Assert.*;
import java.sql.Connection;
import java.math.BigDecimal;
import java.util.Map;

/**
 * Unit tests for ReservationDAO.
 * Tests the core logic for KPI calculations and data retrieval.
 */
public class ReservationDAOTest {
    private static Connection conn;
    private static ReservationDAO dao;

    @BeforeClass
    public static void setUp() throws Exception {
        // Use the application's connection manager for tests
        conn = DBConnectionManager.getInstance().getConnection();
        dao = new ReservationDAO(conn);
    }

    @Test
    public void testGetManagerKPIs() throws Exception {
        Map<String, Object> kpis = dao.getManagerKPIs(null, null, null, null, null);
        assertNotNull("KPI map should not be null", kpis);
        assertTrue("Should contain totalBookings", kpis.containsKey("totalBookings"));
        assertTrue("Should contain totalRevenue", kpis.containsKey("totalRevenue"));
    }

    @Test
    public void testGetMonthlyStats() throws Exception {
        BigDecimal revenue = dao.getMonthlyRevenue();
        int bookings = dao.getMonthlyBookings();
        
        assertNotNull("Monthly revenue should not be null", revenue);
        assertTrue("Monthly bookings should be non-negative", bookings >= 0);
    }

    @Test
    public void testGetRecentReservations() throws Exception {
        var list = dao.getRecentReservations(5, null);
        assertNotNull("Reservation list should not be null", list);
        assertTrue("Should respect the limit", list.size() <= 5);
    }
}
