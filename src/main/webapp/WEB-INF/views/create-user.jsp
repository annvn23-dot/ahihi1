<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="page-header">
    <c:choose>
        <c:when test="${not empty userEdit}">
            <h2>📝 Chỉnh sửa tài khoản</h2>
            <p>Cập nhật thông tin vận hành cho tài khoản <strong>${userEdit.username}</strong></p>
        </c:when>
        <c:otherwise>
            <h2>👤 Tạo tài khoản mới</h2>
            <p>Cấp tài khoản vận hành bãi xe cho nhân viên hoặc quản trị viên</p>
        </c:otherwise>
    </c:choose>
</div>

<c:if test="${not empty message}">
    <div class="alert-box ${message.contains('Lỗi') ? 'alert-danger' : 'alert-success'}">
        <span class="material-symbols-outlined">
            ${message.contains('Lỗi') ? 'error' : 'check_circle'}
        </span>
        <p>${message}</p>
    </div>
</c:if>

<div class="form-container">
    <div class="form-header">
        <span class="material-symbols-outlined form-header-icon">
            ${not empty userEdit ? 'manage_accounts' : 'person_add'}
        </span>
        <div>
            <h3>${not empty userEdit ? 'Cập nhật thông tin' : 'Thông tin tài khoản mới'}</h3>
            <p>${not empty userEdit ? 'Tên đăng nhập là cố định không thể thay đổi' : 'Vui lòng điền đầy đủ thông tin vào các trường (*)'}</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}${not empty userEdit ? '/users/update' : '/users/create'}" 
          method="POST" 
          onsubmit="return validateForm()">

        <c:if test="${not empty userEdit}">
            <input type="hidden" name="id" value="${userEdit.id}">
        </c:if>

        <div class="form-group">
            <label for="fullName">Họ và tên <span class="required">*</span></label>
            <div class="input-wrapper">
                <span class="material-symbols-outlined input-icon">badge</span>
                <input type="text" id="fullName" name="fullName" 
                       value="${not empty userEdit ? userEdit.fullName : ''}" 
                       placeholder="Nhập họ và tên..." required>
            </div>
        </div>

        <div class="form-group">
            <label for="username">Tên đăng nhập (Username) <span class="required">*</span></label>
            <div class="input-wrapper">
                <span class="material-symbols-outlined input-icon">person</span>
                <input type="text" id="username" name="username" 
                       value="${not empty userEdit ? userEdit.username : ''}" 
                       ${not empty userEdit ? 'readonly class="disabled-input"' : ''} 
                       placeholder="Ví dụ: nva_staff" required>
            </div>
        </div>

        <div class="form-grid">
            <div class="form-group">
                <label for="role">Vai trò hệ thống <span class="required">*</span></label>
                <div class="input-wrapper">
                    <span class="material-symbols-outlined input-icon">admin_panel_settings</span>
                    <select id="role" name="role" required>
                        <option value="" disabled ${empty userEdit ? 'selected' : ''}>-- Chọn vai trò --</option>
                        <option value="STAFF" ${userEdit.role eq 'STAFF' ? 'selected' : ''}>Nhân viên (STAFF)</option>
                        <option value="ADMIN" ${userEdit.role eq 'ADMIN' ? 'selected' : ''}>Quản trị viên (ADMIN)</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="phoneNumber">Số điện thoại</label>
                <div class="input-wrapper">
                    <span class="material-symbols-outlined input-icon">call</span>
                    <input type="tel" id="phoneNumber" name="phoneNumber" 
                           value="${not empty userEdit ? userEdit.phoneNumber : ''}" 
                           placeholder="Nhập số điện thoại...">
                </div>
            </div>
        </div>

        <div class="form-grid">
            <div class="form-group">
                <label for="password">
                    Mật khẩu <c:if test="${empty userEdit}"><span class="required">*</span></c:if>
                </label>
                <div class="input-wrapper">
                    <span class="material-symbols-outlined input-icon">lock</span>
                    <input type="password" id="password" name="password" 
                           placeholder="${not empty userEdit ? 'Để trống nếu không muốn đổi mật khẩu mới...' : 'Tối thiểu 6 ký tự...'}" 
                           ${empty userEdit ? 'required' : ''}>
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">
                    Xác nhận mật khẩu <c:if test="${empty userEdit}"><span class="required">*</span></c:if>
                </label>
                <div class="input-wrapper">
                    <span class="material-symbols-outlined input-icon">lock_reset</span>
                    <input type="password" id="confirmPassword" 
                           placeholder="${not empty userEdit ? 'Nhập lại mật khẩu mới để xác nhận...' : 'Nhập lại mật khẩu...'}" 
                           ${empty userEdit ? 'required' : ''}>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/users" class="btn-action btn-secondary">
                <span class="material-symbols-outlined">${not empty userEdit ? 'arrow_back' : 'restart_alt'}</span> 
                ${not empty userEdit ? 'Hủy bỏ' : 'Quay lại'}
            </a>
            <button type="submit" class="btn-action btn-primary">
                <span class="material-symbols-outlined">${not empty userEdit ? 'save' : 'how_to_reg'}</span> 
                ${not empty userEdit ? 'Lưu thay đổi' : 'Tạo tài khoản'}
            </button>
        </div>
    </form>
</div>

<script>
    function validateForm() {
        let password = document.getElementById("password").value;
        let confirmPassword = document.getElementById("confirmPassword").value;
        let isEditMode = ${not empty userEdit ? 'true' : 'false'};

        // Nếu ở chế độ sửa, cho phép bỏ qua nếu admin không nhập gì vào cả 2 ô mật khẩu
        if (isEditMode && password.length === 0 && confirmPassword.length === 0) {
            return true;
        }

        if (password.length < 6) {
            alert("Mật khẩu bảo mật phải chứa ít nhất 6 ký tự!");
            return false;
        }
        if (password !== confirmPassword) {
            alert("Mật khẩu xác nhận không trùng khớp!");
            return false;
        }
        return true;
    }
</script>

<style>
    .page-header {
        margin-bottom: 25px;
    }
    .page-header h2 {
        color: #0b2f8f;
        font-size: 26px;
        font-weight: 700;
    }
    .page-header p {
        color: #64748b;
        margin-top: 4px;
        font-size: 14px;
    }
    .alert-box {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 14px 20px;
        border-radius: 12px;
        margin-bottom: 25px;
        max-width: 750px;
        font-size: 14px;
        font-weight: 500;
    }
    .alert-success {
        background: #f0fdf4;
        color: #15803d;
        border: 1px solid #bbf7d0;
    }
    .alert-danger {
        background: #fef2f2;
        color: #b91c1c;
        border: 1px solid #fecaca;
    }
    .form-container {
        background: white;
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0,0,0,.03);
        border: 1px solid #e2e8f0;
        max-width: 750px;
    }
    .form-header {
        display: flex;
        align-items: center;
        gap: 15px;
        border-bottom: 1px solid #f1f5f9;
        padding-bottom: 20px;
        margin-bottom: 25px;
    }
    .form-header-icon {
        font-size: 32px !important;
        color: #0b2f8f;
        background: #eff6ff;
        padding: 10px;
        border-radius: 12px;
    }
    .form-header h3 {
        color: #0f172a;
        font-size: 18px;
        font-weight: 600;
    }
    .form-header p {
        color: #94a3b8;
        font-size: 13px;
        margin-top: 2px;
    }
    .form-group {
        margin-bottom: 20px;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
    .form-group label {
        font-weight: 600;
        color: #334155;
        font-size: 14px;
    }
    .required {
        color: #ef4444;
    }
    .disabled-input {
        background-color: #f8fafc !important;
        color: #94a3b8 !important;
        border-color: #e2e8f0 !important;
        cursor: not-allowed;
    }
    .input-wrapper {
        position: relative;
        width: 100%;
    }
    .input-icon {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #94a3b8;
        font-size: 20px !important;
    }
    .form-container input, .form-container select {
        width: 100%;
        padding: 12px 16px 12px 42px;
        border: 1px solid #cbd5e1;
        border-radius: 10px;
        font-size: 14px;
        color: #334155;
        outline: none;
        background-color: #fff;
        transition: all 0.2s;
    }
    .form-container input:focus, .form-container select:focus {
        border-color: #0b2f8f;
        box-shadow: 0 0 0 3px rgba(11, 47, 143, 0.1);
    }
    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 15px;
        margin-top: 15px;
        border-top: 1px solid #f1f5f9;
        padding-top: 25px;
    }
    .btn-action {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 12px 24px;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        border: none;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.2s;
    }
    .btn-action span {
        font-size: 18px !important;
    }
    .btn-primary {
        background: #0b2f8f;
        color: white;
    }
    .btn-primary:hover {
        background: #082269;
    }
    .btn-secondary {
        background: #f1f5f9;
        color: #475569;
        border: 1px solid #cbd5e1;
    }
    .btn-secondary:hover {
        background: #e2e8f0;
        color: #0f172a;
    }
</style>