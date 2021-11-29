<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
<!--============= custom css & js =============-->
<!-- custom css -->
<link rel="stylesheet" type="text/css" href="../resources/css/noteBox.css">


</head>

<body>

	<!-- recvNoteView modal menu -->	
	<jsp:include page="../modal/recvNoteView_Modal.jsp"></jsp:include>
	<!-- sencNoteView modal menu -->	
	<jsp:include page="../modal/sentNoteView_Modal.jsp"></jsp:include>
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
			<div class="col" style="text-align:left;margin-rignt:10px;margin-top:55px;">
			
					<!-- div class="container"-->
					
						<!-- 상부 contents s- title 영역 start-->
						<!--div class="row">
						
						
							<div class="col">
								<i class="bi-person-circle" role="img" aria-label="" style="font-size: 8rem; color:#090721;float:left;"></i>
							</div>
							<div class="col-9">
								<h2 style="margin-top:50px;font-size:2rem;color:#090721;float:left;">${sessionUser.name} page</h2>
							 </div>
							<div class="col">
				        		<a href="../main/logoutProcess.do">
				        			<input type="button" value="로그아웃" 
				        				style="margin-top:50px;font-size:15px;color:#090721;
				        						background-color:rgb(0,0,0,0);border:0px;float:right;">
				        		</a>
				        	</div>
							
					    </div-->
					    <!-- 상부 contents s- title 영역 end -->
					    
					    
					    
					    <!--하부 contents 영역 start-->
				    	<div class="container" style="margin-bottom:200px;">
				    	
				        	<div class="py-3" style="text-align:center;font-size:15px;background-color:#090721;color:#FFFFFF;margin-bottom:30px;">&nbsp;회원 정보</div>
				        	
				        	
				        	
				        	<div class="col" >
				        		<a href="editMyInfo.do">
				        			<input type="button" value="기본정보 수정 >" style="margin-right:20px;font-size:13px;font-weight:bold;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;float:right;">
				        		</a>
				        	</div>
				        	
				        	<div class="mb-3" style="margin-left:20px;font-size:13px;">
				             	<label> 회원명 : ${sessionUser.name}</label>
				            </div>
				            
				        	<div class="mb-3" style="margin-left:20px;font-size:13px;">
				            	<label> 아이디 : ${sessionUser.id}</label>
				            </div>
				            
				            <div class="mb-3" style="margin-left:20px;font-size:13px;">
				            	<label>닉네임 : ${sessionUser.nick}</label>
				            </div>
				            
				            <div class="mb-3" style="margin-left:20px;font-size:13px;">
				            	<label>비밀번호 : ******* </label>
				            </div>
				            
				            <div class="mb-3" style="margin-left:20px;font-size:13px;">
				            	<label>생일 : <fmt:formatDate value="${sessionUser.birth}" pattern="yyyy-MM-dd" /></label>
							</div>
							
							<div class="mb-3" style="margin-left:20px;font-size:13px;">
								<label>성별 : ${sessionUser.gender}</label>
							</div>
							
							<div class="mb-3" style="margin-left:20px;font-size:13px;">
								<label>애완견 : ${sessionUser.petName}</label>
							</div>
							
							
				        	<hr style="margin-top:30px;margin-bottom:30px;width:100%; height:1px;background-color:#090721;">
				        	
				        	<div class="mb">
				        		<a href="editMyContactInfo.do">
				        			<input type="button" value="연락처 수정 >" style="margin-right:20px;font-size:13px;font-weight:bold;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;float:right;">
				        		</a>
				        	</div>
				        	
				        	
				        	<div class="mb-3" style="margin-left:20px;font-size:13px;">
				        		<label>휴대폰 : ${sessionUser.phone}</label>
				        	</div>
				        	
				        	<div class="mb-3" style="margin-left:20px;font-size:13px;">
				        		<label>이메일 : ${sessionUser.email}</label>
				        	</div>
				        	
							<div class="mb-3" style="margin-left:20px;font-size:13px;">
				        		<label>주소 : ${sessionUser.address} (${sessionUser.postCode})</label>
				        	</div>
				                
				             
			    	 	<!--div class="py-3" style="margin-top:30px;margin-bottom:30px;text-align:center;font-size:15px;background-color:#090721;color:#FFFFFF;">&nbsp;시터 정보</div>
 						<hr style="width:100%; height:1px;background-color:#090721;">

						<div class="py-3" style="margin-top:30px;margin-bottom:30px;text-align:center;font-size:15px;background-color:#090721;color:#FFFFFF;">&nbsp;유기견 정보</div-->
						<hr style="width:100%; height:1px;background-color:#090721;">
				    	
				    	
				    	</div>
				    	<!-- 하부 contents 영역 end-->
				    
				    
				    <!-- /div-->
				    

			
			
	
			</div>
			<!--contents 영역 end-->
			
		</div>
		<!--  class="row justify-content-center" end -->
		

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
