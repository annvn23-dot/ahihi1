<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="config-wrapper">
    <div class="page-header">
        <h2><span class="material-symbols-outlined">settings_applications</span> Cấu hình hệ thống bãi xe</h2>
        <p>Thiết lập sức chứa, bảng giá và thông tin vận hành của bãi xe</p>
    </div>

    <c:if test="${param.success eq 'true'}">
        <div class="alert-success">
            <span class="material-symbols-outlined">check_circle</span>
            Cấu hình đã được cập nhật thành công vào hệ thống!
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/config/save" method="post">
        <div class="config-grid">
            
            <div class="config-card">
                <div class="card-header">
                    <span class="material-symbols-outlined">grid_view</span>
                    <h3>Quản lý sức chứa</h3>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label>Số chỗ Xe máy tối đa</label>
                        <input type="number" name="maxMoto" value="${maxMoto}" required>
                        <small>Hệ thống sẽ chặn khi số xe máy vượt ngưỡng này.</small>
                    </div>
                    <div class="form-group">
                        <label>Số chỗ Ô tô tối đa</label>
                        <input type="number" name="maxCar" value="${maxCar}" required>
                        <small>Hệ thống sẽ chặn khi số ô tô vượt ngưỡng này.</small>
                    </div>
                </div>
            </div>

            <div class="config-card">
    <div class="card-header" style="color: #16a34a;">
        <span class="material-symbols-outlined">payments</span>
        <h3>Bảng giá dịch vụ (VNĐ)</h3>
    </div>
    <div class="card-body">
        <div class="form-group">
            <label>Giá vé Xe máy (theo lượt)</label>
            <input type="number" name="priceMoto" value="${priceMoto}" required>
        </div>
        <div class="form-group">
            <label>Phụ phí Xe máy qua đêm</label>
            <input type="number" name="surchargeMotoNight" value="${surchargeMotoNight}" required>
        </div>
        <hr style="margin: 20px 0; border: 0; border-top: 1px dashed #e2e8f0;">
        <div class="form-group">
            <label>Giá vé Ô tô (theo lượt)</label>
            <input type="number" name="priceCar" value="${priceCar}" required>
        </div>
        <div class="form-group">
            <label>Phụ phí Ô tô qua đêm</label>
            <input type="number" name="surchargeCarNight" value="${surchargeCarNight}" required>
        </div>
    </div>
</div>

            <div class="config-card full-width">
                <div class="card-header" style="color: #6b21a8;">
                    <span class="material-symbols-outlined">info</span>
                    <h3>Thông tin vận hành</h3>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label>Tên hiển thị của bãi xe</label>
                        <input type="text" name="parkingName" value="${parkingName}" placeholder="VD: Bãi xe UEF Smart Park" required>
                    </div>
                </div>
            </div>
        </div>

        <div class="action-bar">
            <button type="submit" class="btn-save">
                <span class="material-symbols-outlined">save</span> LƯU TẤT CẢ CẤU HÌNH
            </button>
        </div>
    </form>
</div>

<style>
.config-wrapper { padding: 24px; font-family: system-ui, sans-serif; background: #f8fafc; }
.page-header h2 { color: #0b2f8f; display: flex; align-items: center; gap: 10px; margin: 0; }
.page-header p { color: #64748b; margin: 5px 0 25px 0; font-size: 14px; }

.alert-success {
    background: #f0fdf4; color: #16a34a; padding: 15px; border-radius: 12px;
    border: 1px solid #bbf7d0; margin-bottom: 25px; display: flex; align-items: center; gap: 10px;
    font-weight: 600; animation: slideIn 0.3s ease;
}

.config-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
.full-width { grid-column: span 2; }

.config-card {
    background: white; border-radius: 16px; border: 1px solid #e2e8f0;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02); overflow: hidden;
}
.card-header {
    padding: 18px 24px; border-bottom: 1px solid #f1f5f9; display: flex;
    align-items: center; gap: 10px; color: #0b2f8f;
}
.card-header h3 { margin: 0; font-size: 16px; font-weight: 700; }

.card-body { padding: 24px; }
.form-group { margin-bottom: 20px; }
.form-group:last-child { margin-bottom: 0; }
.form-group label { display: block; font-weight: 600; color: #334155; margin-bottom: 8px; font-size: 14px; }
.form-group input {
    width: 100%; padding: 12px; border: 1px solid #cbd5e1; border-radius: 10px;
    outline: none; transition: 0.2s; font-size: 15px;
}
.form-group input:focus { border-color: #0b2f8f; box-shadow: 0 0 0 3px rgba(11,47,143,0.1); }
.form-group small { color: #94a3b8; font-size: 12px; margin-top: 5px; display: block; }

.action-bar { margin-top: 30px; text-align: right; }
.btn-save {
    background: #0b2f8f; color: white; border: none; padding: 15px 40px;
    border-radius: 12px; font-weight: 700; cursor: pointer; display: inline-flex;
    align-items: center; gap: 10px; transition: 0.2s;
}
.btn-save:hover { background: #082269; transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(11,47,143,0.3); }

@keyframes slideIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
</style>