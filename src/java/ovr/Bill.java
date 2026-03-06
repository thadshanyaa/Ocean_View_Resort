package ovr;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Bill {
    private int id;
    private int reservationId;
    private int nights;
    private BigDecimal subtotal;
    private BigDecimal tax;
    private BigDecimal serviceFee;
    private BigDecimal totalAmount;
    private Timestamp issuedAt;

    public Bill() {}

    public Bill(int id, int reservationId, int nights, BigDecimal subtotal, BigDecimal tax, BigDecimal serviceFee, BigDecimal totalAmount) {
        this.id = id;
        this.reservationId = reservationId;
        this.nights = nights;
        this.subtotal = subtotal;
        this.tax = tax;
        this.serviceFee = serviceFee;
        this.totalAmount = totalAmount;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
    public int getNights() { return nights; }
    public void setNights(int nights) { this.nights = nights; }
    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
    public BigDecimal getTax() { return tax; }
    public void setTax(BigDecimal tax) { this.tax = tax; }
    public BigDecimal getServiceFee() { return serviceFee; }
    public void setServiceFee(BigDecimal serviceFee) { this.serviceFee = serviceFee; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public Timestamp getIssuedAt() { return issuedAt; }
    public void setIssuedAt(Timestamp issuedAt) { this.issuedAt = issuedAt; }
}
