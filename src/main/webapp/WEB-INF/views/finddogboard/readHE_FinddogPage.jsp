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

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">

<style>
/*pagination*/
   .my.pagination > .active > a, 
   .my.pagination > .active > span, 
   .my.pagination > .active > a:hover, 
   .my.pagination > .active > span:hover, 
   .my.pagination > .active > a:focus, 
   .my.pagination > .active > span:focus {
     background: black;
     border-color: black;
}

 
</style>

<script src="../resources/js/finddogBoard.js"></script>

<script>


   var finddogboard_no =  ${content.boardVo.finddogboard_no};

   var member_no = null;
   
   var sendMessageToOwner_Modal = null;
   var finalStep_modal = null;
   
   var currentOwner_no = null;
   var currentOwner = null;

   


function checkSession(){


   var xmlhttp = new XMLHttpRequest();

   //서버에서 응답 후 처리 로직.
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
         var data = JSON.parse(xmlhttp.responseText);

         if(data.isLogin == true){
            member_no = data.member_no;

         }

      }
   };

   xmlhttp.open("get" , "../member/getSessionInfo.do" , false);   //마지막 false는 동기식 호출
   xmlhttp.send();



}





function processRecommend(){

      if(member_no == null){

         alert("로그인 후 이용하세요.");
         return;
      }

      var xmlhttp = new XMLHttpRequest();

      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){

            refreshHeart();
            refreshTotalCount();
         }
      };

      xmlhttp.open("post" , "./processRecommend.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("finddogboard_no="+finddogboard_no);
   }



   function refreshHeart(){

      if(member_no == null){

         return;
      }

      var xmlhttp = new XMLHttpRequest();

      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){

            var data= JSON.parse(xmlhttp.responseText);

            var emptyHeart = document.getElementById("emptyHeart");
            var fillHeart = document.getElementById("fillHeart");



            if(data.myRecommendCount > 0){
               //추천 한 경우.. 채워진 하트
               emptyHeart.setAttribute("class","bi bi-heart text-danger fs-1 d-none");
               fillHeart.setAttribute("class","bi bi-heart-fill text-danger fs-1");
            }else{
               //추천 안한 경우.. 비워진 하트
               emptyHeart.setAttribute("class","bi bi-heart text-danger fs-1");
               fillHeart.setAttribute("class","bi bi-heart-fill text-danger fs-1 d-none");
            }
         }
      };

      xmlhttp.open("get" , "./getMyRecommendCount.do?finddogboard_no="+finddogboard_no);
      xmlhttp.send();

   }
   
   /*
   function init(){

      checkSession();
      refreshTotalCount();
      refreshHeart();


   }
*/
function refreshTotalCount(){




      //AJAX API 사용....
      var xmlhttp = new XMLHttpRequest();

      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            var data = JSON.parse(xmlhttp.responseText);
         //DOM rendering
            var totalCountBox = document.getElementById("totalCountBox");
            totalCountBox.innerText = "좋아요 수 : "+data.totalRecommendCount;


         }
      };

      //get 방식으로 파라미터 보내는법...
      //xmlhttp.open("get" , "./testRest.do?id=" + id);
      //xmlhttp.send();

      //post 방식으로 파라미터 보내는법...
      xmlhttp.open("get" , "./getTotalRecommendCount.do?finddogboard_no="+finddogboard_no);
      xmlhttp.send();

}


   //댓글관련======================================================================================

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
      xmlhttp.open("post" , "./writeComment.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("finddogboard_no=" + finddogboard_no + "&comment_content=" + commentValue);

   }

   function refreshCommentList(){



      var xmlhttp = new XMLHttpRequest();


      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){

            var result = JSON.parse(xmlhttp.responseText);

            var commentListBox = document.getElementById("commentListBox");

            //초기화
            commentListBox.innerHTML = "";

            for(data of result){

               //시간 변환 해보자!!(지금 초단위로 나옴 개노답;)

               //console.log(data.memberVo.nick);
               //console.log(data.commentVo.comment_content);


               //createElement, appendChild attribute <-무조건 하세요
               //참고: 절대 innerHTML 쓰지 마세요

               //========================첫번째 박스===========================
               var line = document.createElement("hr");


               var firstRowBox = document.createElement("div");
               firstRowBox.setAttribute("class","row mb-1");

               var colNameBox = document.createElement("div");
               colNameBox.setAttribute("class","col-3");
               colNameBox.innerText = data.memberVo.nick;
               firstRowBox.appendChild(colNameBox);//조립하기

               var colBlankBox = document.createElement("div");
               colBlankBox.setAttribute("class","col");
               firstRowBox.appendChild(colBlankBox);//공백을 주기 위한 자식 블랭크 박스

               var writeDateBox = document.createElement("div");//writeDate~~~~~~:)
               writeDateBox.setAttribute("class","col-3");
               writeDateBox.setAttribute("style","text-align:right");
               writeDateBox.innerText = data.commentVo.writeDate;
               firstRowBox.appendChild(writeDateBox);

               //========================두번째 박스===========================

               var secondRowBox = document.createElement("div");
               secondRowBox.setAttribute("class","row");

               var second_firstBox = document.createElement("div");
               second_firstBox.setAttribute("class","col-1");
               var personIcon = document.createElement("i");
               personIcon.setAttribute("class","bi bi-person-fill");
               second_firstBox.appendChild(personIcon); //사람 표시 아이콘을 div class col-1에 넣기

               var second_secondBox = document.createElement("div");
               second_secondBox.setAttribute("class","col");
               second_secondBox.innerText = data.commentVo.comment_content

               secondRowBox.appendChild(second_firstBox);
               secondRowBox.appendChild(second_secondBox);



               //========================세번째 박스===========================

               if(member_no != null && member_no == data.memberVo.member_no){

               var userthirdRowBox = document.createElement("div");
               userthirdRowBox.setAttribute("class","row mb-1 mt-1");



               var userThird_firstBox = document.createElement("div");
               userThird_firstBox.setAttribute("class","col-10");


               //================쓰레기 박스=========================
               var userThird_secondBox = document.createElement("div");
               userThird_secondBox.setAttribute("class","col-1");

               //================쓰레기 버튼=========================
               var deleteButton = document.createElement("button");
               deleteButton.setAttribute("class","btn btn-secondary");
               deleteButton.setAttribute("onclick","deleteComment("+data.commentVo.comment_no+")");
               //deleteButton.setAttribute("style","background-color:#090721");
               var trashIcon = document.createElement("i");
               trashIcon.setAttribute("class","bi bi-trash");
               
               deleteButton.appendChild(trashIcon);

               userThird_secondBox.appendChild(deleteButton);

               //================수정 박스=========================
               var userThird_thirdBox = document.createElement("div");
               userThird_thirdBox.setAttribute("class","col-1");

               //===============수정 버튼============================
               var updateButton = document.createElement("button");
               updateButton.setAttribute("class","btn btn-secondary");
               
               //수정 속성 해야됨
                  
               
               var updateIcon = document.createElement("i");
               updateIcon.setAttribute("class","bi bi-pen");
               updateButton.appendChild(updateIcon);

               userThird_thirdBox.appendChild(updateButton);

               //userthirdRowBox.appendChild(userThird_firstBox);
               userthirdRowBox.appendChild(userThird_firstBox);
               userthirdRowBox.appendChild(userThird_secondBox);
               userthirdRowBox.appendChild(userThird_thirdBox);


               //========================여기다 전부 합치기===============
               commentListBox.appendChild(firstRowBox);
               commentListBox.appendChild(secondRowBox);
               commentListBox.appendChild(userthirdRowBox);
               commentListBox.appendChild(line);


               }else{
                  
               //========================세번째 박스(남 댓글)===========================
                 var nonUserthirdRowBox = document.createElement("div");
                 nonUserthirdRowBox.setAttribute("class","row mb-1 mt-1");
                           
                 var nonUserthird_firstBox =  document.createElement("div");
                 nonUserthird_firstBox.setAttribute("class","col");
                           
                 var nonUserthird_secondBox =  document.createElement("div");
                 nonUserthird_secondBox.setAttribute("class","col-8");
                 nonUserthird_secondBox.innerText=".";
                           
                 var nonUserthird_thirdBox =  document.createElement("div");
                 nonUserthird_thirdBox.setAttribute("class","col");
                           
                 nonUserthirdRowBox.appendChild(nonUserthird_firstBox);
                 nonUserthirdRowBox.appendChild(nonUserthird_secondBox);
                 nonUserthirdRowBox.appendChild(nonUserthird_thirdBox);
                           
                 commentListBox.appendChild(firstRowBox);
                 commentListBox.appendChild(secondRowBox);
                 commentListBox.appendChild(nonUserthirdRowBox);
                 commentListBox.appendChild(line);
                 }

            }
         }
      };


      /*


      <h6>댓글 수 : ${commentCount }</h6>
      <hr>

         <div class="row mt-1">
         <c:forEach items="${comment }" var="comment">

               <div class="row mb-1">
                  <div class="col-3"> ${comment.memberVo.nick }</div>
                  <div class="col"></div>
                  <div class="col-3" style="text-align:right;">작성일  : <fmt:formatDate value="${comment.commentVo.writeDate }" pattern="MM.dd" /> </div>
               </div>


               <div class="row">
                        <div class="col-1"><i class="bi bi-person-fill"></i></div>
                        <div class="col-1"><i class="bi bi-person"></i></div>
                  <div class="col"> ${comment.commentVo.comment_content }</div>
               </div>


            <!-- 지우기 수정표시, 내꺼가 아니면 띄어쓰기 넣어줘서 공간감 같게 만들어 줌.. -->
            <c:choose>
               <c:when test="${!empty sessionUser && sessionUser.member_no == comment.commentVo.member_no }">
                  <div class="row mb-1 mt-1" style="text-align:right;">
                     <div class="col-8"></div>
                     <div class="col-2"></div>
                     <div class="col-1">
                        <form action="deleteCommentProcess.do" method="get">
                        <button class="btn btn-primary"><i class="bi bi-trash"></i></button>
                        <input type="hidden" name="comment_no" value="${comment.commentVo.comment_no }">
                        <input type="hidden" name="finddogboard_no" value="${content.boardVo.finddogboard_no }">
                        </form>
                     </div>
                     <div class="col-1">
                        <form action="updateHE_finddogBoardCommentPage.do" method="get">
                        <button class="btn btn-primary"><i class="bi bi-pen"></i></button>
                        <input type="hidden" name="comment_no" value="${comment.commentVo.comment_no }">
                        <input type="hidden" name="finddogboard_no" value="${content.boardVo.finddogboard_no }">
                        </form>
                     </div>
                  </div>
               </c:when>
               <c:otherwise>
                  <div class="row mb-1 mt-1">
                     <div class="col"></div>
                     <div class="col-8">&nbsp</div>
                     <div class="col"></div>
                  </div>
               </c:otherwise>
            </c:choose>




            <hr>
         </c:forEach>
         </div>
         */


      //get 방식으로 파라미터 보내는법...
      xmlhttp.open("get" , "./getCommentList.do?finddogboard_no=" + finddogboard_no);
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
      xmlhttp.open("post" , "./deleteComment.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("comment_no=" + commentNo);


   }
   
   

   function updateComment(e, commentNo){
      
      
      
      
      //AJAX API 사용....
      var xmlhttp = new XMLHttpRequest();
      
      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            
            refreshCommentList();
            
         }
      };
      
      //post 방식으로 파라미터 보내는법...
      xmlhttp.open("post" , "./updateComment.do");
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("comment_no=" + commentNo + "&comment_content=" + commentValue);
      
   }
   
   

function openMessageToOwner_Modal(){
   sendMessageToOwner_Modal.show();
}



function sendMessage(){
   

	var lastContent = document.getElementById("lastContent").value;
   //console.log("currentOwner:",currentOwner);
   console.log("content:",lastContent);
      
   
   //AJAX API 사용....
   var xmlhttp = new XMLHttpRequest();
   
   //서버에서 응답 후 처리 로직.
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
      

         
         sendMessageToOwner_Modal.hide();
         
         
         
      }
   };
   
   //post 방식으로 파라미터 보내는법...
   xmlhttp.open("post" , "../member/sendNoteToOwner.do");
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + member_no + "&friend_no=" + currentOwner + "&content=" + lastContent + "&finddogboard_no=" + finddogboard_no);
   
   
   
}

function getNoteList(){
   
   //AJAX API 사용....
   var xmlhttp = new XMLHttpRequest();
   
   //서버에서 응답 후 처리 로직.
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
      
         var result = JSON.parse(xmlhttp.responseText);
         console.log("resutl:",result);
         
         var finalStep_selectList = document.getElementById("finalStep_selectList");
      
         
         finalStep_selectList.innerText = "";
         

         var opt = document.createElement('option');
         opt.value = -1;
         opt.text = "주인 찾음";
         
         finalStep_selectList.appendChild(opt);
         
         var opt_two = document.createElement('option');
         opt_two.value =  0;
         opt_two.text = "보호소 이관";
         
         finalStep_selectList.appendChild(opt_two);
         
         
         
         for(data of result){
         
            console.log("data:",data);
            opt = document.createElement('option');
            opt.value =  data.member_no;
            opt.text =  data.nick;
            
            finalStep_selectList.appendChild(opt);
            
            
         }
         
      }
   };
   
   //post 방식으로 파라미터 보내는법...
   xmlhttp.open("post" , "../ownerboard/getNoteList.do");
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("finddogboard_no=" + finddogboard_no);
   
   
}



function completeStatus(btn){
   
   
   
    console.log(btn.value);
    
    var FinddogStatusBtn = document.getElementById("FinddogStatusBtn");
    
    
    var status = null;
    
    if(btn.value == "완료"){
       console.log("완료1");
       
       finalStep_modal.show();
       status = 'Y';
       
       
       
    }else{
       console.log("취소1");
       
       status = 'ING';
       
    }
    
    
    var xmlhttp = new XMLHttpRequest();
    
    xmlhttp.onreadystatechange = function(){
       
       if(xmlhttp.readyState==4 && xmlhttp.status==200){

          
          if(btn.value == "완료"){
             console.log("완료2");
             
            // FinddogStatusBtn.setAttribute("value", "완료");
            // btn.setAttribute("value", "완료취소");
             
          }else{
             console.log("취소2");
             
             FinddogStatusBtn.setAttribute("value", "진행중");
             btn.setAttribute("value","완료");
             
          }
          
       }
    };
    
    //post 방식으로 파라미터 보내는법...
    xmlhttp.open("post" , "../ownerboard/completeFinddog.do");
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send("status=" + status + "&finddogboard_no=" + finddogboard_no);
   

}

function finalStep(){
   
   console.log("finalStep:", currentOwner_no);
   //AJAX API 사용....
   var xmlhttp = new XMLHttpRequest();
   
   //서버에서 응답 후 처리 로직.
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
      
         
         
         //<a href="../reviewboard/HE_ReviewBoardList.do">후기 작성은 유기견 보호에 큰 도움이 됩니다. </a>
         
         
         console.log("lastowner_result_:", currentOwner_no);
         //var result = JSON.parse(xmlhttp.responseText);

         
         
         //finalStep_selectList.appendChild(opt);
//         var ownerList = document.getElementById("owner_list");
         
         
         
         //========================첫번째 박스===========================
         /*var line = document.createElement("hr");


         var firstRowBox = document.createElement("div");
         firstRowBox.setAttribute("class","row");

         var colNameBox = document.createElement("div");
         colNameBox.setAttribute("class","col-2");
         colNameBox.innerText = result;
         firstRowBox.appendChild(colNameBox);//조립하기
         


         //========================두번째 박스===========================
         
         
         //ownerList.appendChild(firstRowBox);
         //ownerList.appendChild(line);
         */
         
         
         
      }
   };
   

}



   
   function init(){
      
      checkSession();
      refreshHeart();
      refreshTotalCount();
      refreshCommentList();
      
      getNoteList();

      sendMessageToOwner_Modal = new bootstrap.Modal(document.getElementById('sendMessageToOwner_Modal'));
      finalStep_modal = new bootstrap.Modal(document.getElementById('finalStep_modal'));
      

      
      currentOwner_no = document.getElementById("currentOwner");
      
      if(currentOwner_no == null){
         console.log("currentOwner_no_null : ", currentOwner_no);
         currentOwner = ${content.boardVo.member_no};
      }else{
    	 currentOwner = currentOwner_no.value;
      }
      
      
      //console.log("currentOwner_no:",currentOwner_no);
   }
   
   // callback 함수 
   
   window.addEventListener('DOMContentLoaded', init);
   
   
</script>

</head>
<!-- NAVBAR

<!-- 1. 보호소이관 
                         2~~~. 주인으로부터 온 쪽지 중에 선택하기
                              (주인게시판 status: Y로 변경,소유권 주인에게 넘어가게 
                               //견 추적시,db체크하고 주인게시판 상태 Y일 경우,소유권 이전된 상태)
                         
                         선택제출시, 버튼 상태 변경 
                     -->

<body onload="init()">

   <!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>
   
   
    <!--sendMessageToOwner_Modal 시작 -->
     <div class="modal fade" id="sendMessageToOwner_Modal" tabindex="-1" aria-labelledby="testModalLabel" aria-hidden="true">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <h5 class="modal-title" id="testModalLabel">임시보호자에게 쪽지 보내기</h5>
   
             <button type="button" 
                class="btn-close" 
                id="" data-bs-dismiss="modal" 
                aria-label="Close"></button>
           </div>
           
           <div class="modal-body">
              
              
              <div class="row">
               <div class="col">
                  
                  <h1></h1>
                  작성자 : ${sessionUser.nick }<br>
            
                  <div class="mb-3">
                     <label for="content">내용</label> 
                     <textarea name= "content" id="lastContent" style="width:100%; height: 500px; resize: vertical;"></textarea>
                  </div>
                    </div>
                    
                
            <div class="row">
               <div class="col">
                  <button value="확인" onclick="sendMessage()" style="background-color:rgb(0,0,0,0); border:0px;">
                     <i class="bi-check" style="font-size: 3rem; color:gray;"></i>
                  </button>
                     </div>
                     </div>
               </div>
            
           </div>
          
         </div>
       </div>
     </div>
    
    <!-- sendMessageToOwner_Modal 끝 -->
    
    
    
     <!-- finalStep 연결 Modal 시작 -->
     <div class="modal fade" id="finalStep_modal" tabindex="-1" aria-labelledby="testModalLabel" aria-hidden="true">
       <div class="modal-dialog">
         <div class="modal-content" style="width:500px;height:150px;">
           <div class="modal-header">
             <h5 class="modal-title" id="testModalLabel" style="color:#004ba0;text-align:center;font-weight:bold;">완료 선택</h5>
   
             <button type="button" 
                class="btn-close" 
                id="" data-bs-dismiss="modal" 
                aria-label="Close"></button>
           </div>
           
           <div class="modal-body" >
           
            <form action="../ownerboard/finalStep.do" method="post">
               <div class="row" style="margin:15px;">
                  <div class="col-3">
                     
                     <input type="hidden" name="finddogboard_no" value="${content.boardVo.finddogboard_no}">
                        <span >결정 : </span>
                  </div>
                  <div class="col-7">
                     <select class="form-select" id="finalStep_selectList" name="member_no" required aria-label="select example" style="margin-left:0px;width:200px;">
                     </select>
                       
                    </div>
                    
                    <div class="col">
                  
                     <button type="submit" value="확인" style="background-color:rgb(0,0,0,0); border:0px;">
                        <i class="bi-check" style="font-size: 2rem; color:#004ba0;"></i>
                     </button>
                  
                  
                  </div>
                     
               </div>
            </form>
            
           </div>
          
         </div>
       </div>
     </div>
   
    <!--  finalStep 연결 Modal 끝 -->
    
<div class="col mt-9" style="width:1500px; margin: 100px auto;">
      <div class="row">
         <div class="col"></div>
         <div class="col-8" >
                  <div class="row" style="background-color:#F8F9FA;" >
               <div class="col" style="text-align:left;font-size:30px; color:#004ba0; font-weight:bold;">
                  유기견 정보보기
               </div>
               <div class="col">
                  
               </div>
                <div class="col mt-3" style="text-align:right;">
                   <a href="./HE_FinddogBoardList.do" style="text-decoration-line:none;text-decoration-line:none;color:#004ba0;"><i class="bi bi-list"></i>목록 </a>
                </div>
               </div>
            <div class="row mt-5" style="height:500px;"><!--사진 & 내용 부분-->
               <div class="col">  
               
                
                  <c:choose>
                     <c:when test="${!empty content.boardImageVoList}">
                     
                     
                        <c:forEach items="${content.boardImageVoList}" var="boardImageVo">
                           <!-- 사진 시작 -->
                           <div class="row">
                              <div class="col">
                                 <div class="row">
                                    
                                       <img src="/upload/${boardImageVo.imageboard_url}"><br>
                                    
                                 </div>
                              </div>
                           </div>
                        </c:forEach>
                     </c:when>
                     <c:otherwise>
                        <div class="row" >
                                  <div class="col" >
                              <div class="row" >
                                 
                                    <img src="../resources/img/8.jpeg" style="height:500px;"><br>
                                 
                              </div>
                           </div>
                        </div>
                     </c:otherwise>
                  </c:choose>
               <!-- 사진 끝 -->
            </div>
            

            <div class="col-7 mb-2" style="margin-left:30px;">
               <div class="row" style="font-size:25px; color:#004ba0; font-weight:bold;">
                  ${content.boardVo.title }
               </div>
               <div class="row mt-3 mb-3" >
                  <div class="col-5">
                  ${content.memberVo.nick } 
                  </div>
                  <div class="col">
                  작성일: <fmt:formatDate value="${content.boardVo.writeDate }" pattern="yy/MM/dd" />
                  </div>
                  <div class="col" style="text-align:right;">
                   조회수: ${content.boardVo.readcount }
                  </div>
               </div>
               <div class="row" >
                  <hr>
               </div> 
               <div class="row" style="text-align:left;">
                  <div class="col" style="color:gray;">견종 / 성별
                  </div>   
                  <div class="col"> 
                      <div class="row">
                                   <div class="col">
                                      <c:choose>
                                         <c:when test="${!empty content.boardVo.species_no}">
                                          <c:forEach items="${speciesCategoryList}" var="pet">
                                                <c:choose>
                                                      <c:when test="${pet.species_no eq content.boardVo.species_no}">
                                                             ${pet.species} /
                                                      </c:when>
                                                   </c:choose>      
                                             </c:forEach>
                                     </c:when>
                                     <c:when test="${content.boardVo.species_no == -1}">
                                        모름 /
                                     </c:when>
                                      </c:choose>
                                      <c:choose>
                                         <c:when test="${content.boardVo.petGender eq 'M'}">
                                            수컷
                                         </c:when>
                                         <c:when test="${content.boardVo.petGender eq 'F'}">
                                            암컷
                                         </c:when>
                                         <c:otherwise>
                                            모름
                                         </c:otherwise>
                                      </c:choose>
                                   </div>
                               </div>            
                  </div>
               </div>
               <div class="row mt-1" style="margin-bottom:270px;">
                  <div class="col" style="color:gray;">이름 / 나이
                  </div>   
                  <div class="col"> 
                     <div class="row">
                               <div class="col">
                                    <c:choose>
                                        <c:when test="${!empty content.boardVo.petName }">
                                           ${content.boardVo.petName } /
                                        </c:when>
                                        <c:otherwise>
                                           모름 /
                                        </c:otherwise>
                                     </c:choose>
                                    <c:choose>
                                       <c:when test="${!empty content.boardVo.petName }">
                                          ${content.boardVo.petAge }살
                                       </c:when>
                                       <c:otherwise>
                                          모름
                                       </c:otherwise>
                                    </c:choose>
                                     </div>
                               </div>
                  </div>
               </div>
               <div class="row">
                  <hr>
               </div>
               <div class="row"><!-- 버튼 -->
                            
            <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
            <!-- 추후 자동으로 수락시, status 상태 바꾸기 쿼리 넣기-->
            <!-- 시터로 소유주 변경된 경우 -->
            <!-- 현재 시터가 로그인한 멤버인 경우 -->
            <!-- 현재 시터가 로그인한 멤버가 아닌 경우 -->
            
            <!-- 최초 글 올린 사람이 소유주인경우 -->
            <!-- 내 글인 경우  -->
            <!--내 글이 아닌 경우 -->
            
            <!-- 완료 상태 -->

               <div class = "col mt-1" style="text-align:right;margin-bottom:10px;">
               
                  <c:choose>
      

                     <c:when test="${sessionUer.member_no eq member_no}">
                     
                        <c:choose>
                        
                           <c:when test="${sitterVo eq 1 and content.boardVo.status eq 'ING'}">
                           
                              <input type="button" class = "btn btn-light" id="FinddogCompleteBtn" value="완료" onclick="completeStatus(this);"
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;">
                              <input type="button" class = "btn btn-light" id="FinddogStatusBtn" value="진행중" 
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;" disabled>
                           
                           </c:when>
                           
                           <c:when test="${sitterVo eq 1 and content.boardVo.status eq 'Y'}">
                           
                              <input type="button" class = "btn btn-light" id="FinddogStatusBtn" value="완료" 
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;" disabled>
                  
                           </c:when>
                           
                           <c:when test="${sitterVo eq 0 and content.boardVo.status eq 'ING'}">
                           
                              <input type="button" class = "btn btn-light" id="FinddogStatusBtn" value="진행중" 
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;" disabled>
   
                           </c:when>
                        
                           <c:when test="${sitterVo eq 0 and content.boardVo.status eq 'Y'}">
                           
                              <input type="button" class = "btn btn-light" id="FinddogStatusBtn" value="완료" 
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;" disabled>
                           
                           </c:when>
                           
                        </c:choose>
                        
                     </c:when>
                     
                     
                     
                     <c:otherwise>
                     
                        <c:choose>
                           <c:when test="${sitterVo eq 0 and content.boardVo.status eq 'ING'}">
                           
                              <input type="button" class = "btn btn-light" id="FinddogStatusBtn" value="진행중" 
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;" disabled>
   
                           </c:when>
                        
                           <c:when test="${sitterVo eq 0 and content.boardVo.status eq 'Y'}">
                           
                              <input type="button" class = "btn btn-primary" id="FinddogStatusBtn" value="완료" 
                                 style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                                 border-width:2px;border-color:#004ba0;" disabled>
                           
                           </c:when>
                           
                        </c:choose>
                        
                     </c:otherwise>


                     
                  </c:choose>
                  
               </div>
        
              </div>
         </div>
         </div>
      <!-- +++++++++++++++++++++++++내용+++++++++++++++++++++++++++++++++ -->
      <hr>
      <div class="row" style="margin:20px;">
            <c:if test="${!empty content.boardVo.content }">
                  <div class="row" style="font-size:15px;">&nbsp;내용</div>
                  <div class="row mt-4">
                  </div>
                  <div class="row">
                  </div>
                  <div class="row-8" style="color:gray">${content.boardVo.content }</div>
            </c:if>
         </div>
      
      
      <!-- ++++++++++++++++++++++++++++임시보호자목록 + 지도 ++++++++++++++++++++++++++++++ -->

         <div class="row">
            
         </div>
         <div class="row mt-3" style=" padding:7px;  background-color:#F8F9FA;">
            <div class="col">
            

                
            <!-- 견추적 -->
            <div class="row mt-3 justify-content-center" style="margin-right:10px;">
            <h6 style="width:350px;margin-bottom:20px;padding:8px;background-color:#6aaae4;color:#ffffff;font-size:17px;text-align:center;"><i class="bi bi-person-badge-fill"></i>&nbsp;임시보호자 목록</h6><!-- 견추적 시작-->   
            
            <c:forEach items="${history}" var="vo" varStatus="status">
               <div class="card" style="width:350px;margin-bottom:10px;background-color:#E2F4FF;">
                 <div class="card-body" id="owner_list">
   
                  <div class="row">
                       <div class="col-2" style="font-size:17px;color:#004ba0;">${status.count }
                        </div><!--신청 번호: ${vo.sitterVo.sitterboard_process_no} <br>-->
                        
                        <div class="col-10">
                           <div class="row">
                           
                              <div class="col-8">
                                 임시보호 시작일 
                              </div>
                              <div class="col"  style="color:gray">
                                 <fmt:formatDate value="${vo.sitterVo.acceptDate}" pattern="yy/MM/dd"/>
                              </div>
                           </div>
                              
                        <div class="row">
                           <div class="col-8">
                              임시보호자
                           </div>
                           <div class="col"  style="color:gray">
                              ${vo.memberVo.nick}
                              
                              
                           </div>
                           		<c:if test="${status.last}">
                                 	<input type="hidden" id="currentOwner" value="${vo.memberVo.member_no}">
                                 </c:if>
                           </div>
                           
                        </div>
                     </div>
                     
                 </div>
                 
               </div>
                   
            </c:forEach><!-- 견추적 끝 -->   
            
            
         	
            <c:if test="${!empty content.owner}">
               <div class="card" style="width:350px;margin-bottom:10px;background-color:#004ba0;">
                 <div class="card-body" id="owner_list">
   
                   <div class="row">
                        <div class="col-2" style="font-size:17px;color:#E2F4FF;">
                        </div><!--신청 번호: ${vo.sitterVo.sitterboard_process_no} <br>-->
                        
                        <div class="col-10">
                           <div class="row">
                           
                              <div class="col">
                                 
                              </div>
                              <div class="col"  style="color:gray">
                                 
                              </div>
                           </div>
                              
                        <div class="row">
                           <div class="col" style="color:#ffffff">
                              주인찾기완료
                           </div>
                           <div class="col"  style="color:#ffffff">
                              ${content.owner.nick}
                           </div>
                                 <input type="hidden" id="finalOwner" value=" ${content.owner.member_no}">
                           </div>
                        </div>
                     </div>
                     
                 </div>
                 
               </div>               
            </c:if>
         
            </div>
            </div>
            
            
            
          
            
            <div class="col" style="margin-top:10px;">
               <div class="row" style="color:#004ba0;">
                     <c:if test="${!empty content.boardVo.findDate }">
                        <span><i class="bi bi-calendar-check" style="font-weight:bold;"></i>&nbsp;&nbsp;&nbsp;잃어버린 날짜 &nbsp;|&nbsp; <fmt:formatDate  value="${content.boardVo.findDate}" pattern="yy년 MM월 dd일"/></span>
                     </c:if>      
               </div>
               <div class="row" style="color:#004ba0;">
                  <c:if test="${!empty content.boardVo.findPlace }">
                     <span><i class="bi bi-pin-map-fill" style="font-weight:bold;"></i>&nbsp;&nbsp;&nbsp;잃어버린 장소&nbsp; |&nbsp; ${content.boardVo.findPlace }</span>
                  </c:if>
               </div>
               <div class="row-8">
                  <div id="map" style="margin-top:20px;width:100%;height:350px;"></div><!-- 지도 시작 -->
                           <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=daed9b1f32dcc6d9546905fc4900a452"></script>
                              <script>
                                 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                                     mapOption = { 
                                      center: new kakao.maps.LatLng(${content.boardVo.latitude }, ${content.boardVo.longtitude }), // 지도의 중심좌표
                                      level: 3 // 지도의 확대 레벨
                                     };
                            // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
                           var map = new kakao.maps.Map(mapContainer, mapOption); 
          
                           // 마커가 표시될 위치입니다 
                          var markerPosition  = new kakao.maps.LatLng(${content.boardVo.latitude }, ${content.boardVo.longtitude }); 

                          // 마커를 생성합니다
                           var marker = new kakao.maps.Marker({
                               position: markerPosition
                           });

                                    // 마커가 지도 위에 표시되도록 설정합니다
                           marker.setMap(map);
   
                        // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
                           // marker.setMap(null);    
                        </script><!-- 지도 끝 -->
               </div>
            </div>
         </div>
         
         
         
       
      
         
         
            <div class="row">
               <div class="col-2">
                     <i id="emptyHeart" class="bi bi-heart text-danger fs-1" onclick="processRecommend()"></i>
                </div>
                <div class="col-9">
                     <i id="fillHeart" class="bi bi-heart-fill text-danger fs-1 d-none" onclick="processRecommend()"></i> 
                     </div>
                     
                   <div class="col">
                     <c:if test="${!empty sessionUser && content.owner == null && sessionUser.member_no != content.memberVo.member_no }">
                        <i class="bi bi-envelope-fill" style="font-size:3rem;color:#004ba0;" onclick="openMessageToOwner_Modal();"></i>
                     </c:if>
                     </div>
           </div>
               <span id="totalCountBox"></span>
               
                  

                  
                  
                  <div class="row mb-1">
                        <c:if test="${!empty sessionUser  && sessionUser.member_no == content.memberVo.member_no }">
                           <div class="col-10"></div>
                      <!-- boardVo_member_no써도 상관없음   -->
                      
                           <div class="col-1"><a style="text-decoration-line:none;color:#004ba0;" href="./deleteContentProcess.do?finddogboard_no=${content.boardVo.finddogboard_no }"><i class="bi bi-trash-fill"></i>삭제</a></div> <!-- 얘는 걍 삭제만 되면 됨 -->
                           <div class="col-1"><a style="text-decoration-line:none;color:#004ba0;" href="./updateHE_FindDogPage.do?finddogboard_no=${content.boardVo.finddogboard_no }"><i class="bi bi-box-arrow-in-up"></i>수정</a></div><!--  얘는 뭔가 페이지가 있어야됨 -->
                        </c:if>
                    </div>
        
                     <hr>
                        <c:if test="${!empty sessionUser }">
                        
                           <form>
                              <div class="mb-3">
                                    <div class="row">
                                       <div class="col-10">
                                          <input type="text" id="commentContentTextArea" class="form-control" value="" placeholder="댓글을 입력하세요." required>
                                       </div>
                                       <div class="col">
                                          <button class="btn" style="width:100%;background-color:#004ba0;border-color:#004ba0;color:#ffffff" onclick="writeComment()" >입력</button>
                                       </div>
                                    </div>
                              </div>
                           </form>
                        </c:if>
               <div id="commentListBox" class="row mt-1">
                  <!-- 커멘드 리스트 -->
               </div>
          </div>        
       <div class="col"></div>
   </div>
  </div>       

      <!-- FOOTER -->
   <jsp:include page="../include/footer.jsp"></jsp:include>

   
   <!-- /.container -->
      <!-- Bootstrap core JavaScript
    ================================================== -->
   <!-- Placed at the end of the document so the pages load faster -->
    <script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
</body>
</html>    
    
    
