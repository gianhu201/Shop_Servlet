<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous"/>
    <link rel="stylesheet" href="/views/css/style2.css">
    <script src="<%= request.getContextPath() %>/views/js/login_validation.js"></script>
    <script src="https://accounts.google.com/gsi/client" async defer></script>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="row border rounded-5 p-3 bg-white shadow box-area">

        <!-- Left Image Box -->
        <div class="col-md-6 rounded-4 d-flex justify-content-center align-items-center flex-column left-box">
            <div class="featured-image mb-3">
                <img src="<%= request.getContextPath() %>/views/images/Login.jpg" class="img-fluid">
            </div>
        </div>

        <!-- Right Login Box -->
        <div class="col-md-6 right-box">
            <div class="row align-items-center">
                <div class="header-text mb-4">
                    <h2>Đăng nhập</h2>
                </div>

                <%-- Hiển thị thông báo thành công khi đăng xuất --%>
                <%
                    String message = request.getParameter("message");
                    if ("logout_success".equals(message)) {
                %>
                <div class="alert alert-success" role="alert">
                    Đăng xuất thành công!
                </div>
                <%
                    }
                %>

                <%-- Hiển thị thông báo lỗi khi đăng nhập thất bại --%>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%= error %>
                </div>
                <%
                    }
                %>

                <form id="loginForm"  action="<%= request.getContextPath() %>/login" method="post">
                    <div class="input-group mb-3">
                        <div class="w-100">
                            <label for="email" class="form-label fs-6">Email</label>

                            <input type="text" id="email" name="email"
                                   class="form-control form-control-lg bg-light fs-6" placeholder="Nhập email">
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <div class="w-100">
                            <label for="password" class="form-label fs-6">Mật khẩu</label>
                            <input type="password" id="password" name="password"
                                   class="form-control form-control-lg bg-light fs-6" placeholder="Nhập mật khẩu">
                        </div>
                    </div>

                    <div class="input-group mb-5 d-flex justify-content-between">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="formCheck">
                            <label for="formCheck" class="form-check-label text-secondary"><small>Ghi nhớ đăng nhập</small></label>
                        </div>
                        <div class="forgot">
                            <small><a href="/forgotpassword">Quên mật khẩu?</a></small>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="submit" value="Đăng nhập" class="btn btn-lg btn-primary w-100 fs-6"/>
                    </div>
                </form>

                <!-- Nút đăng nhập Google -->
                <%
                    String googleLoginURL = dao.GoogleUtils.getOAuthURL();
                %>

                <a href="<%= googleLoginURL %>" style="text-decoration: none;">
                    <button style="
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 5px 15px;
        background-color: white;
        border: 1px solid #dadce0;
        border-radius: 4px;
        font-family: Roboto, sans-serif;
        font-size: 16px;
        color: #3c4043;
        cursor: pointer;
        box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 2px 0px;
    ">
                        <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google Logo" style="height: 20px; width: 20px;">
                        Đăng nhập bằng Google
                    </button>
                </a>



                <div class="row">
                    <small>Chưa có tài khoản? <a href="<%= request.getContextPath() %>/views/signup.jsp">Đăng ký</a></small>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://accounts.google.com/gsi/client" async defer></script>

<script>
    function handleCredentialResponse(response) {
        // Gửi code từ Google đến oauth2callback
        const code = response.credential;
        window.location.href = "<%= request.getContextPath() %>/oauth2callback?code=" + encodeURIComponent(code);
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>
</body>
</html>
