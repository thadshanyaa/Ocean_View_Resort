package ovr;
import java.math.BigDecimal;

/**
 * Design Pattern: Strategy (Concrete Implementation)
 * Purpose: Simple base rate multiplication.
 */
public class NormalPricingStrategy implements PricingStrategy {
    @Override
    public BigDecimal calculateRate(BigDecimal baseRate, java.sql.Date checkIn, java.sql.Date checkOut) {
        long diff = checkOut.getTime() - checkIn.getTime();
        long nights = diff / (1000 * 60 * 60 * 24);
        if (nights <= 0) nights = 1;
        return baseRate.multiply(BigDecimal.valueOf(nights));
    }
}
