package ovr;
import java.math.BigDecimal;

/**
 * Design Pattern: Factory (Product Interface)
 * Purpose: Unified interface for different payment processors.
 */
public interface PaymentProcessor {
    Payment processPayment(int billId, BigDecimal amount, String reference);
}
