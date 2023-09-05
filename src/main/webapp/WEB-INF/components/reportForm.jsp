<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal">신고하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-danger">신고하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>