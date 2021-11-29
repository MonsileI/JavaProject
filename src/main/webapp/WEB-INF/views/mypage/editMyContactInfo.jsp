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
<!-- rbt_css -->
<link rel="stylesheet" type="text/css" href="../resources/css/board_list_main.css">
<!-- custom css -->
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="../resources/css/noteBox.css">

<!-- daum 주소 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 

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
			
					<!-- div class="container"-->
					    
					    <!--하부 contents 영역 start-->
				    	<div class="container">
				    	
				    		<div class="row">
					        	<div class="py-3 text-left" style="text-align:center;font-size:15px;background-color:#090721;color:#FFFFFF;">연락처 정보</div>
					        	<hr style="width:100%; height:1px;background-color:#090721;">
				        	</div>

				        
				        	
				        	<!--===========이메일 수정==============-->
				        	<div class="row-mb-3" style="margin-top:30px;margin-bottom:20px;">
				        	

				        	
							    <div class="col">
					            	<input id="statusBtn_email" type="button" value="수정" 
					            			onclick="displayBtn_email(this)"
					            			style="margin-right:20px;font-size:13px;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					
					            </div>
					            
					           <div class="col">
					            	<input id="cancle_statusBtn_email" type="button" value="취소" 
					            			onclick="displayBtn_email(this)"
					            			style="margin-right:20px;font-size:13px;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					
					            </div>
					        	
					        	<div class="col" style="margin-left:20px;font-size:13px;">
					            	<label> 이메일 : </label>
					            	<input id="before_email" type="text" value="${sessionUser.email}" 
					            			style="width:200px;color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;" disabled>     	
					            	
					            </div>
							</div>
				            
				            
							<div class="row-mb-3">
								<div class="col">
									<label id="editLabel_email" 
											style="margin-left:20px;width:100%;font-size:11px;color:#090721;float:center;
													margin-bottom:10px;display:none;"> 
					            			이메일 변경을 위해서 인증이 필요합니다.
					            	</label>
								</div>
								
								<div class="col">
									<input name="email" id="edit_email" type="text" value="" placeholder="변경할 이메일을 입력하세요."
						            			style="margin-left:20px;color:#FFFFFF;background-color:#aaaaaa;border:0px;
						            					margin-bottom:10px;display:none;">
								</div>
								
							
					            <div class="col">
					            		<!--input type="hidden" name="name"-->
					            		<input id="editBtn_email" class="btn btn-primary" type="button" 
					            				value="인증메일 전송"
					            				onclick="edit_email()"
					            				style="margin-left:20px;width:100%;padding:10px;float:center;
					            						margin-bottom:10px;display:none;background-color:#090721;color:#FFFFFF;border:0px;">
					            </div>
				            </div>
				            <!--===================================-->
				            
				            
				            				        	
				        	<!--============주소 수정==============-->
				        	<div class="row-mb-3">
							    <div class="col">
					            		<input id="statusBtn_address" type="button" value="수정" 
					            				onclick="displayBtn_address(this)"
					            				style="margin-right:20px;font-size:13px;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;
					            						margin-bottom:10px;float:right;">
					        
					            </div>
					            
					            <div class="col">
					            	<input id="cancle_statusBtn_address" type="button" value="취소" 
					            			onclick="displayBtn_address(this)"
					            			style="margin-right:20px;font-size:13px;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					
					            </div>
					            
					        	<div class="col" >
					            	<input type="text" id="before_address" value="주소 : ${sessionUser.address} (${sessionUser.postCode})" 
						            		style="width:800px;margin-left:20px;font-size:13px;color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;display:flex" readonly disabled>
					            					
						            <input type="hidden" name="postCode" id="postCode" placeholder="우편번호"   
						            		style="color:#FFFFFF;background-color:#aaaaaa;border:0px;
					            					margin-bottom:10px;display:none" readonly disabled> 
						            <input type="button" class="btn btn-primary" id="postcode_button" onclick="open_Postcode()" value="우편번호 찾기"
						            		style="color:#FFFFFF;background-color:#090721;border:0px;
					            					margin-bottom:10px;display:none" ><br> 
						            <input type="text" id="road_address" placeholder="도로 주소" 
						            		style="color:#FFFFFF;background-color:#aaaaaa;border:0px;
					            					margin-bottom:10px;display:none" readonly>
						            <input type="text" name="address" id="address" placeholder="지번 주소" 
						            		style="color:#FFFFFF;background-color:#aaaaaa;border:0px;
					            					margin-bottom:10px;display:none"readonly><br> 

					            </div>
							</div>
							<!--===================================-->
							
				        	
				        	
				        	<!--===========휴대폰 수정==============-->
				        	<!-- 인증번호 전송 api 알아보기 -->
				        	<!-- https://firebase.google.com/docs/auth/web/phone-auth?hl=ko#before-you-begin
				        	https://beam307.github.io/2017/12/08/sendSMS/ -->
				        	<div class="row-mb-3" >
							    <div class="col">
					            	<input id="statusBtn_phone" type="button" value="수정" 
					            			onclick="displayBtn_phone(this)"
					            			style="margin-right:20px;font-size:13px;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					            </div>
					            
					            
					           	<div class="col">
					            	<input id="cancle_statusBtn_phone" type="button" value="취소" 
					            			onclick="displayBtn_phone(this)"
					            			style="margin-right:20px;font-size:13px;color:#004ba0;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;float:right;">
					
					            </div>
					        	
					        	<div class="col">
					            	<input name="phone" id="edit_phone" type="text" value="휴대전화 : ${sessionUser.phone}"
					            			style="width:200px;margin-left:20px;font-size:13px;color:#090721;background-color:rgb(0,0,0,0);border:0px;
					            					margin-bottom:10px;" disabled>
					            </div>
							</div>
				            <!--===================================-->
				            
							 <hr style="margin-top:30px;width:100%; height:1px;background-color:#090721;">
				    	
				    	
				    	
					    	
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
