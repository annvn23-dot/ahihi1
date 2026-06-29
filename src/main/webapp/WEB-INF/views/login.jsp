<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Đăng nhập - Quản Lý Bãi Đỗ Xe</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
</head>
<body class="bg-slate-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-md border border-slate-200">
        <div class="text-center mb-6">
            <h1 class="text-2xl font-bold text-slate-800">Hệ Thống Bãi Xe</h1>
            <p class="text-sm text-slate-500">Vui lòng đăng nhập hệ thống điều hành</p>
        </div>
        <c:if test="${not empty errorMessage}">
            <div class="bg-red-50 text-red-600 p-3 rounded-lg text-sm mb-4 border border-red-200">${errorMessage}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="POST" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Tài khoản</label>
                <input type="text" name="username" required class="w-full rounded-lg border-slate-300 focus:border-blue-500 focus:ring-blue-500"/>
            </div>
            <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Mật khẩu</label>
                <input type="password" name="password" required class="w-full rounded-lg border-slate-300 focus:border-blue-500 focus:ring-blue-500"/>
            </div>
            <button type="submit" class="w-full bg-blue-700 hover:bg-blue-800 text-white font-medium py-2.5 rounded-lg transition-colors flex justify-center items-center gap-2">
                Đăng nhập <span class="material-symbols-outlined text-sm">arrow_forward</span>
            </button>
        </form>
    </div>
</body>
</html>