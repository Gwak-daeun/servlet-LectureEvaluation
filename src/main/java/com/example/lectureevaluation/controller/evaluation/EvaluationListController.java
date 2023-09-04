package com.example.lectureevaluation.controller.evaluation;

import com.example.lectureevaluation.controller.Controller;
import com.example.lectureevaluation.evaluation.EvaluationDAO;
import com.example.lectureevaluation.evaluation.EvaluationDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

public class EvaluationListController implements Controller {
    @Override
    public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("start search");
        String lectureDivide = request.getParameter("lectureDivide");
        String searchType = request.getParameter("searchType");
        int pageNumber = 0;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        System.out.println("pageNumber" + pageNumber);
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        System.out.println("check search : " + lectureDivide + searchType + search + pageNumber);
        ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
        evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);

        HttpSession session = request.getSession();
        session.setAttribute("evaluationList", evaluationList);
        session.setAttribute("pageNumber", pageNumber);
        System.out.println("evaluationList : " + evaluationList.size());
        return "main";
    }

}
