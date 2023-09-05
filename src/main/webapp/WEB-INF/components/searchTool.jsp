<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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