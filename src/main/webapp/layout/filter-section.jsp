<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-3 mb-4">
    <div class="row">
        <div class="col-md-12">
            <form action="${pageContext.request.contextPath}/product" method="GET" class="d-flex flex-wrap align-items-center">
                <div class="form-group me-3 mb-2">
                    <input type="text" class="form-control" name="name" placeholder="Tên sản phẩm" value="${param.name}">
                </div>
                <div class="form-group me-3 mb-2">
                    <select class="form-select" name="categoryId">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary mb-2">Tìm kiếm</button>
            </form>
        </div>
    </div>
</div>
</div>