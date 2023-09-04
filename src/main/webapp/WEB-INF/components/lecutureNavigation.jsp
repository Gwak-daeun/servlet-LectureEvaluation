<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<nav class="navbar navbar-expand-lg nav-bar-light bg-light">
    <a class="navbar-brand" href="../../index.jsp">강의평가 웹사이트</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="mainView.do">메인</a>
            </li>
            <li class="nav-item dropdown">
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" role="button" id="dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        회원 관리
                    </a>
                    <ul class="dropdown-menu">
                        <c:if test="${userID == null}" >
                        <li><a class="dropdown-item" href="login.do">로그인</a></li>
                        <li> <a class="dropdown-item" href="insertUserView.do">회원가입</a></li>
                        </c:if>

                        <c:if test="${userID != null}">
                        <li><a class="dropdown-item" href="logout.do">로그아웃</a></li>
                        </c:if>
                    </ul>
                </div>
            </li>
        </ul>
        <form action="searchList.do" method="get" class="form-inline my-2 my-lg-0">
            <input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
    </div>
</nav>