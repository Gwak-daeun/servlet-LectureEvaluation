package com.example.lectureevaluation.controller.user;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.user.UserDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class UserLoginController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String userID = null;
        String userPassword = null;
        HttpSession session = request.getSession();

        if (request.getParameter("userID") != null) {
            userID = request.getParameter("userID");
        }
        if (request.getParameter("userPassword") != null) {
            userPassword = request.getParameter("userPassword");
        }

        if (userID == null || userPassword == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 부분이 있어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }
        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(userID, userPassword);
        if (result == 1) {
            session.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'index.jsp'");
            script.println("</script>");
            script.close();
            return null;
        } else if (result == 0){
            session.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀렸어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }
        else if (result == -1){
            session.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디에요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }
        else if (result == -2){
            session.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }

        return null;
    }
}
