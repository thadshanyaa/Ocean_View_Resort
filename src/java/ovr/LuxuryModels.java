package ovr;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * High-luxury models for the Standalone Redesign.
 * Isolated from existing models to ensure 100% safety.
 */
public class LuxuryModels {

    public static class Reservation {
        private int id;
        private String reservationNumber;
        private String guestName;
        private String guestEmail;
        private String guestPhone;
        private String roomType;
        private Date checkIn;
        private Date checkOut;
        private int guests;
        private String specialRequests;
        private BigDecimal totalAmount;
        private String status; // Pending, Confirmed, Checked-In, Checked-Out, Cancelled
        private Timestamp createdAt;

        // Getters and Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getReservationNumber() { return reservationNumber; }
        public void setReservationNumber(String reservationNumber) { this.reservationNumber = reservationNumber; }
        public String getGuestName() { return guestName; }
        public void setGuestName(String guestName) { this.guestName = guestName; }
        public String getGuestEmail() { return guestEmail; }
        public void setGuestEmail(String guestEmail) { this.guestEmail = guestEmail; }
        public String getGuestPhone() { return guestPhone; }
        public void setGuestPhone(String guestPhone) { this.guestPhone = guestPhone; }
        public String getRoomType() { return roomType; }
        public void setRoomType(String roomType) { this.roomType = roomType; }
        public Date getCheckIn() { return checkIn; }
        public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }
        public Date getCheckOut() { return checkOut; }
        public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }
        public int getGuests() { return guests; }
        public void setGuests(int guests) { this.guests = guests; }
        public String getSpecialRequests() { return specialRequests; }
        public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }
        public BigDecimal getTotalAmount() { return totalAmount; }
        public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Timestamp getCreatedAt() { return createdAt; }
        public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    }

    public static class ServiceRequest {
        private int id;
        private String guestName;
        private String roomNumber;
        private String serviceType; // Spa, Pool, Laundry, Transport, etc.
        private String details;
        private String status; // Pending, In-Progress, Completed
        private Timestamp requestedAt;

        // Getters and Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getGuestName() { return guestName; }
        public void setGuestName(String guestName) { this.guestName = guestName; }
        public String getRoomNumber() { return roomNumber; }
        public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
        public String getServiceType() { return serviceType; }
        public void setServiceType(String serviceType) { this.serviceType = serviceType; }
        public String getDetails() { return details; }
        public void setDetails(String details) { this.details = details; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Timestamp getRequestedAt() { return requestedAt; }
        public void setRequestedAt(Timestamp requestedAt) { this.requestedAt = requestedAt; }
    }
}
