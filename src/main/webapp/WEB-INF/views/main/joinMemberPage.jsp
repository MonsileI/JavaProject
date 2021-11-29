<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">

<!-- custom css -->
<!--link href="form-validation.css" rel="stylesheet"-->
<style>
.container {
  max-width: 960px;
}

</style>

<!-- daum 주소 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
	<!-- custom js -->
	<script src="../resources/js/joinMember.js"></script> 
		
</head>
 <body>
 
 	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	
		<div style="width:1200px; margin: 100px auto;background-color:#FFF5EA;">
	
		<div class="row">
			<div class="col"></div>
			<div class="col-10">
	
	
	

	  <main>
	    <div class="py-5 text-center">
	      <h2 >회원 가입</h2>
	      <p class="lead" style="color:#909090;">회원가입하세요. 가입하면 모든 게시판을 열람할 수 있습니다.</p>
	    </div>
	
	    <div class="row g-5">
	     
	      <div class="col-md-8 offset-md-2 col-lg-8">
	      
	      
	      
	      
	        <h4 class="mb-3">기본 정보</h4>
	        
	        <form class="needs-validation" action="./joinMemberProcess.do" method="POST" novalidate>
	        
	          <div class="row g-3">
	            <div class="col-12">
	            	<label for="id" class="form-label"> 아이디 </label>
	           		<input type="text" class="form-control" name="id" id="id" maxlength="12" size="15" 
	           				pattern="[a-zA-Z0-9]{4,12}" title="4~12자의 영문 대소문자와 숫자로만 입력." oninput="checkId()" required> 
	           				<!--patter으로 아이디 유효성 검사 minlength와 maxlength로 글자 수 제한-->
	              	<div class="invalid-feedback">
	                	Valid first name is required.
	              	</div>
	            </div>
	
	
	            <div class="col-sm-6">
	            	<label for="pw" class="form-label">비밀번호</label> 
	            	<input type="password" class="form-control" name="pw" id="pw" 
	            			placeholder="" value="" oninput="checkPw()" required>
	              	<div class="invalid-feedback">
	                	Valid last name is required.
	              	</div>
	            </div>
	            
	           	<div class="col-sm-6">
	            	<label for="pwConfirm" class="form-label">비밀번호 확인</label> 
					<input type="password" class="form-control" name="pwConfirm" id="pwConfirm" 
							placeholder="" value="" oninput="checkPw()" required> 
					<div class="invalid-feedback">
	                	Valid last name is required.
	              	</div>
	            </div>
	            
	            
	           <div class="col-12">
	           		<label for="name"  class="form-label">이름</label> 
	           		<input type="text" class="form-control" name="name" id="name" 
	           				placeholder="" value="" required>           	
	           		<div class="invalid-feedback">
	               	 	Please enter your shipping address.
	              	</div>
	            </div>
	            
	            
	            <div class="col-12">
	            	<label for="nick" class="form-label">닉네임</label> 
	            	<input type="text" class="form-control" name="nick" id="nick" 
	            			placeholder="" value="" oninput="checkId()" required>
	             	<div class="invalid-feedback">
	               	 	Please enter your shipping address.
	              	</div>
	            </div>
	            
	            
	           	<div class="col-12">
	           		<label for="birth" class="form-label">생일</label> 
	            	<input type="date" class="form-control" name="birth" id="birth" 
	            			placeholder="" value="" required>
	             	<div class="invalid-feedback">
	               	 	Please enter your shipping address.
	              	</div>
	            </div>
	            
	
	           	<div class="col-12">
					<label class="form-label">성별</label> 
						<input type="radio" name="gender" id="" value="M" checked>남
						<input type="radio" name="gender" id="" value="F">여
	             	<div class="invalid-feedback">
	               	 	Please enter your shipping address.
	              	</div>
	            </div>
	            
	            <hr class="my-4">
	            
	            
	            
	            
	            
	            
	            
	            <h4 class="mb-3">연락처 정보</h4>
	
		        <div class="col-12">
		        	<label for="phone" class="form-label">휴대폰</label>
		        	<input type="text" class="form-control" name="phone" value="" 
	                		size="20" pattern="(010)-\d{3,4}-\d{4}" title="형식 010-0000-0000" required>  
	                		<!--patter으로 휴대폰 유효성 검사 -->
	                <div class="invalid-feedback">
	                	Please enter a valid email address for shipping updates.
	             	</div>
	            </div>            
	            
	            
	
	            <div class="col-12">
	              <label for="email" class="form-label">Email <span class="text-muted">(Optional)</span></label>
	              <input type="email" class="form-control" name="email" value="" placeholder="you@example.com"
	                		size="20" pattern="[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}" 
	                		oninput="checkId()" required>  
	                		<!--patter으로 메일 유효성 검사 -->
	               <div class="invalid-feedback">
	               	 Please enter a valid email address for shipping updates.
	               </div>
	            </div>
	
	            <div class="col-12">
	 			  <label for="address" class="form-label">Address</label><br>
			      <input type="text" name="postCode" id="postCode" placeholder="우편번호" style="margin-bottom:10px;" readonly > 
			      <input type="button"  id="postcode_button" onclick="open_Postcode()" value="우편번호 찾기" style="margin-bottom:10px;background-color:#004ba0;color:#ffffff;"><br> 
			      <input type="text"  id="road_address" placeholder="도로 주소" readonly>
			      <input type="text" name="address" id="address" placeholder="지번 주소" readonly><br> 
				  <div class="invalid-feedback">
	              	Please enter your shipping address.
	              </div>
	            </div>
	
	            <div class="col-12">
	           		<label for="address" class="form-label">애완견 유무 : &nbsp; </label> 
					<input type="radio" name="pet" id="pet" value="Y" onclick="checkedPet()" style="margin-right:5px;">YES
					<input type="radio" name="pet" id="pet" value="N" onclick="checkedPet()" style="margin-right:5px;">NO
					<div class="invalid-feedback">
	              		Please enter your shipping address.
	              	</div>
	            </div>
	
				<div class="col-12">
	            	<label for="petName" class="form-label">애완견 이름</label> 
					<input type="text" class="form-control" name="petName" id="petName" 
							placeholder="" disabled>
					<div class="invalid-feedback">
	              		Please enter your shipping address.
	              	</div>
	            </div>
	
	
	          <button class="w-100 btn" id="signupBtn" type="submit" 
	          		onclick="submitForm()" 
	          		style="background-color:#004ba0;color:#ffffff;"
	          		disabled>가입하기</button>
	          
	          <hr class="mb-4">
	          
	          <div class="row mb-4">
	          	<div class="col-10">
	          		<label><a href="./loginPage.do" style="text-decoration:none;color:#909090;">로그인</a></label>
	          	</div>
	          	<div class="col-2" style="text-align:right;">
	          		<label><a href="./main.do" style="float:right;padding-left:32px;text-decoration:none;color:#909090;">메인</a></label>
	          	</div>
	          </div>
	          
	          </div>
	          
	          </form>
	      </div>
	    </div>
	  </main>
	  
	  			</div>
			<div class="col"></div>
		</div>
	</div>

 		<!-- FOOTER -->
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
	
	<script>
		//bootstrap - Example starter JavaScript for disabling form submissions if there are invalid fields
		(function () {
		  'use strict'
		
		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  var forms = document.querySelectorAll('.needs-validation')
		
		  // Loop over them and prevent submission
		  Array.prototype.slice.call(forms)
		    .forEach(function (form) {
		      form.addEventListener('submit', function (event) {
		        if (!form.checkValidity()) {
		          event.preventDefault()
		          event.stopPropagation()
		        }
		
		        form.classList.add('was-validated')
		      }, false)
		    })
		})()	
	</script>
	
	
		<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
 	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
  </body>
</html>