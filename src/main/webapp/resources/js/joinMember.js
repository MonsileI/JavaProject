//custom

	    var idCheck = 0;
	    var pwCheck = 0;
	    //아이디 체크하여 가입버튼 비활성화, 중복확인.
	    function checkId() {

	    	var inputed = document.getElementById('id').value;

	    	var xmlhttp = new XMLHttpRequest();

	    	//서버에서 응답 후 처리 로직.
	    	xmlhttp.onreadystatechange = function(){

	    		if(xmlhttp.readyState==4 && xmlhttp.status==200){

	    			var data = JSON.parse(xmlhttp.responseText);

	    			 if(inputed=="" && data=='0') {
		                   	document.getElementById("signupBtn").disabled = true;
		                    document.getElementById("signupBtn").style.backgroundColor = "#aaaaaa";
		                    document.getElementById("id").style.backgroundColor = "#FFCECE";
		                    idCheck = 0;
		                } else if (data == '0') {
		                	document.getElementById("id").style.backgroundColor = "#B0F6AC";
		                    idCheck = 1;
		                    if(idCheck==1 && pwCheck == 1) {
		                    	document.getElementById("signupBtn").disabled = false;
		                    	document.getElementById("signupBtn").style.backgroundColor = "#4CAF50";
		                        //document.getElementById("id").removeClass("is-invalid");
		                        //signupCheck();
		                    }
		                } else if (data == '1') {
		                    // is-invalid 클래스를 붙여줘서 빨간 경고문구 붙여준다
		                    //document.getElementById("id").addClass("is-invalid");
		                    //document.getElementById("id").focus();
		                    //document.getElementById("id").attr('placeholder', inputed+' 는 존재하는 Id입니다.');

		                    	document.getElementById("signupBtn").disabled = true;
		                    document.getElementById("signupBtn").style.backgroundColor = "#aaaaaa";
		                    document.getElementById("id").style.backgroundColor = "#FFCECE";
		                    idCheck = 0;
		                }
	    		}
	    	}

	    	//post 방식으로 파라미터 보내는법...
	    	xmlhttp.open("post" , "../member/checkId.do");
	    	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	    	xmlhttp.send("id=" + inputed);

	    }

	  //재입력 비밀번호 체크하여 가입버튼 비활성화 또는 맞지않음을 알림.
	    function checkPw() {

	        var inputed = document.getElementById('pw').value;

	        var reinputed = document.getElementById('pwConfirm').value;

	        if(reinputed=="" && (inputed != reinputed || inputed == reinputed)){
	        	document.getElementById("signupBtn").disabled = true;
	        	document.getElementById("signupBtn").style.backgroundColor = "#aaaaaa";
	        	document.getElementById("pwConfirm").style.backgroundColor = "#FFCECE";
	        }
	        else if (inputed == reinputed) {
	        	document.getElementById("pwConfirm").style.backgroundColor = "#B0F6AC";
	            pwdCheck = 1;
	            if(idCheck==1 && pwdCheck == 1) {
	            	document.getElementById("signupBtn").disabled = false;
	            	document.getElementById("signupBtn").style.backgroundColor = "#4CAF50";
	                //signupCheck();
	            }
	        } else if (inputed != reinputed) {
	            pwdCheck = 0;
	        	document.getElementById("signupBtn").disabled = true;
	            document.getElementById("signupBtn").style.backgroundColor = "#aaaaaa";
	            document.getElementById("pwConfirm").style.backgroundColor = "#FFCECE";

	        }
	    }


			//================= 유효성 검사

			//phone & email은 html 입력폼에서 체크
			//아이디 중복 검사: 서버측에서 판단(db 때문에)
			function submitForm(){

				var memberForm = document.getElementById("memberForm");

				//pw
				var pwText = document.getElementById("pw");
				if(pwText.value == ""){
					alert("비밀번호를 입력해주세요~!");
					pwText.focus();
					document.getElementById("signupBtn").disabled = true;
					return;
				}
				//address
				var addrText = document.getElementById('postcode');
				if (addrText=="") {
					  alert("주소를 입력해주세요");
					  document.getElementById('postcode_button').focus();
					  document.getElementById("signupBtn").disabled = true;
					  return false;
					}
				//pwConfirm
				var pwConfirmText = document.getElementById("pwConfirm");
				if(pwText.value != pwConfirmText.value){
					alert("비밀번호 확인을 다시 해주세요~!");
					pwText.value = "";
					pwConfirmText.value = "";
					pwText.focus();
					document.getElementById("signupBtn").disabled = true;
					return;
				}
				//petName
				var petExist = document.getElementById("pet").checked;
				var petNameText = document.getElementById("petName");
				if(petExist == true && petNameText.value == ""){
					alert("애완견 이름을 다시 해주세요~!");
					petNameText .value = "";
					petNameText .focus();
					document.getElementById("signupBtn").disabled = true;
					return;
				}
				else{
					document.getElementById("signupBtn").disabled = false;
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
