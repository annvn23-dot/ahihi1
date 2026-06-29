<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<div class="dashboard">

    <div class="top-bar">
        <div class="title">
            <h1>📊 ${not empty parkingName ? parkingName : "Quản lý bãi đỗ xe"}</h1>
            <p><span class="pulse-dot"></span> Hệ thống cập nhật theo thời gian thực</p>
        </div>
        <button class="btn btn-primary" onclick="themXe()">
            <span class="material-symbols-outlined">add_circle</span> Ghi nhận xe vào
        </button>
    </div>

    <div class="cards">
        
        <div class="card card-total">
            <div class="card-icon">
                <span class="material-symbols-outlined">directions_car</span>
            </div>
            <div class="card-info">
                <h3>Xe đang gửi</h3>
                <h1>${totalVehicles}</h1>
                <p class="status-ok">Đang trong bãi</p>
            </div>
        </div>

        <div class="card card-moto">
            <div class="card-icon">
                <span class="material-symbols-outlined">two_wheeler</span>
            </div>
            <div class="card-info">
                <h3>Xe máy</h3>
                <h1>${motorbikeCount} / ${availableMoto != null ? availableMoto : 0}</h1>
                <p style="font-size: 13px; color: #64748b; margin-top: 4px;">
                    Đang trong bãi: <b>${motorbikeCount}</b> | Còn trống: <b>${availableMoto != null ? availableMoto : 0}</b>
                </p>
            </div>
        </div>

        <div class="card card-car">
            <div class="card-icon">
                <span class="material-symbols-outlined">local_parking</span>
            </div>
            <div class="card-info">
                <h3>Ô tô</h3>
                <h1>${carCount} / ${availableCar != null ? availableCar : 0}</h1>
                <p style="font-size: 13px; color: #64748b; margin-top: 4px;">
                    Đang trong bãi: <b>${carCount}</b> | Còn trống: <b>${availableCar != null ? availableCar : 0}</b>
                </p>
            </div>
        </div>

        <div class="card card-revenue">
            <div class="card-icon">
                <span class="material-symbols-outlined">payments</span>
            </div>
            <div class="card-info" style="width: 100%;">
                <div class="revenue-header" style="display: flex; justify-content: space-between; align-items: center;">
                    <h3>Doanh thu</h3>
                    <select id="revenueFilter" onchange="switchRevenue()" style="border: none; background: #f0fdf4; color: #15803d; font-weight: 600; font-size: 12px; outline: none; cursor: pointer; padding: 2px 6px; border-radius: 6px;">
                        <option value="today">Hôm nay</option>
                        <option value="week">Tuần này</option>
                        <option value="month">Tháng này</option>
                    </select>
                </div>
                <h1 class="revenue-text" id="revenueDisplay">${todayRevenue}đ</h1>
                <p class="status-grow" id="revenueSubText">Giao dịch hôm nay</p>
            </div>
        </div>

    </div> <div class="table-box" style="width: 100%; display: block; clear: both; box-sizing: border-box; margin-top: 25px;">
        <div class="table-header">
            <h2>📋 Danh sách xe đang gửi</h2>
            <div class="table-actions">
                <span class="text-muted">Dữ liệu mới nhất</span>
            </div>
        </div>

        <table style="width: 100%; border-collapse: collapse; table-layout: fixed;">
            <thead>
                <tr>
                    <th style="padding: 14px 20px; text-align: left; width: 8%;">STT</th>
                    <th style="padding: 14px 20px; text-align: left; width: 25%;">Biển số xe</th>
                    <th style="padding: 14px 20px; text-align: left; width: 22%;">Phân loại xe</th>
                    <th style="padding: 14px 20px; text-align: left; width: 25%;">Thời gian vào bãi</th>
                    <th style="text-align: center; padding: 14px 20px; width: 20%;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty recentLogs}">
                        <c:forEach items="${recentLogs}" var="v" varStatus="status">
                            <tr>
                                <td style="padding: 16px 20px; color: #94a3b8;"># ${status.index + 1}</td>

                                <td style="padding: 16px 20px; font-weight: 600; color: #0f172a;">
                                    <div style="display: flex; align-items: center; gap: 8px;">
                                        <span class="material-symbols-outlined" style="color: #94a3b8; font-size: 18px;">tag</span>
                                        ${v.licensePlate}
                                    </div>
                                </td>

                                <td style="padding: 16px 20px;">
                                    <span class="badge ${v.vehicleType eq 'Ô tô' || v.vehicleType eq 'O to' || v.vehicleType eq 'CAR' ? 'badge-car' : 'badge-moto'}">
                                        <span class="material-symbols-outlined">
                                            ${v.vehicleType eq 'Ô tô' || v.vehicleType eq 'O to' || v.vehicleType eq 'CAR' ? 'directions_car' : 'two_wheeler'}
                                        </span>
                                        ${v.vehicleType}
                                    </span>
                                </td>

                                <td style="padding: 16px 20px; color: #64748b;">
                                    <div style="display: flex; align-items: center; gap: 6px;">
                                        <span class="material-symbols-outlined" style="font-size: 16px; color: #cbd5e1;">schedule</span>
                                        <span>${v.checkInTime}</span>
                                    </div>
                                </td>

                                <td style="text-align: center; padding: 16px 20px;">
                                    <button class="btn-action btn-pay" onclick="traXe(${v.vehicleId})" style="margin: 0 auto;">
                                        <span class="material-symbols-outlined">credit_score</span> Thanh toán
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="empty-cell" style="text-align: center; padding: 60px 0;">
                                <span class="material-symbols-outlined empty-icon" style="font-size: 48px; color: #cbd5e1;">no_sim</span>
                                <p style="margin-top: 10px; color: #94a3b8;">Hiện tại không có phương tiện nào đang gửi trong bãi</p>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="table-footer">
            <span>Hiển thị lịch sử bãi xe</span>
            <a href="${pageContext.request.contextPath}/history" class="btn-history">
                Xem tất cả lịch sử <span class="material-symbols-outlined">arrow_forward</span>
            </a>
        </div>
    </div>
</div>

<style>
    .dashboard {
        padding: 24px;
        font-family: system-ui, -apple-system, sans-serif;
        background-color: #f8fafc;
    }
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    .title h1 {
        font-size: 28px;
        color: #0b2f8f;
        font-weight: 700;
    }
    .title p {
        font-size: 14px;
        color: #64748b;
        margin-top: 6px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }
    .pulse-dot {
        width: 8px;
        height: 8px;
        background: #22c55e;
        border-radius: 50%;
        display: inline-block;
        box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.7);
        animation: pulse 1.6s infinite;
    }
    @keyframes pulse {
        0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.5); }
        70% { transform: scale(1); box-shadow: 0 0 0 6px rgba(34, 197, 94, 0); }
        100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(34, 197, 94, 0); }
    }
    .btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 12px 24px;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        border: none;
        cursor: pointer;
        transition: all 0.2s;
    }
    .btn-primary {
        background: #0b2f8f;
        color: white;
        box-shadow: 0 4px 12px rgba(11, 47, 143, 0.15);
    }
    .btn-primary:hover {
        background: #082269;
        transform: translateY(-1px);
    }
    .cards {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 24px;
        margin-bottom: 35px;
    }
    .card {
        background: white;
        padding: 24px;
        border-radius: 16px;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,.02);
        border: 1px solid #e2e8f0;
        display: flex;
        align-items: center;
        gap: 18px;
    }
    .card-icon {
        width: 54px;
        height: 54px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .card-icon span { font-size: 30px !important; }
    .card-info h3 { font-size: 14px; color: #64748b; font-weight: 500; }
    .card-info h1 { font-size: 26px; color: #0f172a; font-weight: 700; margin-top: 4px; }
    .card-total .card-icon { background: #eff6ff; color: #1d4ed8; }
    .card-moto .card-icon { background: #f8fafc; color: #475569; }
    .card-car .card-icon { background: #f3e8ff; color: #6b21a8; }
    .card-revenue .card-icon { background: #f0fdf4; color: #15803d; }
    .card-revenue .revenue-text { color: #16a34a; }
    .status-ok { color: #2563eb !important; font-weight: 500; }
    .status-grow { color: #16a34a !important; font-weight: 500; }

    .table-box {
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,.02);
        border: 1px solid #e2e8f0;
        margin-top: 20px;
    }
    .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 24px;
        border-bottom: 1px solid #f1f5f9;
    }
    .table-header h2 { font-size: 18px; color: #0f172a; font-weight: 600; }
    th {
        background: #f8fafc;
        color: #475569;
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
    }
    tr:hover td { background-color: #f8fafc; }
    .badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
    }
    .badge-moto { background: #f1f5f9; color: #475569; }
    .badge-car { background: #f3e8ff; color: #7e22ce; }
    .btn-action {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 16px;
        border: 1px solid #bfdbfe;
        border-radius: 8px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        background: white;
        color: #0b2f8f;
        transition: all 0.2s;
    }
    .btn-action:hover {
        background: #eff6ff;
        border-color: #3b82f6;
    }
    .table-footer {
        padding: 20px 24px;
        background: #f8fafc;
        border-top: 1px solid #f1f5f9;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .btn-history {
        color: #0b2f8f;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }
</style>

<script>
    function themXe() {
        location.href = "${pageContext.request.contextPath}/checkin";
    }
    function traXe(vehicleId) {
        if (!vehicleId) {
            alert("Không tìm thấy ID phương tiện!");
            return;
        }
        location.href = "${pageContext.request.contextPath}/payment/" + vehicleId;
    }
    function switchRevenue() {
        let filterType = document.getElementById("revenueFilter").value;
        let revenueDisplay = document.getElementById("revenueDisplay");
        let revenueSubText = document.getElementById("revenueSubText");

        let today = "${todayRevenue}đ";
        let week = "${weeklyRevenue}đ";
        let month = "${monthlyRevenue}đ";

        if (filterType === "today") {
            revenueDisplay.innerText = today;
            revenueSubText.innerText = "Giao dịch hôm nay";
        } else if (filterType === "week") {
            revenueDisplay.innerText = week;
            revenueSubText.innerText = "Tổng doanh thu tuần này";
        } else if (filterType === "month") {
            revenueDisplay.innerText = month;
            revenueSubText.innerText = "Tổng doanh thu tháng này";
        }
    }
</script>