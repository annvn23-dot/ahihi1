package uef.edu.vn.managerpark.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import uef.edu.vn.managerpark.dao.DBConnection;

public class ParkingSlot {

    private int slotId;
    private String slotCode;
    private String slotType;
    private boolean occupied;

    public ParkingSlot() {
    }

    public ParkingSlot(
            int slotId,
            String slotCode,
            String slotType,
            boolean occupied) {

        this.slotId = slotId;
        this.slotCode = slotCode;
        this.slotType = slotType;
        this.occupied = occupied;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public String getSlotCode() {
        return slotCode;
    }

    public void setSlotCode(String slotCode) {
        this.slotCode = slotCode;
    }

    public String getSlotType() {
        return slotType;
    }

    public void setSlotType(String slotType) {
        this.slotType = slotType;
    }

    public boolean isOccupied() {
        return occupied;
    }

    public void setOccupied(boolean occupied) {
        this.occupied = occupied;
    }
    
public ParkingSlot findById(int slotId) {

    ParkingSlot slot = null;

    try (Connection con =
                 DBConnection.getConnection()) {

        String sql =
                "SELECT * FROM parking_slot " +
                "WHERE slot_id=?";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(1, slotId);

        ResultSet rs =
                ps.executeQuery();

        if (rs.next()) {

            slot = new ParkingSlot();

            slot.setSlotId(
                    rs.getInt("slot_id"));

            slot.setSlotCode(
                    rs.getString("slot_code"));

            slot.setSlotType(
                    rs.getString("slot_type"));

            slot.setOccupied(
                    rs.getBoolean("occupied"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return slot;
}


}
