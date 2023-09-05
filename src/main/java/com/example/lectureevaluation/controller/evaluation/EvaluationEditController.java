package com.example.lectureevaluation.controller.evaluation;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.evaluation.EvaluationDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class EvaluationEditController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int evaluationID = Integer.parseInt(request.getParameter("evaluationID"));
        String lectureName = request.getParameter("lectureName");
        String professorName = request.getParameter("professorName");
        int lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
        String semesterDivide = request.getParameter("semesterDivide");
        String lectureDivide = request.getParameter("lectureDivide");
        String evaluationTitle = request.getParameter("evaluationTitle");
        String evaluationContent = request.getParameter("evaluationContent");
        String userID = request.getParameter("userID");

        HttpSession session = request.getSession();

        String SessionUserID = (String) session.getAttribute("userID");

        if (!userID.equals(SessionUserID)) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('자신이 쓴 글만 수정할 수 있어요.');");
            script.println("location.href = 'mainView.do'");
            script.println("</script>");
            script.close();
            return null;
        }

        EvaluationDAO evaluationDAO = new EvaluationDAO();

        int result = evaluationDAO.edit(
                evaluationID, lectureName, professorName, lectureYear,
                semesterDivide, lectureDivide, evaluationTitle, evaluationContent);

        if (result == 1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('수정 완료!');");
            script.println("location.href = 'mainView.do'");
            script.println("</script>");
            script.close();
            return null;
        }

        return null;
    }
}
