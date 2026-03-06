package ovr;
import java.sql.Timestamp;

public class AuditLog {
    private int id;
    private Integer userId; // Can be null for system actions
    private String action;
    private String details;
    private Timestamp timestamp;

    public AuditLog() {}

    public AuditLog(int id, Integer userId, String action, String details) {
        this.id = id;
        this.userId = userId;
        this.action = action;
        this.details = details;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }
    public Timestamp getTimestamp() { return timestamp; }
    public void setTimestamp(Timestamp timestamp) { this.timestamp = timestamp; }
}
