<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.lectureevaluation.evaluation.EvaluationDAO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%

    String userID = null;
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
        return;
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
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 생겼어요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


%>