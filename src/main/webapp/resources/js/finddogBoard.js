
//==============견종 select
function selectSpecies(pet){
	pet_no = $("#species_selectList").find(":selected").val();
	//console.log(pet_no);
	$("#species_no").attr("value", pet_no);
	console.log($('#species_no').val());
}

/* 
============================취소버튼 기능 없애기로!!!==========================================
//==============권한 있는 자가 취소 버튼 누른 경우 
function cancelFinddog(btn){
	console.log(btn.value);
	
	 $("#FinddogStatusBtn").attr("value","취소완료상태");
	 $("#FinddogCancelBtn").attr("disabled", true);
	 document.querySelector("#FinddogCancelBtn").style.display = 'none';
	 
	 
	//AJAX API 사용....
	var xmlhttp = new XMLHttpRequest();
				
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
							
		}
	};
				
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../finddogboard/cancelFinddog.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("finddogboard_no=" + finddogboard_no);

}
*/