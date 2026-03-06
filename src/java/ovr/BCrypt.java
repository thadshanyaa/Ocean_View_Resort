package ovr;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Native Java cryptographic class exposing a BCrypt-like API.
 * Uses PBKDF2WithHmacSHA256 instead of actual Blowfish-based BCrypt 
 * to ensure 100% offline compatibility without external JAR files.
 */
public class BCrypt {
    
    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;
    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";

    public static String gensalt(int logRounds) {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    public static String hashpw(String password, String salt) {
        try {
            byte[] saltBytes = Base64.getDecoder().decode(salt);
            PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), saltBytes, ITERATIONS, KEY_LENGTH);
            SecretKeyFactory skf = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] hash = skf.generateSecret(spec).getEncoded();
            return salt + "$" + Base64.getEncoder().encodeToString(hash);
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public static boolean checkpw(String plaintext, String hashed) {
        if (hashed == null || !hashed.contains("$")) {
            return false;
        }
        try {
            String[] parts = hashed.split("\\$");
            String salt = parts[0];
            String newlyHashed = hashpw(plaintext, salt);
            return newlyHashed.equals(hashed);
        } catch (Exception e) {
            return false;
        }
    }
}
