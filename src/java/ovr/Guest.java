package ovr;
public class Guest {
    private int id;
    private int userId;
    private String fullName;
    private String address;
    private String contactNumber;

    public Guest() {}

    public Guest(int id, int userId, String fullName, String address, String contactNumber) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.address = address;
        this.contactNumber = contactNumber;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
}
