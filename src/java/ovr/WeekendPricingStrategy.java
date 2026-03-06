package ovr;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;

/**
 * Design Pattern: Strategy (Concrete Implementation)
 * Purpose: Calculates price factoring in weekends (10% higher).
 */
public class WeekendPricingStrategy implements PricingStrategy {
    @Override
    public BigDecimal calculateRate(BigDecimal baseRate, Date checkIn, Date checkOut) {
        LocalDate start = checkIn.toLocalDate();
        LocalDate end = checkOut.toLocalDate();
        
        BigDecimal total = BigDecimal.ZERO;
        for (LocalDate date = start; date.isBefore(end); date = date.plusDays(1)) {
            DayOfWeek day = date.getDayOfWeek();
            BigDecimal dailyRate = baseRate;
            if (day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY) {
                // Add 10% for weekends
                dailyRate = baseRate.multiply(new BigDecimal("1.10"));
            }
            total = total.add(dailyRate);
        }
        return total;
    }
}
