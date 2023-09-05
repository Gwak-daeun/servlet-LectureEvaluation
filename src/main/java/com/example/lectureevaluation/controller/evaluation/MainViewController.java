package com.example.lectureevaluation.controller.evaluation;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.evaluation.EvaluationDAO;
import com.example.lectureevaluation.evaluation.EvaluationDTO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

public class MainViewController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("move to Main view");

        String lectureDivide = "전체";
        String searchType = "최신순";
        int pageNumber = 0;
        String search = "";

        ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
        evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);

        HttpSession session = request.getSession();
        session.setAttribute("evaluationList", evaluationList);
        session.setAttribute("pageNumber", pageNumber);
        session.setAttribute("lectureDivide", lectureDivide);
        session.setAttribute("searchType", searchType);
        System.out.println("evaluationList : " + evaluationList.size());

        return "main";
    }
}
