package controller;

import dao.UserDAO;
import model.User;
import dao.GoogleUtils;
import com.google.api.services.oauth2.model.Userinfo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/login", "/oauth2callback"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/oauth2callback".equals(path)) {
            // Xử lý Google OAuth callback
            String code = request.getParameter("code");
            if (code != null) {
                try {
                    // Trao đổi code để lấy access token
                    String accessToken = GoogleUtils.getAccessTokenFromCode(code);
                    // Lấy thông tin người dùng từ Google
                    Userinfo userInfo = GoogleUtils.getUserInfo(accessToken);
                    String userEmail = userInfo.getEmail();
                    String userFullname = userInfo.getName();

                    // Kiểm tra nếu người dùng đã tồn tại hay ch
                    User user = UserDAO.getUserByEmail(userEmail);
                    if (user == null) {
                        // Nếu người dùng chưa có, tạo mới người dùng
                        user = new User(userEmail, userFullname);
                        UserDAO.insertUser(user);

                        // Lấy lại user để có userId
                        user = UserDAO.getUserByEmail(userEmail);

                        int roleId = 2; // mac dinh role 2 la User
                        UserDAO.assignRoleToUser(user.getUserId(), roleId);
                    }

                    HttpSession session = request.getSession();
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userEmail", user.getEmail());
                    session.setAttribute("userName", user.getFullname());
                    session.setAttribute("userRole", UserDAO.getUserRole(user.getUserId()));

                    response.sendRedirect(request.getContextPath() + "/product");
                } catch (Exception e) {
                    request.setAttribute("error", "Lỗi khi đăng nhập với Google: " + e.getMessage());
                    request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            }
        } else {
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/login".equals(path)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                User user = UserDAO.getUserByEmailAndPassword(email, password);
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userEmail", user.getEmail());
                    session.setAttribute("userName", user.getFullname());

                    String userRole = UserDAO.getUserRole(user.getUserId());
                    session.setAttribute("userRole", userRole);

                    if ("Admin".equals(userRole)) {
                        response.sendRedirect(request.getContextPath() + "/admin/ADproduct");
                    } else if ("User".equals(userRole)) {
                        response.sendRedirect(request.getContextPath() + "/product");
                    }
                } else {
                    request.setAttribute("error", "Sai email hoặc mật khẩu");
                    request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                throw new ServletException("Lỗi kết nối DB: " + e.getMessage());
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    }
}