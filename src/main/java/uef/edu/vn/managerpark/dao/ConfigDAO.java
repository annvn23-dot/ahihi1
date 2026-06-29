package uef.edu.vn.managerpark.dao;

import uef.edu.vn.managerpark.model.SystemConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class ConfigDAO {

    // 1. Lấy giá trị cấu hình theo Key (Trả về String để xử lý đa năng)
    public String getValue(String key) {
        String sql = "SELECT config_value FROM system_config WHERE config_key = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, key);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("config_value");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; 
    }

    // 2. Lấy toàn bộ danh sách cấu hình để hiển thị lên bảng Admin nếu cần
    public List<SystemConfig> getAllConfigs() {
        List<SystemConfig> list = new ArrayList<>();
        String sql = "SELECT * FROM system_config";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new SystemConfig(
                    rs.getString("config_key"),
                    rs.getString("config_value"),
                    rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Hàm cập nhật giá trị theo từng Key khi Admin sửa
    public void updateValue(String key, String value) {
        String sql = "UPDATE system_config SET config_value = ? WHERE config_key = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, value);
            ps.setString(2, key);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}