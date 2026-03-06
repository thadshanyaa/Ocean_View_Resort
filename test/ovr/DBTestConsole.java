package ovr;

import java.sql.Connection;
import java.util.List;

/**
 * Migrated from src/java/ovr/DBTestConsole.java
 * Formalized as a manual test console within the test package.
 */
public class DBTestConsole {
    public static void main(String[] args) {
        String resNum = "OVR-20260303-9497";
        System.out.println("TESTING DEEP LOAD FOR: " + resNum);
        try {
            DBConnectionManager db = DBConnectionManager.getInstance();
            Connection conn = db.getConnection();
            
            ReservationDAO resDao = new ReservationDAO(conn);
            Reservation res = resDao.getByReservationNumber(resNum);
            if (res == null) {
                System.out.println("RES IS NULL in DAO!");
                return;
            }
            System.out.println("1/6: Res OK. ID=" + res.getId() + ", RoomID=" + res.getRoomId()+", GuestID="+res.getGuestId());
            
            Room room = new RoomDAO(conn).getById(res.getRoomId());
            if (room == null) throw new Exception("Room is NULL");
            System.out.println("2/6: Room OK. RoomTypeID=" + room.getRoomTypeId());
            
            RoomType type = new RoomTypeDAO(conn).getById(room.getRoomTypeId());
            if (type == null) throw new Exception("RoomType is NULL");
            System.out.println("3/6: RoomType OK. Name=" + type.getTypeName());
            
            Guest guest = new GuestDAO(conn).getById(res.getGuestId());
            if (guest == null) throw new Exception("Guest is NULL");
            System.out.println("4/6: Guest OK. Name=" + guest.getFullName());
            
            Bill bill = new BillDAO(conn).getByReservationId(res.getId());
            if (bill == null) throw new Exception("Bill is NULL");
            System.out.println("5/6: Bill OK. ID=" + bill.getId());
            
            AdditionalChargeDAO chargeDao = new AdditionalChargeDAO(conn);
            List<AdditionalCharge> charges = chargeDao.getByReservationId(res.getId());
            System.out.println("5.5/6: Charges OK. Count=" + charges.size());
            
            PaymentDAO paymentDao = new PaymentDAO(conn);
            List<Payment> payments = paymentDao.getByBillId(bill.getId());
            System.out.println("6/6: Payments OK. Count=" + payments.size());
            
            System.out.println("ALL OK. Sanity test passed.");
        } catch (Exception e) {
            System.out.println("EXCEPTION CAUGHT!");
            e.printStackTrace();
        }
    }
}
