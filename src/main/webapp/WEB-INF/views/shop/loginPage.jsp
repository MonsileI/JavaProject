<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
    <title>Mangae</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="../resources/mangae/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../resources/mangae/img/favicon.ico">

    <link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/mangae/css/templatemo.css">
    <link rel="stylesheet" href="../resources/mangae/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="../resources/mangae/css/fontawesome.min.css">

</head>
<body>

 <div class="container">
        <div class="py-5 text-center">
            <h2>로그인</h2>
        </div>

 <div class="col-md-12 order-md-1">
      <form class="form-signin" action="../shop/loginProcess.do" method="post">
      
      			<div class="mb-3">
                    <label for="pw">아이디</label> 
                    <input type="text" class="form-control" name="id" id="id" placeholder="id" value="" required>
                </div>
                
                 <div class="mb-3">
                    <label for="pw">비밀번호</label> 
                    <input type="password" class="form-control" name="pw" id="pw" placeholder="Password" value="" required>
                </div>
      
      <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>  <label><a href="./joinMemberPage.do">회원가입</a></label>
      
        
      
       </form>
      </div>
    </div> 
     
    <!-- Start Script -->
    <script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
    <script src="../resources/mangae/js/templatemo.js"></script>
    <script src="../resources/mangae/js/custom.js"></script>
    <!-- End Script -->

</body>
</html>
