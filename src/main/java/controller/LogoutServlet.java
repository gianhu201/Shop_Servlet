package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("LogoutServlet: Dang xu li logout...");

            HttpSession session = request.getSession(false);
            if (session != null) {
                System.out.println("LogoutServlet: Session ton tai, dang huy...");
                session.invalidate(); // Hủy session
            }

            System.out.println("LogoutServlet: chuyen huong den trang login");
            response.sendRedirect(request.getContextPath() + "/login?message=logout_success");
        } catch (Exception e) {
            System.err.println("Loi khi logout: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=logout_failed");
        }
    }

}