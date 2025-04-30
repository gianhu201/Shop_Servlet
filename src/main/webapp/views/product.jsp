<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/product-card.css">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery và Popper.js trước Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- You can include CSS references here or in the header.jsp -->
    <style>
        h3 {
            font-family: cursive;
            font-size: 24px;
            font-weight: normal;
            color: #333;
            text-align: center;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        .search-container {
            max-width: 500px;
            margin: 20px auto;
            padding: 0 15px;
        }
    </style>
</head>
<body>
<!-- Include Header -->
<jsp:include page="/layout/header.jsp" />

<!-- If you need the carousel on the product page -->
<jsp:include page="/layout/carousel.jsp" />


<!-- Product Content-->
<section class="product spad">
    <div class="container">
        <br>
        <br>
        <div class="row">
            <h3>NEW PRODUCTS</h3>
        </div>
        <br>

        <!--  -->
        <div class="row property__gallery">
            <c:forEach var="product" items="${products}">
                <!-- Kiểm tra nếu status của sản phẩm là true -->
                <c:if test="${product.status == true}">
                    <div class="col-lg-3 col-md-4 col-sm-6 mix men">
                        <div class="product__item">
                            <div class="card" style="width: 18rem;">
                                <img src="${pageContext.request.contextPath}/views/images/${product.image}" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">${product.name}</h5>
                                    <p class="card-text">${product.description}</p>
                                    <h4>
                                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="true" /> VND
                                    </h4>
                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/product-details?id=${product.id}" class="btn btn-primary">Mua ngay</a>
                                        <!-- Nút "Thêm vào giỏ hàng" sẽ kích hoạt modal -->
                                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addToCartModal-${product.id}">
                                            Thêm vào giỏ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Thêm vào giỏ hàng -->
                    <div class="modal fade" id="addToCartModal-${product.id}" tabindex="-1" role="dialog" aria-labelledby="addToCartLabel-${product.id}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Chọn thuộc tính sản phẩm</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span>&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" name="productId" value="${product.id}" />

                                        <!-- Lọc danh sách size duy nhất -->
                                        <c:set var="uniqueSizes" value="" />
                                        <c:forEach var="variant" items="${product.variants}">
                                            <c:set var="sizeUpper" value="${variant.size.toUpperCase()}" />
                                            <c:if test="${not fn:contains(uniqueSizes, sizeUpper)}">
                                                <c:set var="uniqueSizes" value="${uniqueSizes}${uniqueSizes != '' ? ',' : ''}${sizeUpper}" />
                                            </c:if>
                                        </c:forEach>

                                        <!-- Size -->
                                        <div class="form-group">
                                            <label for="size">Size</label>
                                            <select class="form-control" name="size" required>
                                                <option value="">--Chọn size--</option>
                                                <c:forEach var="size" items="${fn:split(uniqueSizes, ',')}">
                                                    <option value="${size}">${size}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Lọc danh sách color duy nhất -->
                                        <c:set var="uniqueColors" value="" />
                                        <c:set var="seenColors" value="" />
                                        <c:forEach var="variant" items="${product.variants}">
                                            <c:set var="colorLower" value="${variant.color.toLowerCase()}" />
                                            <c:if test="${not fn:contains(seenColors, colorLower)}">
                                                <c:set var="uniqueColors" value="${uniqueColors}${uniqueColors != '' ? ',' : ''}${variant.color}" />
                                                <c:set var="seenColors" value="${seenColors}${seenColors != '' ? ',' : ''}${colorLower}" />
                                            </c:if>
                                        </c:forEach>

                                        <!-- Color -->
                                        <div class="form-group">
                                            <label for="color">Màu sắc</label>
                                            <select class="form-control" name="color" required>
                                                <option value="">--Chọn màu--</option>
                                                <c:forEach var="color" items="${fn:split(uniqueColors, ',')}">
                                                    <option value="${color}">${color}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Quantity -->
                                        <div class="form-group">
                                            <label for="quantity">Số lượng</label>
                                            <input type="number" class="form-control" name="quantity" value="1" min="1" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-success">Thêm vào giỏ hàng</button>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</section>

<!-- Product Content-->

<!-- Categories Content-->
<section class="categories spad">

        <div class="row">
            <h3>Thời Trang - Thời thượng</h3>
        </div>
        <br>

        <!-- Your product-specific content here -->
        <div class="row property__gallery">
            <jsp:include page="/layout/categories-section.jsp" />
        </div>

</section>
<!-- Categories Content-->

<!--Trend Section Begin-->
<section class="trend spad">
    <div class="container">
        <br>
        <br>
        <div class="row">
            <h3>Hot Trend</h3>
        </div>
        <br>

        <!-- Your product-specific content here -->
        <div class="row property__gallery">
            <jsp:include page="/layout/trend-section.jsp" />
        </div>
    </div>
</section>
<!--Trend Section End -->

<!-- Include Footer -->
<jsp:include page="/layout/footer.jsp" />

</body>
</html>