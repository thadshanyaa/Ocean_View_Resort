package ovr;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.UUID;

/**
 * Design Pattern: Adapter
 * Purpose: Simulates converting our system's request into a 3rd party Gateway request format and converting the response back.
 */
public class PaymentGatewayAdapter implements PaymentProcessor {
    
    // Simulate an external gateway call
    private String callExternalGatewayLegacy(String amount, String currency) {
        // Here we'd map to some external SDK
        // Return a mock simulated transaction ID
        return "TXN-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    @Override
    public Payment processPayment(int billId, BigDecimal amount, String reference) {
        // Adapting the external dummy API back to our Payment object
        String gatewayTxnId = callExternalGatewayLegacy(amount.toString(), "USD");
        
        Payment payment = new Payment();
        payment.setBillId(billId);
        payment.setPaymentMethod("Online Gateway");
        payment.setTransactionRef(reference != null && !reference.isEmpty() ? reference : gatewayTxnId);
        payment.setAmountPaid(amount);
        payment.setPaymentStatus("Paid");
        payment.setPaidAt(new Timestamp(System.currentTimeMillis()));
        return payment;
    }
}
