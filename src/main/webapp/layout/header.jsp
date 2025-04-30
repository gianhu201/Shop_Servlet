<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Clothes Shop</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

    <!-- Include additional CSS links here -->
</head>
<body>
<header class="bg-light">
    <div class="container">
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Clothes Shop</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false"> Danh mục sản phẩm </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product?categoryId=1" >Nữ</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product?categoryId=2">Nam</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product?categoryId=3">Thời trang trẻ em</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product?categoryId=4">Mỹ phẩm</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/product?categoryId=5">Phụ kiện</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/order">Đơn hàng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link disabled" aria-disabled="true">Liên hệ</a>
                        </li>
                    </ul>
                    <form  action="${pageContext.request.contextPath}/product" method="get" class="d-flex" role="search">
                        <input class="form-control me-2" type="text" name="name" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                </div>

                <!-- Right elements -->
                <div class="d-flex align-items-center">
                    <!-- Giỏ hàng -->
                    <a class="nav-link me-3" href="${pageContext.request.contextPath}/cart">
                        <i class="fas fa-shopping-cart"></i>
                    </a>

                    <!-- Hiển thị tên người dùng nếu đã đăng nhập -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <a class="nav-link me-3" href="#">
                                <i class="fas fa-user me-1"></i>
                                <span>Hello, ${sessionScope.userName}</span>
                            </a>

                            <!-- Nút đăng xuất -->
                            <a href="${pageContext.request.contextPath}/logout" class="border rounded px-2 nav-link">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a>
                        </c:when>

                        <c:otherwise>
                            <!-- Nếu chưa đăng nhập -->
                            <a class="nav-link me-3" href="#">
                                <i class="fas fa-user me-1"></i>
                                <span>Chào bạn</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/login" class="border rounded px-2 nav-link">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Right elements -->
            </div>
        </nav>
    </div>
</header>