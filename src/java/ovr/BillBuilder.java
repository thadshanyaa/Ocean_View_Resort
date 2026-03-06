package ovr;
import java.math.BigDecimal;

/**
 * Design Pattern: Builder
 * Purpose: Allows step-by-step construction of complex Bill objects.
 */
public class BillBuilder {
    private Bill bill;

    public BillBuilder() {
        this.bill = new Bill();
        this.bill.setSubtotal(BigDecimal.ZERO);
        this.bill.setTax(BigDecimal.ZERO);
        this.bill.setServiceFee(BigDecimal.ZERO);
        this.bill.setTotalAmount(BigDecimal.ZERO);
    }

    public BillBuilder withReservationId(int resId) {
        this.bill.setReservationId(resId);
        return this;
    }

    public BillBuilder withNights(int nights) {
        this.bill.setNights(nights);
        return this;
    }

    public BillBuilder withSubtotal(BigDecimal subtotal) {
        this.bill.setSubtotal(subtotal);
        return this;
    }

    public BillBuilder applyTaxAndFees(BigDecimal taxRate, BigDecimal serviceFeeRate) {
        BigDecimal taxAmount = this.bill.getSubtotal().multiply(taxRate);
        BigDecimal feeAmount = this.bill.getSubtotal().multiply(serviceFeeRate);
        
        this.bill.setTax(taxAmount);
        this.bill.setServiceFee(feeAmount);
        
        BigDecimal total = this.bill.getSubtotal().add(taxAmount).add(feeAmount);
        this.bill.setTotalAmount(total);
        
        return this;
    }

    public Bill build() {
        return this.bill;
    }
}
