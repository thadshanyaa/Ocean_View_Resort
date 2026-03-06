package ovr;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Design Pattern: Factory (Concrete Product)
 * Purpose: Processor for offline (Cash/Card manual entry) payments.
 */
public class OfflinePaymentProcessor implements PaymentProcessor {
    private final String method;

    public OfflinePaymentProcessor(String method) {
        this.method = method; // E.g., 'Cash', 'Card Terminal'
    }

    @Override
    public Payment processPayment(int billId, BigDecimal amount, String reference) {
        Payment payment = new Payment();
        payment.setBillId(billId);
        payment.setPaymentMethod(method);
        payment.setTransactionRef(reference != null && !reference.isEmpty() ? reference : "OFFLINE-" + System.currentTimeMillis());
        payment.setAmountPaid(amount);
        payment.setPaymentStatus("Paid");
        payment.setPaidAt(new Timestamp(System.currentTimeMillis()));
        return payment;
    }
}
