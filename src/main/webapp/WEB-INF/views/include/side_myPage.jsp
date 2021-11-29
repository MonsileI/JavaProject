<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.panel-title{
	margin-top:10px;
	margin-bottom:10px;
}
.list-group-item{
	background-color:#ffffff;
}

</style>

				<!-- 사이드 바 메뉴-->
				<!-- 마이페이지 좌측 사이드 메뉴 -->
				<div class="col-2" style="text-align:center;margin-left:10px;margin-rignt:10px;margin-top:50px;">

					<div class="card" style="padding:20px;background-color:#ffffff;height:700px;">
						
						<!-- user picture+nick+logout start-->
						<div class="row">
							<div class="col">
				        		<a href="../main/logoutProcess.do" style="padding:0px;font-size:13px;text-decoration-line:none;color:#909090;float:right;">
				        			로그아웃
				        		</a>
				        	</div>
			        	</div>
						
						<div class="row">
						  	<div class="col">
									<i class="bi-person-circle" role="img" aria-label="" style="font-size:7rem; color:#090721;margin-bottom:0px;"></i>
							</div>
						</div>
							
						<div class="row">
							<div class="col">
								<h2 style="font-size:15px;color:#909090;">${sessionUser.name} 님</h2>
							</div>
						</div>
			        	<!-- user picture+nick+logout end-->
						
								
						
				
					
						<div class="panel panel-info" style="text-align:left;margin-bottom:20px;">
						    <div class="panel-heading">
						     
						     	<h3 class="panel-title" style="font-size: 17px; color:#090721;">
						     		<i class="bi bi-bell" style="font-size: 15px;margin-right:5px;"></i>임시보호알림
						      	</h3>
						    </div>
						    <!-- 사이드바 메뉴목록1 -->
						    <ul class="list-group">
						    	<li class="list-group-item" style="background-color:#E2F4FF;">
						      		<a href="../sitterboard_process/sitterRequestListPage.do" 
						      			style="color:#333333;text-decoration:none;">나의 요청</a></li>
						    	<li class="list-group-item" style="background-color:#E2F4FF;"><a href="../sitterboard_process/sitterAcceptListPage.do" 
						      		style="color:#333333;text-decoration:none;">나의 수락</a></li>
						    </ul>
						</div>
						
						<!-- 패널 타이틀2 -->
						<div class="panel panel-default" style="text-align:left;margin-bottom:20px;">
							<div class="panel-heading">
						    	<h3 class="panel-title" style="font-size: 17px; color:#090721;">
						    		<i class="bi bi-journals" style="font-size: 15px;margin-right:5px;"></i>나의 유기견
						    	</h3>
						 	</div>
							<!-- 사이드바 메뉴목록2 -->
							<ul class="list-group">
						  		<li class="list-group-item" style="background-color:#E2F4FF;">
						  			<a href="../member/myDogHistoryPage.do" style="color:#333333;text-decoration:none;">히스토리</a>
						  		</li>
							</ul>
						</div>      
						
						<!-- 패널 타이틀3 -->
						<div class="panel panel-info" style="text-align:left;margin-bottom:20px;">
							<div class="panel-heading">
						    	<h3 class="panel-title" style="font-size: 17px; color:#090721;">
						    		<i class="bi bi-info-circle" style="font-size: 15px;margin-right:5px;"></i>내정보관리
						    	</h3>
						  	</div>
						  	<!-- 사이드바 메뉴목록3 -->
						  	<ul class="list-group">
						  		<li class="list-group-item" style="background-color:#E2F4FF;">
						  			<a href="../mypage/editMyInfo.do"
						  				style="color:#333333;text-decoration:none;">기본정보수정</a>
						  		</li>
						  		<li class="list-group-item" style="background-color:#E2F4FF;">
						  			<a href="../mypage/editMyContactInfo.do"
						  				style="color:#333333;text-decoration:none;">연락처정보수정</a>
						  		</li>
						  		<!--li class="list-group-item" style="background-color:#E2F4FF;">
						  			<a href="#" style="color:#333333;text-decoration:none;">탈퇴하기</a>
						  		</li-->
						  	</ul>
					   </div>
					   
					   </div>
				   
				</div>