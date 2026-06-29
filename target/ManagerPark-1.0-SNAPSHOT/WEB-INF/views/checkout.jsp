<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="checkout-container">
    <div class="page-header">
        <h2><span class="material-symbols-outlined">local_shipping</span> Quản lý lấy xe</h2>
        <p>Danh sách các phương tiện hiện đang gửi trong hệ thống bãi xe</p>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-icon" style="background: #eff6ff; color: #2563eb;">
                <span class="material-symbols-outlined">directions_car</span>
            </div>
            <div class="stat-info">
                <h3>${logs.size()}</h3>
                <span>Xe đang gửi</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon" style="background: #f0fdf4; color: #16a34a;">
                <span class="material-symbols-outlined">grid_view</span>
            </div>
            <div class="stat-info">
                <h3>${(availableMoto != null ? availableMoto : 0) + (availableCar != null ? availableCar : 0)} chỗ</h3>
                <span>Số chỗ trống còn lại</span>
            </div>
        </div>
    </div>

    <div class="search-box">
        <span class="material-symbols-outlined search-icon">search</span>
        <input type="text" id="searchInput" placeholder="Nhập biển số xe cần tìm kiếm để lấy xe...">
    </div>

    <div class="table-card">
        <table id="vehicleTable">
            <thead>
                <tr>
                    <th style="width: 8%;">ID</th>
                    <th style="width: 24%;">Biển số</th>
                    <th style="width: 18%;">Loại xe</th>
                    <th style="width: 22%;">Giờ vào bãi</th>
                    <th style="width: 14%;">Trạng thái</th>
                    <th style="width: 14%; text-align: center;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty logs}">
                        <c:forEach items="${logs}" var="log">
                            <tr>
                                <td style="color: #94a3b8; font-weight: 500;">#${log.vehicleId}</td>
                                <td style="font-weight: 600; color: #0f172a;">
                                    <div style="display: flex; align-items: center; gap: 6px;">
                                        <span class="material-symbols-outlined" style="color: #94a3b8; font-size: 18px;">tag</span>
                                        ${log.licensePlate}
                                    </div>
                                </td>
                                <td>
                                    <span class="badge ${log.vehicleType eq 'Ô tô' || log.vehicleType eq 'O to' || log.vehicleType eq 'CAR' ? 'badge-car' : 'badge-moto'}">
                                        <span class="material-symbols-outlined">
                                            ${log.vehicleType eq 'Ô tô' || log.vehicleType eq 'O to' || log.vehicleType eq 'CAR' ? 'directions_car' : 'two_wheeler'}
                                        </span>
                                        ${log.vehicleType}
                                    </span>
                                </td>
                                <td style="color: #475569;">
                                    <div style="display: flex; align-items: center; gap: 6px;">
                                        <span class="material-symbols-outlined" style="font-size: 16px; color: #cbd5e1;">schedule</span>
                                        <span>${log.checkInTime}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="status-parking">Đang gửi</span>
                                </td>
                                <td style="text-align: center;">
                                    <a class="checkout-btn" href="${pageContext.request.contextPath}/payment/${log.vehicleId}">
                                        <span class="material-symbols-outlined" style="font-size: 16px;">credit_score</span> Thanh toán
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="empty-cell">
                                <span class="material-symbols-outlined" style="font-size: 48px; color: #cbd5e1;">minor_crash</span>
                                <p style="margin-top: 10px; color: #94a3b8;">Hiện không có phương tiện nào đang đỗ trong bãi</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                
                <tr id="noResultRow" style="display: none;">
                    <td colspan="6" class="empty-cell">
                        <span class="material-symbols-outlined" style="font-size: 48px; color: #cbd5e1;">search_off</span>
                        <p style="margin-top: 10px; color: #94a3b8;">Không tìm thấy xe nào khớp với biển số trên</p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
document.getElementById("searchInput").addEventListener("keyup", function() {
    let keyword = this.value.toLowerCase().trim();
    let rows = document.querySelectorAll("#vehicleTable tbody tr");
    let hasResult = false;
    let totalDataRows = 0;

    rows.forEach(row => {
        if (row.id === "noResultRow") return; 
        totalDataRows++;
        
        let plateCell = row.cells[1];
        if (plateCell) {
            let plate = plateCell.innerText.toLowerCase();
            if (plate.includes(keyword)) {
                row.style.display = "";
                hasResult = true;
            } else {
                row.style.display = "none";
            }
        }
    });

    let noResultRow = document.getElementById("noResultRow");
    if (noResultRow && totalDataRows > 0) {
        noResultRow.style.display = (!hasResult && keyword !== "") ? "" : "none";
    }
});
</script>

<style>
.checkout-container {
    padding: 24px;
    font-family: system-ui, -apple-system, sans-serif;
    background-color: #f8fafc;
}

.page-header {
    margin-bottom: 24px;
}
.page-header h2 {
    color: #0b2f8f;
    font-weight: 700;
    font-size: 24px;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 10px;
}
.page-header p {
    color: #64748b;
    font-size: 14px;
    margin-top: 6px;
}

/* Khối Thống kê */
.stats {
    display: flex;
    gap: 20px;
    margin-bottom: 24px;
}
.stat-card {
    flex: 1;
    background: #fff;
    padding: 20px;
    border-radius: 16px;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02), 0 2px 4px -2px rgba(0,0,0,0.02);
    border: 1px solid #e2e8f0;
    display: flex;
    align-items: center;
    gap: 16px;
}
.stat-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}
.stat-icon span { font-size: 24px !important; }
.stat-info h3 {
    font-size: 26px;
    color: #0f172a;
    font-weight: 700;
    margin: 0;
    line-height: 1.2;
}
.stat-info span {
    color: #64748b;
    font-size: 13px;
    font-weight: 500;
}

/* Ô tìm kiếm */
.search-box {
    position: relative;
    margin-bottom: 24px;
}
.search-box input {
    width: 100%;
    padding: 12px 16px 12px 44px;
    border: 1px solid #cbd5e1;
    border-radius: 12px;
    font-size: 14px;
    outline: none;
    transition: all 0.2s ease;
}
.search-box input:focus {
    border-color: #0b2f8f;
    box-shadow: 0 0 0 3px rgba(11, 47, 143, 0.15);
}
.search-icon {
    position: absolute;
    left: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: #94a3b8;
}

/* Bảng */
.table-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02), 0 2px 4px -2px rgba(0,0,0,0.02);
    border: 1px solid #e2e8f0;
}
table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed;
}
th {
    background: #f8fafc;
    padding: 14px 20px;
    text-align: left;
    color: #475569;
    font-weight: 600;
    font-size: 13px;
    text-transform: uppercase;
    border-bottom: 1px solid #edf2f7;
}
td {
    padding: 16px 20px;
    border-bottom: 1px solid #f1f5f9;
    color: #334155;
    font-size: 14px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
tr:last-child td { border-bottom: none; }
tr:hover td { background-color: #f8fafc; }

.status-parking {
    background: #eff6ff;
    color: #1d4ed8;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
}

.badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}
.badge span { font-size: 14px !important; }
.badge-moto { background: #f1f5f9; color: #475569; }
.badge-car { background: #f3e8ff; color: #7e22ce; }

.checkout-btn {
    background: #2563eb;
    color: white;
    text-decoration: none;
    padding: 8px 14px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 13px;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: all 0.2s ease;
}
.checkout-btn:hover {
    background: #1d4ed8;
    box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
}

.empty-cell {
    text-align: center;
    padding: 50px 0 !important;
}
</style>