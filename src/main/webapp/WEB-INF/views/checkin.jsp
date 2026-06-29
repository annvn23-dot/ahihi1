<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống Check In bãi xe</title>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: system-ui, -apple-system, sans-serif;
        }

        body {
            background: #f8fafc;
            padding: 24px;
        }

        .container {
            display: flex;
            gap: 24px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .left-panel {
            width: 35%;
        }

        .right-panel {
            width: 65%;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05), 0 2px 4px -2px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }

        h2 {
            color: #0f2f92;
            margin-bottom: 24px;
            font-size: 20px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        h2 span {
            font-size: 24px !important;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #475569;
            font-size: 14px;
        }

        /* Ô nhập thông tin biển số hiện đại */
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group span {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 20px !important;
        }

        input[type=text] {
            width: 100%;
            padding: 12px 16px 12px 42px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 15px;
            color: #1e293b;
            outline: none;
            transition: all 0.2s ease;
        }

        input[type=text]:focus {
            border-color: #0f2f92;
            box-shadow: 0 0 0 3px rgba(15, 47, 146, 0.15);
        }

        /* Làm lại giao diện chọn Loại xe dạng Thẻ (Custom Radio buttons) */
        .radio-container {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }

        .radio-label {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            color: #64748b;
            transition: all 0.2s ease;
            margin-bottom: 0;
        }

        .radio-label input[type="radio"] {
            display: none; /* Ẩn nút tròn mặc định xấu xí */
        }

        .radio-label:hover {
            background-color: #f8fafc;
            border-color: #cbd5e1;
        }

        /* Style khi radio được chọn */
        .radio-label:has(input[type="radio"]:checked) {
            border-color: #0f2f92;
            color: #0f2f92;
            background-color: #eff6ff;
        }

        /* Nút Gửi xe */
        .btn {
            width: 100%;
            padding: 14px;
            background: #0f2f92;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 4px 6px rgba(15, 47, 146, 0.2);
            transition: all 0.2s ease;
        }

        .btn:hover {
            background: #0d287a;
            transform: translateY(-1px);
            box-shadow: 0 6px 12px rgba(15, 47, 146, 0.25);
        }

        /* Bảng danh sách phía bên phải */
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th {
            background: #f8fafc;
            padding: 14px 16px;
            text-align: left;
            color: #475569;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            border-bottom: 1px solid #edf2f7;
        }

        td {
            padding: 16px 16px;
            border-bottom: 1px solid #f1f5f9;
            color: #334155;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        tr:hover td {
            background-color: #f8fafc;
        }

        /* Huy hiệu phân loại xe */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge span { font-size: 14px !important; }
        .badge-moto { background: #f1f5f9; color: #475569; }
        .badge-car { background: #f3e8ff; color: #7e22ce; }

        /* Badge Trạng thái */
        .status {
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .active {
            background: #eff6ff;
            color: #1d4ed8;
        }

        /* Nút thanh toán hành động */
        .checkout-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: white;
            background-color: #10b981;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .checkout-btn:hover {
            background-color: #059669;
            box-shadow: 0 2px 4px rgba(16, 185, 129, 0.2);
        }
    </style>
</head>
<body>

<div class="container">

    <div class="left-panel">
        <div class="card">
            <h2><span class="material-symbols-outlined">local_parking</span> Ghi nhận gửi xe</h2>
            
            <form action="${pageContext.request.contextPath}/checkin/save" method="post">
                
                <label>Biển số xe</label>
                <div class="input-group">
                    <span class="material-symbols-outlined">tag</span>
                    <input type="text" name="licensePlate" placeholder="VD: 59A-12345" required>
                </div>

                <label>Loại phương tiện</label>
                <div class="radio-container">
                    <label class="radio-label">
                        <input type="radio" name="vehicleType" value="Xe máy" checked>
                        <span class="material-symbols-outlined">two_wheeler</span> Xe máy
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="vehicleType" value="Ô tô">
                        <span class="material-symbols-outlined">directions_car</span> Ô tô
                    </label>
                </div>

                <button class="btn" type="submit">
                    <span class="material-symbols-outlined">how_to_reg</span> GHI NHẬN VÀO BÃI
                </button>
            </form>
        </div>
    </div>

    <div class="right-panel">
        <div class="card">
            <h2><span class="material-symbols-outlined">view_list</span> Danh sách xe đang gửi</h2>
            
            <table>
                <thead>
                    <tr>
                        <th style="width: 8%;">STT</th>
                        <th style="width: 25%;">Biển số</th>
                        <th style="width: 20%;">Loại xe</th>
                        <th style="width: 25%;">Giờ vào</th>
                        <th style="width: 22%;">Trạng thái</th>
                        <th style="width: 20%; text-align: center;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${logs}" var="log" varStatus="st">
                        <tr>
                            <td style="color: #94a3b8; font-weight: 500;">#${st.index + 1}</td>
                            <td style="font-weight: 600; color: #0f172a;">${log.licensePlate}</td>
                            <td>
                                <span class="badge ${log.vehicleType eq 'Ô tô' ? 'badge-car' : 'badge-moto'}">
                                    <span class="material-symbols-outlined">
                                        ${log.vehicleType eq 'Ô tô' ? 'directions_car' : 'two_wheeler'}
                                    </span>
                                    ${log.vehicleType}
                                </span>
                            </td>
                            <td style="color: #64748b; font-size: 13px;">${log.checkInTime}</td>
                            <td>
                                <span class="status active">
                                    ${log.status}
                                </span>
                            </td>
                            <td style="text-align: center;">
                                <a class="checkout-btn" href="${pageContext.request.contextPath}/payment/${log.vehicleId}">
                                    <span class="material-symbols-outlined" style="font-size: 16px;">credit_score</span> Trả xe
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>