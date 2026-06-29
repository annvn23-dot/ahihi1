<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SmartPark</title>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            html, body {
                height: 100%;
                overflow: hidden;
                background: #f3f6fc;
            }

            /* SIDEBAR */
            .sidebar {
                position: fixed;
                left: 0;
                top: 0;
                width: 290px;
                height: 100vh;
                background: #021936;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .header {
                padding: 35px;
            }
            .user {
                display: flex;
                align-items: center;
                gap: 18px;
            }
            .avatar {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: #3150e0;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 24px;
                color: white;
                font-weight: bold;
            }
            .info h2 {
                font-size: 18px;
                color: white;
            }
            .info p {
                font-size: 13px;
                margin-top: 5px;
                color: #8ea1c9;
            }

            /* MENU */
            .menu {
                padding: 20px;
                display: flex;
                flex-direction: column;
                gap: 8px;
                overflow-y: auto;
                flex: 1;
            }
            .menu a {
                text-decoration: none;
            }
            .item {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 18px;
                border-radius: 16px;
                color: #d6def6;
                cursor: pointer;
            }
            .item:hover {
                background: #12316b;
            }
            .active {
                background: #1f3e9d;
                color: white;
            }

            /* DROPDOWN */
            .group {
                display: flex;
                flex-direction: column;
            }
            .group-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 18px;
                border-radius: 16px;
                cursor: pointer;
                color: #d6def6;
            }
            .group-title:hover {
                background: #12316b;
            }
            .group-title-left {
                display: flex;
                gap: 15px;
                align-items: center;
            }
            .sub {
                display: none;
                padding-left: 55px;
                flex-direction: column;
            }
            .sub.open {
                display: flex;
            }
            .sub a {
                padding: 14px;
                color: #cfd7f2;
                text-decoration: none;
            }
            .sub a:hover {
                color: white;
            }

            /* FOOTER */
            .footer {
                padding: 20px;
                border-top: 1px solid rgba(255,255,255,.1);
            }
            .logout {
                display: flex;
                gap: 16px;
                padding: 18px;
                color: white;
                text-decoration: none;
            }

            /* CONTENT */
            .content {
                margin-left: 290px;
                height: 100vh;
                overflow-y: auto;
                padding: 40px;
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <div>
                <div class="header">
                    <div class="user">
                        <div class="avatar">A</div>
                        <div class="info">
                            <h2>${sessionScope.user.fullName}</h2>
                            <p>${sessionScope.user.role}</p>
                        </div>
                    </div>
                </div>

                <div class="menu">
                    <a href="${pageContext.request.contextPath}/dashboard">
                        <div class="item ${activeTab=='dashboard'?'active':''}">
                            <span class="material-symbols-outlined">dashboard</span> Dashboard
                        </div>
                    </a>

                    <div class="group">
                        <div class="group-title ${activeTab=='parking'?'active':''}" onclick="toggleParking()">
                            <div class="group-title-left">
                                <span class="material-symbols-outlined">directions_car</span> Quản lý xe
                            </div>
                            <span>▼</span>
                        </div>
                        <div id="parkingMenu" class="sub">
                            <a href="${pageContext.request.contextPath}/checkin">Gửi xe</a>
                            <a href="${pageContext.request.contextPath}/checkout">Trả xe</a>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/payment">
                        <div class="item ${activeTab=='payment'?'active':''}">
                            <span class="material-symbols-outlined">payments</span> Thanh toán
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/history">
                        <div class="item ${activeTab=='history'?'active':''}">
                            <span class="material-symbols-outlined">history</span> Xem Lịch Sử
                        </div>
                    </a>

                    <c:choose>
                        <c:when test="${sessionScope.user.role eq 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/users">
                                <div class="item ${activeTab=='users'?'active':''}">
                                    <span class="material-symbols-outlined">group</span> Quản lý tài khoản
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/create-user">
                                <div class="item ${activeTab=='create-user'?'active':''}">
                                    <span class="material-symbols-outlined">person_add</span> Tạo tài khoản
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/config">
                                <div class="item ${activeTab=='config'?'active':''}">
                                    <span class="material-symbols-outlined">settings_applications</span> Cấu hình bãi xe
                                </div>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="item" onclick="noPermission()">
                                <span class="material-symbols-outlined">group</span> Quản lý tài khoản
                            </div>
                            <div class="item" onclick="noPermission()">
                                <span class="material-symbols-outlined">person_add</span> Tạo tài khoản
                            </div>
                            <div class="item" onclick="noPermission()">
                                <span class="material-symbols-outlined">settings_applications</span> Cấu hình bãi xe
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="footer">
                <a class="logout" href="${pageContext.request.contextPath}/logout" onclick="return confirm('Bạn có chắc muốn đăng xuất không?');">
                    <span class="material-symbols-outlined">logout</span> Đăng xuất
                </a>
            </div>
        </div>

        <div class="content">
            <jsp:include page="${viewContent}" />
        </div>

        <script>
            function noPermission() {
                alert("Bạn không có quyền truy cập chức năng này!");
            }

            function toggleParking() {
                document.getElementById("parkingMenu").classList.toggle("open");
            }

            window.onload = function () {
                if ("${activeTab}" === "parking") {
                    document.getElementById("parkingMenu").classList.add("open");
                }
            }
        </script>
    </body>
</html>