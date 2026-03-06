package ovr;

/**
 * Migrated from src/java/ovr/TestRegister.java
 * Formalized as a manual registration test within the test package.
 */
public class TestRegister {
    public static void main(String[] args) {
        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            UserDAO userDAO = new UserDAO(db.getConnection());
            
            String userParam = "TestAdmin" + System.currentTimeMillis();
            String passParam = "SecurePass123!";
            
            System.out.println("Connecting to DB...");
            
            User user = new User();
            user.setUsername(userParam);
            user.setPasswordHash(SecurityUtils.hashPassword(passParam));
            user.setRole("Admin");
            user.setVerified(false);
            userDAO.create(user);
            System.out.println("User created with ID: " + user.getId());

            GuestDAO guestDAO = new GuestDAO(db.getConnection());
            Guest guest = new Guest();
            guest.setUserId(user.getId());
            guest.setFullName("Admin FullName");
            guest.setContactNumber("1234");
            guest.setAddress("N/A");
            guestDAO.create(guest);
            System.out.println("Guest created with ID: " + guest.getId());

            AuditLogDAO auditDAO = new AuditLogDAO(db.getConnection());
            auditDAO.log(user.getId(), "USER_REGISTERED", "User registered: " + userParam);
            System.out.println("Audit log created.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
