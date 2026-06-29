<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="page-header">
    <h2>👥 Quản lý tài khoản</h2>
    <p>Danh sách nhân viên điều hành hệ thống SmartPark</p>
</div>

<div class="stats-container">
    <div class="stat-card blue-theme">
        <div class="stat-icon">
            <span class="material-symbols-outlined">badge</span>
        </div>
        <div class="stat-info">
            <h3>${users.size()}</h3>
            <span>Tổng số tài khoản</span>
        </div>
    </div>
    
    <a href="${pageContext.request.contextPath}/create-user" class="stat-card action-theme">
        <div class="stat-icon">
            <span class="material-symbols-outlined">person_add</span>
        </div>
        <div class="stat-info">
            <h3>Thêm mới</h3>
            <span>Cấp tài khoản nhân viên</span>
        </div>
    </a>
</div>

<div class="search-wrapper">
    <span class="material-symbols-outlined search-icon">search</span>
    <input type="text" 
           id="userSearchInput" 
           placeholder="Tìm theo tên nhân viên, tên đăng nhập...">
</div>

<div class="table-container">
    <table id="userTable">
        <thead>
            <tr>
                <th style="width: 60px;">ID</th>
                <th>Tên đăng nhập</th>
                <th>Mật khẩu</th> <th>Họ và tên</th>
                <th>Số điện thoại</th>
                <th>Vai trò</th>
                <th style="text-align: center; width: 180px;">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${users}" var="u">
                <tr>
                    <td class="id-cell">#${u.id}</td>
                    <td class="username-cell"><strong>${u.username}</strong></td>
                    
                    <td class="password-cell">
                        <div class="password-wrapper" title="Rê chuột vào để xem mật khẩu">
                            <span class="pass-hidden">••••••</span>
                            <span class="pass-visible">${u.password}</span>
                        </div>
                    </td>

                    <td class="name-cell">${u.fullName}</td>
                    <td class="phone-cell">
                        <span class="phone-text">${u.phoneNumber != null ? u.phoneNumber : '---'}</span>
                    </td>
                    <td>
                        <span class="role-badge ${u.role eq 'ADMIN' ? 'role-admin' : 'role-staff'}">
                            <span class="material-symbols-outlined badge-icon">
                                ${u.role eq 'ADMIN' ? 'admin_panel_settings' : 'engineering'}
                            </span>
                            ${u.role}
                        </span>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <a class="btn-action edit-btn" href="${pageContext.request.contextPath}/users/edit/${u.id}" title="Chỉnh sửa">
                                <span class="material-symbols-outlined">edit</span> Sửa
                            </a>
                            <c:if test="${sessionScope.user.username ne u.username}">
                                <a class="btn-action delete-btn" 
                                   href="${pageContext.request.contextPath}/users/delete/${u.id}"
                                   onclick="return confirm('Bạn chắc chắn muốn xóa tài khoản [${u.username}] không?');"
                                   title="Xóa tài khoản">
                                    <span class="material-symbols-outlined">delete</span> Xóa
                                </a>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
document.getElementById("userSearchInput").addEventListener("keyup", function() {
    let keyword = this.value.toLowerCase();
    let rows = document.querySelectorAll("#userTable tbody tr");

    rows.forEach(row => {
        let username = row.querySelector(".username-cell").innerText.toLowerCase();
        let fullName = row.querySelector(".name-cell").innerText.toLowerCase();
        
        if (username.includes(keyword) || fullName.includes(keyword)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
});
</script>

<style>
/* Header */
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

/* Stats Layout */
.stats-container {
    display: flex;
    gap: 20px;
    margin-bottom: 25px;
}
.stat-card {
    flex: 1;
    background: white;
    border-radius: 16px;
    padding: 20px 24px;
    display: flex;
    align-items: center;
    gap: 20px;
    text-decoration: none;
    box-shadow: 0 4px 12px rgba(0,0,0,.03);
    border: 1px solid #e2e8f0;
    transition: transform 0.2s, box-shadow 0.2s;
}
.stat-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(0,0,0,.06);
}
.stat-icon {
    width: 52px;
    height: 52px;
    border-radius: 12px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.stat-icon span {
    font-size: 28px;
}
.stat-info h3 {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 2px;
}
.stat-info span {
    font-size: 13px;
    color: #64748b;
}

/* Khối màu cho Stats */
.blue-theme .stat-icon { background: #eff6ff; color: #1e40af; }
.blue-theme h3 { color: #1e40af; }
.action-theme .stat-icon { background: #f0fdf4; color: #15803d; }
.action-theme h3 { color: #15803d; }

/* Ô Tìm kiếm cải tiến */
.search-wrapper {
    position: relative;
    margin-bottom: 25px;
    max-width: 450px;
}
.search-icon {
    position: absolute;
    left: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: #94a3b8;
}
.search-wrapper input {
    width: 100%;
    padding: 12px 16px 12px 45px;
    border: 1px solid #cbd5e1;
    border-radius: 12px;
    font-size: 14px;
    outline: none;
    transition: all 0.2s;
}
.search-wrapper input:focus {
    border-color: #0b2f8f;
    box-shadow: 0 0 0 3px rgba(11, 47, 143, 0.1);
}

/* Khối Bảng hiện đại */
.table-container {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,.03);
    border: 1px solid #e2e8f0;
}
table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
}
thead {
    background: #f8fafc;
    border-bottom: 2px solid #edf2f7;
}
th {
    padding: 16px 20px;
    color: #475569;
    font-weight: 600;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
td {
    padding: 16px 20px;
    color: #334155;
    font-size: 15px;
    border-bottom: 1px solid #f1f5f9;
}
tr:last-child td {
    border-bottom: none;
}
tr:hover td {
    background: #fdfdfd;
}

.id-cell { color: #94a3b8; font-weight: 500; }
.username-cell { color: #0f172a; }
.phone-text { background: #f8fafc; padding: 4px 8px; border-radius: 6px; font-family: monospace; font-size: 13px; color: #475569; }

/* CSS Xử lý che giấu / Hiển thị Mật khẩu thông minh khi hover */
.password-wrapper {
    background: #f1f5f9;
    padding: 6px 10px;
    border-radius: 6px;
    display: inline-block;
    font-family: monospace;
    font-size: 14px;
    min-width: 90px;
    text-align: center;
    color: #64748b;
    cursor: pointer;
    transition: all 0.2s;
}
.password-wrapper .pass-visible { display: none; }
.password-wrapper .pass-hidden { display: inline; }

.password-wrapper:hover {
    background: #e2e8f0;
    color: #0f172a;
    font-weight: 600;
}
.password-wrapper:hover .pass-visible { display: inline; }
.password-wrapper:hover .pass-hidden { display: none; }

/* Role Badges */
.role-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}
.badge-icon { font-size: 16px !important; }
.role-admin { background: #fee2e2; color: #991b1b; }
.role-staff { background: #e0f2fe; color: #0369a1; }

/* Buttons hành động */
.action-buttons {
    display: flex;
    gap: 8px;
    justify-content: center;
}
.btn-action {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.2s;
    cursor: pointer;
}
.btn-action span { font-size: 16px !important; }

.edit-btn {
    background: #f1f5f9;
    color: #334155;
    border: 1px solid #cbd5e1;
}
.edit-btn:hover {
    background: #e2e8f0;
    color: #0f172a;
}
.delete-btn {
    background: #fff5f5;
    color: #e11d48;
    border: 1px solid #fee2e2;
}
.delete-btn:hover {
    background: #ffe4e6;
    color: #be123c;
    border-color: #fecdd3;
}
</style>