//===================================species selectlist===================================
function selectSpecies(pet){
	pet_no = $("#species_selectList").find(":selected").val();
	console.log(pet_no);
	$("#species_no").attr("value", pet_no);
	console.log($('#species_no').val());
}
/*
//==================================취소 버튼 기능 없애기로!!!=================================================
//==============권한 있는 자가 취소 버튼 누른 경우 
function cancelLostdog(btn){
	 $("#lostdogStatusBtn").attr("value","취소완료상태");
	 $("#lostdogStatusBtn").attr("disabled", true);
	 document.querySelector("#lostdogCancelBtn").style.display = 'none';
	
	//AJAX API 사용....
	var xmlhttp = new XMLHttpRequest();
				
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
		
	
		}
	};
				
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../lostdogboard/cancelLostdog.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("lostdogboard_no=" + lostdogboard_no);

}
*/


//==============권한 있는 자가 완료 버튼 누른 경우(본인 개 찾은 경우, 누를 수 있도록)
function completeLostdog(btn){

	 document.getElementById("lostdogStatusBtn").value = "완료상태";
	 document.getElementById("lostdogStatusBtn").disabled = true; 
	 document.getElementById("lostdogCompleteBtn").style.display = 'none';
	
	//AJAX API 사용....
	var xmlhttp = new XMLHttpRequest();
				
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
		}
	};
				
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../lostdogboard/completeLostdog.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("lostdogboard_no=" + lostdogboard_no);

}

