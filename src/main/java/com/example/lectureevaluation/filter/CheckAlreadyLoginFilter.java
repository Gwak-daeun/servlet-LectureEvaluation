package com.example.lectureevaluation.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebFilter(urlPatterns = {"/insertUser.do", "/login.do"})
public class CheckAlreadyLoginFilter extends HttpFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //세션에 userID정보가 등록되어있는지 확인
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        if (session.getAttribute("userID") != null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인 하셨어요.');");
            script.println("location.href='mainView.do'");
            script.println("</script>");
            script.close();
        } else {
            chain.doFilter(request, response);
        }
    }
}
