<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductVariant" %>
<%@ page import="model.Category" %>

<%
  List<Product> productList = (List<Product>) request.getAttribute("products");
  int stt = 1;
%>

<html>
<head>
  <title>Quản lý sản phẩm</title>

  <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
  />

  <style>
    .product-img {
      width: 100px;
      height: 60px;
      object-fit: cover;
    }
    .action-icons i {
      cursor: pointer;
      margin: 0 5px;
    }
    .btn {
      padding: 5px 10px;
      cursor: pointer;
    }
    .btn-primary {
      background-color: #007bff;
      color: white;
      border: none;
    }
    .btn-danger {
      background-color: #dc3545;
      color: white;
      border: none;
    }
    table input {
      width: 100%;
    }
    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }
    .form-group label {
      margin-right: 10px;
      width: 120px;
    }
    .form-group input, .form-group select {
      margin-left: 10px;
      flex: 1;
      padding: 5px;
    }
    .error-message {
      color: red;
      font-size: 12px;
      display: none;
      margin-left: 130px;
    }
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.4);
      padding-top: 60px;
    }
    .modal-content {
      background-color: #fefefe;
      margin: 5% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      max-width: 600px;
      position: relative;
    }
    .close {
      color: #aaa;
      position: absolute;
      right: 20px;
      top: 10px;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }
    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
    textarea {
      width: 100%;
      padding: 5px;
    }
    .status-label {
      margin-left: 130px;
    }
    .success-message {
      color: green;
      font-weight: bold;
      margin: 10px 0;
      padding: 10px;
      background-color: #d4edda;
      border: 1px solid #c3e6cb;
      border-radius: 4px;
    }
    .error-container {
      color: red;
      font-weight: bold;
      margin: 10px 0;
      padding: 10px;
      background-color: #f8d7da;
      border: 1px solid #f5c6cb;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<div style="display: flex; justify-content: end; align-items: center;">
  <c:choose>
    <c:when test="${not empty sessionScope.userId}">
      <a class="nav-link me-3" href="#">
        <i class="fas fa-user me-1"></i>
        <span>Hello, ${sessionScope.userName}</span>
      </a>

      <!-- Nút đăng xuất -->
      <a href="${pageContext.request.contextPath}/logout" class="border rounded px-2 nav-link" style="margin-left: 10px;">
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

<div style="display: flex; justify-content: center; align-items: center; height: 100px;">
  <h2>Quản lý sản phẩm</h2>
</div>
<c:if test="${not empty successMessage}">
  <div class="success-message">${successMessage}</div>
</c:if>

<c:if test="${not empty errorMessage}">
  <div class="error-container">${errorMessage}</div>
</c:if>

<!-- Thanh công cụ -->
<button id="addProductBtn" class="btn btn-primary">+ Thêm mới</button>
<!-- Hiển thị tên người dùng nếu đã đăng nhập -->

<%-- Form thêm mới --%>
<div id="addProductModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('addProductModal')">×</span>
    <h3>Thêm mới sản phẩm</h3>
    <form action="${pageContext.request.contextPath}/admin/ADproduct" method="post" enctype="multipart/form-data" onsubmit="return validateAddProductForm();">
      <input type="hidden" name="action" value="add">

      <div class="form-group">
        <label>Tên sản phẩm:</label>
        <input type="text" name="add-name" />
      </div>
      <span id="nameError" class="error-message"></span>

      <div class="form-group">
        <label>Đơn Giá:</label>
        <input type="text" name="add-price" />
      </div>
      <span id="priceError" class="error-message"></span>

      <div class="form-group">
        <label for="categoryId">Danh mục:</label>
        <select name="add-category" id="add-category">
          <option value="">Chọn danh mục</option>
          <c:forEach var="cat" items="${categoryList}">
            <option value="${cat.id}">${cat.name}</option>
          </c:forEach>
        </select>
      </div>
      <span id="categoryError" class="error-message"></span>

      <div class="form-group">
        <label>Ảnh:</label>
        <input type="file" name="add-image" />
      </div>
      <span id="imageError" class="error-message"></span>

      <div class="form-group">
        <label for="description">Mô tả:</label>
        <textarea name="add-description" rows="4"></textarea>
      </div>
      <span id="descriptionError" class="error-message"></span>

      <div class="form-group">
        <label>Trạng thái:</label>
        <span class="status-label">
          <input type="checkbox" name="add-status" /> Hiển thị
        </span>
      </div>

      <h4>Thêm biến thể mới</h4>
      <div class="form-group">
        <label>Màu sắc:</label>
        <input type="text" name="addColor" placeholder="Nhập màu mới" />
      </div>
      <span id="colorError" class="error-message"></span>

      <div class="form-group">
        <label>Size:</label>
        <input type="text" name="addSize" placeholder="Nhập size mới" />
      </div>
      <span id="sizeError" class="error-message"></span>

      <div style="margin-top: 20px; text-align: center;">
        <button type="submit" class="btn btn-primary">Thêm mới</button>
      </div>
    </form>
  </div>
</div>

<!-- Form chỉnh sửa sản phẩm -->
<%
  Product editProduct = (Product) request.getAttribute("editProduct");
  List<Category> categoryList = (List<Category>) request.getAttribute("categories");
  if (editProduct != null) {
%>
<div id="editProductModal" class="modal" data-show="true">
  <div class="modal-content">
    <span class="close" onclick="closeModal('editProductModal')">×</span>
    <h3>Chỉnh sửa sản phẩm</h3>
    <form action="${pageContext.request.contextPath}/admin/ADproduct" method="post" enctype="multipart/form-data" onsubmit="return validateEditProductForm();">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" value="<%= editProduct.getId() %>" />

      <div class="form-group">
        <label>Tên sản phẩm:</label>
        <input type="text" name="name" value="<%= editProduct.getName() %>" />
      </div>
      <span id="edit-nameError" class="error-message"></span>

      <c:set var="formattedPrice">
        <fmt:formatNumber value="${editProduct.price}" type="number" pattern="#.###" />
      </c:set>

      <div class="form-group">
        <label>Đơn Giá:</label>
        <input type="text" name="price" value="${formattedPrice}" />
      </div>
      <span id="edit-priceError" class="error-message"></span>

      <div class="form-group">
        <label for="categoryId">Danh mục:</label>
        <select name="categoryId" id="categoryId">
          <c:forEach var="cat" items="${categoryList}">
            <option value="${cat.id}" <c:if test="${cat.id == editProduct.category}">selected</c:if>>
                ${cat.name}
            </option>
          </c:forEach>
        </select>
      </div>
      <span id="edit-categoryError" class="error-message"></span>

      <div class="form-group">
        <label>Ảnh hiện tại:</label>
        <img src="<%= request.getContextPath() + "/views/images/" + editProduct.getImage() %>" width="100"/>
      </div>

      <div class="form-group">
        <label>Ảnh mới:</label>
        <input type="file" name="image" />
      </div>
      <span id="edit-imageError" class="error-message"></span>

      <div class="form-group">
        <label for="description">Mô tả:</label>
        <textarea name="description" rows="4"><%= editProduct.getDescription() %></textarea>
      </div>
      <span id="edit-descriptionError" class="error-message"></span>

      <!-- Biến thể sản phẩm -->
      <h4>Biến thể sản phẩm:</h4>
      <table border="1" cellspacing="0" cellpadding="5" width="100%">
        <thead>
        <tr>
          <th>Màu sắc</th>
          <c:forEach var="size" items="${sizes}">
            <th><input type="hidden" name="size" value="${size}">${size}</th>
          </c:forEach>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="color" items="${colors}">
          <tr>
            <td><input type="text" name="color" value="${color}" /></td>
            <c:forEach var="size" items="${sizes}">
              <td>
                <c:set var="found" value="false" />
                <c:forEach var="v" items="${variants}">
                  <c:if test="${v.color == color && v.size == size}">
                    <input type="number" name="quantity_${color}_${size}" value="${v.quantity}" min="0" />
                    <c:set var="found" value="true" />
                  </c:if>
                </c:forEach>
                <c:if test="${!found}">
                  <input type="number" name="quantity_${color}_${size}" value="0" min="0" />
                </c:if>
              </td>
            </c:forEach>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <span id="edit-variantError" class="error-message"></span>

      <div class="form-group">
        <label>Trạng thái:</label>
        <span class="status-label">
          <input type="checkbox" name="status" <%= editProduct.isStatus() ? "checked" : "" %> /> Hiển thị
        </span>
      </div>

      <h4>Thêm biến thể mới</h4>
      <div class="form-group">
        <label>Màu mới:</label>
        <input type="text" name="updateColor" placeholder="Nhập màu mới" />
      </div>
      <span id="edit-colorError" class="error-message"></span>

      <div class="form-group">
        <label>Size mới:</label>
        <input type="text" name="updateSize" placeholder="Nhập size mới" />
      </div>
      <span id="edit-sizeError" class="error-message"></span>

      <div style="margin-top: 20px; text-align: center;">
        <button type="submit" class="btn btn-primary">Cập nhật</button>
      </div>
    </form>
  </div>
</div>
<% } %>

<!-- Danh sách sản phẩm -->
<div style="margin-top: 20px; overflow-x: auto;">
  <table border="1" cellspacing="0" cellpadding="5" width="100%">
    <thead>
    <tr>
      <th>STT</th>
      <th>Mã SP</th>
      <th>Thông tin sản phẩm</th>
      <th>Hình ảnh</th>
      <th>Danh mục</th>
      <th>Phân loại</th>
      <th>Hiển thị</th>
      <th>Tác vụ</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (productList != null) {
        for (Product p : productList) {
    %>
    <tr>
      <td><%= stt++ %></td>
      <td><b><%= p.getId() %></b></td>
      <td>
        <b><%= p.getName() %></b><br>
        <span style="color: red; font-size: 12px;"><%= p.getCreated() %></span>
      </td>
      <td>
        <img src="<%= request.getContextPath() + "/views/images/" + p.getImage() %>" class="product-img" />
      </td>
      <td><%= p.getCategoryName() %></td>
      <td>
        <%
          List<ProductVariant> variants = p.getVariants();
          if (variants != null && !variants.isEmpty()) {
            for (ProductVariant v : variants) {
        %>
        <div>Size: <%= v.getSize() %> - Màu: <%= v.getColor() %> - SL: <%= v.getQuantity() %></div>
        <%
          }
        } else {
        %>
        <i>Không có</i>
        <%
          }
        %>
      </td>
      <td style="text-align: center;">
        <form action="<%= request.getContextPath() + "/update-product-status" %>" method="post">
          <input type="hidden" name="productId" value="<%= p.getId() %>" />
          <input type="checkbox" name="status" <%= p.isStatus() ? "checked" : "" %> onchange="this.form.submit()" />
        </form>
      </td>
      <td class="action-icons" style="text-align: center;">
        <a href="ADproduct?editId=<%=p.getId()%>" title="Sửa"><i class="fas fa-edit" style="color: blue;"></i></a>
        <form action="${pageContext.request.contextPath}/admin/ADproduct" method="post" style="display: inline;">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="id" value="<%= p.getId() %>">
          <a href="javascript:void(0)" onclick="if(confirmDelete()) this.parentNode.submit();" title="Xóa"><i class="fas fa-trash-alt" style="color: red;"></i></a>
        </form>
      </td>
    </tr>
    <%
        }
      }
    %>
    </tbody>
  </table>
</div>

<script>
  // Modal control functions
  const addProductModal = document.getElementById("addProductModal");
  const editProductModal = document.getElementById("editProductModal");
  const addProductBtn = document.getElementById("addProductBtn");

  function openModal(modalId) {
    document.getElementById(modalId).style.display = "block";
  }

  function closeModal(modalId) {
    document.getElementById(modalId).style.display = "none";
  }

  addProductBtn.onclick = function() {
    openModal("addProductModal");
  }

  window.onclick = function(event) {
    if (event.target == addProductModal) {
      closeModal("addProductModal");
    }
    if (event.target == editProductModal) {
      closeModal("editProductModal");
    }
  }

  <% if (editProduct != null) { %>
  openModal("editProductModal");
  <% } %>

  // Validation helper functions
  function displayError(errorId, message) {
    const errorElement = document.getElementById(errorId);
    if (errorElement) {
      errorElement.textContent = message;
      errorElement.style.display = 'block';
    }
  }

  function clearErrorMessages() {
    const errorElements = document.querySelectorAll('.error-message');
    errorElements.forEach(element => {
      element.textContent = '';
      element.style.display = 'none';
    });
  }

  // Validate Add Product Form
  function validateAddProductForm() {
    console.log("validateAddProductForm is called");
    let valid = true;
    clearErrorMessages();

    // Validate Product Name
    const name = document.getElementsByName("add-name")[0].value.trim();
    if (name === "") {
      valid = false;
      displayError("nameError", "Vui lòng nhập tên sản phẩm!");
    } else if (name.length < 3) {
      valid = false;
      displayError("nameError", "Tên sản phẩm phải có ít nhất 3 ký tự!");
    }

    // Validate Price
    const price = document.getElementsByName("add-price")[0].value.trim();
    if (price === "") {
      valid = false;
      displayError("priceError", "Vui lòng nhập đơn giá!");
    } else if (isNaN(price)) {
      valid = false;
      displayError("priceError", "Đơn giá phải là số!");
    } else if (parseFloat(price) <= 0) {
      valid = false;
      displayError("priceError", "Đơn giá phải lớn hơn 0!");
    }

    // Validate Category
    const category = document.getElementById("add-category").value;
    if (category === "" || category === "Chọn danh mục") {
      valid = false;
      displayError("categoryError", "Vui lòng chọn danh mục!");
    }

    // Validate Description
    const description = document.getElementsByName("add-description")[0].value.trim();
    if (description === "") {
      valid = false;
      displayError("descriptionError", "Vui lòng nhập mô tả sản phẩm!");
    }

    // Validate Image
    const imageInput = document.getElementsByName("add-image")[0];
    if (imageInput.files.length === 0) {
      valid = false;
      displayError("imageError", "Vui lòng chọn ảnh sản phẩm!");
    } else {
      const fileName = imageInput.files[0].name;
      const fileExt = fileName.split('.').pop().toLowerCase();
      const allowedExts = ['jpg', 'jpeg', 'png', 'gif'];
      if (!allowedExts.includes(fileExt)) {
        valid = false;
        displayError("imageError", "Chỉ chấp nhận file ảnh (jpg, jpeg, png, gif)!");
      }
    }

    // Validate Color (if provided)
    const addColor = document.getElementsByName("addColor")[0].value.trim();
    if (addColor !== "") {
      const alphaRegex = /^[a-zA-ZÀ-ỹ\s]+$/;
      if (!alphaRegex.test(addColor)) {
        valid = false;
        displayError("colorError", "Tên màu chỉ được chứa chữ cái!");
      }
    }

    // Validate Size (if provided)
    const addSize = document.getElementsByName("addSize")[0].value.trim();
    if (addSize !== "") {
      const alphaRegex = /^[a-zA-ZÀ-ỹ0-9\s]+$/;
      if (!alphaRegex.test(addSize)) {
        valid = false;
        displayError("sizeError", "Tên size chỉ được chứa chữ cái và số!");
      }
    }

    if (addColor !== "" && addSize === "") {
      valid = false;
      displayError("sizeError", "Vui lòng nhập size khi đã nhập màu!");
    }
    if (addSize !== "" && addColor === "") {
      valid = false;
      displayError("colorError", "Vui lòng nhập màu khi đã nhập size!");
    }

    console.log("Form validation result:", valid);
    return valid;
  }

  // Validate Edit Product Form
  function validateEditProductForm() {
    console.log("validateEditProductForm is called");
    let valid = true;
    clearErrorMessages();

    // Validate Product Name
    const name = document.getElementsByName("name")[0].value.trim();
    if (name === "") {
      valid = false;
      displayError("edit-nameError", "Vui lòng nhập tên sản phẩm!");
    } else if (name.length < 3) {
      valid = false;
      displayError("edit-nameError", "Tên sản phẩm phải có ít nhất 3 ký tự!");
    }

    // Validate Price
    const price = document.getElementsByName("price")[0].value.trim();
    if (price === "") {
      valid = false;
      displayError("edit-priceError", "Vui lòng nhập đơn giá!");
    } else if (isNaN(price) || parseFloat(price) <= 0) {
      valid = false;
      displayError("edit-priceError", "Đơn giá phải là số dương!");
    }

    // Validate Category
    const category = document.getElementById("categoryId").value;
    if (category === "") {
      valid = false;
      displayError("edit-categoryError", "Vui lòng chọn danh mục!");
    }

    // Validate Description
    const description = document.getElementsByName("description")[0].value.trim();
    if (description === "") {
      valid = false;
      displayError("edit-descriptionError", "Vui lòng nhập mô tả sản phẩm!");
    }

    // Validate variant quantities
    const quantityInputs = document.querySelectorAll('input[name^="quantity_"]');
    for (let i = 0; i < quantityInputs.length; i++) {
      const qty = quantityInputs[i].value.trim();
      if (qty === "" || isNaN(qty) || parseInt(qty) < 0) {
        valid = false;
        displayError("edit-variantError", "Số lượng phải là số không âm!");
        break;
      }
    }

    // Validate new color/size (if provided)
    const addColor = document.getElementsByName("updateColor")[0].value.trim();
    if (addColor !== "") {
      const alphaRegex = /^[a-zA-ZÀ-ỹ\s]+$/;
      if (!alphaRegex.test(addColor)) {
        valid = false;
        displayError("edit-colorError", "Tên màu chỉ được chứa chữ cái!");
      }
    }

    const addSize = document.getElementsByName("updateSize")[0].value.trim();
    if (addSize !== "") {
      const alphaRegex = /^[a-zA-ZÀ-ỹ0-9\s]+$/;
      if (!alphaRegex.test(addSize)) {
        valid = false;
        displayError("edit-sizeError", "Tên size chỉ được chứa chữ cái và số!");
      }
    }

    if (addColor !== "" && addSize === "") {
      valid = false;
      displayError("edit-sizeError", "Vui lòng nhập size khi đã nhập màu!");
    }
    if (addSize !== "" && addColor === "") {
      valid = false;
      displayError("edit-colorError", "Vui lòng nhập màu khi đã nhập size!");
    }

    console.log("Form validation result:", valid);
    return valid;
  }

  // Confirm delete function
  function confirmDelete() {
    return confirm("Bạn có chắc chắn muốn xóa sản phẩm này?");
  }
</script>

</body>
</html>