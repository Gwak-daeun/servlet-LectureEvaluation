<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul class="pagination justify-content-center mt-3">
    <li class="page-item">
        <c:if test="${pageNumber <= 0}">
            <a class="page-link disabled">이전</a>
        </c:if>
        <c:if test="${pageNumber > 0}">
            <a class="page-link" href="searchList.do?lectureDivide=${lectureDivide}&searchType=${searchType}&search=${search}&pageNumber=${pageNumber - 1}">
                이전
            </a>
        </c:if>
    </li>
    <li>
        <c:if test="${evaluationList.size() < 6}">
            <a class="page-link disabled">다음</a>
        </c:if>
        <c:if test="${evaluationList.size() >= 6}">
            <a class="page-link" href="searchList.do?lectureDivide=${lectureDivide}&searchType=${searchType}&search=${search}&pageNumber=${pageNumber + 1}">
                다음
            </a>
        </c:if>
    </li>
</ul>