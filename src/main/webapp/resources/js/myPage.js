
//=============아이디 체크하여 버튼 비활성화, 중복확인.
	    function checkId() {
	        var inputed = $('#edit_id').val();
	        $.ajax({
	            data : {
	                id : inputed
	            },
	            url : "../member/checkId.do",
	            success : function(data) {
	                if(inputed=="" && data=='0') {
	                    $("#statusBtn_id").prop("disabled", true);
	                    $("#edit_id").css("background-color", "#FFCECE");
	                  
	                } else if (data == '0') {
	                    $("#edit_id").css("background-color", "#B0F6AC");
	          
	                    console.log("btnTextChange");
	                    $("#statusBtn_id").prop("disabled", false);
	   
	                       
	                } else if (data == '1') {
	                    $("#statusBtn_id").prop("disabled", true);
	                    $("#edit_id").css("background-color", "#FFCECE");
	        
	                } 
	            }
	        });
	    }
	    
//=============닉네임 체크하여 버튼 비활성화, 중복확인.
	    function checkNick() {
	        var inputed = $('#edit_nick').val();
	        $.ajax({
	            data : {
	                nick : inputed
	            },
	            url : "../member/checkNick.do",
	            success : function(data) {
	                if(inputed=="" && data=='0') {
	                    $("#statusBtn_nick").prop("disabled", true);
	                    $("#edit_nick").css("background-color", "#FFCECE");
	                  
	                } else if (data == '0') {
	                    $("#edit_nick").css("background-color", "#B0F6AC");
	                    $("#statusBtn_nick").prop("disabled", false);
	   
	                       
	                } else if (data == '1') {
	                    $("#statusBtn_nick").prop("disabled", true);
	                    $("#edit_nick").css("background-color", "#FFCECE");
	        
	                } 
	            }
	        });
	    }


//=============비밀번호 체크하여 버튼 비활성화
	    function checkBeforePw() {
	        var inputed = $('#before_pw').val();
	        $.ajax({
	            data : {
	                pw : inputed
	            },
	            url : "../mypage/checkBeforePw.do",
	            success : function(data) {
	                if(inputed=="" && data=='1') {
	                    $("#statusBtn_pw").prop("disabled", true);
	                    $("#edit_pw").prop("disabled", true);
	                    $("#confirm_pw").prop("disabled", true);
	                    
	                    $("#edit_pw").css("background-color", "#FFCECE");
	                    $("#confirm_pw").css("background-color", "#FFCECE");
	                  
	                } else if (data == '1') {
	                 	$("#statusBtn_pw").prop("disabled", false);
	                    $("#edit_pw").prop("disabled", false);
	                    $("#confirm_pw").prop("disabled", false);
	                 	
	                    $("#edit_pw").css("background-color", "#B0F6AC");
	                    $("#confirm_pw").css("background-color", "#B0F6AC");
	          
	                   // console.log("btnTextChange");
	                   
	                       
	                } else if (data == '0') {
	                    $("#statusBtn_pw").prop("disabled", true);
	                    $("#edit_pw").prop("disabled", true);
	                    $("#confirm_pw").prop("disabled", true);
	                    
	                    $("#edit_pw").css("background-color", "#FFCECE");
	                    $("#confirm_pw").css("background-color", "#FFCECE");
	        
	                } 
	            }
	        });
	    }

//=================재입력 비밀번호 체크하여 가입버튼 비활성화 또는 맞지않음을 알림.
function checkPw() {

	var inputed = $('#edit_pw').val();
	var reinputed = $('#confirm_pw').val();
	
	if(reinputed=="" && (inputed != reinputed || inputed == reinputed)){
		$("#statusBtn_pw").prop("disabled", true);
		$("#statusBtn_pw").css("background-color", "#aaaaaa");
		$("#confirm_pw").css("background-color", "#FFCECE");
	}
	else if (inputed == reinputed) {
		$("#statusBtn_pw").prop("disabled", false);
		$("#statusBtn_pw").css("background-color", "#4CAF50");
		$("#confirm_pw").css("background-color", "#B0F6AC");
		
	} else if (inputed != reinputed) {
		$("#statusBtn_pw").prop("disabled", true);
		$("#statusBtn_pw").css("background-color", "#aaaaaa");
		$("#confirm_pw").css("background-color", "#FFCECE");
	            
	}
}


//=================name
function displayBtn_name(btn){
	console.log(btn.value);
	
	var editBtn_name = document.querySelector('#editBtn_name');
	var editLabel_name = document.querySelector('#editLabel_name');
		
	 if(btn.value == "수정"){
	 
	 	editLabel_name.style.display = 'flex';
	 	editBtn_name.style.display = 'flex';
	 	
	 	$("#statusBtn_name").attr("value","취소");
	 	
		//$("#editBtn_name").prop("disabled", false);
		
	 }else{
	 
	 	editLabel_name.style.display = 'none';
	 	editBtn_name.style.display = 'none';
	 	$("#statusBtn_name").attr("value","수정");
	 	
	 	$("#editBtn_name").attr("value","");
	 }

}

//=================id
function displayBtn_id(btn){
	
	var edit_id = document.querySelector('#edit_id');
	var id = edit_id.value;
	
	console.log("btnText:",btn.value);
	console.log("id:",id);

	 if(btn.value == "수정"){
	 
	 	$("#edit_id").prop("disabled", false);
	 
	 	$("#statusBtn_id").attr("value"," 제출");
	 	$("#statusBtn_id").prop("disabled", true);
	 	$("#edit_id").css("background-color", "#BDBDBD");
	 
		
	 }else{
	 	
	 	//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
				
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
			}
		};
				
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "../mypage/editMyId.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("id=" + id);
	 
	 
	 	$("#statusBtn_id").attr("value","수정");
	 	$("#edit_id").css("background-color", "#FFFFFF");
	 	//$("#edit_id").prop("disabled", true);
	 	
	 	
	 }

}

//=================nick
function displayBtn_nick(btn){
	
	var edit_nick = document.querySelector('#edit_nick');
	var nick = edit_nick.value;
	
	console.log("btnText:",btn.value);
	console.log("nick:",nick);

	 if(btn.value == "수정"){
	 
	 	$("#edit_nick").prop("disabled", false);
	 
	 	$("#statusBtn_nick").attr("value"," 제출");
	 	$("#statusBtn_nick").prop("disabled", true);
	 	$("#edit_nick").css("background-color", "#BDBDBD");
	 
		
	 }else{
	 	
	 	//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
				
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
			}
		};
				
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "../mypage/editMyNick.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("nick=" + nick);
	 
	 
	 	$("#statusBtn_nick").attr("value","수정");
	 	$("#edit_nick").css("background-color", "#FFFFFF");
	 	
	 	
	 }

}

//=================birth
function displayBtn_birth(btn){
	
	var editBtn_birth = document.querySelector('#editBtn_birth');
	var editLabel_birth = document.querySelector('#editLabel_birth');
	
	var birth = editBtn_birth.value;
	
	console.log("btnText:",btn.value);
	console.log("birth:",birth);

	 if(btn.value == "수정"){
	 
	 	editBtn_birth.style.display = 'flex';
	 	editLabel_birth.style.display = 'none';
	 	
	 	$("#editBtn_birth").attr("disabled", false);
	 
	 	$("#statusBtn_birth").attr("value"," 제출");

	 	$("#editBtn_birth").css("background-color", "#BDBDBD");
	 
		
	 }else{
	 	
	 	//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
				
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
			}
		};
				
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "../mypage/editMyBirth.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("birth=" + birth);
		
		
	 	editBtn_birth.style.display = 'none';
	 	editLabel_birth.style.display = 'flex';
	 	
	 	$("#editBtn_birth").attr("disabled", true);
	 
	 	$("#statusBtn_birth").attr("value","수정");
	 	$("#editBtn_birth").css("background-color", "#FFFFFF");
	 	
	 	$("#editLabel_birth").attr("value", birth);
	 	
	 	
	 }

}

//=================petName
function displayBtn_petName(btn){
	
	var edit_petName = document.querySelector('#edit_petName');
	var petName = edit_petName.value;
	
	console.log("btnText:",btn.value);
	console.log("petName:",petName);

	 if(btn.value == "수정"){
	 
	 	$("#edit_petName").attr("disabled", false);
	 
	 	$("#statusBtn_petName").attr("value"," 제출");
	 	
	 	$("#edit_petName").css("background-color", "#BDBDBD");
	 
		
	 }else{
	 	
	 	//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
				
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
			}
		};
				
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "../mypage/editMyPetName.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("petName=" + petName);
	 
	 
	 	$("#statusBtn_petName").attr("value","수정");
	 	$("#editBtn_birth").attr("disabled", true);
	 	$("#edit_petName").css("background-color", "#FFFFFF");
	 	
	 	$("#editLabel_petName").attr("value", petName);
	 	
	 	
	 }

}


//=================pw
function displayBtn_pw(btn){
	
	var edit_pw = document.getElementById('edit_pw');
	
	var pw = edit_pw.value;
	
	//AJAX API 사용....
	var xmlhttp = new XMLHttpRequest();
				
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			//location.href = "../mypage/editMyInfo.do";
			//history.go(0);
			location.reload(true);
			
		/*
			$("#edit_pw").css("background-color", "#FFFFFF");
			$("#confirm_pw").css("background-color", "#FFFFFF");
			$("#statusBtn_pw").css("background-color", "#090721");
			
			$("#before_pw").attr("value", "");
			$("#edit_pw").attr("value", "");
			$("#confirm_pw").attr("value", "");
			
			$("#edit_pw").attr("disabled", true);
			$("#confirm_pw").attr("disabled", true);
			$("#statusBtn_pw").attr("disabled", true);
			
			*/				
		}
	};
				
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../mypage/editMyPw.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("pw=" + pw);
		
	
}

//=================email
//====
function displayBtn_email(btn){
	
	var before_email = document.querySelector('#before_email');
	var edit_email = document.querySelector('#edit_email');
	var editLabel_email = document.querySelector('#editLabel_email');
	var editBtn_email = document.querySelector('#editBtn_email');
	//var statusBtn_email = document.querySelector('#statusBtn_email');
	
	
	
	var before_email = before_email.value;
	var email = edit_email.value;
	
	
	console.log("btnText:",btn.value);
	console.log("before_email:",before_email);
	console.log("email:",email);

	 if(btn.value == "수정"){
	 
	 	editLabel_email.style.display = 'flex';
	 	edit_email.style.display = 'flex';
	 	editBtn_email.style.display = 'flex';
	 	
	 	$("#statusBtn_email").attr("value"," 취소");
	 	
	 	$("#edit_email").css("background-color", "#BDBDBD");
		
	 }else{
	 	
	 	editLabel_email.style.display = 'none';
	 	edit_email.style.display = 'none';
	 	editBtn_email.style.display = 'none';
	 	
	 	$("#statusBtn_email").attr("value","수정");
	 	
	 	$("#edit_email").css("background-color", "#FFFFFF");
	 	$("#edit_email").attr("value","");
	 	

	 	
	 }

}
//====
function edit_email(){

	var before_email = document.querySelector('#before_email');
	var edit_email = document.querySelector('#edit_email');
	var editLabel_email = document.querySelector('#editLabel_email');
	
	var before_email = before_email.value;
	var email = edit_email.value;


	//AJAX API 사용....
	var xmlhttp = new XMLHttpRequest();
				
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
			}
	};
				
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../mypage/editMyEmail.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("email=" + email);
	 	
	editLabel_email.style.display = 'none';
	edit_email.style.display = 'none';
	editBtn_email.style.display = 'none';
	 	
	$("#statusBtn_email").attr("value","수정");
	 	
	$("#edit_email").css("background-color", "#FFFFFF");
	 	
	$("#before_email").attr("value", email);
	$("#edit_email").attr("value","");
}


//===============================address
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

//=================addres
function displayBtn_address(btn){
	
	var input_before_address = document.querySelector('#before_address');
	var statusBtn_address = document.querySelector('#statusBtn_address');
	
	var input_postcode = document.querySelector('#postCode');
	var btn_postcode= document.querySelector('#postcode_button');
	var input_road_address = document.querySelector('#road_address');
	var input_address = document.querySelector('#address');
	
	
	var before_address = input_before_address.value;

	var address = input_address.value;
	var postCode = input_postcode.value;
	console.log("btnText:",btn.value);
	console.log("berfore_address:",before_address);
	

	 if(btn.value == "수정"){
	 
	 	input_postcode.style.display = 'flex';
		btn_postcode.style.display = 'flex';
		input_road_address.style.display = 'flex';
		input_address.style.display = 'flex';
		//before_address.style.display = 'none';
	 	
	 	$("#address").attr("value", before_address);
	 	
	 
	 	$("#statusBtn_address").attr("value"," 제출");

	 	$("#postCode").css("background-color", "#BDBDBD");
	 	$("#postcode_button").css("background-color", "#BDBDBD");
	 	$("#road_address").css("background-color", "#BDBDBD");
	 	$("#address").css("background-color", "#BDBDBD");
	 
		
	 }else{
	 	
	 	//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
				
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
			
				input_postcode.style.display = 'none';
				btn_postcode.style.display = 'none';
				input_road_address.style.display = 'none';
				input_address.style.display = 'none';
				//before_address.style.display = 'flex';
			 	
			 	$("#statusBtn_address").attr("value","수정");
			 	
			 	$("#postCode").css("background-color", "#EAEAEA");
			 	$("#postcode_button").css("background-color", "#FFFFFF");
			 	$("#road_address").css("background-color", "#FFFFFF");
			 	$("#address").css("background-color", "#FFFFFF");
			 	
			 	$("#before_address").attr("value", address+"("+postCode+")");
			 	
			 	$("#address").attr("value", "");	
			 	$("#postCode").attr("value", "");
			 }
							
			}
		};
				
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "../mypage/editMyAddress.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("address=" + address + "&postCode=" + postCode);
		
		


}













