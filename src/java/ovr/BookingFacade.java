package ovr;
import java.sql.Connection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Random;

/**
 * Design Pattern: Facade
 * Purpose: Simplifies the complex business logic of checking availability, saving the reservation,
 * generating a reservation number, marking the room as unavailable, and notifying observers.
 */
public class BookingFacade {
    private final ReservationDAO reservationDAO;
    private final RoomDAO roomDAO;
    private final ReservationRepository repository;
    private final ReservationSubject subject;
    private final Connection connection;

    public BookingFacade(Connection connection) {
        this.connection = connection;
        this.reservationDAO = new ReservationDAO(connection);
        this.roomDAO = new RoomDAO(connection);
        this.repository = new ReservationRepository(connection);
        
        // Initialize observer pattern implicitly
        this.subject = new ReservationSubject();
        this.subject.addObserver(new AuditObserver(new AuditLogDAO(connection)));
    }

    public Reservation bookRoom(int userId, int savedGuestId, String guestName, String guestPhone, String guestAddress, int roomId, Date checkIn, Date checkOut, String[] services) throws Exception {
        System.out.println("Starting bookRoom process for User " + userId + " (SavedGuest: " + savedGuestId + ") room " + roomId);
        // 1. Check availability
        if (!repository.isRoomAvailable(roomId, checkIn, checkOut)) {
            System.err.println("Room is not available according to repository.");
            throw new Exception("Room is not available for the selected dates.");
        }

        // 2. Generate unique reservation number: OVR-YYYYMMDD-XXXX
        String datePart = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String randPart = String.format("%04d", new Random().nextInt(10000));
        String resNum = "OVR-" + datePart + "-" + randPart;
        System.out.println("Generated Reservation Number: " + resNum);

        // 3. Create Reservation object
        Reservation res = new Reservation();
        res.setReservationNumber(resNum);
        res.setRoomId(roomId);
        res.setCheckIn(checkIn);
        res.setCheckOut(checkOut);
        res.setStatus("Confirmed");

        // 4. Save using DAO inside a transaction
        try {
            connection.setAutoCommit(false);
            try {
                // 4a. Resolve or Create Guest Record
                System.out.println("Resolving Guest record for UserID: " + userId + " / SavedGuestID: " + savedGuestId);
                GuestDAO guestDao = new GuestDAO(connection);
                Guest guest = null;
                
                if (savedGuestId > 0) {
                    System.out.println("Using pre-saved Walk-In Guest ID: " + savedGuestId);
                    guest = guestDao.getById(savedGuestId);
                } else {
                    System.out.println("No savedGuestId. Using logged in UserID: " + userId);
                    guest = guestDao.getByUserId(userId);
                }
                
                if (guest == null) {
                    System.out.println("No Guest found. Creating default Guest...");
                    UserDAO userDao = new UserDAO(connection);
                    User user = userDao.getById(userId);
                    
                    guest = new Guest();
                    guest.setUserId(userId);
                    
                    // Prioritize explicit Walk-In fields, fallback to User info, fallback to 'Walk-in Guest'
                    String finalName = "Walk-in Guest";
                    if (guestName != null && !guestName.trim().isEmpty()) {
                        finalName = guestName;
                    } else if (user != null) {
                        finalName = user.getUsername();
                    }
                    guest.setFullName(finalName);
                    
                    guest.setContactNumber(guestPhone != null && !guestPhone.trim().isEmpty() ? guestPhone : "N/A");
                    guest.setAddress(guestAddress != null && !guestAddress.trim().isEmpty() ? guestAddress : "N/A");
                    
                    guestDao.create(guest);
                    if (guest.getId() <= 0) {
                        throw new Exception("Failed to auto-generate Guest record for Reservation.");
                    }
                }
                
                // Update reservation to use the true Guest Primary Key
                res.setGuestId(guest.getId());

                System.out.println("Attempting to save reservation...");
                reservationDAO.create(res);
                System.out.println("Reservation save attempt finished. ID is now: " + res.getId());

                Room room = roomDAO.getById(roomId);
                RoomType type = new RoomTypeDAO(connection).getById(room.getRoomTypeId());
                
                long diffInMillis = checkOut.getTime() - checkIn.getTime();
                int nights = (int) (diffInMillis / (1000 * 60 * 60 * 24));
                if (nights <= 0) nights = 1;
                
                java.math.BigDecimal rate = type.getBaseRate();
                java.math.BigDecimal subtotal = rate.multiply(new java.math.BigDecimal(nights));
                java.math.BigDecimal tax = subtotal.multiply(new java.math.BigDecimal("0.10"));
                java.math.BigDecimal serviceFee = subtotal.multiply(new java.math.BigDecimal("0.05"));
                java.math.BigDecimal total = subtotal.add(tax).add(serviceFee);

                Bill bill = new Bill();
                bill.setReservationId(res.getId());
                bill.setNights(nights);
                bill.setSubtotal(subtotal);
                bill.setTax(tax);
                bill.setServiceFee(serviceFee);
                bill.setTotalAmount(total);

                BillDAO billDao = new BillDAO(connection);
                billDao.create(bill);

                Payment payment = new Payment();
                payment.setBillId(bill.getId());
                payment.setPaymentMethod("PENDING");
                payment.setTransactionRef("TX-PENDING-" + resNum);
                payment.setAmountPaid(java.math.BigDecimal.ZERO);
                payment.setPaymentStatus("PENDING");

                PaymentDAO paymentDao = new PaymentDAO(connection);
                paymentDao.create(payment);

                connection.commit();
                System.out.println("[BookingFacade] Transaction committed successfully for " + resNum);

                // Final DB confirmation
                Reservation created = reservationDAO.getByReservationNumber(resNum);
                if (created == null || created.getId() <= 0) {
                    throw new Exception("CRITICAL ERROR: DB commit succeeded but reservation " + resNum + " cannot be found.");
                }
                res = created; // Use the verified DB object
            } catch (Exception ex) {
                System.out.println("[BookingFacade] Rolling back transaction due to error: " + ex.getMessage());
                connection.rollback();
                throw ex;
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (Exception ex) {
            System.err.println("FATAL ERROR DURING RESERVATION TRANSACTION:");
            ex.printStackTrace();
            throw new Exception("Booking failed: " + ex.getMessage());
        }

        // 5. Notify observers (this triggers the Audit Log)
        try {
            System.out.println("Notifying observers...");
            subject.notifyCreated(res);
        } catch(Exception e) {
            System.err.println("Error notifying observers:");
            e.printStackTrace();
        }

        System.out.println("Booking complete, returning res object.");
        return res;
    }
}
