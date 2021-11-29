<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- custom css -->

<!-- 합쳐지고 최소화된 최신 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>

<!-- daum 주소 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 

		<script>

		
			//================= 유효성 검사
			
			//id & email은 html 입력폼에서 체크 
			//아이디 중복 검사: 서버측에서 판단(db 때문에)
			function submitForm(){

				var memberForm = document.getElementById("memberForm");
				
				//pw 
				var pwText = document.getElementById("pw");
				if(pwText.value == ""){
					alert("비밀번호를 입력해주세요~!");
					pwText.focus();
					return;
				}
				//address
				var addrText = document.getElementById('postcode');
				if (addrText=="") { 
					  alert("주소를 입력해주세요"); 
					  document.getElementById('postcode_button').focus(); 
					  return false; 
					} 
				//pwConfirm
				var pwConfirmText = document.getElementById("pwConfirm");
				if(pwText.value != pwConfirmText.value){
					alert("비밀번호 확인을 다시 해주세요~!");
					pwText.value = "";
					pwConfirmText.value = "";
					pwText.focus();
					return;
				}
				//petName
				var petExist = document.getElementById("pet").checked;
				var petNameText = document.getElementById("petName");
				if(petExist == true && petNameText.value == ""){
					alert("애완견 이름을 다시 해주세요~!");
					petNameText .value = "";
					petNameText .focus();
					return;
				}
				
				memberForm.submit();
				
			}

			//================= petName - pet 유/무 확인 후, petName 입력칸 활성화
			function checkedPet(){
				var petExist = document.getElementById("pet").checked;
				if (petExist == true){
					document.getElementById("petName").disabled = false;
				}else{
					document.getElementById("petName").disabled = true;
				}

			}
			
			//================= address - 다음 카카오 주소찾기 
			function open_Postcode(){  
				  new daum.Postcode({ 
				    oncomplete: function(data) { 
				 
				       // 우편번호와 주소 정보를 해당 필드에 넣는다. 
				       document.getElementById('postCode').value = data.zonecode; 
				       document.getElementById("road_address").value = data.roadAddress; 
				       document.getElementById("address").value = data.jibunAddress; 
				 
				  } 
				}).open(); 
				} 
		</script>
		
</head>
<body>
    <div class="container">
        <div class="py-5 text-center">
            <h2>회원가입</h2>
            <p class="lead">회원가입하세요. 가입하면 모든 게시판을 열람할 수 있습니다.</p>
        </div>
        
        
 		<form name="memberForm" action="./joinMemberProcess.do" method="POST">

        <div class="col-md-12 order-md-1">

                <div class="mb-3">
                    <label for="id"> 아이디 </label>
               		 <input type="text" class="form-control" name="id" id="id" minlength="4" maxlength="12" size="15" pattern="[a-zA-Z0-9]{4,12}" title="4~12자의 영문 대소문자와 숫자로만 입력." required/> <!--patter으로 아이디 유효성 검사 minlength와 maxlength로 글자 수 제한--> 
                </div>
   
                
                <div class="mb-3">
                    <label for="pw">비밀번호</label> 
                    <input type="password" class="form-control" name="pw" id="pw" placeholder="" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="pwConfirm">비밀번호</label> 
                    <input type="password" class="form-control" name="pwConfirm" id="pwConfirm" placeholder="" value="" required>
                </div>

               <div class="mb-3">
                    <label for="firstName">닉네임</label> 
                    <input type="text" class="form-control" name="nick" id="nick" placeholder="" value="" required>

                </div>

                <div class="mb-3">
                    <label for="firstName">이름</label> 
                    <input type="text" class="form-control" name="name" id="name" placeholder="" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="birth">생일</label> 
                    <input type="date" class="form-control" name="birth" id="birth" placeholder="" value="" required>
				 </div>
				 
				 <div>
					<label for="firstName">성별</label> 
						<input type="radio" name="gender" id="" value="M" checked>남
						<input type="radio" name="gender" id="" value="F">여
				 </div>
				 
				 <div class="mb-3">
                    <label for="phone">휴대폰</label>
                	<input type="text" class="form-control" name="phone" value="" size="20" pattern="(010)-\d{3,4}-\d{4}" title="형식 010-0000-0000" required>  <!--patter으로 휴대폰 유효성 검사 --> 
                </div>
                
                <div class="mb-3">
                    <label for="email">이메일</label>
                	<input type="email" class="form-control" name="email" value="" size="20" pattern="[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}" required>  <!--patter으로 메일 유효성 검사 --> 
                </div>

                <div class="mb-3">
                    <label for="address">주소</label><br> 
		            <input type="text" name="postCode" id="postCode" placeholder="우편번호" readonly > 
		            <input type="button"  id="postcode_button" onclick="open_Postcode()" value="우편번호 찾기"><br> 
		            <input type="text"  id="road_address" placeholder="도로 주소" readonly>
		            <input type="text" name="address" id="address" placeholder="지번 주소" readonly><br> 
                </div>
                
                
                <div class="mb-3">
                    <label for="address">애완동물 유무</label> 
					<input type="radio" name="pet" id="pet" value="Y" onclick="checkedPet()">Y
					<input type="radio" name="pet" id="pet" value="N" onclick="checkedPet()">N
				</div>
				
                <div class="mb-3">
                    <label for="petName">애완견 이름</label> 
                    <input type="text" class="form-control" name="petName" id="petName" placeholder="" disabled>
                </div>
                
                <hr class="mb-4">
                <button class="btn btn-primary btn-lg btn-block" type="submit" onclick="submitForm()">가입하기</button>
                <hr class="mb-4"> 
                
		         <label><a href="./loginPage.do" >로그인</a></label>
		         <label><a href="./index.do" style="padding-left:1030px;">메인</a></label>

       	 </div>
         </form>
    </div>
	</body>
</html>