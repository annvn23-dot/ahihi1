<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="payment-list-container">
    <div class="page-header">
        <h2><span class="material-symbols-outlined">payments</span> Danh sách xe thanh toán</h2>
        <p>Chọn phương tiện yêu cầu xuất bãi để tiến hành tính phí và lập hóa đơn</p>
    </div>

    <div class="table-card">
        <table class="table">
            <thead>
                <tr>
                    <th style="width: 10%;">ID xe</th>
                    <th style="width: 30%;">Biển số xe</th>
                    <th style="width: 25%;">Phân loại xe</th>
                    <th style="width: 20%;">Trạng thái</th>
                    <th style="width: 15%; text-align: center;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty logs}">
                        <c:forEach items="${logs}" var="log">
                            <tr>
                                <td style="color: #94a3b8; font-weight: 500;">#${log.vehicleId}</td>
                                
                                <td style="font-weight: 600; color: #0f172a;">
                                    <div style="display: flex; align-items: center; gap: 8px;">
                                        <span class="material-symbols-outlined" style="color: #94a3b8; font-size: 18px;">tag</span>
                                        ${log.licensePlate}
                                    </div>
                                </td>
                                
                                <td>
                                    <span class="badge ${log.vehicleType eq 'Ô tô' ? 'badge-car' : 'badge-moto'}">
                                        <span class="material-symbols-outlined">
                                            ${log.vehicleType eq 'Ô tô' ? 'directions_car' : 'two_wheeler'}
                                        </span>
                                        ${log.vehicleType}
                                    </span>
                                </td>
                                
                                <td>
                                    <span class="status-active">
                                        <span class="status-dot"></span>
                                        ${log.status}
                                    </span>
                                </td>
                                
                                <td style="text-align: center;">
                                    <a class="btn-pay" href="${pageContext.request.contextPath}/payment/${log.vehicleId}">
                                        <span class="material-symbols-outlined" style="font-size: 16px;">receipt_long</span> Tính tiền
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="empty-cell">
                                <span class="material-symbols-outlined" style="font-size: 48px; color: #cbd5e1;">credit_card_off</span>
                                <p style="margin-top: 10px; color: #94a3b8;">Không có yêu cầu thanh toán nào cần xử lý</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<style>
/* Khung tổng thể */
.payment-list-container {
    padding: 24px;
    font-family: system-ui, -apple-system, sans-serif;
    background-color: #f8fafc;
}

/* Tiêu đề trang */
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

/* Thẻ bọc bảng */
.table-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02), 0 2px 4px -2px rgba(0,0,0,0.02);
    border: 1px solid #e2e8f0;
}

/* Cấu trúc Bảng dữ liệu */
.table {
    width: 100%;
    border-collapse: collapse;
    table-layout: fixed;
}
.table th {
    background: #f8fafc;
    padding: 14px 20px;
    text-align: left; /* Chuyển sang canh lề trái cho dễ nhìn */
    color: #475569;
    font-weight: 600;
    font-size: 13px;
    text-transform: uppercase;
    border-bottom: 1px solid #edf2f7;
}
.table td {
    padding: 16px 20px;
    text-align: left;
    vertical-align: middle;
    border-bottom: 1px solid #f1f5f9;
    color: #334155;
    font-size: 14px;
}
.table tr:last-child td {
    border-bottom: none;
}
.table tr:hover td {
    background-color: #f8fafc;
}

/* Badge Phân loại xe */
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

/* Trạng thái */
.status-active {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: #1d4ed8;
    background: #eff6ff;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
}
.status-dot {
    width: 6px;
    height: 6px;
    background-color: #2563eb;
    border-radius: 50%;
}

/* Nút thanh toán */
.btn-pay {
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
.btn-pay:hover {
    background: #1d4ed8;
    box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
}

/* Trạng thái danh sách rỗng */
.empty-cell {
    text-align: center !important;
    padding: 60px 0 !important;
}
</style>