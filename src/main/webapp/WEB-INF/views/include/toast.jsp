<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<script>
var myToast = null;
var adminToast = null;

var toastCount = null;

var toastList = null;
var senderList = null;


//============= 시간 0 맞추기 
function addZero(num){
	if(num < 10){
		return "0" + num;
	} else {
		return num;
	}
}
//============= 남은 시간 
function calTime(num){
	var now = new Date();
	var current = now.getTime();
	console.log("current: ",current);
	console.log("num: ",num);
	console.log("now.getTime() - num:",now.getTime() - num);
	
	var remaindSec = ((now.getTime() - num ) / 1000);
	var remaindMin = remaindSec / 60;
	var remaindHour = remaindMin / 60;

	
	
	//화면에 
	var displaySec = addZero(Math.floor(remaindSec % 60));
	var displayMin= addZero(Math.floor(remaindMin % 60));
	var displayHour = addZero(Math.floor(remaindHour % 24));
	
	var sec = addZero(displaySec);
	var min = addZero(displayMin);
	var hour = addZero(displayHour);
	
	var text = hour +"시간 " + min + "분 " + sec +"초 전";
	
	console.log("text:",text);
	
	return text;
}


//=============1. Toast
function showToast(){

	
	var xmlhttp = new XMLHttpRequest();
	
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			
			var result = JSON.parse(xmlhttp.responseText);
			
			//toastCount = result.toastList.length;
			//console.log("size:",result.toastList.length);
			
			var toastListBox = document.getElementById("toastBody");
			
			//초기화
			toastListBox.innerHTML = "";
			
			for(var i=0; i < result.toastList.length; i++){
				
					
					var elapseTime = calTime(result.toastList[i].writeDate);
					//console.log(elapseTime);
					
					//console.log("all:",result.toastList[i]);
					
					//=========dom 그리기 
					//========================첫번째 박스===========================
					var line = document.createElement("hr");


					var firstRowBox = document.createElement("div");
					firstRowBox.setAttribute("class","row mb-1");

					var colNameBox = document.createElement("div");
					colNameBox.setAttribute("class","col-7");
					colNameBox.innerText = result.toastList[i].content;
					colNameBox.setAttribute("style","text-align:left;font-size:20px;");
					firstRowBox.appendChild(colNameBox);//조립하기

					var colBlankBox = document.createElement("div");
					colBlankBox.setAttribute("class","col");
					firstRowBox.appendChild(colBlankBox);//공백을 주기 위한 자식 블랭크 박스

					var writeDateBox = document.createElement("div");//writeDate~~~~~~:)
					writeDateBox.setAttribute("class","col-4");
					writeDateBox.setAttribute("style","text-align:right");
					writeDateBox.innerText = elapseTime;//result.toastList[i].writeDate;//
					firstRowBox.appendChild(writeDateBox);

					//========================두번째 박스===========================

					var secondRowBox = document.createElement("div");
					secondRowBox.setAttribute("class","row");

					var second_firstBox = document.createElement("div");
					second_firstBox.setAttribute("class","col-1");
					var personIcon = document.createElement("i");
					personIcon.setAttribute("class","bi bi-person-fill");
					personIcon.setAttribute("style","text-align:left;font-size:15px;");
					second_firstBox.appendChild(personIcon); //사람 표시 아이콘을 div class col-1에 넣기

					var second_secondBox = document.createElement("div");
					second_secondBox.setAttribute("class","col");
					second_secondBox.innerText = result.senderList[i].nick;
					second_secondBox.setAttribute("style","text-align:left;font-size:15px;");

					secondRowBox.appendChild(second_firstBox);
					secondRowBox.appendChild(second_secondBox);

					//========================세번째 박스===========================
					var userthirdRowBox = document.createElement("div");
					userthirdRowBox.setAttribute("class","row mb-1 mt-1");

					var userThird_firstBox = document.createElement("div");
					userThird_firstBox.setAttribute("class","col-10");

					//================확인 박스=========================
					var userThird_secondBox = document.createElement("div");
					userThird_secondBox.setAttribute("class","col-1");

					//================확인 버튼=========================
					var confirmButton = document.createElement("button");
					confirmButton.setAttribute("style","background-color:#ffffff;color:#FFFFFF;border:0px;");
					confirmButton.setAttribute("onclick","confirmToast("+result.toastList[i].notebox_no+")");
					var confirmIcon = document.createElement("i");
					confirmIcon.setAttribute("class","bi bi-check2-square");
					confirmIcon.setAttribute("style","font-size:20px;background-color:#ffffff;color:#5587ED;border:0px;");
					
					confirmButton.appendChild(confirmIcon);

					userThird_secondBox.appendChild(confirmButton);

					
					//userthirdRowBox.appendChild(userThird_firstBox);
					userthirdRowBox.appendChild(userThird_firstBox);
					userthirdRowBox.appendChild(userThird_secondBox);


					//========================여기다 전부 합치기===============
					//toastListBox.appendChild(container);
					toastListBox.appendChild(firstRowBox);
					toastListBox.appendChild(secondRowBox);
					toastListBox.appendChild(userthirdRowBox);
					toastListBox.appendChild(line);
					//toastListBox.scrollTop = toastListBox.scrollHeight; //가장 아래로 하는 속성 추가(스크롤)
		
				}
			
				myToast.show();
			}

	};
	
	xmlhttp.open("get" , "../member/getNewToast.do");   
	xmlhttp.send();

}

//=======2. admin toast
function showAdminToast(){
	
	var xmlhttp = new XMLHttpRequest();

	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			var result = JSON.parse(xmlhttp.responseText);
			
			console.log(result.length);
			
			if(result.adminVo != undefined){
				
				var elapseTime = calTime(result.adminVo.writeDate);
				//console.log(elapseTime);
				
				var toastListBox = document.getElementById("adminToastBody");
				
				//초기화
				toastListBox.innerHTML = "";
				
				//=========dom 그리기 
				
				//========================첫번째 박스===========================
				var firstRowBox = document.createElement("div");
				firstRowBox.setAttribute("class","row mb-1");

				var colNameBox = document.createElement("div");
				colNameBox.setAttribute("class","col-7");
				colNameBox.innerText = result.adminVo.content;
				colNameBox.setAttribute("style","text-align:leftt;font-size:17px;");
				firstRowBox.appendChild(colNameBox);//조립하기

				var colBlankBox = document.createElement("div");
				colBlankBox.setAttribute("class","col");
				firstRowBox.appendChild(colBlankBox);//공백을 주기 위한 자식 블랭크 박스

				var writeDateBox = document.createElement("div");//writeDate~~~~~~:)
				writeDateBox.setAttribute("class","col-4");
				writeDateBox.setAttribute("style","text-align:right;font-size:13px;");
				writeDateBox.innerText = elapseTime//result.adminVo.writeDate;
				firstRowBox.appendChild(writeDateBox);

				//========================두번째 박스===========================

				var secondRowBox = document.createElement("div");
				secondRowBox.setAttribute("class","row");

				var second_firstBox = document.createElement("div");
				second_firstBox.setAttribute("class","col-1");
				var personIcon = document.createElement("i");
				personIcon.setAttribute("class","bi bi-person-fill");
				personIcon.setAttribute("style","text-align:right;font-size:15px;");
				second_firstBox.appendChild(personIcon); //사람 표시 아이콘을 div class col-1에 넣기

				var second_secondBox = document.createElement("div");
				second_secondBox.setAttribute("class","col");
				second_secondBox.innerText = "admin";
				second_secondBox.setAttribute("style","font-size:15px;");

				secondRowBox.appendChild(second_firstBox);
				secondRowBox.appendChild(second_secondBox);

				//========================세번째 박스===========================
				var userthirdRowBox = document.createElement("div");
				userthirdRowBox.setAttribute("class","row mb-1 mt-1");

				var userThird_firstBox = document.createElement("div");
				userThird_firstBox.setAttribute("class","col-11");

				//================확인 박스=========================
				var userThird_secondBox = document.createElement("div");
				userThird_secondBox.setAttribute("class","col-1");

				//================확인 버튼=========================
				var confirmButton = document.createElement("button");
				confirmButton.setAttribute("style","background-color:rgb(0,0,0,0);border:0px;");
				confirmButton.setAttribute("onclick","confirmAdminToast("+result.adminVo.notebox_no+")");
				var confirmIcon = document.createElement("i");
				confirmIcon.setAttribute("class","bi bi-check2-square");
				confirmIcon.setAttribute("style","font-size:20px;background-color:#E2F4FF;color:#FF6666;");
				
				confirmButton.appendChild(confirmIcon);

				userThird_secondBox.appendChild(confirmButton);

				
				//userthirdRowBox.appendChild(userThird_firstBox);
				userthirdRowBox.appendChild(userThird_firstBox);
				userthirdRowBox.appendChild(userThird_secondBox);


				//========================여기다 전부 합치기===============
				toastListBox.appendChild(firstRowBox);
				toastListBox.appendChild(secondRowBox);
				toastListBox.appendChild(userthirdRowBox);

				adminToast.show();	
			}
			
		}
	};

	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("get" , "../member/checkAdminToast.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();
	
}

//=============Toast 확인 아이콘 클릭시 
function confirmToast(notebox_no){
	
	var xmlhttp = new XMLHttpRequest();

	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){

			toastCount -=1;
		}
	};

	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../member/confirmNote.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("notebox_no=" + notebox_no);

}
//=============admin Toast 확인 아이콘 클릭시 
function confirmAdminToast(notebox_no){
	
	var xmlhttp = new XMLHttpRequest();

	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){

			toastCount -=1;
			adminToast.hide();
			
		}
	};

	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../member/confirmNote.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("notebox_no=" + notebox_no);

}

//===============Toast 열기, 닫기 
function openCloseToast(){
	
	var toastBody = document.getElementById("toastBody");
	//var showBar = document.getElementById("showBar");
	var hideIcon = document.getElementById("hideIcon");
	
	if(toastBody.style.display == 'none'){
		myToast.hide();
		//showBar.style.display = 'flex';
		toastBody.style.display = '';
		hideIcon.setAttribute("class", "bi bi-chevron-double-down");
		
	}else{
		myToast.hide();
		//showBar.style.display = 'flex';
		toastBody.style.display = 'none';
		hideIcon.setAttribute("class", "bi bi-chevron-double-up");
	}
}


function toastInit(){

	myToast = new bootstrap.Toast(document.getElementById('myToast'));
	adminToast = new bootstrap.Toast(document.getElementById('adminToast'));

	
	setInterval(showToast, 2000);
	setInterval(showAdminToast, 2000);
	adminToast.hide();
	

	
} 

window.addEventListener('DOMContentLoaded', toastInit);

</script>

	<!---------------------------------------------------- Toast Start -------------------------------------------------->
	<!-- Toast start -->
	
	 <c:choose>
        <c:when test="${!empty sessionUser}"> 
        
		 	<div class="container">
			  	<div class="col">
					
			  		<div class="toast-container position-fixed bottom-0 end-0 p-0" id="toastPlacement"  
			  			style="z-index: 11;background-color:#5587ED;width:350px;">
			  			
						 <div class="toast" id="myToast" role="alert" aria-live="assertive"><!-- data-bs-delay="10000"-->
						 	
						  	<div class="toast-header py-2" id="showBar" style="background-color:#5587ED;color:#FFFFFF;">
						  
							    <div class="col-8" style="margin-left:10px;font-size:15px;">
								    <strong class="me-auto" >Message</strong>
								    <small>new</small>
									<span class="badge rounded-pill" id="badge_recv" style="background-color:#FFFFFF;color:#5587ED">
				    					<!--안읽은 메세지 기능추가 : js -->
										<script>setInterval(checkNewNote, 10000);</script>
				 					</span>
				 				</div>
			 					<div class="col" style="text-align:right;">
									<button type="button" onclick="openCloseToast()" 
											style="border-width:0px;background-color:#5587ED;color:#FFFFFF">
										<i class="bi bi-chevron-double-up" id="hideIcon" style="font-size:15px;"></i>
									</button>
							    </div>
							    <!--div class="col" style="text-align:right;margin-right:10px;">
								    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close">
								    	<i class="bi bi-x-square" style="font-size:13px;]background-color:rgb(0,0,0);color:#F7DAD9 ;"></i>
								    </button>
								</div-->
							
						  	</div>
						  
						  <div class="toast-body" id="toastBody" style="height:320px;width:350px;overflow-y: scroll;background-color:#FFFFFF;color:#5587ED;">
						
						  	
						   </div>
						  
						</div>	
					
					</div>
					
				</div>
			</div>
			<!-- Toast end -->
			
			<!-- admin Toast start -->
			<div class="container" >
			  	<div class="col">
			  	
			  		<div class="toast-container position-fixed start-50 translate-middle-x" id="adminToastPlacement"  
			  			style="z-index: 11;top:30%;">
			  			
						 <div class="toast" id="adminToast" role="alert" aria-live="assertive"
						 	style="width:600px;background-color:#E2F4FF;color:#FF6666;border-width:7px;border-color:#FF6666;"><!-- #AAFFA3-->
						 	
						  	<div class="toast-header py-2" style="background-color:#FF6666;color:#E2F4FF;font-size:13px;">
						  		<h3 style="width:600px;text-align:left;"><i class="bi bi-bell" style="margin-right:10px;font-size:17px;"></i>notice</h3>
						  	</div>
						  	<div class="toast-body" id="adminToastBody" 
						  		style="height:200px;overflow-y:scroll;"></div>
						  
						</div>	
					
					</div>
					
				</div>
			</div>
			<!-- admin Toast end -->
			
			
		</c:when>
	</c:choose>
	
	<!-------------------------------------------------- Toast End -------------------------------------------------->
	
	