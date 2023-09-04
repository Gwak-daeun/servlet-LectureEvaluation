<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.lectureevaluation.user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.lectureevaluation.evaluation.EvaluationDTO" %>
<%@ page import="com.example.lectureevaluation.evaluation.EvaluationDAO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    request.setCharacterEncoding("UTF-8");
    String lectureDivide = "전체";
    String searchType = "최신순";
    String search = "";
    int pageNumber = 0;
    if (request.getParameter("lectureDivide") != null) {
        lectureDivide = request.getParameter("lectureDivide");
    }
    if (request.getParameter("searchType") != null) {
        searchType = request.getParameter("searchType");
    }
    if (request.getParameter("search") != null) {
        search = request.getParameter("search");
    }
    if (request.getParameter("pageNumber") != null) {
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        } catch (Exception e) {
            System.out.println("검색 페이지 번호 오류");
            e.printStackTrace();
        }
    }
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
//  if (userID == null) {
//    session.setAttribute("userID", userID);
//    PrintWriter script = response.getWriter();
//    script.println("<script>");
//    script.println("alert('로그인 해주세요.');");
//    script.println("location.href = 'userLogin.jsp'");
//    script.println("</script>");
//    script.close();
//    return;
//  }
//  boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
//  if (emailChecked == false) {
//    session.setAttribute("userID", userID);
//    PrintWriter script = response.getWriter();
//    script.println("<script>");
//    script.println("location.href = 'emailSendConfirm.jsp'");
//    script.println("</script>");
//    script.close();
//    return;
//  }

%>


<%@ include file="./components/lecutureNavigation.jsp" %>

<section class="container">
    <form method="get" action="searchList.do" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
            <option value="전체">전체</option>
            <option value="전공" <c:if test="${lectureDivide == '전공'}" >selected</c:if>>전공</option>
            <option value="교양" <c:if test="${lectureDivide == '교양'}" >selected</c:if>>교양</option>
            <option value="기타" <c:if test="${lectureDivide == '기타'}" >selected</c:if>>기타</option>
        </select>
        <select name="searchType" class="form-control mx-1 mt-2">
            <option value="최신순" <c:if test="${searchType == '최신순'}" >selected</c:if>>최신순</option>
            <option value="추천순"<c:if test="${searchType == '추천순'}" >selected</c:if>>추천순</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-bs-toggle="modal" data-bs-target="#registerModal">등록하기</a>
        <a class="btn btn-danger mx-1 mt-2" data-bs-toggle="modal" data-bs-target="#reportModal">신고</a>
    </form>

    <c:forEach var="evaluation" items="${evaluationList}">
        <div class="card bg-light mt-3">
            <div class="card-header bg-light">
                <div class="row">
                    <div class="col-8 text-left">${evaluation.lectureName}&nbsp;<small>${evaluation.professorName}</small></div>
                    <div class="col-4 text-right">
                        종합<span style="color: red;">${evaluation.totalScore}</span>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <h5 class="card-title">
                        ${evaluation.evaluationTitle}&nbsp;<small>${evaluation.lectureYear}년 ${evaluation.semesterDivide}</small>
                </h5>
                <p class="card-text">${evaluation.evaluationContent}</p>
                <div class="row">
                    <div class="col-9 text-left">
                        성적<span style="color: red;">${evaluation.creditScore}</span>
                        널널<span style="color: red;">${evaluation.comfortableScore}</span>
                        강의<span style="color: red;">${evaluation.lectureScore}</span>
                        <span style="color: green">(추천: ${evaluation.likeCount})</span>
                    </div>
                    <div class="col-3 text-right">
                        <a onclick="return confirm('추천하시겠습니까?')" href="like.do?evaluationID=${evaluation.evaluationID}">추천</a>
                        <a onclick="return confirm('삭제하시겠습니까?')" href="evaluationDelete.do?evaluationID=${evaluation.evaluationID}">삭제</a>

                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</section>

<ul class="pagination justify-content-center mt-3">
    <li class="page-item">

        <c:if test="${pageNumber <= 0}">
            <a class="page-link disabled">이전</a>
        </c:if>
        <c:if test="${pageNumber > 0}">
            <a class="page-link" href="searchList.do?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">
                이전
            </a>
        </c:if>
    </li>
    <li>
        <c:if test="${evaluationList.size() < 6}">
            <a class="page-link disabled">다음</a>
        </c:if>
        <c:if test="${evaluationList.size() >= 6}">
            <a class="page-link" href="searchList.do?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">
                다음
            </a>

        </c:if>
    </li>
</ul>


<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal">평가 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="evaluationRegister.do" method="post">
                    <div class="row">
                        <div class="form-group col-sm-6">
                            <label>강의명</label>
                            <input type="text" name="lectureName" class="form-control" maxlength="20">
                        </div>
                        <div class="form-group col-sm-6">
                            <label>교수</label>
                            <input type="text" name="professorName" class="form-control" maxlength="20">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-4">
                            <label>수강 연도</label>
                            <select name="lectureYear" class="form-control">
                                <option value="2011">2011</option>
                                <option value="2012">2012</option>
                                <option value="2013">2013</option>
                                <option value="2014">2014</option>
                                <option value="2015">2015</option>
                                <option value="2016">2016</option>
                                <option value="2017">2017</option>
                                <option value="2018">2018</option>
                                <option value="2019">2019</option>
                                <option value="2020">2020</option>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                                <option value="2023" selected>2023</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-4">
                            <label>수강 학기</label>
                            <select name="semesterDivide" class="form-control">
                                <option value="" selected>1학기</option>
                                <option value="여름학기" >여름학기</option>
                                <option value="2학기" >2학기</option>
                                <option value="겨울학기" >겨울학기</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-4">
                            <label>강의 구분</label>
                            <select name="lectureDivide" class="form-control">
                                <option value="전공" selected>전공</option>
                                <option value="교양" >교양</option>
                                <option value="기타" >기타</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input type="text" name="evaluationTitle" class="form-control" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-3">
                            <label>종합</label>
                            <select name="totalScore" class="form-control">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>성적</label>
                            <select name="creditScore" class="form-control">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>널널</label>
                            <select name="comfortableScore" class="form-control">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>강의</label>
                            <select name="lectureScore" class="form-control">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal">신고하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="report.do" method="post">
                    <div class="form-group">
                        <label>신고 제목</label>
                        <input type="text" name="reportTitle" class="form-control" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label>신고 내용</label>
                        <textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-danger">신고하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<footer class="bg-dark mt-4 p-5 text-center" style="color: #ffffff;">
    Copyright &copy; 곽다은
</footer>
</body>
</html>