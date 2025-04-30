<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/views/css/footer.css">

<!-- Footer Section Begin -->
<footer class="footer">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 col-md-6 col-sm-7">
        <div class="footer__about">
          <div class="footer__logo">
            <a href="./index.html"><img src="img/logo.png" alt=""></a>
          </div>
          <p>Phong cách và cá tính</p>
          <p>Đẳng cấp trong từng chi tiết.</p>
          <div class="footer__payment">
            <a href="#"><img src="img/payment/payment-1.png" alt=""></a>
            <a href="#"><img src="img/payment/payment-2.png" alt=""></a>
            <a href="#"><img src="img/payment/payment-3.png" alt=""></a>
            <a href="#"><img src="img/payment/payment-4.png" alt=""></a>
            <a href="#"><img src="img/payment/payment-5.png" alt=""></a>
          </div>
        </div>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-5">
        <div class="footer__widget">
          <h6>Quick links</h6>
          <ul>
            <li><a href="#">Thông tin</a></li>
            <li><a href="#">Blogs</a></li>
            <li><a href="#">Liên hệ</a></li>
            <li><a href="#">Trang chủ</a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-4">
        <div class="footer__widget">
          <h6>Account</h6>
          <ul>
            <li><a href="#">Tài khoản </a></li>
            <li><a href="#">Giỏ hàng</a></li>
            <li><a href="#">Yêu thích</a></li>
            <li><a href="#">Sản phẩm</a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-4 col-md-8 col-sm-8">
        <div class="footer__newslatter">
          <h6>NEWSLETTER</h6>
          <form action="#">
            <input type="text" placeholder="Email" class="email">
            <button type="submit" class="site-btn">Subscribe</button>
          </form>
          <div class="footer__social">
            <a href="#"><i class="fab fa-facebook"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</footer>
<!-- Footer Section End -->