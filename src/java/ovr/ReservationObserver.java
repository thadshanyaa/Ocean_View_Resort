package ovr;
/**
 * Design Pattern: Observer (Observer Interface)
 * Purpose: Used to notify listeners of reservation events.
 */
public interface ReservationObserver {
    void onReservationCreated(Reservation reservation);
    void onReservationCancelled(Reservation reservation);
}
