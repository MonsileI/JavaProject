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

<title>Carousel Template for Bootstrap</title>

</head>
<!-- NAVBAR
================================================== -->
<body>

	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	<!-- side menu -->
	<jsp:include page="../include/side.jsp"></jsp:include>
	
	
	
	
	<form action = "updateHE_SitterBoardProcess.do" method="post"> <!-- 액션에다가 ?board_no=도 할 수 있음 근데 form 태그를 쓰는 이상.. 절대 쓰지마..어차피 post방식이기도 하고 -->
															   <!-- 보통 url에 보낼땐 링크일때 쓰렴 -->	
	<div class="row mt-5">
	
		<div class="col"></div>
		<div class="col-8">
		
			<div class="row">
				<h6>작성자 : ${content.memberVo.nick }</h6>
			</div>
			
			<div class="row">		
				<div class="form-floating">
  					<textarea class="form-control" name="title" id="floatingTextarea">${content.boardVo.title }</textarea>
  					<label for="floatingTextarea"></label>
				</div>	
			</div>
			
			<div class="row-8 mt-2">
				<div class="form-floating">
  					<textarea class="form-control" name="content" id="floatingTextarea2" style="height: 300px">${content.boardVo.content }</textarea>
  					<label for="floatingTextarea2"></label>
  					<input name = "sitterboard_no" type="hidden" value="${content.boardVo.sitterboard_no }">
				</div>
			</div>
			
			
			<div class="mb-3">
				<label for="endDate">마감 기한</label> 
        		<input type="date" class="form-control" name="endDate" value="${content.boardVo.endDate }">    
			</div>
			<div class="mb-3">
				<label for="possibleArea">가능 지역</label> 
          		<input type="text" class="form-control" name="possibleArea value=${content.boardVo.possibleArea }">
			</div>
	
			<input name = "sitterboard_no" type="hidden" value="${content.boardVo.sitterboard_no }"> <!-- 사용자가 못건드리게 할때 이렇게 히든을 쓰는구나~ 재밌자나-->
	
			<div class="row mt-2">
				<div class="col-9"></div>
				<div class="col" style="text-align:right;"><button type="submit" class="btn btn-primary">수정</button></div>
			</div>
			
		</div>
			
		<div class="col"></div>
		
	</div>
	
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- FOOTER -->
	<jsp:include page="../include/footer.jsp"></jsp:include>

	
	<!-- /.container -->
		<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
 	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
</body>
</html>