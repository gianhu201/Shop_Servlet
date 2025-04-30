<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/views/css/categories-card.css">

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-6 p-0">
      <div class="categories__item categories__large__item set-bg">
        <img alt="" src="<%= request.getContextPath() %>/views/images/categories/banner1.jpg">
        <div class="categories__text categories__text-overlay">
          <h1>Women’s fashion</h1>
          <p>Thời trang cho phụ nữ: Nét đẹp tinh tế và phong cách thời
            thượng.</p>
          <a href="#">Shop now</a>
        </div>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
          <div class="categories__item set-bg">
            <img alt="" src="<%= request.getContextPath() %>/views/images/categories/banner2.jpg">
            <div class="categories__text categories__text-overlay">
              <h4>Men’s fashion</h4>
              <p>358 items</p>
              <a href="#">Shop now</a>
            </div>
          </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
          <div class="categories__item set-bg">
            <img alt="" src="<%= request.getContextPath() %>/views/images/categories/banner3.jpg">
            <div class="categories__text categories__text-overlay">
              <h4>Kid’s fashion</h4>
              <p>273 items</p>
              <a href="#">Shop now</a>
            </div>
          </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
          <div class="categories__item set-bg">
            <img alt="" src="<%= request.getContextPath() %>/views/images/categories/banner4.jpg">
            <div class="categories__text categories__text-overlay">
              <h4>Cosmetics</h4>
              <p>159 items</p>
              <a href="#">Shop now</a>
            </div>
          </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
          <div class="categories__item set-bg">
            <img alt="" src="<%= request.getContextPath() %>/views/images/categories/banner5.jpg">
            <div class="categories__text categories__text-overlay">
              <h4>Accessories</h4>
              <p>792 items</p>
              <a href="#">Shop now</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Additional product items here -->