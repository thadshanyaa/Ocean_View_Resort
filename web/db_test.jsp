<%@ page import="java.sql.*, ovr.*, java.io.*" %>
    <% String resNum="OVR-20260303-9195" ; out.println("TESTING RESERVATION: " + resNum + " \n"); try {
        DBConnectionManager db=DBConnectionManager.getInstance(); Connection conn=db.getConnection(); ReservationDAO
        rd=new ReservationDAO(conn); Reservation res=rd.getByReservationNumber(resNum); if (res==null) {
        out.println("RES IS NULL!"); } else { out.println("RES FOUND! ID=" + res.getId() + " ,
        RoomID=" + res.getRoomId() + " , GuestID=" + res.getGuestId());
            Room room = new RoomDAO(conn).getById(res.getRoomId());
            out.println(" ROOM IS NULL? " + (room == null));
            if (room != null) out.println(" RoomTypeID=" + room.getRoomTypeId());
            
            Guest guest = new GuestDAO(conn).getById(res.getGuestId());
            out.println(" GUEST IS NULL? " + (guest == null));
            
            Bill bill = new BillDAO(conn).getByReservationId(res.getId());
            out.println(" BILL IS NULL? " + (bill == null));
        }
    } catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));
    }
%>