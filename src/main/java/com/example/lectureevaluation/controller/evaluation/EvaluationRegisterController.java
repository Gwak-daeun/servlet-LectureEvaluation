package com.example.lectureevaluation.controller.evaluation;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.evaluation.EvaluationDAO;
import com.example.lectureevaluation.evaluation.EvaluationDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class EvaluationRegisterController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {


        String userID = null;

        HttpSession session = request.getSession();

        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            request.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 해주세요.');");
            script.println("location.href = 'loginView.do';");
            script.println("</script>");
            script.close();
        }

        String lectureName = null;
        String professorName = null;
        int lectureYear = 0;
        String semesterDivide = null;
        String lectureDivide = null;
        String evaluationTitle = null;
        String evaluationContent = null;
        String totalScore = null;
        String creditScore = null;
        String comfortableScore = null;
        String lectureScore = null;

        if (request.getParameter("lectureName") != null) {
            lectureName = request.getParameter("lectureName");
        }
        if (request.getParameter("professorName") != null) {
            professorName = request.getParameter("professorName");
        }
        if (request.getParameter("lectureYear") != null) {
            try {
                lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
            } catch (Exception e) {
                System.out.println("강의 연도 데이터 오류");
                e.printStackTrace();
            }
        }
        if (request.getParameter("semesterDivide") != null) {
            semesterDivide = request.getParameter("semesterDivide");
        }
        if (request.getParameter("lectureDivide") != null) {
            lectureDivide = request.getParameter("lectureDivide");
        }
        if (request.getParameter("evaluationTitle") != null) {
            evaluationTitle = request.getParameter("evaluationTitle");
        }
        if (request.getParameter("evaluationContent") != null) {
            evaluationContent = request.getParameter("evaluationContent");
        }


        if (request.getParameter("creditScore") != null) {
            creditScore = request.getParameter("creditScore");
        }
        if (request.getParameter("comfortableScore") != null) {
            comfortableScore = request.getParameter("comfortableScore");
        }
        if (request.getParameter("lectureScore") != null) {
            lectureScore = request.getParameter("lectureScore");
        }

       int scoreSum = calculateScore(creditScore, comfortableScore, lectureScore);

      totalScore = choiceTotalScore(scoreSum);

        if (lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null ||
                lectureDivide == null || evaluationTitle == null || evaluationContent == null ||
                totalScore == null || creditScore == null || comfortableScore == null || lectureScore == null ||
                evaluationTitle.isEmpty() || evaluationContent.isEmpty()
        ) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 부분이 있어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        }
        EvaluationDAO evaluationDAO = new EvaluationDAO();
        int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName,
                lectureYear, semesterDivide, lectureDivide,
                evaluationTitle, evaluationContent, totalScore,
                creditScore, comfortableScore, lectureScore, 0
        ));
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('강의평가 등록에 실패했어요.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return null;
        } else if(result == 1) {
            session.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'mainView.do'");
            script.println("</script>");
            script.close();
            return null;
        } else {
            return "mainView.do";
        }
    }

    public int calculateScore(String creditScore, String comfortableScore, String lectureScore) {

       int result = Math.round((Integer.parseInt(creditScore)  + Integer.parseInt(comfortableScore) + Integer.parseInt(lectureScore)) / 3);

       return result;
    }

    public String choiceTotalScore(int scoreSum) {
        String totalScore;
        switch (scoreSum) {
            case 1:
                totalScore = "F";
                break;
            case 2:
                totalScore = "D";
                break;
            case 3:
                totalScore = "C";
                break;
            case 4:
                totalScore = "B";
                break;
            case 5:
                totalScore = "A";
                break;
            default:
                totalScore = "";
                break;
        }

        return totalScore;
    }
}
