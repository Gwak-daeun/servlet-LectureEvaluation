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

<%@ include file="./components/lecutureNavigation.jsp" %>
<section class="container mt-3" style="max-width: 560px;">
    <form method="post" action="insertUser.do">
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




<%@ include file="./components/footer.jsp" %>
</body>
</html>