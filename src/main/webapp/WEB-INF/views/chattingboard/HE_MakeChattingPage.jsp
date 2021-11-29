<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- for문 if문 등등 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- date 타입을 예쁘게 바꿔주기위해 사용하는 tag library -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">


</head>
<!-- NAVBAR
================================================== -->
<body>

   <!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>
   
   
             <div style="width:1200px; margin: 100px auto;">
      <div class="row">
         <div class="col"></div>
         <div class="col-8">
         

   
   

   <h1>게시글 쓰기</h1>                              
      
      
   <form action = "./MakeChattingProcess.do" method="post" enctype="multipart/form-data">
   
      작성자 : ${sessionUser.nick }<br>
   
      <div class="mb-3">
         <label for="title">제목</label> 
         <input type="text" class="form-control" name= "title" value="" placeholder="title" required>
      </div>
     <input type="submit" value="개설하기">
   </form>
   
   

   
   <!-- /.container -->
   
            </div>
         <div class="col"></div>
      </div>
   </div>

      <!-- FOOTER -->
   <jsp:include page="../include/footer.jsp"></jsp:include>
   
   	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
 	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
</body>
</html>