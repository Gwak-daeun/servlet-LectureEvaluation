<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <form method="post" action="join">
        <div class="form-group">
            <label>아이디</label>
            <input type="text" name="userID" class="form-control">
        </div>
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="userPassword" class="form-control">
        </div>
        <div class="form-group">
            <label>이메일</label>
            <input type="email" name="userEmail" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">회원가입</button>
    </form>
</section>




<footer class="bg-dark mt-4 p-5 text-center" style="color: #ffffff;">
    Copyright &copy; 곽다은
</footer>
</body>
</html>