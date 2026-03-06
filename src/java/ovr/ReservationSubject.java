package ovr;
import java.util.ArrayList;
import java.util.List;

/**
 * Design Pattern: Observer (Subject Class)
 * Purpose: Manages a list of observers and notifies them of events.
 */
public class ReservationSubject {
    private final List<ReservationObserver> observers = new ArrayList<>();

    public void addObserver(ReservationObserver observer) {
        observers.add(observer);
    }

    public void removeObserver(ReservationObserver observer) {
        observers.remove(observer);
    }

    public void notifyCreated(Reservation reservation) {
        for (ReservationObserver observer : observers) {
            observer.onReservationCreated(reservation);
        }
    }

    public void notifyCancelled(Reservation reservation) {
        for (ReservationObserver observer : observers) {
            observer.onReservationCancelled(reservation);
        }
    }
}
