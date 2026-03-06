package ovr;
import java.math.BigDecimal;
import java.sql.Date;

/**
 * Design Pattern: Strategy
 * Purpose: Allows dynamic computation of the room rate depending on dates or seasons.
 */
public interface PricingStrategy {
    BigDecimal calculateRate(BigDecimal baseRate, Date checkIn, Date checkOut);
}
