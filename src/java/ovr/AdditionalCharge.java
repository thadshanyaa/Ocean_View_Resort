package ovr;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class AdditionalCharge {
    private int id;
    private int reservationId;
    private String category;
    private String itemName;
    private BigDecimal unitPrice;
    private int qty;
    private BigDecimal totalPrice;
    private Timestamp createdAt;

    // Default constructor
    public AdditionalCharge() {
    }

    public AdditionalCharge(int id, int reservationId, String category, String itemName, BigDecimal unitPrice, int qty, BigDecimal totalPrice, Timestamp createdAt) {
        this.id = id;
        this.reservationId = reservationId;
        this.category = category;
        this.itemName = itemName;
        this.unitPrice = unitPrice;
        this.qty = qty;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    
    public int getQty() { return qty; }
    public void setQty(int qty) { this.qty = qty; }
    
    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
