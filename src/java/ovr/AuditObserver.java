package ovr;
/**
 * Design Pattern: Observer (Concrete Observer)
 * Purpose: Automatically logs an audit entry when a reservation is created or cancelled.
 */
public class AuditObserver implements ReservationObserver {
    private final AuditLogDAO auditDAO;

    public AuditObserver(AuditLogDAO auditDAO) {
        this.auditDAO = auditDAO;
    }

    @Override
    public void onReservationCreated(Reservation reservation) {
        auditDAO.log(null, "RESERVATION_CREATED", "System automatically generated reservation " + reservation.getReservationNumber() + " for Guest ID: " + reservation.getGuestId());
    }

    @Override
    public void onReservationCancelled(Reservation reservation) {
        auditDAO.log(null, "RESERVATION_CANCELLED", "System automatically cancelled reservation " + reservation.getReservationNumber());
    }
}
