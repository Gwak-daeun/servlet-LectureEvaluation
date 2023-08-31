<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page import="com.example.lectureevaluation.util.SHA256" %>
<%@ page import="java.util.Properties" %>

<%@ page import="com.example.lectureevaluation.util.Gmail" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%

    UserDAO userDAO = new UserDAO();
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



    boolean emailChecked = userDAO.getUserEmailChecked(userID);
    if (emailChecked) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 인증된 회원입니다.');");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    String host = "http://localhost:8080/";
    String from = "gwakmanager@gmail.com";
    String to = userDAO.getUserEmail(userID);
    String subject = "강의평가를 위한 이메일 인증 메일입니다.";
    String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." + "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";

    Properties p = new Properties();
    p.put("mail.smtp.user", from);
    p.put("mail.smtp.host", "smtp.googlemail.com");
    p.put("mail.smtp.port", "465");
    p.put("mail.smtp.starttls.enable", "true");
    p.put("mail.smtp.auth", "true");
    p.put("mail.smtp.debug", "true");
    p.put("mail.smtp.socketFactory.port", "465");
    p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    p.put("mail.smtp.socketFactory.fallback", "false");

    try {
        Authenticator auth = new Gmail();
        Session ses = Session.getInstance(p, auth);
        ses.setDebug(true);
        MimeMessage msg = new MimeMessage(ses);
        msg.setSubject(subject);
        Address fromAddr = new InternetAddress(from);
        msg.setFrom(fromAddr);
        Address toAddr = new InternetAddress(to);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
        msg.setContent(content,"text/html;charset=UTF8");
        Transport.send(msg);
    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생했습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>강의평가 웹사이트</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./css/custom.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

</head>
<body>

<%
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 해주세요.');");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
%>
<nav class="navbar navbar-expand-lg nav-bar-light bg-light">
    <a class="navbar-brand" href="index.jsp">강의평가 웹사이트</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">메인</a>
            </li>
            <li class="nav-item dropdown">
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" role="button" id="dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        회원 관리
                    </a>
                    <ul class="dropdown-menu">
                        <%
                            if (userID == null) {
                        %>
                        <li><a class="dropdown-item" href="userLogin.jsp">로그인</a></li>
                        <li> <a class="dropdown-item" href="userJoin.jsp">회원가입</a></li>
                        <%
                        } else {
                        %>
                        <li><a class="dropdown-item" href="userLogout.jsp">로그아웃</a></li>
                        <%
                            }
                        %>
                    </ul>
                </div>
            </li>
        </ul>
        <form action="index.jsp" method="get" class="form-inline my-2 my-lg-0">
            <input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
    </div>
</nav>
<section class="container mt-3" style="max-width: 560px;">
   <div class="alert alert-success mt-4" role="alert">
       이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가셔서 인증해주세요.
   </div>
</section>




<footer class="bg-dark mt-4 p-5 text-center" style="color: #ffffff;">
    Copyright &copy; 곽다은
</footer>
</body>
</html>