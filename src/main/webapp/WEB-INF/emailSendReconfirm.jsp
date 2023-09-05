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
  <div class="alert alert-warning mt-4" role="alert">
    이메일 주소 인증을 하셔야 이용 가능합니다. 인증 메일을 받지 못하셨나요?
  </div>
  <a href="emailSend.do" class="btn btn-primary">인증 메일 다시 받기</a>
</section>

<%@ include file="./components/footer.jsp" %>
</body>
</html>