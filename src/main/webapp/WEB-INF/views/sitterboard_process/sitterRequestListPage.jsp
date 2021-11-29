<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- for문 if문 등등 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- date 타입을 예쁘게 바꿔주기위해 사용하는 tag library -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">

</head>

<body>

	<!--===================================-->
	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	
	<div style="width:1200px; margin: 100px auto;background-color:#FFF5EA;">

	<div class="row">
		<div class="col"></div>
		<div class="col-12">
	
	
	<!-- inner contents -->
	<!-- sideBar 영역 목차 & 링크 -->
	<div class="container">
	
	
		<div class="row justify-content-center">
			
			<!--left side menu 영역 start-->
			<jsp:include page="../include/side_myPage.jsp"></jsp:include>

			<!--left side menu 영역 end-->
			
			
			<!--contents 영역 start-->
			<div class="col" style="text-align:left;margin:30px;margin-top:100px;height:750px;overflow:auto;">
			
								<!--  검색 -->
					<div class="row mt-5" >
						<div class="col-2" id="search_select" style="margin-bottom:30px;">
							<select name="search_type" style="height:23px;width:100%;">
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="nick">닉네임</option>
								</select>
								
							</div>
								
							<div class="col-8" id="search_input">
								<input type="text" name="search_word" style="width:100%;">
							</div>
					
							<div class="col-2" id="search_btn">
								<Button class="btn" style="background-color:#090721;color:#FFFFFF;border:0px;width:100%;">search</Button>
						</div>
					</div>
			
					    
				<!--하부 contents 영역 start-->
				<div class="container">
				 
					<div class="row" >
					
					 	<div class="py-3 text-left" style="text-align:center;font-size:20px;background-color:#090721;color:#FFFFFF;">임시보호자 요청한 내역</div>
						 	<hr style="width:100%; height:1px;background-color:#090721;">
					    </div>
						      
						<c:set var="finddog_size" value="${fn:length(sitterRequestList)+1}" />
						<c:forEach items="${sitterRequestList}" var="map" varStatus="finddog_numbering">
								
							<div class="col py-5" style="background-color:rgb(0,0,0,0);">
							
							
								<c:set var="sitter_size" value="${fn:length(map)+1}" />
								<c:forEach items="${map}" var="finddogVo" varStatus="sitter_numbering">
								
									<div class="col-md-10 offset-md-1 py-2" style="background-color:#090721;color:#FFFFFF;">
									
									<div style="margin:10px 10px 10px 10px;font-size:20px;">
										<a href="../finddogboard/readHE_FinddogPage.do?finddogboard_no= ${finddogVo.key.finddogboard_no}" 
											style="color:#FFFFFF;">
											NO.${finddog_size-finddog_numbering.count}.
											주인찾기 게시물 보러가기
											<!--${finddogVo.key.finddogboard_no}-->
										</a>
									</div>
									<div style="margin:10px 10px 10px 10px;font-size:17px;">
									내용 :
									${finddogVo.key.content} 
									</div>
									<div style="margin:0px 10px 10px 10px;font-size:17px;">
									작성일 :  <fmt:formatDate value="${finddogVo.key.writeDate}" pattern="yy년 MM월 dd일"/>
									</div>
											
								</div>
									
									<div class="col-md-10 offset-md-1 py-1" style="text-align:center;font-size:17px;background-color:#FFFFFF;color:#090721;">수락 내역</div>

										<div class="col-md-10 offset-md-1 py-2" style="background-color:#FFFFFF;color:#090721;">
										<hr>
										<div style="margin:10px 10px 10px 10px;font-size:13px;">
										<!-- NO.${sitter_size-sitter_numbering.count}.-->
										<!--sitterBoard_process 글 번호 :
										${finddogVo.value.sitterboard_process_no}-->
										</div>
										<div style="margin:10px 10px 10px 10px;font-size:13px;">
										<!--finddogBoard 메시지 번호 : 
										${finddogVo.value.finddogboard_no}-->
										</div>
										<div style="margin:10px 10px 10px 10px;font-size:13px;">
										요청한 날짜 : <fmt:formatDate value="${finddogVo.value.writeDate}" pattern="yy년 MM월 dd일"/>
										</div>
										<div style="margin:10px 10px 10px 10px;font-size:13px;">
										메시지 : 
										${finddogVo.value.message}
										</div>
											
										<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
					
										<!-- 추후 자동으로 수락시, status 상태 바꾸기 쿼리 넣기-->
										<!-- ing -> Y / N -->
										<c:choose>
										
											<c:when test="${finddogVo.value.status eq 'Y'}">
												<input type="button" class = "btn btn-primary" id="sitterProcessStatusBtn" value="신청수락완료" 
													style="margin:10px 10px 10px 10px;background-color:#090721;color:#FFFFFF;border:0px;" disabled>
											</c:when>
											
											<c:when test="${finddogVo.value.status eq 'ING'}">
									
												<form action="cancelSitterRequest.do" method="post">
													<input type="hidden" name="sitterboard_process_no" value="${finddogVo.value.sitterboard_process_no}">
													<input type="submit" class = "btn btn-primary" id="sitterProcessStatusBtn" value="수락대기중(취소)"
														style="margin:10px 10px 10px 10px;background-color:#090721;color:#FFFFFF;border:0px;">
												</form>
											</c:when>
											
											<c:otherwise>
												<input type="button" class = "btn btn-primary" id="sitterProcessStatusBtn" value="수락거절완료" 
													style="margin:10px 10px 10px 10px;background-color:#090721;color:#FFFFFF;border:0px;" disabled>
											</c:otherwise>
										
										</c:choose>
										<br>
						 				 <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
									</div>		
									</c:forEach>
									</div>
									
								</c:forEach>
							</div>
			

					


					<div class="row mt-2"><!-- 페이징 및 글쓰기 버튼 -->
						<div class="col-2">
						</div>
						<div class="col">
							<nav>
		  						<ul class="pagination">
		  						
		    						<c:choose>
		  								<c:when test="${beginPage <= 1 }">
											<li class="disabled">
										    	<span>
										    		<a class="page-link" aria-hidden="true"
										    			style="background-color:#090721;color:#FFFFFF;border:0px;">&laquo;</a>
												</span>
											</li>
		  								</c:when>
		  								<c:otherwise>
		  									<li class="page-item">
		  										<a class="page-link" href="./sitterRequestListPage.do?page_number=${beginPage-1 }${addParam}"
		  											style="background-color:#090721;color:#FFFFFF;border:0px;">&laquo;
		  										</a>
		  									</li>
		  								</c:otherwise>
		  							</c:choose>
		    							
		    						<c:forEach begin="${beginPage }" end="${endPage }" var = "i"> <!-- begin end 반복문임!!!! 여기서 반복 설정 -->
		    							<c:choose>
		    								<c:when test="${currentPage == i }">
		    									<li class="page-item active">
		    										<a class="page-link" href="./sitterRequestListPage.do?page_number=${i }${addParam}"
		    											style="background-color:#090721;color:#FFFFFF;border:0px;">${i }
		    										</a>
		    									</li> <!-- 현재 클릭한 페이지 -->	
		    								</c:when>
		    								<c:otherwise>
		    									<li class="page-item">
		    										<a class="page-link" href="./sitterRequestListPage.do?page_number=${i }${addParam}"
		    											style="background-color:#090721;color:#FFFFFF;border:0px;">${i }
		    										</a>
		    									</li>
		    								</c:otherwise>
		    							</c:choose>
		    						</c:forEach>
		    						
		 							<c:choose>
		  								<c:when test="${endPage >= totalPageCount }">
											<li class="disabled">
												<span>
													<a class="page-link" aria-hidden="true"
														style="background-color:#090721;color:#FFFFFF;border:0px;">&raquo;</a>
												</span>
											</li>
		  								</c:when>
		  								<c:otherwise>
		  									<li class="page-item">
		  										<a class="page-link" href="./sitterRequestListPage.do?page_number=${endPage+1 }${addParam}"
		  											style="background-color:#090721;color:#FFFFFF;border:0px;">&raquo;
		  										</a>
		  									</li>
		  								</c:otherwise>
		  							</c:choose>
		  							
		  							
	  							</ul>
							</nav>
						</div>
					</div>
					
					
				<!-- 하부 contents 영역 end-->
			
			</div>
			<!--contents 영역 end-->
			
		</div>
		<!--  class="row justify-content-center" end -->

	</div>
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