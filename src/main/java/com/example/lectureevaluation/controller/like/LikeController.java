package com.example.lectureevaluation.controller.like;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.evaluation.EvaluationDAO;
import com.example.lectureevaluation.like.LikeyDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class LikeController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=UTF-8");

        getClientIP(request);

        String userID = null;

        HttpSession session = request.getSession();

        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 해주세요.');");
            script.println("location.href = 'userLogin.jsp'");
            script.println("</script>");
            script.close();
            return null;
        }

        request.setCharacterEncoding("UTF-8");
        String evaluationID = null;
        if (request.getParameter("evaluationID") != null) {
            evaluationID = request.getParameter("evaluationID");
        }
        EvaluationDAO evaluationDAO = new EvaluationDAO();
        LikeyDAO likeyDAO = new LikeyDAO();
        int result = likeyDAO.like(userID, evaluationID, getClientIP(request));

        if (result == 1) {
            result = evaluationDAO.like(evaluationID);
            if (result == 1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('추천 완료!');");
                script.println("location.href = 'index.jsp';");
                script.println("</script>");
                script.close();
                return null;
            }
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 생겼어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }

        return null;
    }

    public static String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-FORWARD-FOR");
        if (ip == null || ip.isEmpty()) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty()) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty()) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
