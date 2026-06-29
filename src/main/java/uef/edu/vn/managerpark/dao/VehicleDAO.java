package uef.edu.vn.managerpark.dao;

import uef.edu.vn.managerpark.model.Vehicle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class VehicleDAO {

    // ================= KHỐI THỐNG KÊ DOANH THU THEO THỜI GIAN =================

    // 1. Doanh thu ngày hôm nay
    public double getTodayRevenue() {
        double total = 0;
        String sql = "SELECT IFNULL(SUM(amount), 0) FROM payment "
                   + "WHERE payment_status = 'Đã thanh toán' "
                   + "AND DATE(payment_time) = CURDATE()";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // 2. Doanh thu tuần này
    public double getWeeklyRevenue() {
        double total = 0;
        String sql = "SELECT IFNULL(SUM(amount), 0) FROM payment "
                   + "WHERE payment_status = 'Đã thanh toán' "
                   + "AND YEARWEEK(payment_time, 1) = YEARWEEK(CURDATE(), 1)";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // 3. Doanh thu tháng này
    public double getMonthlyRevenue() {
        double total = 0;
        String sql = "SELECT IFNULL(SUM(amount), 0) FROM payment "
                   + "WHERE payment_status = 'Đã thanh toán' "
                   + "AND MONTH(payment_time) = MONTH(CURDATE()) "
                   + "AND YEAR(payment_time) = YEAR(CURDATE())";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }


    // ================= KHỐI QUẢN LÝ THÔNG TIN PHƯƠNG TIỆN =================

    // Lấy tất cả xe
    public List<Vehicle> findAll() {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicle ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setId(rs.getInt("id"));
                vehicle.setLicensePlate(rs.getString("license_plate"));
                vehicle.setVehicleType(rs.getString("vehicle_type"));
                vehicle.setOwnerName(rs.getString("owner_name"));
                vehicle.setOwnerPhone(rs.getString("owner_phone"));
                list.add(vehicle);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái xe khi ra bãi
    public void checkoutVehicle(int id) {
        String sql = "UPDATE vehicle SET status = 'Đã lấy' WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Tìm phương tiện theo ID
    public Vehicle findById(int id) {
        Vehicle vehicle = null;
        String sql = "SELECT * FROM vehicle WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    vehicle = new Vehicle();
                    vehicle.setId(rs.getInt("id"));
                    vehicle.setLicensePlate(rs.getString("license_plate"));
                    vehicle.setVehicleType(rs.getString("vehicle_type"));
                    vehicle.setOwnerName(rs.getString("owner_name"));
                    vehicle.setOwnerPhone(rs.getString("owner_phone"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vehicle;
    }

    // Tìm phương tiện theo biển số
    public Vehicle findByLicensePlate(String licensePlate) {
        Vehicle vehicle = null;
        String sql = "SELECT * FROM vehicle WHERE license_plate = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, licensePlate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    vehicle = new Vehicle();
                    vehicle.setId(rs.getInt("id"));
                    vehicle.setLicensePlate(rs.getString("license_plate"));
                    vehicle.setVehicleType(rs.getString("vehicle_type"));
                    vehicle.setOwnerName(rs.getString("owner_name"));
                    vehicle.setOwnerPhone(rs.getString("owner_phone"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vehicle;
    }

    // Thêm xe mới vào danh mục hệ thống
    public void insert(Vehicle vehicle) {
        String sql = "INSERT INTO vehicle (license_plate, vehicle_type, owner_name, owner_phone) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, vehicle.getLicensePlate());
            ps.setString(2, vehicle.getVehicleType());
            ps.setString(3, vehicle.getOwnerName());
            ps.setString(4, vehicle.getOwnerPhone());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin xe
    public void update(Vehicle vehicle) {
        String sql = "UPDATE vehicle SET license_plate = ?, vehicle_type = ?, owner_name = ?, owner_phone = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, vehicle.getLicensePlate());
            ps.setString(2, vehicle.getVehicleType());
            ps.setString(3, vehicle.getOwnerName());
            ps.setString(4, vehicle.getOwnerPhone());
            ps.setInt(5, vehicle.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa xe khỏi danh mục
    public void delete(int id) {
        String sql = "DELETE FROM vehicle WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Đếm tổng số lượng xe trong danh mục hệ thống
    public int countVehicles() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM vehicle";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Đếm số lượng xe theo phân loại (Ô tô / Xe máy)
    public int countByType(String vehicleType) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM vehicle WHERE vehicle_type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, vehicleType);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
}