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

<script src="../resources/js/finddogBoard.js"></script>


</head>
<!-- NAVBAR
================================================== -->
<body>

	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	<!-- side menu -->
	<jsp:include page="../include/side.jsp"></jsp:include>
	
	
	<div style="width:1100px; margin: 100px auto;">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				<div class="row mt-5">
					<div class="col"></div>
	

					<div>
						<a href="https://www.law.go.kr/%EB%B2%95%EB%A0%B9/%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EB%B2%95" target="_blank">
				    		<img src="../resources/img/law.png" alt="" class="img-responsive img-thumbnail"></a> <!--이미지를 액자처럼 테두리가 있게-->
					</div>
	
					<h2 class="bg-info">제목 : ${content.boardVo.title }

					<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
					<!-- 추후 자동으로 수락시, status 상태 바꾸기 쿼리 넣기-->
						
					<c:choose>
						<c:when test="${sessionUser.member_no eq content.memberVo.member_no and content.boardVo.status eq 'N'}">
							<input type="button" class = "btn btn-primary" id="FinddogStatusBtn" value="진행중" onclick="changeFinddogStatus(this);">
							<!-- 수락시, status 상태 바꾸기(Y) 쿼리 -->
						</c:when>
						<c:when test="${sessionUser.member_no ne content.memberVo.member_no and content.boardVo.status eq 'N'}">
							<input type="button" class = "btn btn-primary" id="FinddogStatusBtn" value="진행중" onclick="changeFinddogStatus(this);" disabled>
						</c:when>
						<c:otherwise>
							<input type="button" class = "btn btn-primary" id="FinddogStatusBtn" value="완료" onclick="changeFinddogStatus(this);" disabled>
						</c:otherwise>
					</c:choose>
					
				  
					  <script>
						  function changeFinddogStatus(status){
								console.log(status.value);
								
								 if(status.value == "진행중"){
								 	$("#FinddogStatusBtn").attr("value","완료");
								 }else{
								 	$("#FinddogStatusBtn").attr("value","진행중");
								 }
							}
					  </script>
			  
			 		 <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
			  
					</h2> <br>
					
					작성자 : ${content.memberVo.nick }<br>
					작성일 : <fmt:formatDate value="${content.boardVo.writeDate }" pattern="yy년MM월dd일"/> <br>
					조회수 : ${content.boardVo.readcount } <br>
					
					<br>
				    
				    <c:if test="${!empty content.boardVo.findPlace }">
				    발견장소:
				    	${content.boardVo.findPlace }
				    </c:if><br>
				    
				     <c:if test="${!empty content.boardVo.latitude }">
				     위도:
				    	${content.boardVo.latitude }
				    </c:if>
				    <c:if test="${!empty content.boardVo.longtitude }">
				     경도:
				    	${content.boardVo.longtitude }
				    </c:if><br>
				    
				    <c:if test="${!empty content.boardVo.findDate }">
				    발견날짜:
				    	${content.boardVo.findDate }
				    </c:if><br>
				  	
				    <c:if test="${!empty content.boardVo.petGender}">
				    성별:
				    	${content.boardVo.petGender}
				    </c:if><br>
				    
				    <c:if test="${!empty content.boardVo.species_no}">
					<c:forEach items="${speciesCategoryList}" var="pet">
						<c:choose>
							<c:when test="${pet.species_no eq content.boardVo.species_no}">
								종류: ${pet.species}
							</c:when>
							</c:choose>		
						</c:forEach>
				    </c:if><br>
				    
				    <c:if test="${!empty content.boardVo.petName }">
				    이름:
				    	${content.boardVo.petName }
				    </c:if><br>
				    <c:if test="${!empty content.boardVo.petAge}">
				    나이:
				    	${content.boardVo.petAge }
				    </c:if><br>
				    
				    <c:if test="${!empty content.boardVo.content }">
					내용 : 
						${content.boardVo.content }
					</c:if><br><br>
				    
				    <c:forEach items="${content.boardImageVoList}" var="boardImageVo" >
						<img src="/upload/${boardImageVo.imageboard_url }"><br>
					</c:forEach>
					
					<br>
					
					<br>
					
					<c:if test="${!empty sessionUser }">
						<c:choose>
							<c:when test="${like != 1  }" >
								<form action="clickRecommendProcess.do">
									<input type="hidden" name="finddogboard_no" value="${content.boardVo.finddogboard_no }">
									<button name="recommend">♡<i class="bi bi-heart text-danger fs-1"></i></button>
								</form>		
							</c:when>
							<c:otherwise>
								<form action="clickUnRecommendProcess.do">
									<input type="hidden" name="finddogboard_no" value="${content.boardVo.finddogboard_no }">
									<input type="hidden" name="member_no" value="${sessionUser.member_no }">
									<button name="recommend">♥<i class="bi bi-heart-fill text-danger fs-1"></i></button>
								</form>	  	
							</c:otherwise>
						</c:choose>
					</c:if>
				
					<br>
					좋아요 수 : ${goodCount }
					
					
					<br>
					<a href="./HE_FinddogBoardList.do">목록으로 </a>
					
						<c:if test="${!empty sessionUser  && sessionUser.member_no == content.memberVo.member_no }"> <!-- boardVo_member_no써도 상관없음   -->
						&nbsp; &nbsp;<a href="./deleteContentProcess.do?finddogboard_no=${content.boardVo.finddogboard_no }">삭제</a> <!-- 얘는 걍 삭제만 되면 됨 -->
						&nbsp; &nbsp;<a href="./updateHE_FinddogPage.do?finddogboard_no=${content.boardVo.finddogboard_no }">수정</a> <!--  얘는 뭔가 페이지가 있어야됨 -->
						</c:if>
					
					
					<hr>

					---------------------- 댓글 ---------------------- <br>
					
						<c:forEach items="${comment }" var="comment">
						
								작성자 : ${comment.memberVo.nick }
								작성일 : <fmt:formatDate value="${comment.commentVo.writeDate }" pattern="MM.dd" /><br>
								<c:if test="${!empty sessionUser && sessionUser.member_no == comment.commentVo.member_no }">
								
									<form action="updateCommentProcess.do" method="get">
										내용 : 
										<input type="text" name="comment_content" value="${comment.commentVo.comment_content }">
										<button>수정</button>
										<input type="hidden" name="comment_no" value="${comment.commentVo.comment_no }">
										<input type="hidden" name="finddogboard_no" value="${content.boardVo.finddogboard_no }">
									</form>
								</c:if>
						<hr>
						</c:forEach>
					
					
					
					
					</div>
					<div class="col"></div>
				</div>
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