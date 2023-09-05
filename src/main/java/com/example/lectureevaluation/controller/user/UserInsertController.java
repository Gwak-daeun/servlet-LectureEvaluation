package com.example.lectureevaluation.controller.user;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.user.UserDAO;
import com.example.lectureevaluation.user.UserDTO;
import com.example.lectureevaluation.util.SHA256;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class UserInsertController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("회원가입 처리 시작");

        String userID = null;
        if (request.getAttribute("userID") != null) {
            userID = (String) request.getAttribute("userID");
        }
        if (userID != null) {
            request.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인한 상태 입니다.');");
            script.println("location.href = 'mainView.do';");
            script.println("</script>");
            script.flush();
            script.close();

        }
        String userPassword = null;
        String userEmail = null;
        if (request.getParameter("userID") != null) {
            userID = request.getParameter("userID");
        }
        if (request.getParameter("userPassword") != null) {
            userPassword = request.getParameter("userPassword");
        }
        if (request.getParameter("userEmail") != null) {
            userEmail = request.getParameter("userEmail");
        }
        if (userID == null || userPassword == null || userEmail == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 부분이 있어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.flush();
            script.close();

        }
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디 입니다.');");
            script.println("history.back();");
            script.println("</script>");
            script.flush();
            script.close();
        } else {
            request.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'emailSendConfirmView.do'");
            script.println("</script>");
            script.flush();
            script.close();
        }
        return "index";
    }
}
