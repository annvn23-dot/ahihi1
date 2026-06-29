package uef.edu.vn.managerpark.dao;

import uef.edu.vn.managerpark.model.AccessLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
@Repository
public class AccessLogDAO {

    public void checkIn(int vehicleId, int slotId) {

        try (Connection con = DBConnection.getConnection()) {

            String sql
                    = "INSERT INTO access_log "
                    + "(vehicle_id, slot_id, check_in_time, status) "
                    + "VALUES (?, ?, NOW(), ?)";

            PreparedStatement ps
                    = con.prepareStatement(sql);

            ps.setInt(1, vehicleId);
            ps.setInt(2, slotId);
            ps.setString(3, "Đang gửi");

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
public void checkout(int vehicleId) {

    try (
        Connection con =
                DBConnection.getConnection()
    ) {

        String sql =
                "UPDATE access_log "
              + "SET status='Đã lấy', "
              + "check_out_time=NOW() "
              + "WHERE vehicle_id=? "
              + "AND status='Đang gửi'";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ps.setInt(1, vehicleId);

        ps.executeUpdate();

    } catch (Exception e) {

        e.printStackTrace();

    }
}
    public void checkOut(int logId) {

        try (Connection con = DBConnection.getConnection()) {

            String sql
                    = "UPDATE access_log "
                    + "SET check_out_time = NOW(), "
                    + "status = ? "
                    + "WHERE log_id = ?";

            PreparedStatement ps
                    = con.prepareStatement(sql);

            ps.setString(1, "Đã lấy");
            ps.setInt(2, logId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public AccessLog findActiveLogByVehicle(int vehicleId) {

        AccessLog log = null;

        try (Connection con = DBConnection.getConnection()) {

            String sql
                    = "SELECT * FROM access_log "
                    + "WHERE vehicle_id=? "
                    + "AND status='Đang gửi'";

            PreparedStatement ps
                    = con.prepareStatement(sql);

            ps.setInt(1, vehicleId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                log = new AccessLog();

                log.setLogId(rs.getInt("log_id"));
                log.setVehicleId(rs.getInt("vehicle_id"));
                log.setSlotId(rs.getInt("slot_id"));
                log.setCheckInTime(
                        rs.getTimestamp("check_in_time")
                                .toLocalDateTime()
                );

                if (rs.getTimestamp("check_out_time") != null) {

                    log.setCheckOutTime(
                            rs.getTimestamp("check_out_time")
                                    .toLocalDateTime()
                    );
                }

                log.setStatus(
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return log;
    }

    public List<AccessLog> recentLogs() {

    List<AccessLog> list =
            new ArrayList<>();

    try (Connection con =
                 DBConnection.getConnection()) {

        String sql =
                "SELECT a.*, " +
                "v.license_plate, " +
                "v.vehicle_type " +
                "FROM access_log a " +
                "JOIN vehicle v " +
                "ON a.vehicle_id=v.id " +
                "ORDER BY a.check_in_time DESC " +
                "LIMIT 10";

        PreparedStatement ps =
                con.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        while (rs.next()) {

            AccessLog log =
                    new AccessLog();

            log.setLogId(
                    rs.getInt("log_id"));

            log.setVehicleId(
                    rs.getInt("vehicle_id"));

            log.setSlotId(
                    rs.getInt("slot_id"));

            log.setLicensePlate(
                    rs.getString("license_plate"));

            log.setVehicleType(
                    rs.getString("vehicle_type"));

            log.setCheckInTime(
                    rs.getTimestamp("check_in_time")
                            .toLocalDateTime());

            log.setStatus(
                    rs.getString("status"));

            list.add(log);
        }

    } catch (Exception e) {

        e.printStackTrace();
    }

    return list;
}
    public List<AccessLog> findAll() {
    List<AccessLog> list = new ArrayList<>();
    
    // ĐÃ SỬA: Thay thế a.id bằng a.log_id để khớp hoàn toàn với MySQL của bạn
    String sql = "SELECT a.*, v.license_plate, v.vehicle_type " +
                 "FROM access_log a " +
                 "JOIN vehicle v ON a.vehicle_id = v.id " +
                 "ORDER BY a.log_id DESC"; // Đã sửa từ a.id -> a.log_id

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            AccessLog log = new AccessLog();
            
            // ĐÃ SỬA: Lấy đúng cột "log_id" thay vì "id"
            log.setLogId(rs.getInt("log_id")); 
            
            log.setVehicleId(rs.getInt("vehicle_id"));
            log.setSlotId(rs.getInt("slot_id"));
            log.setLicensePlate(rs.getString("license_plate"));
            log.setVehicleType(rs.getString("vehicle_type"));
            
            if (rs.getTimestamp("check_in_time") != null) {
                log.setCheckInTime(rs.getTimestamp("check_in_time").toLocalDateTime());
            }
            
            if (rs.getTimestamp("check_out_time") != null) {
                log.setCheckOutTime(rs.getTimestamp("check_out_time").toLocalDateTime());
            }

            log.setStatus(rs.getString("status"));

            list.add(log);
        }
    } catch (Exception e) {
        System.out.println("Lỗi tại hàm findAll của AccessLogDAO: " + e.getMessage());
        e.printStackTrace();
    }
    
    return list;
}
    public List<AccessLog> findActiveLogs() {
    List<AccessLog> list = new ArrayList<>();
    
    // Đã sửa: Lấy a.log_id, a.vehicle_id và lọc theo trạng thái thực tế 'Đang gửi'
    String sql = "SELECT a.log_id, a.slot_id, a.check_in_time, a.status, " +
                 "v.id AS vehicle_id, v.license_plate, v.vehicle_type " +
                 "FROM access_log a " +
                 "JOIN vehicle v ON a.vehicle_id = v.id " +
                 "WHERE a.status = 'Đang gửi' AND a.check_out_time IS NULL " +
                 "ORDER BY a.log_id DESC";
                 
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            AccessLog log = new AccessLog();
            
            // Ánh xạ chính xác tên cột từ Database vào các Setter của Model AccessLog
            log.setLogId(rs.getInt("log_id")); // Khớp với trường log_id trong DB của bạn
            log.setVehicleId(rs.getInt("vehicle_id")); // Dùng cho hàm xử lý thanh toán nút bấm
            log.setSlotId(rs.getInt("slot_id"));
            log.setLicensePlate(rs.getString("license_plate"));
            log.setVehicleType(rs.getString("vehicle_type"));
            
            if (rs.getTimestamp("check_in_time") != null) {
                log.setCheckInTime(rs.getTimestamp("check_in_time").toLocalDateTime());
            }
            log.setStatus(rs.getString("status"));
            
            list.add(log);
        }
    } catch (Exception e) {
        System.out.println("Lỗi nghiêm trọng tại findActiveLogs: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}

    public AccessLog findById(int logId) {

        AccessLog log = null;

        try (Connection con
                = DBConnection.getConnection()) {

            String sql
                    = "SELECT * FROM access_log "
                    + "WHERE log_id=?";

            PreparedStatement ps
                    = con.prepareStatement(sql);

            ps.setInt(1, logId);

            ResultSet rs
                    = ps.executeQuery();

            if (rs.next()) {

                log = new AccessLog();

                log.setLogId(
                        rs.getInt("log_id"));

                log.setVehicleId(
                        rs.getInt("vehicle_id"));

                log.setSlotId(
                        rs.getInt("slot_id"));

                log.setCheckInTime(
                        rs.getTimestamp("check_in_time")
                                .toLocalDateTime());

                if (rs.getTimestamp("check_out_time") != null) {

                    log.setCheckOutTime(
                            rs.getTimestamp("check_out_time")
                                    .toLocalDateTime());
                }

                log.setStatus(
                        rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return log;
    }

    // ĐANG GỬI
    public int countActiveVehicles() {

        int total = 0;

        try (Connection con = DBConnection.getConnection()) {

            String sql
                    = "SELECT COUNT(*) "
                    + "FROM access_log "
                    + "WHERE status='Đang gửi'";

            PreparedStatement ps
                    = con.prepareStatement(sql);

            ResultSet rs
                    = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
}
