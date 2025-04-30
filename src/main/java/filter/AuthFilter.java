package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false); // Lấy session nếu có

        if (session == null || session.getAttribute("userRole") == null) {
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
            return;
        }

        String role = (String) session.getAttribute("userRole");
        if (!"Admin".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/views/access-denied.jsp");
            return;
        }

        // Cho phép truy cập
        chain.doFilter(request, response);
    }
}
