package ovr;
/**
 * Design Pattern: Factory
 * Purpose: Creates appropriate PaymentProcessor based on payment method string.
 */
public class PaymentProcessorFactory {
    public static PaymentProcessor getProcessor(String method) {
        if ("Online".equalsIgnoreCase(method)) {
            // Returns an Adapter wrapping the external gateway
            return new PaymentGatewayAdapter();
        } else if ("Card".equalsIgnoreCase(method)) {
            return new OfflinePaymentProcessor("Card");
        } else {
            return new OfflinePaymentProcessor("Cash");
        }
    }
}
