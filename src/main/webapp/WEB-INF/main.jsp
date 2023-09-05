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

<%--헤더 네비게이션--%>
<%@ include file="./components/lecutureNavigation.jsp" %>

<section class="container">

    <%--검색 툴--%>
    <%@ include file="./components/searchTool.jsp" %>

    <c:forEach var="evaluation" items="${evaluationList}">
        <div class="card bg-light mt-3" data-bs-toggle="modal" data-bs-target="#${evaluation.evaluationID}">
            <div class="card-header bg-light">
                <div class="row">
                    <div class="col-8 text-left">
                            ${evaluation.lectureName}&nbsp;<small>${evaluation.professorName}</small>
                    </div>
                    <div class="col-4 text-right">
                        종합
                        <span style="color: red;">
                                ${evaluation.totalScore}
                        </span>
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
                        <a onclick="return confirm('추천하시겠습니까?')" href="like.do?evaluationID=${evaluation.evaluationID}">
                            추천
                        </a>
                        <a onclick="return confirm('삭제하시겠습니까?')" href="evaluationDelete.do?evaluationID=${evaluation.evaluationID}">
                            삭제
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%--모달--%>
        <div class="modal fade" id="${evaluation.evaluationID}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modal">작성자 : ${evaluation.userID}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="evaluationEdit.do" method="post">

                            <input name="evaluationID" hidden="hidden" value="${evaluation.evaluationID}"/>
                            <input name="userID" hidden="hidden" value="${evaluation.userID}">

                            <div class="row">
                                <div class="form-group col-sm-6">
                                    <label>교수</label>
                                    <input value="${evaluation.professorName}" type="text" name="professorName" class="form-control" maxlength="20">
                                </div>
                                <div class="form-group col-sm-6">
                                    <label>강의명</label>
                                    <input value="${evaluation.lectureName}" type="text" name="lectureName" class="form-control" maxlength="20">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-sm-4">
                                    <label>수강 연도</label>
                                    <input value="${evaluation.lectureYear}" type="text" name="lectureYear" class="form-control">
                                </div>
                                <div class="form-group col-sm-4">
                                    <label>수강 학기</label>
                                    <select name="semesterDivide" class="form-control">
                                        <option value="1학기" ${evaluation.semesterDivide.equals("1학기") ? "selected" : ""}>1학기</option>
                                        <option value="여름학기" ${evaluation.semesterDivide.equals("여름학기") ? "selected" : ""}>여름학기</option>
                                        <option value="2학기" ${evaluation.semesterDivide.equals("2학기") ? "selected" : ""}>2학기</option>
                                        <option value="겨울학기" ${evaluation.semesterDivide.equals("겨울학기") ? "selected" : ""}>겨울학기</option>
                                    </select>
                                </div>
                                <div class="form-group col-sm-4">
                                    <label>강의 구분</label>
                                    <select name="lectureDivide" class="form-control">
                                        <option value="전공" ${evaluation.lectureDivide.equals("전공") ? "selected" : ""} >전공</option>
                                        <option value="교양" ${evaluation.lectureDivide.equals("교양") ? "selected" : ""}>교양</option>
                                        <option value="기타" ${evaluation.lectureDivide.equals("기타") ? "selected" : ""}>기타</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>제목</label>
                                <input value="${evaluation.evaluationTitle}" type="text" name="evaluationTitle" class="form-control" maxlength="30">
                            </div>
                            <div class="form-group">
                                <label>내용</label>
                                <textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;">${evaluation.evaluationContent}</textarea>
                            </div>
                            <div class="row">
                                <div class="form-group col-sm-3">
                                    <label>종합</label>
                                        <input
                                                class="form-control"
                                            data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Tooltip on top"
                                            value="${evaluation.totalScore}"
                                            readonly
                                        />
                                </div>
                                <div class="form-group col-sm-3">
                                    <label>성적</label>
                                    <input
                                        class="form-control"
                                        value="${evaluation.creditScore}"
                                        readonly
                                    />
                                </div>
                                <div class="form-group col-sm-3">
                                    <label>널널</label>
                                    <input
                                            class="form-control"
                                        value="${evaluation.comfortableScore}"
                                        readonly
                                    />
                                </div>
                                <div class="form-group col-sm-3">
                                    <label>강의</label>
                                        <input
                                                class="form-control"
                                            value="${evaluation.lectureScore}"
                                            readonly
                                        />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                <c:if test="${userID == evaluation.userID}">
                                    <button type="submit" class="btn btn-success">수정하기</button>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </c:forEach>
</section>



<%--페이지네이션--%>
<%@ include file="./components/lecturePagination.jsp" %>

<%--강의 평가 등록 폼--%>
<%@ include file="./components/lectureEvaluationForm.jsp" %>


<%--신고 폼--%>
<%@ include file="./components/reportForm.jsp" %>

<%--풋터--%>
<%@ include file="./components/footer.jsp" %>
</body>
</html>