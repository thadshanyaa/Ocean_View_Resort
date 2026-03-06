package ovr;

import org.junit.Test;
import org.junit.BeforeClass;
import static org.junit.Assert.*;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * Unit tests for PaymentDAO.
 * Verifies financial data aggregations and payment retrieval logic.
 */
public class PaymentDAOTest {
    private static Connection conn;
    private static PaymentDAO dao;

    @BeforeClass
    public static void setUp() throws Exception {
        conn = DBConnectionManager.getInstance().getConnection();
        dao = new PaymentDAO(conn);
    }

    @Test
    public void testGetAccountantKPIs() throws Exception {
        Map<String, Object> kpis = dao.getAccountantKPIs();
        assertNotNull("KPI map should not be null", kpis);
        assertTrue("Should contain todayRevenue", kpis.containsKey("todayRevenue"));
        assertTrue("Should contain pendingCount", kpis.containsKey("pendingCount"));
    }

    @Test
    public void testGetRecentPayments() throws Exception {
        List<Map<String, Object>> payments = dao.getRecentPayments(10);
        assertNotNull("Payments list should not be null", payments);
        assertTrue("Should not exceed limit", payments.size() <= 10);
    }

    @Test
    public void testGetDailyRevenue() throws Exception {
        List<Map<String, Object>> trend = dao.getDailyRevenue(7);
        assertNotNull("Revenue trend should not be null", trend);
        assertTrue("Should not exceed requested days", trend.size() <= 7);
    }
}
