<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- for문 if문 등등 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- date 타입을 예쁘게 바꿔주기위해 사용하는 tag library -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">

<style>
      
 
            #commentListBox::-webkit-scrollbar {
                width: 20px; /*스크롤바의 너비*/
            }
 
            #commentListBox::-webkit-scrollbar-thumb {
                background-color: #CDECFA; /*스크롤바의 색상*/
                background-clip: padding-box;
                border: 4px solid transparent;
                border-top-left-radius: 50px;
                border-bottom-right-radius: 50px;
            }
 
            #commentListBox::-webkit-scrollbar-track {
                background-color: #E1F6FA; /*스크롤바 트랙 색상*/
            }
 
       

</style>

<!-- 날짜 포맷 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script type="text/javascript">
   
   var board_no = ${content.boardVo.chattingboard_no};

   var member_no = null;
   
   function checkSession(){
      
      //AJAX API 사용....
      var xmlhttp = new XMLHttpRequest();
      
      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            //alert("테스트");
            //alert(xmlhttp.responseText);
            var data = JSON.parse(xmlhttp.responseText);
            
            if(data.isLogin == true){
               member_no = data.member_no;
            }
         }
      };
      
      //get 방식으로 파라미터 보내는법...
      xmlhttp.open("get" , "../member/getSessionInfo.do" , false); //마지막 false는 동기식 호출... 
      xmlhttp.send();
   }
   

   
   
   //채팅 관련...
   function writeComment(){
      
      var commentContentTextArea = document.getElementById("commentContentTextArea");
      
      var commentValue = commentContentTextArea.value; 
      
      commentContentTextArea.value = "";
      
      //AJAX API 사용....
      var xmlhttp = new XMLHttpRequest();
      
      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            refreshCommentList();
         }
      };
      
      //post 방식으로 파라미터 보내는법...
      xmlhttp.open("post" , "./writeChattingProcess.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("chattingboard_no=" +board_no + "&chatting_content=" + commentValue);
      
   }
   
   function joinChattingMessage() {
      
   var commentContentTextArea = document.getElementById("commentContentTextArea");
      
      var commentValue = commentContentTextArea.value; 
      
      commentContentTextArea.value = "";
      
      //AJAX API 사용....
      var xmlhttp = new XMLHttpRequest();
      
      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            refreshCommentList();
         }
      };
      
      //post 방식으로 파라미터 보내는법...
      xmlhttp.open("post" , "./joinChattingMessage.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("chattingboard_no=" +board_no);
      
      
   }
   
   //마우스 커서 올려대면 달라지는거(delete)
   function setCursor(str,str2){
        str.style.cursor = str2; 
   }
   
   //엔터키 치면 입력 가능
   function enterkey() {

           if(window.event.keyCode == 13){   
           writeComment();
        }
      
   }
   
   function refreshCommentList(){
      
      
      
      var xmlhttp = new XMLHttpRequest();
      
   
      xmlhttp.onreadystatechange = function(){
            
            if(xmlhttp.readyState==4 && xmlhttp.status==200){
            
            var result = JSON.parse(xmlhttp.responseText);
            
            var commentListBox = document.getElementById("commentListBox");
            
            //크기 조절해주자(속성)
            
            
            
            //초기화
            commentListBox.innerHTML = "";
            
            
            for(data of result){
               
               //console.log(data.memberVo.member_nick);
               //console.log(data.commentVo.comment_content);
               
               
               //createElement, appendChild attribute <-무조건 하세요
               //참고: 절대 innerHTML 쓰지 마세요
               
               //본인이면 오른쪽에 표시
               
               
               
                     
                     
                     
               var rowBox = document.createElement("div");
               rowBox.setAttribute("class","row mt-3 mb-3");
                     
                     
                if(member_no != null && member_no == data.memberVo.member_no){
                     
                     var commentDate = moment(data.commentVo.writedate).format("HH:mm","Asia/Seoul"); //시간타입설정, 서울로 설정
                     
                     //날짜                   
                      var writedate = document.createElement("li");
                      writedate.setAttribute("style","text-align:left;display: inline;padding: 6px;font-size:5px;color:#AADBFF;");
                      writedate.innerText = commentDate;
                      
                     
                     //채팅 달린거(여기서 뭐좀 해주자)
                     var colContentBox = document.createElement("div");
                     colContentBox.setAttribute("class","col");
                     colContentBox.setAttribute("style","text-align:right");
                     
                     
                     //삭제버튼
                     var deleteBox = document.createElement("li");
                     deleteBox.innerText = "x";
                     deleteBox.setAttribute("style","text-align:right;display: inline;padding: 6px; color:#82B3ED");   
                     deleteBox.setAttribute("onclick","deleteComment("+data.commentVo.chattingroomboard_no+")");
                     deleteBox.setAttribute("onmouseover","setCursor(this,'pointer')");
                     
                     //텍스트 박스
                     var chattingTextBox = document.createElement("li");
                     chattingTextBox.setAttribute("style","text-align:right;background-color:#CDECFA;border-radius:10%;display: inline;padding: 6px;");            
                     chattingTextBox.innerText = data.commentVo.chatting_content;
                     
                     colContentBox.appendChild(deleteBox);
                     colContentBox.appendChild(writedate);
                     colContentBox.appendChild(chattingTextBox);
      
                  
                     rowBox.appendChild(colContentBox);//조립하기
                  
                     
                     //최종 조립
                     commentListBox.appendChild(rowBox);
                     commentListBox.scrollTop = commentListBox.scrollHeight; //가장 아래로 하는 속성 추가(스크롤)commentListBox.sc표시
                     
                     
               //상대방이면 왼쪽에 표시      
                }else{
                   
                      var commentDate = moment(data.commentVo.writedate).format("HH:mm","Asia/Seoul"); //시간타입설정, 서울로 설정
                     
                     //날짜                   
                      var writedate = document.createElement("li");
                      writedate.setAttribute("style","text-align:left;display: inline;padding: 6px;font-size:5px;color:#AADBFF;");
                      writedate.innerText = commentDate;
                     
                  
                      
                     var colIconAndNickBox = document.createElement("div");
                     colIconAndNickBox.setAttribute("class","col-1");
                     colIconAndNickBox.setAttribute("style","width:15%");
                     //아이콘
                     var colIconBox = document.createElement("span");
                     colIconBox.setAttribute("class"," bi bi-person-fill");
                   
                     //닉네임
                     var colNameBox = document.createElement("span");
                     colNameBox.innerText = data.memberVo.nick;
                     colNameBox.setAttribute("style","text-align:left; margin-left:15px;");
                     
                     colIconAndNickBox.appendChild(colIconBox);
                     colIconAndNickBox.appendChild(colNameBox);
                     
                     //채팅 달린거(여기서 뭐좀 해주자)
                     var colContentBox = document.createElement("div");
                     colContentBox.setAttribute("class","col");
                     colContentBox.setAttribute("style","text-align:left");
                     var chattingTextBox = document.createElement("li");
                     chattingTextBox.setAttribute("style","text-align:left;background-color:#CDECFA;border-radius:10%;display: inline;padding: 6px;");            
                     chattingTextBox.innerText = data.commentVo.chatting_content;
                     
                     colContentBox.appendChild(chattingTextBox);
                     colContentBox.appendChild(writedate);
                   
                   
                   
                      rowBox.appendChild(colIconAndNickBox);//조립하기
                     //조립하기
                     rowBox.appendChild(colContentBox);//조립하기
                      
                     
                     
                     //최종 조립
                     commentListBox.appendChild(rowBox);
                     commentListBox.scrollTop = commentListBox.scrollHeight; //가장 아래로 하는 속성 추가(스크롤)commentListBox.sc표시
                   
                   
                     
                  
                     
                }
               
            }
         }
      };
      
      
      //get 방식으로 파라미터 보내는법...
      xmlhttp.open("get" , "./getChattingList.do?chattingboard_no="+board_no); 
      xmlhttp.send();
      
      
      
      
   }
   
   function deleteComment(commentNo){
      
      
      
      var xmlhttp = new XMLHttpRequest();
      
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            
            refreshCommentList();
         }
      };
      
      //post 방식으로 파라미터 보내는법...
      xmlhttp.open("post" , "./deleteChatting.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("chattingroomboard_no=" + commentNo);
      
      
   }
   
   function init(){
      checkSession();
      
      refreshCommentList();
      
      setInterval(refreshCommentList , 500);
      
      
   }
   
   
</script>


</head>
<body onload="init()">


<!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>
   
   
   
   
   
   <div style="width:700px; margin: 100px auto;">

   <div class="row mt-4">
      <div class="col" style="text-align:left; padding-left:0px;">
         <h4 style="color:#00CDFF">TITLE &nbsp; | &nbsp; ${content.boardVo.title }</h4>
      </div>
      <div class="col" style="text-align:right; padding-right:0px;">
         <c:if test="${!empty sessionUser }">
         <form action="exitChattingRoom.do" method="post">
            <input type="hidden" name="chattingboard_no" value="${content.boardVo.chattingboard_no}">
            <input type="submit" value="exit" class="btn btn" style="background-color:#00CDFF; color:white">
         </form>
         </c:if>
      </div>
   </div>

   <div class="row mt-2 mb-3">
      <div class="col" style="background-color:white;text-align:center;border:1px #EBFBFF solid;padding-left:0px;">
         <h4 style="text-wegiht:bold;color:#00CDFF">chat</h4>
      </div>
   </div>
   <div class="row">
      <span id="commentListBox" style=" overflow:auto; overflow-x:hidden;width:900px; height:500px; background-color:#EBFBFF">
      </span>
   </div>
   
   
   <div class="row mt-1">
      <div class="col" style="background-color:white;">
         &nbsp;
      </div>
   </div>
   <div class="row mt-3">
   <c:if test="${!empty sessionUser }">
      <div class="col-11" style="padding-left:0px;">                          <!-- 이렇게 하면 엔터쳤을때도 입력되지롱 -->
         <textarea id="commentContentTextArea" rows="1" cols= "150px" 
         onkeyup="enterkey()" class="form-control" placeholder="채팅입력" required></textarea>
      </div>
      <div class="col-1" style="padding-left:0px">   
         <input onclick="writeComment()" type="button" value="입력" class="btn"style="resize:none;background-color:#00CDFF; color:white">
      </div>   
   </c:if>
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