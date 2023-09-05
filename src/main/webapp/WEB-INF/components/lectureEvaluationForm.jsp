<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal">평가 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                    <div class="row">
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
                                <option value="1학기" selected>1학기</option>
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
                    <div class="row">
                        <div class="form-group col-sm-3">
                            <label>종합</label>
                            <select name="totalScore" class="form-control">
                                <option value="5" selected>A</option>
                                <option value="4">B</option>
                                <option value="3">C</option>
                                <option value="2">D</option>
                                <option value="1">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>성적</label>
                            <select name="creditScore" class="form-control">
                                <option value="5" selected>A</option>
                                <option value="4">B</option>
                                <option value="3">C</option>
                                <option value="2">D</option>
                                <option value="1">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>널널</label>
                            <select name="comfortableScore" class="form-control">
                                <option value="5" selected>A</option>
                                <option value="4">B</option>
                                <option value="3">C</option>
                                <option value="2">D</option>
                                <option value="1">F</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-3">
                            <label>강의</label>
                            <select name="lectureScore" class="form-control">
                                <option value="5" selected>A</option>
                                <option value="4">B</option>
                                <option value="3">C</option>
                                <option value="2">D</option>
                                <option value="1">F</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>