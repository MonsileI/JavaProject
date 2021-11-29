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

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!--============= custom css & js =============-->
<!-- rbt_css -->
<link rel="stylesheet" type="text/css" href="../resources/css/board_list_main.css">
<!-- custom css -->
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="../resources/css/noteBox.css">
<!-- custom js -->
<script src="../resources/js/myPage.js"></script>

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
			<div class="col" style="text-align:left;margin-rignt:10px;margin-top:55px;height:750px;">
			
					    
					    
					    <!--하부 contents 영역 start-->
				    	<div class="container">
				    	
	
				    		<div class="row">
					        	<div class="py-3" style="background-color:#090721;color:#FFFFFF;">기본 정보</div>
					        	<hr style="width:100%; height:1px;background-color:#090721;">
				        	</div>
				        	
				        	
				        	<!--============회원명 수정==============-->
				        	<div class="row-mb-3">
					        	<div class="col">
					            	<input id="statusBtn_name" type="button" value="수정" 
					            			onclick="displayBtn_name(this)"
					            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					
					            </div>
					        	<div class="col">
					            	<label> 회원명 : </label>
					            	<input id="edit_name" type="text" value="${sessionUser.name}" 
					            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;" disabled>     	
					            	
					            </div>
					            

							</div>
				            
				            
							<div class="row-mb-3">
								<div class="col">
									<label id="editLabel_name" 
											style="width:100%;font-size:11px;color:#090721;float:center;
													margin-bottom:10px;display:none;"> 
					            			개명하신 경우 본인인증을 하시면 자동으로 이름이 변경됩니다.
					            	</label>
								</div>
							
					            <div class="col">
					            	<a href=".do" style="text-decoration:none;"><!-- 휴대폰 인증 api 찾아보기 -->
					            		<!--input type="hidden" name="name"-->
					            		<input type="button" id="editBtn_name" class="btn btn-primary btn-large"
					            				value="본인명의 휴대폰으로 인증" 
					            				style="width:100%;padding:10px;float:center;
					            						margin-bottom:10px;display:none;background-color:#090721;color:#FFFFFF;border:0px;">
					        		</a>
					            </div>
				            </div>
				            <!--===================================-->
				        	
				        	
				        	
				        	
				        	<!--============아이디 수정==============-->
				        	<div class="row-mb-3">
							    <div class="col">
					            	<input id="statusBtn_id" type="button" value="수정" 
					            			onclick="displayBtn_id(this)"
					            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					            </div>
					        	
					        	<div class="col">
					            	<label> 아이디 : </label>
					            	<input name="id" id="edit_id" type="text" value="${sessionUser.id}" 
					            			oninput="checkId()"
					            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;" disabled>
					            </div>
							</div>
				            <!--===================================-->
				          
				          
				          
				            
				            <!--============닉네임 수정==============-->
				        	<div class="row-mb-3">
							    <div class="col">
					            		<input id="statusBtn_nick" type="button" value="수정" 
					            				onclick="displayBtn_nick(this)"
					            				style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            						margin-bottom:10px;float:right;">
					            </div>
					        	
					        	<div class="col">
					            	<label> 닉네임 : </label>
					            	<input name="nick" id="edit_nick" type="text" value="${sessionUser.nick}" 
					            			oninput="checkNick()"
					            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;" disabled>
					            </div>
							</div>
   							<!--===================================-->
				            
				            
				            
				            <!--============생일 수정==============-->
				        	<div class="row-mb-3">
							    <div class="col">
					            		<input id="statusBtn_birth" type="button" value="수정" 
					            				onclick="displayBtn_birth(this)"
					            				style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            						margin-bottom:10px;float:right;">
					        
					            </div>
					        	
					        	<div class="col">
					        	
					        		<label>생년월일 :</label>
					        		
					            	<label id="editLabel_birth">
					            		<fmt:formatDate value="${sessionUser.birth}" pattern="yyyy-MM-dd"/>
					            	</label>
					            	
					            	<input name="birth" id="editBtn_birth" type="date" value="${sessionUser.birth}"
					            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;display:none" disabled>
					            </div>
							</div>
							<!--===================================-->
							
							<!--============애완견 정보 수정==============-->
				        	<div class="row-mb-3">
					            <div class="col" style="color:rgb(0,0,0,0);">
					            .
					            </div>
							    <div class="col">
					            		<input id="statusBtn_petName" type="button" value="수정" 
					            				onclick="displayBtn_petName(this)"
					            				style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            				margin-bottom:10px;float:right;">
					            </div>
					            
					            <div class="col">
					            
						            <label> 애완견 정보 : </label>
						            
						            <input name="petName" id="edit_petName" type="text" value="${sessionUser.petName}"
						            			style="color:#090721;background-color:rgb(0,0,0,0);border:0px;
						            					margin-bottom:10px;" disabled>
						       	</div>
					        	
					            
							</div>
				            <!--===================================-->
				            
				            
				            
				            
				            <!--============비밀번호 수정==============-->
				            <div class="row-mb-3">
					        	<hr style="width:100%; height:1px;background-color:#090721;">
					        	<div class="py-3 text-left" style="background-color:#090721;color:#FFFFFF;">&nbsp;비밀번호 변경</div>
					            <hr style="width:100%; height:1px;background-color:#090721;">
					            
					            
					            <div class="col">
					            	<input id="before_pw" type="password" class="form-control"
					            			placeholder="현재 비밀번호를 입력하세요." value="" oninput="checkBeforePw()" 
					            			style="width:100%;margin-bottom:10px;" required>
					           	</div>
					           	
					           	<div class="col">
					           		<input  name="pw" id="edit_pw" type="password" class="form-control"
					           				placeholder="새 비밀번호를 입력하세요." value="" oninput="checkPw()" 
					           				style="width:100%;margin-bottom:10px;" required disabled>
					            </div>
					            <div class="col">
					           		<input 	id="confirm_pw" type="password" class="form-control"
					           				placeholder="새 비밀번호를 한번 더 확인해주세요." value="" oninput="checkPw()" 
					           				style="width:100%;margin-bottom:10px;" required disabled>
					            </div>
					            
					            <div class="col">
					            
					            	<input id="statusBtn_pw" class="btn btn-primary btn-large" type="button" 
					            				value="비밀번호 변경"
					            				onclick="displayBtn_pw(this)"
					            				style="width:100%;padding:10px;float:center;background-color:#090721;color:#FFFFFF;border:0px;" disabled>
					            				
					            </div>
				           		 
				            </div>
				            <!--===================================-->
				            
							 <hr style="width:100%; height:1px;background-color:#090721;">
				    	
				    	
				    	
					    	
				    	</div>
				    	<!-- 하부 contents 영역 end-->
				    
				    
				    <!-- /div-->
				    

			
			
	
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
