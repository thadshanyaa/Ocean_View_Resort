package ovr;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {
    private int id;
    private int billId;
    private String paymentMethod;
    private String transactionRef;
    private BigDecimal amountPaid;
    private String paymentStatus;
    private Timestamp paidAt;

    public Payment() {}

    public Payment(int id, int billId, String paymentMethod, String transactionRef, BigDecimal amountPaid, String paymentStatus) {
        this.id = id;
        this.billId = billId;
        this.paymentMethod = paymentMethod;
        this.transactionRef = transactionRef;
        this.amountPaid = amountPaid;
        this.paymentStatus = paymentStatus;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getTransactionRef() { return transactionRef; }
    public void setTransactionRef(String transactionRef) { this.transactionRef = transactionRef; }
    public BigDecimal getAmountPaid() { return amountPaid; }
    public void setAmountPaid(BigDecimal amountPaid) { this.amountPaid = amountPaid; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public Timestamp getPaidAt() { return paidAt; }
    public void setPaidAt(Timestamp paidAt) { this.paidAt = paidAt; }
}
