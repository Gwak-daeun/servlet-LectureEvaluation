<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page import="com.example.lectureevaluation.user.UserDTO" %>
<%@ page import="com.example.lectureevaluation.util.SHA256" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
  String code = null;
  if (request.getParameter("code") != null) {
    code = request.getParameter("code");
  }
  UserDAO userDAO = new UserDAO();
  String userID = null;

  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
  }
  if (userID == null) {
    session.setAttribute("userID", userID);
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그인을 해주세요.');");
    script.println("location.href = 'userLogin.jsp';");
    script.println("</script>");
    script.close();
//    return;
  }

  String userEmail = userDAO.getUserEmail(userID);
  boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;

  if (isRight) {
    userDAO.setUserEmailChecked(userID);
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('인증에 성공했습니다.');");
    script.println("location.href = 'index.jsp';");
    script.println("</script>");
    script.close();
//    return;
  } else {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않은 코드 입니다.');");
    script.println("location.href = 'index.jsp';");
    script.println("</script>");
    script.close();
//    return;
  }

%>
