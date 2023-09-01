<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                        <li> <a class="dropdown-item" href="insertUserView.do">회원가입</a></li>
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