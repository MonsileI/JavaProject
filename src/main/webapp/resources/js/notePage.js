//=====================================
//아이디 체크하여 활성화.

function checkFriendId(thisId, myId) {

	console.log(thisId.id + myId);
	
	if(thisId.id == "friendId"){
		var inputed = ""
		inputed = document.getElementById("friendId").value;
		
	}else if(thisId.id == "friendId_one"){
		var inputed = ""
		inputed = document.getElementById("friendId_one").value;
		//var friendList = document.getElementById("friend_selectList_one");
		
	}else if(thisId.id == "friendId_two"){
	
		var inputed = ""
		inputed = document.getElementById("friendId_two").value;
		//var friendList = document.getElementById("friend_selectList_two");
	
	}
	
	var xmlhttp = new XMLHttpRequest();
	
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			
			var data = JSON.parse(xmlhttp.responseText);
			
			console.log(data[0], data[1]);
				
				if(thisId.id == "friendId_one"){
					document.getElementById("friend_no_one").setAttribute("value", data[0]);
					document.getElementById("friend_id_one").setAttribute("value", inputed);
					
				}else if(thisId.id == "friendId_two"){
					document.getElementById("friend_no_two").setAttribute("value", data[0]);
					document.getElementById("friend_id_two").setAttribute("value", inputed);
				}
									
				if(inputed == myId){//자신 아이디인 경우
				
					//팝업쪽지함 - 친추 불가
					
					document.getElementById("addFriendBtn").disabled = true; 
    					
					document.getElementById("addFriendBtn").style.backgroundColor = "#aaaaaa";
		            
		            document.getElementById("friendId").style.backgroundColor = "#FFCECE";
		            
		            //쪽지 보내기 가능
		            document.getElementById("sendBtn_one").disabled = false;
					document.getElementById("sendBtn_one").style.backgroundColor = "#4CAF50";
		            
		            
					document.getElementById("sendBtn_two").disabled = false;
					document.getElementById("sendBtn_two").style.backgroundColor = "#4CAF50";
					
					document.getElementById("friendId_one").style.backgroundColor = "#B0F6AC";
		            document.getElementById("friendId_two").style.backgroundColor = "#B0F6AC";
		            
		            
		        	 if(thisId.id == "friendId_one"){
						document.getElementById("friend_no_one").setAttribute("value", "");
						document.getElementById("friend_id_one").setAttribute("value", "");
					}else{
						document.getElementById("friend_no_two").setAttribute("value", "");
						document.getElementById("friend_id_two").setAttribute("value", "");
					}
					
				}
				else if(inputed == "" || data[1] == 0) {//입력값 없거나 + 없는 회원일때
					
					//친추 불가
					document.getElementById("addFriendBtn").disabled = true; 
					
					//document.getElementById("addFriendBtn").style.backgroundColor = "#aaaaaa";
		            document.getElementById("friendId").style.backgroundColor = "#FFCECE";
		            
		            //쪽지 보내기 불가능
		            
					document.getElementById("sendBtn_one").disabled = true; 
					document.getElementById("sendBtn_one").style.backgroundColor = "#aaaaaa";
		            
					document.getElementById("sendBtn_two").disabled = true;
					document.getElementById("sendBtn_two").style.backgroundColor = "#aaaaaa";
					
					document.getElementById("friendId_one").style.backgroundColor = "#FFCECE";
		            document.getElementById("friendId_two").style.backgroundColor = "#FFCECE";
		           
		            
		        } else if (data[1] == 0) { //없는 회원일때
		        
		        	//친추 불가
					document.getElementById("addFriendBtn").disabled = true; 
	
					//document.getElementById("addFriendBtn").style.backgroundColor = "#aaaaaa";
		            document.getElementById("friendId").style.backgroundColor = "#FFCECE";
		            
		   			//쪽지 보내기 불가능 
					document.getElementById("sendBtn_one").disabled = true; 
					document.getElementById("sendBtn_one").style.backgroundColor = "#aaaaaa";
		   			
					document.getElementById("sendBtn_two").disabled = true;
					document.getElementById("sendBtn_two").style.backgroundColor = "#aaaaaa";
					
		            document.getElementById("friendId_one").style.backgroundColor = "#FFCECE";
		            document.getElementById("friendId_two").style.backgroundColor = "#FFCECE";
		           
		            
				} else if (data[1] == 1) { //있는 회원일때
				
				 	//친추 가능
					document.getElementById("addFriendBtn").disabled = false; 
					
    				document.getElementById("addFriendBtn").style.backgroundColor = "#4CAF50";
					document.getElementById("friendId").style.backgroundColor = "#B0F6AC";
					
					
					//쪽지 보내기 가능
					document.getElementById("sendBtn_one").disabled = false;
					document.getElementById("sendBtn_one").style.backgroundColor = "#4CAF50"; 
					
					document.getElementById("sendBtn_two").disabled = false; 
    				document.getElementById("sendBtn_two").style.backgroundColor = "#4CAF50";	
    				           
					document.getElementById("friendId_one").style.backgroundColor = "#B0F6AC";
		            document.getElementById("friendId_two").style.backgroundColor = "#B0F6AC";
					
					
				} else if (data[1] == 2) { //이미 내 친구일 때
				
					//친추 불가능
					document.getElementById("addFriendBtn").disabled = true; 
					
					document.getElementById("addFriendBtn").style.backgroundColor = "#aaaaaa";
					document.getElementById("friendId").style.backgroundColor = "#FFCECE";
					
					//쪽지 보내기 가능
					document.getElementById("sendBtn_one").disabled = false;
					document.getElementById("sendBtn_one").style.backgroundColor = "#4CAF50"; 
					
					document.getElementById("sendBtn_two").disabled = false; 
    				document.getElementById("sendBtn_two").style.backgroundColor = "#4CAF50";
				
					document.getElementById("friendId_one").style.backgroundColor = "#B0F6AC";
		            document.getElementById("friendId_two").style.backgroundColor = "#B0F6AC";
		           
				} 
			}
	
	};
																
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../member/checkFriendId.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("id=" + inputed);
	


}

//===================================friend selectlist===================================
function selectFriend(friend){
	
	var friend_no = friend.value;
	var data = [];
	
	if(friend.id == "friend_selectList_two"){
		//console.log("two");
		
		friend_nick = friend.value;
		data = friend_nick.split("++");
		
		document.getElementById("friend_no_two").setAttribute("value", data[0]);
		document.getElementById("friend_id_two").setAttribute("value", data[1]);	
		
	}else if(friend.id == "friend_selectList_one"){
		//console.log("one");
		
		friend_nick = friend.value;
		data = friend_nick.split("++");
		
		document.getElementById("friend_no_one").setAttribute("value", data[0]);
		document.getElementById("friend_id_one").setAttribute("value", data[1]);	
		
	}
	
	console.log("no:",document.getElementById('friend_no_one').value);
	console.log("id:",document.getElementById('friend_id_one').value);
}
//===================================modal_friend selectlist===================================
function friendModalSelectGroup(friendModal_group){
	
	console.log("friendModal_group");
	
	for(var i = 0; i < friendModal_group.length; i++){
		if(friendModal_group[i].selected){
			console.log("selected");
			var group_value = friendModal_group[i].value;
			document.getElementById("friendModal_after_grouplist_no").setAttribute("value", group_value);
			break;
		}
	}


	console.log(document.getElementById("friendModal_after_grouplist_no").value);
	
}	
//========================add group========================================================================
function addGroup(obj){

	if(obj.id == 'addGroupBtn_popup'){
		thisInput = document.getElementById('addGroupInput_popup');
		thisAddBtn = document.getElementById('addGroupBtn_popup');
		
		group_name = thisInput.value;
		member_no = document.getElementById('addMemberNo_popup').value;
		btnValue = thisAddBtn.value;
	}
	else{
		thisInput = document.getElementById('addGroupInput');
		thisAddBtn = document.getElementById('addGroupBtn');
	
	
		group_name =thisInput.value;
		member_no = document.getElementById('addMemberNo').value;
		btnValue = thisAddBtn.value;
	}

	//console.log(group_name, member_no, btnValue)
	
	
	if(btnValue == "그룹+"){
		thisInput.style.display = 'flex';
		thisAddBtn.value = "제출";
		//console.log("그룹 ");
		
	}else{
	
		if(thisInput.value != ""){
			
			var xmlhttp = new XMLHttpRequest();
		
			//서버에서 응답 후 처리 로직.
			xmlhttp.onreadystatechange = function(){
				
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
						
					console.log("success");
				  	location.href = "../main/main.do";
				}
			}
			
			//post 방식으로 파라미터 보내는법...
			xmlhttp.open("post" , "../member/addGroupProcess.do");
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("member_no=" + member_no + "&group_name=" +group_name);

		}
		else{
			alert("그룹이름을 입력하세요!")		
		}
		
		thisInput.style.display = 'none';
		
		thisAddBtn.value = "그룹+";
	}
	
}

//===================================count new note==============================================

function checkNewNote(){

	var xmlhttp = new XMLHttpRequest();
		
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
			var data = JSON.parse(xmlhttp.responseText);
			console.log("complete_check");
			document.getElementById("badge_recv").innerHTML = data;
		}
	}
	
	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../member/checkNewNote.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();

}

//===================================confirm readDate===================================
//=========================recv

function confirmNote(nick, notebox_no, content, writeDate, readDate){
        
	console.log(nick, notebox_no, content, writeDate, readDate);

	if(readDate == ""){

		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
		
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				var dt = new Date();
				
		      	document.getElementById("readDate_recv").setAttribute("value",dt.toString());
			}
		}
	
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "../member/confirmNote.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("notebox_no=" + notebox_no);
	
		
	}

}

//========================체크박스(전체선택)========================================================================
function checkAllNote(checkAll){

	var checkboxes = document.getElementsByName('notebox_no');
	
	//console.log("checkAllNote");

	if(checkAll.id == 'checkAllRecvNote'){
	
		checkboxes.forEach((checkbox) => {
	
			if(checkbox.id == 'notebox_no_recv'){
				checkbox.checked = checkAll.checked;
				console.log("recv");
			}
		
		})

	}else{
		checkboxes.forEach((checkbox) => {
	
			if(checkbox.id == 'notebox_no_sent'){
				checkbox.checked = checkAll.checked;
				console.log("sent");
			}
		
		})
	}
}
//========================체크박스(선택)===========================================================================
function checkNote(note){

	var checkArr = [];
	console.log("check!");
	// 전체 체크박스
  	var checkbox = document.getElementsByName('notebox_no');
  	console.log("checkNote_size:",checkbox.length);
  	// 선택된 체크박스
  	for(var i = 0; i<checkbox.length; i++){
  		console.log("checkNote_checked status:",checkbox[i]);
  		
  		if(checkbox[i].checked){
  			console.log("checkNote___checked");
  			checkArr.push(checkbox[i].value);
  		}
  	}

  /*	// 선택된 체크박스
 	if(checkboxes.length === checked.length)  {
 		document.getElementById("checkAllSentNote").setAttribute("checked", true);
 		document.getElementById("checkAllRecvNote").setAttribute("checked", true);
 		checkAll.checked = true;
 		console.log("true");
 	}else {
 		document.getElementById("checkAllSentNote").setAttribute("checked", false);
 		document.getElementById("checkAllRecvNote").setAttribute("checked", true);
		console.log("false");
 	}*/
}
//=========================delete note===========================================================================

function deleteNote(obj){
	
	var checkArr = new Array();	
	
	var checkbox = document.getElementsByName('notebox_no');
	
	for(var i = 0; i < checkbox.length; i++ ){
	
		if(checkbox[i].checked){
		
			console.log("checked", checkbox[i].value);
			
			if(checkbox[i].id == "deleteNoteBtn_sent"){
			
				console.log("deleteChecked");
				
				var readDate = checkbox[i].value + "_date";			//히든 input id는 글번호+"date" 로 줌, 
		        checkRead = document.getElementById(readDate).value;   //value로 확인일 준 값 읽어오기
		        
				if(checkRead == ""){
		        
		        	console.log("before read. can delete");
		        	console.log("readDate:",document.getElementById(readDate).value);
		        	
		        	checkArr.push(checkbox[i].value);  // sent 체크된 것 중에(상대방이 아직 안 읽은 것만) 
		        											 //값을 뽑아서 배열에 push
				}

			
			}else{
				checkArr.push(checkbox[i].value);     // sent 체크된 것 중에(상대방이 아직 안 읽은 것만) 
	        											 //값을 뽑아서 배열에 push
	 
			}
			
		}
	}
		
	console.log(checkArr.length);
		
	var xmlhttp = new XMLHttpRequest();
	
	//서버에서 응답 후 처리 로직.
	xmlhttp.onreadystatechange = function(){
		
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
			location.href = "../member/notePage.do";
		}
	}

	//post 방식으로 파라미터 보내는법...
	xmlhttp.open("post" , "../member/deleteCheckedNote.do");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("chbox[]="+ checkArr);
   
}


















//=============================================================================================================================
//=============================================================================================================================
//=============================================================================================================================

/*
function chooseReceiverID(){
	console.log(friendId_two.value);
	$("#friend_no").attr("value", friendId_two.value);
	console.log($("#friend_no").val());
}
*/

/*

	//var nickList = [];
	
	//console.log(friendList.length);
	//console.log("friendList value : " + friendList.options.length);
	
	//for(var i=0; friendList.length > i; i++){
	//	console.log(friendList[i]);
	//	nickList.push(friendList[i]);	
	//}
*/


/*
//===================================RecvNoteBoxNoView : popup===================================
//=========================open
function open_popup_recv(nick, notebox_no, content, writeDate, readDate){
        
	//console.log(nick, notebox_no, content, writeDate, readDate);

	if(readDate == ""){
		
		var xmlhttp = new XMLHttpRequest();
			
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
					
		      //location.href = "../member/notePage.do";
		      var dt = new Date();
		      document.getElementById("readDate_recv").setAttribute("value",dt.toString());
			}
		}
		
		//post 방식으로 파라미터 보내는법...
		xmlhttp.open("post" , "confirmNote.do");
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("notebox_no=" + notebox_no);	
		
		
	}
	
	
	var bColor =  $("#closePopup_recv").css('color');
	var popupList = $('#popup_mylist_recv');
  
	document.querySelector('.popup_recv').style.display = 'flex';
           	
    closeBtn = `<div id="closePopup_recv" onclick="close_popup_recv();">+</div>`
	frame = `<table><tr>`
        	
	noLabel = `<th><Label class = "popup_mylist_list_recv" style="color:${bColor};">번호</Label></th>`;
	nickLabel = `<th><Label class = "popup_mylist_list_recv" style="color:${bColor};">보낸이</Label></th>`;
	contentLabel = `<th><Label class = "popup_mylist_list_recv" style="color:${bColor};">내용</Label></th>`;
 	writeDateLabel = `<th><Label class = "popup_mylist_list_recv" style="color:${bColor};">작성일</Label></th>`;
	readDateLabel = `<th><Label class = "popup_mylist_list_recv" style="color:${bColor}">확인일</Label></th></tr>`;
     		
	middleFrame = `<tr>`
	noInput = `<td class="col"><input type="text" class = "popup_mylist_list_recv" value="${notebox_no}_recv" style="color:${bColor};"></td>`;
	nickInput = `<td class="col"><input type="text" class = "popup_mylist_list_recv" value="${nick}" style="color:${bColor};"></td>`;
	contentInput=`<td class="col"><input type="text" class = "popup_mylist_list_recv" value="${content}" style="color:${bColor};"></td>`;
	writeDateInput = `<td class="col"><input type="text" class = "popup_mylist_list_recv" value="${writeDate}" style="color:${bColor};"></td>`;
	readDateInput = `<td class="col"><input type="text" class = "popup_mylist_list_recv" id="readDate_recv" value="${readDate}" style="color:${bColor};"></td>`;
	lastFrame = `</tr></table>`;

	popupList.append(closeBtn);
	popupList.append(frame);
	popupList.append(noLabel);
	popupList.append(nickLabel);
	popupList.append(contentLabel);
	popupList.append(writeDateLabel);
	popupList.append(readDateLabel);
    		
	popupList.append(middleFrame);
    		
	popupList.append(noInput);
	popupList.append(nickInput);
	popupList.append(contentInput);
	popupList.append(writeDateInput);
	popupList.append(readDateInput);
	popupList.append(lastFrame);
        	
}

//=========================close    
function close_popup_recv(){

	var popupList = $('#popup_mylist_recv');
	
	popupList.empty();
	
  	document.querySelector('.popup_recv').style.display = 'none';
  	document.querySelector('.popup-create-content_recv').style.display = 'none';

  
}

		
//===================================SentNoteBoxNoView : popup===================================

//=========================open
function open_popup(nick, notebox_no, content, writeDate, readDate){
        
	//console.log(nick, notebox_no, content, writeDate, readDate);

	if(readDate == ""){
		readDate = "미확인";
	}
	
	var bColor =  $("#closePopup").css('color');
	var popupList = $('#popup_mylist');
  
	document.querySelector('.popup').style.display = 'flex';
           	
           	
    closeBtn = `<div id="closePopup" onclick="close_popup();">+</div>`      	
	frame = `<table><tr>`
        	
	noLabel = `<th><Label class = "popup_mylist_list" style="color:${bColor};">번호</Label></th>`;
	nickLabel = `<th><Label class = "popup_mylist_list" style="color:${bColor};">받는이</Label></th>`;
	contentLabel = `<th><Label class = "popup_mylist_list" style="color:${bColor};">내용</Label></th>`;
 	writeDateLabel = `<th><Label class = "popup_mylist_list" style="color:${bColor};">작성일</Label></th>`;
	readDateLabel = `<th><Label class = "popup_mylist_list" style="color:${bColor}">확인일</Label></th></tr>`;
     		
	middleFrame = `<tr>`
	noInput = `<td class="col"><input type="text" class = "popup_mylist_list" value="${notebox_no}_sent" style="color:${bColor};"></td>`;
	nickInput = `<td class="col"><input type="text" class = "popup_mylist_list" value="${nick}" style="color:${bColor};"></td>`;
	contentInput=`<td class="col"><input type="text" class = "popup_mylist_list" value="${content}" style="color:${bColor};"></td>`;
	writeDateInput = `<td class="col"><input type="text" class = "popup_mylist_list" value="${writeDate}" style="color:${bColor};"></td>`;
	readDateInput = `<td class="col"><input type="text" class = "popup_mylist_list" value="${readDate}" style="color:${bColor};"></td>`;
	lastFrame = `</tr></table>`;

	popupList.append(closeBtn);
	popupList.append(frame);
	popupList.append(noLabel);
	popupList.append(nickLabel);
	popupList.append(contentLabel);
	popupList.append(writeDateLabel);
	popupList.append(readDateLabel);
    		
	popupList.append(middleFrame);
    		
	popupList.append(noInput);
	popupList.append(nickInput);
	popupList.append(contentInput);
	popupList.append(writeDateInput);
	popupList.append(readDateInput);
	popupList.append(lastFrame);
        	
}

//=========================close    
function close_popup(){
	
	var popupList = $('#popup_mylist');
	
	popupList.empty();

  	document.querySelector('.popup').style.display = 'none';
  	document.querySelector('.popup-create-content').style.display = 'none';
  

}


//===================================friend selectlist===================================
function selectGroup(){
	//console.log(base_group.value);
	
	group_selectList = document.getElementById("group_selectList")
	
	for(var i = 0; i < group_selectList.length; i++){
		if(group_selectList[i].selected){
			console.log("selected");
			var group_value = group_selectList[i].value;
			
			//var group = group_value.split("++");
			//var group_no = group[0];
			//var group_name = group[1];
			
			document.getElementById("group_selectList").setAttribute("value", group_value);
			break;
		}
	}
	
}
	











*/