<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page import="com.example.lectureevaluation.user.UserDTO" %>
<%@ page import="com.example.lectureevaluation.util.SHA256" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID != null) {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인한 상태 입니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
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
        script.close();
        return;
    }
    UserDAO userDAO = new UserDAO();
    int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디 입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'emailSendAction.jsp'");
        script.println("</script>");
        script.close();
//        return;
    }
%>
