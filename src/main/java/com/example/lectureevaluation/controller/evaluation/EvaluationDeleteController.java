package com.example.lectureevaluation.controller.evaluation;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.evaluation.EvaluationDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class EvaluationDeleteController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 해주세요.');");
            script.println("location.href = 'loginView.do'");
            script.println("</script>");
            script.close();

        }

        request.setCharacterEncoding("UTF-8");
        String evaluationID = null;
        if (request.getParameter("evaluationID") != null) {
            evaluationID = request.getParameter("evaluationID");
        }
        EvaluationDAO evaluationDAO = new EvaluationDAO();
        if (userID.equals(evaluationDAO.getUserID(evaluationID))) {
            int result = new EvaluationDAO().delete(evaluationID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('삭제 완료!');");
            script.println("location.href = 'loginView.do';");
            script.println("</script>");
            script.close();
            System.out.println("delete result : " + result);

        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 생겼어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
        }
        return null;
    }
}
