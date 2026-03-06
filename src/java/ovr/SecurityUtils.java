package ovr;
import java.security.SecureRandom;
import java.util.regex.Pattern;

public class SecurityUtils {
    private static final SecureRandom random = new SecureRandom();

    // The Ultimate Security Regex:
    // (?=.*[a-z]) : At least 1 lowercase
    // (?=.*[A-Z]) : At least 1 uppercase
    // (?=.*\d)    : At least 1 number
    // (?=.*[@#$%&*!]) : At least 1 special character
    // ^\S+$       : No spaces allowed
    // .{8,}       : Minimum 8 chars long - (handled by basic length check below for better performance, but strict regex is active)
    private static final String PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%&*!])\\S{8,}$";
    
    private static final String[] WEAK_PASSWORDS = {
        "password", "12345678", "qwerty", "admin123", "guest123", "123456789", "iloveyou"
    };

    /**
     * Strictly verifies if a plain text password meets all enterprise constraints.
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        // 1. Check against weak blacklisted patterns
        String lowerPwd = password.toLowerCase();
        for (String weak : WEAK_PASSWORDS) {
            if (lowerPwd.contains(weak)) {
                return false;
            }
        }
        
        // 2. Check the rigorous Regex pattern
        return Pattern.matches(PASSWORD_PATTERN, password);
    }

    public static String hashPassword(String plainPassword) {
        // Uses BCrypt cost of 12 for strong security
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false; // In case an old SHA-256 hash gets checked against BCrypt
        }
    }

    public static String generateOTP() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
