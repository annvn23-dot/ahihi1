
package uef.edu.vn.managerpark.dao;

import uef.edu.vn.managerpark.model.ParkingSlot;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
@Repository
public class ParkingSlotDAO {

    // Danh sách tất cả vị trí đỗ
    public List<ParkingSlot> findAll() {

        List<ParkingSlot> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM parking_slot " +
                    "ORDER BY slot_code";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                ParkingSlot slot =
                        new ParkingSlot();

                slot.setSlotId(
                        rs.getInt("slot_id"));

                slot.setSlotCode(
                        rs.getString("slot_code"));

                slot.setSlotType(
                        rs.getString("slot_type"));

                slot.setOccupied(
                        rs.getBoolean("occupied"));

                list.add(slot);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Tìm vị trí trống theo loại xe
    public ParkingSlot findAvailableSlot(
            String slotType) {

        ParkingSlot slot = null;

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT * FROM parking_slot " +
                    "WHERE slot_type=? " +
                    "AND occupied=0 " +
                    "LIMIT 1";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, slotType);

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

    // Đánh dấu đã sử dụng
    public void occupySlot(int slotId) {

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "UPDATE parking_slot " +
                    "SET occupied=1 " +
                    "WHERE slot_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, slotId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Trả chỗ khi xe ra
    public void releaseSlot(int slotId) {

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "UPDATE parking_slot " +
                    "SET occupied=0 " +
                    "WHERE slot_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, slotId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Đếm chỗ trống
    public int countAvailableSlots() {

        int total = 0;

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT COUNT(*) " +
                    "FROM parking_slot " +
                    "WHERE occupied=0";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // Đếm chỗ đang sử dụng
    public int countOccupiedSlots() {

        int total = 0;

        try (Connection con = DBConnection.getConnection()) {

            String sql =
                    "SELECT COUNT(*) " +
                    "FROM parking_slot " +
                    "WHERE occupied=1";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
}

