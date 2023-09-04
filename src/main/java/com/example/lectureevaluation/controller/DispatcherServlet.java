package com.example.lectureevaluation.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("*.do")
public class DispatcherServlet extends HttpServlet {
    private HandlerMapping handlerMapping;
    private ViewResolver viewResolver;

    public void init() throws ServletException {
        handlerMapping = new HandlerMapping();
        viewResolver = new ViewResolver();
        viewResolver.setPrefix("./WEB-INF/");
        viewResolver.setSuffix(".jsp");
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1. 사용자 요청 path를 추출한다.
        String uri = request.getRequestURI();
        String path = uri.substring(uri.lastIndexOf("/"));

        //2. HandlerMapping을 통해 path에 해당하는 Controller를 검색한다.
        Controller ctrl = handlerMapping.getController(path);

        //3. 검색된 Controller를 실행한다.
        String viewName = ctrl.handleRequest(request, response);

        System.out.println("viewName??? : " + viewName);

        //4. ViewResolver를 통해 viewName에 해당하는 경로를 완성한다.
        String view = null;
        if (!viewName.contains(".do")) {
            if (viewName.equals("index")) {
                view = viewName + ".jsp";
            } else {
                view = viewResolver.getView(viewName);
            }
        } else {
            view = viewName;
        }

        System.out.println("view???? : " + view);

        //5. 검색된 화면으로 포워딩한다.
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
}
