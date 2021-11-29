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

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">

<script src="../resources/js/noticeBoard.js"></script>


<script>


	var noticeboard_no =  ${content.boardVo.noticeboard_no};

	var member_no = null;



function checkSession(){
	
	
	var xmlhttp = new XMLHttpRequest();
	
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			var data = JSON.parse(xmlhttp.responseText);
			
			if(data.isLogin == true){
				member_no = data.member_no;
				
			}
			
		}
	};
	
	xmlhttp.open("get" , "../member/getSessionInfo.do" , false);   //마지막 false는 동기식 호출
	xmlhttp.send();


	
}





function processRecommend(){
	
		if(member_no == null){
			
			alert("로그인 후 이용하세요.");
			return;
		}
	
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				refreshHeart();
				refreshTotalCount();
			}
		};
		
		xmlhttp.open("post" , "./processRecommend.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("noticeboard_no="+noticeboard_no);
	}


	
	function refreshHeart(){
		
		if(member_no == null){
			
			return;
		}
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data= JSON.parse(xmlhttp.responseText);
				
				var emptyHeart = document.getElementById("emptyHeart");
				var fillHeart = document.getElementById("fillHeart");
				
				
				
				if(data.myRecommendCount > 0){
					//추천 한 경우.. 채워진 하트
					emptyHeart.setAttribute("class","bi bi-heart text-danger fs-1 d-none");
					fillHeart.setAttribute("class","bi bi-heart-fill text-danger fs-1");
				}else{
					//추천 안한 경우.. 비워진 하트
					emptyHeart.setAttribute("class","bi bi-heart text-danger fs-1");
					fillHeart.setAttribute("class","bi bi-heart-fill text-danger fs-1 d-none");
				}
			}
		};
		
		xmlhttp.open("get" , "./getMyRecommendCount.do?noticeboard_no="+noticeboard_no);
		xmlhttp.send();
		
	}
	function init(){
		
		checkSession();
		refreshTotalCount();
		refreshHeart();
		
		
	}

function refreshTotalCount(){
	
	
		
	
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				var data = JSON.parse(xmlhttp.responseText);
			//DOM rendering
				var totalCountBox = document.getElementById("totalCountBox");
				totalCountBox.innerText = "좋아요 수 : "+data.totalRecommendCount;
			
			
			}
		};
		
		//get 방식으로 파라미터 보내는법...
		//xmlhttp.open("get" , "./testRest.do?id=" + id); 
		//xmlhttp.send();
		
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./getTotalRecommendCount.do?noticeboard_no="+noticeboard_no);
		xmlhttp.send();

}



</script>


</head>
<!-- NAVBAR
================================================== -->
<body onload="init()">

	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	<!-- side menu -->
	<jsp:include page="../include/side.jsp"></jsp:include>
	
	
	<div style="width:1200px; margin: 100px auto;">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				<div class="row mt-5">
					
	
					<h2 class="bg-info">제목 : ${content.boardVo.title }

					<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
					<!-- 추후 자동으로 수락시, status 상태 바꾸기 쿼리 넣기-->
			
				
			 		 <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
			  
					</h2> <br>
					
					<h6>작성자 : ${content.memberVo.nick }</h6>
					<h6>작성일 : <fmt:formatDate value="${content.boardVo.writeDate }" pattern="yy년MM월dd일"/></h6>
					<h6>조회수 : ${content.boardVo.readcount }</h6>
					
					
				    <c:if test="${!empty content.boardVo.content }">
				    <div class="card">
					  <div class="card-body">
					   	${content.boardVo.content }
					  </div>
					</div>
					</c:if>
				    
				    <c:forEach items="${content.boardImageVoList}" var="boardImageVo" >
						<img src="/upload/${boardImageVo.imageboard_url}"><br>
					</c:forEach>
					
					
					<div class="row">
					<i id="emptyHeart" class="bi bi-heart text-danger fs-1" onclick="processRecommend()"></i>
					<i id="fillHeart" class="bi bi-heart-fill text-danger fs-1 d-none" onclick="processRecommend()"></i> 
					</div>
					<!-- <i class="bi bi-heart-fill text-danger fs-1"></i>  -->
					
					
				
					
					
					<span id="totalCountBox"></span>
						<div class="row mb-1">
					<br>
							<div class="col-8"><a href="./HE_NoticeBoardList.do">목록으로 </a></div>
							<c:if test="${!empty sessionUser  && sessionUser.member_no == content.memberVo.member_no }">
							<div class="col-2"></div>
							 <!-- boardVo_member_no써도 상관없음   -->
							<div class="col-1"><a href="./deleteContentProcess.do?noticeboard_no=${content.boardVo.noticeboard_no }">삭제</a></div> <!-- 얘는 걍 삭제만 되면 됨 -->
							<div class="col-1"><a href="./updateHE_NoticePage.do?noticeboard_no=${content.boardVo.noticeboard_no }">수정</a></div><!--  얘는 뭔가 페이지가 있어야됨 -->
						</c:if>
					
						</div>
					<hr>
					
					
					<c:if test="${!empty sessionUser}">
						<form action="writeCommentProcess.do">
							
							 
							<div class="mb-3">
								<div class="row">
									<div class="col-10">
										<input type="hidden" name="noticeboard_no" value="${content.boardVo.noticeboard_no }">
										<input type="text" class="form-control" name= "comment_content" value="" placeholder="댓글을 입력하세요." required>
									</div>
									<div class="col">
										<button class="btn" style="width:100%;background-color:#004ba0;border-color:#004ba0;color:#ffffff">입력</button>
									</div>
								</div>
								
							
							</div>
							
							
						</form>
					</c:if>
					
					<hr>
					
					
					<h6>댓글 수 : ${commentCount }</h6>
					<hr>
					
						<div class="row mt-1">
						<c:forEach items="${comment }" var="comment">
							
								<div class="row mb-1">
									<div class="col-3"> ${comment.memberVo.nick }</div>
									<div class="col"></div>
									<div class="col-3" style="text-align:right;">작성일  : <fmt:formatDate value="${comment.commentVo.writeDate }" pattern="MM.dd" /> </div>
								</div>
							
							
								<div class="row">
									<c:choose>
										<c:when test="${comment.memberVo.gender == 'M' }">
											<div class="col-1"><i class="bi bi-person-fill"></i></div>
										</c:when>
										<c:otherwise>
											<div class="col-1"><i class="bi bi-person"></i></div>
										</c:otherwise>
									</c:choose>
									<div class="col"> ${comment.commentVo.comment_content }</div>
								</div>
								
							
							<!-- 지우기 수정표시, 내꺼가 아니면 띄어쓰기 넣어줘서 공간감 같게 만들어 줌.. -->	
							<c:choose>
								<c:when test="${!empty sessionUser && sessionUser.member_no == comment.commentVo.member_no }">
									<div class="row mb-1 mt-1" style="text-align:right;">
										<div class="col-8"></div>
										<div class="col-2"></div>
										<div class="col-1">
											<form action="deleteCommentProcess.do" method="get">
											<button class="btn btn-primary"><i class="bi bi-trash"></i></button>
											<input type="hidden" name="comment_no" value="${comment.commentVo.comment_no }">
											<input type="hidden" name="noticeboard_no" value="${content.boardVo.noticeboard_no }">
											</form>
										</div>
										<div class="col-1">	
											<form action="updateHE_NoticeBoardCommentPage.do" method="get">
											<button class="btn btn-primary"><i class="bi bi-pen"></i></button>
											<input type="hidden" name="comment_no" value="${comment.commentVo.comment_no }">
											<input type="hidden" name="noticeboard_no" value="${content.boardVo.noticeboard_no }">
											</form>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="row mb-1 mt-1">
										<div class="col"></div>
										<div class="col-8">&nbsp</div>
										<div class="col"></div>
									</div>	
								</c:otherwise>
							</c:choose>
							
							
							
							
							<hr>
						</c:forEach>
						</div>
					</div>	
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