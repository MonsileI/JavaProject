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

<script>

var finddogboard_no =  ${content.boardVo.finddogboard_no};

function checkSession(){
	
	
	var xmlhttp = new XMLHttpRequest();
	
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			var data = JSON.parse(xmlhttp.responseText);
			
			if(data.isLogin == true){
				member_no=data.member_no;
				
			}
			
		}
	};
	
	xmlhttp.open("get" , "../member/getSessionInfo.do" , false);   //마지막 false는 동기식 호출
	xmlhttp.send();

	
}


function init(){
	checkSession();
	
}


</script>

</head>
<!-- NAVBAR
===================== -->
<body onload="init()">

	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	<!-- side menu -->
	<jsp:include page="../include/side.jsp"></jsp:include>

	
	<div style="width:1100px; margin: 100px auto;">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				<div class="row mt-5"><!-- 배너 -->
					<div class="col">
					</div>
				</div>
				<div>
				</div>
				
				
				<form action="./HE_SitterBoard_ProcessList.do" method="get">
				
					<div class="row mt-2"><!--  검색 -->
						<div class="col">
							<select name="search_type" class="form-select">
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="nick">닉네임</option>
							</select>
						</div>
						
						<div class="col-8">
							<input name="search_word" type="text">
							 <input type="submit" value="검색" class="btn btn-primary">
						</div>
					
						<div class="row text">
						
							<c:forEach items="${contentList }" var="data">
							
							
			  					<div class="col-sm-6 col-md-4">
					                 글 번호 : ${data.boardVo.sitterboard_process_no }<br>
			    				
						      		<div class="caption">
							        	<p><a href="./readHE_SitterPage.do?sitterboard_no= ${data.boardVo.sitterboard_no }">${data.boardVo.title }</a></p>
					
							       		<h6 style="color: gray; ">작성자 : ${data.memberVo.nick }</h6>
							       		<h6 style="color: gray; ">작성일 : <fmt:formatDate value="${data.boardVo.writeDate }" pattern="MM.dd" /></h6>
							        	<h6 style="color: gray; ">조회수: ${data.boardVo.readcount }</h6>
				
						    		</div>
					  			</div>
				
							</c:forEach>
						</div>
		
			
					</div>
			
				</form>
	
				
				<div class="row mt-2"><!-- 페이징 및 글쓰기 버튼 -->
					<div class="col-2"></div>
					<div class="col">
						<nav>
  						<ul class="pagination">
    							<c:choose>
  									<c:when test="${beginPage <= 1 }">
										    <li class="disabled">
										      <span>
										        <span aria-hidden="true">&laquo;</span>
										      </span>
										    </li>
  									</c:when>
  									<c:otherwise>
  										<li class="page-item"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${beginPage-1 }${addParam}">&laquo;</a></li> <!-- 비긴 페이지 ex)6에서 1빼줘야지 -->
  									</c:otherwise>
  								</c:choose>
    							
    							<c:forEach begin="${beginPage }" end="${endPage }" var = "i"> <!-- begin end 반복문임!!!! 여기서 반복 설정 -->
    									<c:choose>
    										<c:when test="${currentPage == i }">
    											<li class="page-item active"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${i }${addParam}">${i }</a></li> <!-- 현재 클릭한 페이지 -->	
    										</c:when>
    										<c:otherwise>
    											<li class="page-item"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${i }${addParam}">${i }</a></li>
    										</c:otherwise>
    									</c:choose>
    									
    							</c:forEach>
 								<c:choose>
  									<c:when test="${endPage >= totalPageCount }">
										    <li class="disabled">
										      <span>
										        <span aria-hidden="true">&raquo;</span>
										      </span>
										    </li>
  									</c:when>
  									<c:otherwise>
  										<li class="page-item"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${endPage+1 }${addParam}">&raquo;</a></li>
  									</c:otherwise>
  								</c:choose>
  							</ul>
						</nav>
					</div>
						<div class="col-2 d-grid">
						<c:if test="${!empty sessionUser }">
						<a class = "btn btn-primary"  href="./writeHE_SitterPage.do">시터 등록</a> <!-- d-grid : 공간 꽉꽉 채우는거(보통 버튼 만들땐 이거 쓰자) -->
						</c:if>
					</div>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>
	

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