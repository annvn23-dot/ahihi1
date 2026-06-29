package uef.edu.vn.managerpark.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAO {

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

    // --- HÀM QUAN TRỌNG ĐỂ HẾT LỖI DÒNG 86 ---
    public void savePayment(int vehicleId, double amount, String paymentMethod) {
        String sql = "INSERT INTO payment (vehicle_id, amount, payment_method, payment_status, payment_time) "
                   + "VALUES (?, ?, ?, 'Đã thanh toán', NOW())";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, vehicleId);
            ps.setDouble(2, amount);
            ps.setString(3, paymentMethod);
            
            ps.executeUpdate();
            System.out.println(">> Đã ghi nhận thanh toán thành công cho xe ID: " + vehicleId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}