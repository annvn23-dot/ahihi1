<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="history-container">
    
    <div class="history-header">
        <div class="title-section">
            <h1>📋 Lịch sử gửi xe</h1>
            <p>Quản lý và tra cứu toàn bộ lịch sử phương tiện ra vào bãi</p>
        </div>
        
        <div class="search-box">
            <span class="material-symbols-outlined search-icon">search</span>
            <input type="text" id="historySearch" onkeyup="filterHistoryTable()" placeholder="Nhập biển số xe cần tìm kiếm...">
        </div>
    </div>

    <div class="table-box">
        <table id="historyTable">
            <thead>
                <tr>
                    <th style="width: 8%;">ID</th>
                    <th style="width: 22%;">Biển số xe</th>
                    <th style="width: 18%;">Phân loại xe</th>
                    <th style="width: 22%;">Thời gian vào</th>
                    <th style="width: 22%;">Thời gian ra</th>
                    <th style="text-align: center; width: 10%;">Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty logs}">
                        <c:forEach items="${logs}" var="log">
                            <tr>
                                <td class="id-cell">#${log.logId}</td>
                                
                                <td class="plate-cell">
                                    <span class="material-symbols-outlined plate-icon">tag</span>
                                    <strong>${log.licensePlate}</strong>
                                </td>
                                
                                <td>
                                    <span class="badge ${log.vehicleType eq 'Ô tô' || log.vehicleType eq 'O to' || log.vehicleType eq 'CAR' ? 'badge-car' : 'badge-moto'}">
                                        <span class="material-symbols-outlined">
                                            ${log.vehicleType eq 'Ô tô' || log.vehicleType eq 'O to' || log.vehicleType eq 'CAR' ? 'directions_car' : 'two_wheeler'}
                                        </span>
                                        ${log.vehicleType}
                                    </span>
                                </td>
                                
                                <td class="time-cell">
                                    <span class="material-symbols-outlined time-icon">login</span>
                                    ${log.checkInTime}
                                </td>
                                
                                <td class="time-cell">
                                    <span class="material-symbols-outlined time-icon" style="color: #ef4444;">logout</span>
                                    <c:choose>
                                        <c:when test="${not empty log.checkOutTime}">
                                            ${log.checkOutTime}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted-italic">Chưa xuất bãi</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                                <td style="text-align: center;">
                                    <span class="status-badge ${log.status eq 'Đang gửi' ? 'status-parking' : 'status-done'}">
                                        ${log.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr id="noDataRow">
                            <td colspan="6" class="empty-cell">
                                <span class="material-symbols-outlined empty-icon">folder_open</span>
                                <p>Hệ thống chưa ghi nhận dữ liệu lịch sử nào</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                
                <tr id="noResultRow" style="display: none;">
                    <td colspan="6" class="empty-cell">
                        <span class="material-symbols-outlined empty-icon">search_off</span>
                        <p>Không tìm thấy phương tiện nào khớp với từ khóa</p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<style>
/* Toàn bộ khung container */
.history-container {
    padding: 24px;
    font-family: system-ui, -apple-system, sans-serif;
    background-color: #f8fafc;
}

/* Tiêu đề & Thanh tìm kiếm */
.history-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    gap: 20px;
    flex-wrap: wrap;
}
.title-section h1 {
    font-size: 26px;
    color: #0b2f8f;
    font-weight: 700;
    margin: 0;
}
.title-section p {
    font-size: 14px;
    color: #64748b;
    margin: 6px 0 0 0;
}

/* Ô tìm kiếm bo tròn hiện đại */
.search-box {
    position: relative;
    width: 320px;
}
.search-box input {
    width: 100%;
    padding: 12px 16px 12px 42px;
    border: 1px solid #cbd5e1;
    border-radius: 10px;
    font-size: 14px;
    color: #334155;
    outline: none;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
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
    font-size: 20px !important;
    pointer-events: none;
}

/* Khối bảng */
.table-box {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,.02), 0 2px 4px -2px rgba(0,0,0,.02);
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
    letter-spacing: 0.5px;
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

/* Định dạng các ô đặc thù */
.id-cell { color: #64748b; font-weight: 500; }
.plate-cell { display: flex; align-items: center; gap: 8px; color: #0f172a; line-height: 24px; }
.plate-icon { color: #94a3b8; font-size: 18px !important; }
.time-cell { align-items: center; gap: 6px; color: #475569; }
.time-icon { font-size: 16px !important; color: #cbd5e1; vertical-align: middle; margin-right: 4px; }
.text-muted-italic { color: #94a3b8; font-style: italic; }

/* Badge loại xe */
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

/* Trạng thái đơn gửi xe */
.status-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
}
.status-parking { background-color: #eff6ff; color: #1d4ed8; }
.status-done { background-color: #f0fdf4; color: #16a34a; }

/* Trạng thái bảng rỗng */
.empty-cell {
    text-align: center;
    padding: 60px 0 !important;
    color: #94a3b8;
}
.empty-icon { font-size: 48px !important; margin-bottom: 10px; color: #cbd5e1; }
</style>

<script>
// Hàm lọc tìm kiếm dữ liệu trực tiếp bằng Javascript không cần tải lại trang
function filterHistoryTable() {
    let input = document.getElementById("historySearch");
    let filter = input.value.toUpperCase().trim();
    let table = document.getElementById("historyTable");
    let tr = table.getElementsByTagName("tr");
    let hasResult = false;
    let totalRows = 0;

    // Vòng lặp qua tất cả các hàng dữ liệu (bỏ qua hàng tiêu đề index = 0)
    for (let i = 1; i < tr.length; i++) {
        // Bỏ qua 2 hàng thông báo lỗi hệ thống
        if (tr[i].id === "noDataRow" || tr[i].id === "noResultRow") continue;
        
        totalRows++;
        // Lấy ô chứa dữ liệu biển số xe (Cột thứ 2, index = 1)
        let tdPlate = tr[i].getElementsByTagName("td")[1];
        
        if (tdPlate) {
            let txtValue = tdPlate.textContent || tdPlate.innerText;
            // Nếu từ khóa trùng khớp với biển số xe
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
                hasResult = true;
            } else {
                tr[i].style.display = "none";
            }
        }
    }

    // Xử lý hiển thị thông báo nếu không có kết quả tìm kiếm nào thỏa mãn
    let noResultRow = document.getElementById("noResultRow");
    if (noResultRow) {
        if (!hasResult && filter !== "" && totalRows > 0) {
            noResultRow.style.display = "";
        } else {
            noResultRow.style.display = "none";
        }
    }
}
</script>