package ovr;
import java.math.BigDecimal;

public class RoomType {
    private int id;
    private String typeName;
    private BigDecimal baseRate;
    private int capacity;
    private String description;

    public RoomType() {}

    public RoomType(int id, String typeName, BigDecimal baseRate, int capacity, String description) {
        this.id = id;
        this.typeName = typeName;
        this.baseRate = baseRate;
        this.capacity = capacity;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTypeName() { return typeName; }
    public void setTypeName(String typeName) { this.typeName = typeName; }
    public BigDecimal getBaseRate() { return baseRate; }
    public void setBaseRate(BigDecimal baseRate) { this.baseRate = baseRate; }
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
