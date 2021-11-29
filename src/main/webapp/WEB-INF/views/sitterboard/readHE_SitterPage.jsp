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

<title>Carousel Template for Bootstrap</title>

<script>

var sitterboard_no =  ${content.boardVo.sitterboard_no};
var member_no = null;
//var btnAction = $("#sitterStatusBtn");//false;

function checkSession(){
   
   
   var xmlhttp = new XMLHttpRequest();
   
   //서버에서 응답 후 처리 로직.
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
         var data = JSON.parse(xmlhttp.responseText);
         
         if(data.isLogin == true){
            
            member_no=data.member_no;
            
            
         }
         
      }
   };
   
   xmlhttp.open("get" , "../member/getSessionInfo.do" , false);   //마지막 false는 동기식 호출
   xmlhttp.send();


}


select * from 


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
      xmlhttp.send("sitterboard_no="+sitterboard_no);
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
      
      xmlhttp.open("get" , "./getMyRecommendCount.do?sitterboard_no="+sitterboard_no);
      xmlhttp.send();
      
   }



function refreshTotalCount(){
   
      //AJAX API 사용....
      var xmlhttp = new XMLHttpRequest();
      
      //서버에서 응답 후 처리 로직.
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            var data = JSON.parse(xmlhttp.responseText);
         //DOM rendering
            
            var totalCountBox = document.getElementById("totalCountBox");
            totalCountBox.innerText = data.totalRecommendCount;
            //console.log(totalCountBox.innerText);
         
         }
      };
      
      //get 방식으로 파라미터 보내는법...
      //xmlhttp.open("get" , "./testRest.do?id=" + id); 
      //xmlhttp.send();
      
      //post 방식으로 파라미터 보내는법...
      xmlhttp.open("get" , "./getTotalRecommendCount.do?sitterboard_no="+sitterboard_no);
      xmlhttp.send();


   
}

//=========sitterboard_process에서 수락한 경우, 부여 받은 finddogboard 권한 업데이트 
function getFinddogAuthority(){
   //console.log("init___getFinddogAuthority");
   
   
   var xmlhttp = new XMLHttpRequest();
   
   //서버에서 응답 후 처리 로직.
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
         var authority = JSON.parse(xmlhttp.responseText);
         
         console.log("res_authority: ", authority);
         //myFinddogAuthority은 arrayList<HE_FinddogBoard>
         //myFinddogAuthority = data.myFinddogAuthority;
         
         var finddogSelectList = document.getElementById("finddogboard_selectList");
         //finddogSelectList.innerHTML= "";
         
         for(data of authority){
            console.log(data);
            console.log(data.finddogboard_no);

            var opt = document.createElement('option');
            opt.value =  data.finddogboard_no;
            opt.text =  "게시글("+data.title + "_" + data.writeDate + ") : ../finddogboard/readHE_FinddogPage.do?finddogboard_no="+data.finddogboard_no;
            
            
            finddogSelectList.appendChild(opt);
            
            
         }
         
         /*//===DOM 그리기
         대상 글: 
            <select class="form-control" name="finddogboard_no" id="finddogboard_selectList" required aria-label="select example"
                  style="margin-top:10px;">
                  
               <c:forEach items="${finddogBoardList}" var="finddog">
                     <option value="${finddog.finddogboard_no}" selected>
                     
                        게시글(${finddog.title}_${finddog.writeDate}) :
                        ../finddogboard/readHE_FinddogPage.do?finddogboard_no= ${finddog.finddogboard_no}
            
                     </option>
               </c:forEach>
               
               
            </select>
         */
         
         
      }
   };
   
   xmlhttp.open("get" , "../member/getFinddogAuthority.do" , false);   //마지막 false는 동기식 호출
   xmlhttp.send();
}



//+++++++++++++시터 요청 버튼 작동 추가 
            /*
            
            //=========getSession()에서 설정한 data값 가져오기 
            sitterboardList = data.sitterBoardList;
            
            //console.log(sitterboardList.length);
            //console.log(sitterboardList[0].sitterboard_no);
            
            //=========신청버튼 작동 설정
            //1.finddogBoardList 가 0 이면(즉, 유기견 보유한 사람(=finddogBoard글 게시자)이 아닌 경우)
            //2.sitterboardList안의 sitterboard_no값과 현재 읽은 글의 sitterboard_no 값이 값거나(즉, 이미 해당글로 인해 신청 수락한 경우)
            //시터 신청 못받도록 btnAction 값 설정(즉, btnAction == true이면, 신청버튼 disabled)
            if(finddogBoardList.length == 0){
               console.log("disabled0");
               //btnAction.attr("disabled", true);
               btnAction = true;
               return;
            }else{
               for(i=0;i<sitterboardList.length;i++){
                  
                  if (sitterboardList[i].sitterboard_no == sitterboard_no){
                     console.log("disabled1");
                     //btnAction.attr("disabled", true);
                     btnAction = true;
                     return;
                  }
                  
               }
            }
            */


function init(){
   checkSession();
   refreshTotalCount();
   refreshHeart();
   getFinddogAuthority();
   //setInterval(checkSession, 1000);
   
   
}
</script>


</head>
<!-- NAVBAR
================================================== -->
<body onload="init()">


   <!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>
   
   <!-- sitterRequest_Modal -->
   <jsp:include page="../sitterboard_process/sitterRequest_Modal.jsp"></jsp:include>
   
   
   <div style="width:1200px; margin: 100px auto;">
      <div class="row">
         <div class="col"></div>
         <div class="col-8">
            <div class="row mb-4" style="background-color:#005ae6;color:white;text-align:center;padding:10px;">
               <h3>${content.boardVo.title }</h3>
            </div>
            <div class="row mt-4">
               &nbsp;
            </div>
            <div class="row mt-4">
               <div class="col"></div>
                  <!-- 티어 그림 -->
               <div class="col-8"style="text-align:center; height:400px;">
                  
                     <c:choose>
                        <c:when test="${content.sitterCount == 0}">
                           <img src="../resources/img/sitterNormal.png" style="width:150px;border:1px solid; border-radius:100%">
                        </c:when>
                        <c:when test="${content.sitterCount == 1}">
                           <img src="../resources/img/sitterLevel_1.png" style="width:150px;border:1px solid; border-radius:100%">
                        </c:when>
                        <c:when test="${content.sitterCount == 2}">
                           <img src="../resources/img/sitterLevel_Bronze.png" style="width:150px;border:1px solid; border-radius:100%">
                        </c:when>
                        <c:when test="${content.sitterCount == 3}">
                           <img src="../resources/img/sitterLevel_Silver.png" style="width:150px;border:1px solid; border-radius:100%">
                        </c:when>
                        <c:when test="${content.sitterCount == 4}">
                           <img src="../resources/img/sitterLevel_Gold.png" style="width:150px;border:1px solid; border-radius:100%">
                        </c:when>
                       </c:choose>
                    
                    <!-- 시터 nick -->
                    <div class="row mt-4" >
                       <h3>${content.memberVo.nick }</h3>              
                    </div>
                    <div class="row mt-3">
                       <h4>${content.boardVo.content }</h4>
                    
                    </div>
                 </div>
                 
               <div class="col"></div>
            </div>
            <div class="row" style="background-color:#F6F6F6;color:#FFFFFF;">
               <div class="col">
                  &nbsp;
               </div>
            </div>
            <div class="row" style="background-color:#F6F6F6;color:#FFFFFF;" >
               <div class="col">
                  시터횟수 : ${content.sitterCount}
               </div>
               <div class="col">
                         <c:choose>
                           <c:when test="${!empty content.boardVo.endDate }">
                                 마감기한 : <fmt:formatDate value="${content.boardVo.endDate }" pattern="yy년MM월dd일"/>
                           </c:when>
                           <c:otherwise>
                                 마감기한 : 없음
                           </c:otherwise>
                        </c:choose>
               </div>
            </div>
            <div class="row" style="background-color:#F6F6F6;">
               <div class="col">
                  시터티어 :    
                  <c:choose>
                        <c:when test="${content.sitterCount == 0}">
                           비기너
                        </c:when>
                        <c:when test="${content.sitterCount == 1}">
                           노멀
                        </c:when>
                        <c:when test="${content.sitterCount == 2}">
                           브론즈
                        </c:when>
                        <c:when test="${content.sitterCount == 3}">
                           실버
                        </c:when>
                        <c:when test="${content.sitterCount == 4}">
                           골드
                        </c:when>
                       </c:choose>
                </div>
                <div class="col">
                   가능지역 : ${content.boardVo.possibleArea }
                </div>
            </div>
            <div class="row" style="background-color:#F6F6F6;">
               <div class="col">
                  &nbsp;
               </div>
            </div>
               
            
            <div class="row">
               <div class="col" style="text-align:right;">
                  <input type="button" id="sitterStatusBtn"
                        class = "btn btn-primary"
                        data-bs-toggle="modal" 
                        data-bs-target="#sitterRequestModal"
                        value="신청"
                        data-value1="${content.boardVo.sitterboard_no}" 
                        data-value2="${content.boardVo.member_no}"
                        data-value3="${content.boardVo.endDate}"
                        style="border:0px;font-size:13px;">
               </div>
            </div>
            
                 <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
            <div class="row mt-3">      
               <c:if test="${!empty sessionUser  && sessionUser.member_no == content.memberVo.member_no }">
                  <div class="col-8"></div>
                   <!-- boardVo_member_no써도 상관없음   -->
                 
               </c:if>
            </div>
               <hr>
            <div class="row">
               <i id="emptyHeart" class="bi bi-heart text-danger fs-1" onclick="processRecommend()"></i>
               <i id="fillHeart" class="bi bi-heart-fill text-danger fs-1 d-none" onclick="processRecommend()"></i> 
            </div>
               <!-- <i class="bi bi-heart-fill text-danger fs-1"></i>  -->
            <div class="row">
               <div class="col-10">
               좋아요 수 : <span id="totalCountBox"></span>
               </div>
                <div class="col" style="text-align:right;"><a style="text-decoration-line:none;color:#004ba0;" href="./deleteContentProcess.do?sitterboard_no=${content.boardVo.sitterboard_no }"><i class="bi bi-trash-fill"></i>삭제</a></div> 
                <div class="col" style="text-align:right;"><a style="text-decoration-line:none;color:#004ba0;" href="./updateHE_SitterPage.do?sitterboard_no=${content.boardVo.sitterboard_no }"><i class="bi bi-box-arrow-in-up"></i>수정</a></div>
            </div>
            <div class="row mt-2">
               <div class="col" style="text-align:right;">
                     <a href="./readHE_SitterPage.do" style="text-decoration-line:none;color:#004ba0;"><i class="bi bi-list"></i>목록 </a>
               </div>
            </div>   
            
               <c:if test="${!empty sessionUser}">
                  <form action="writeCommentProcess.do">
                        <div class="row">
                           <div class="col-10">
                              <input type="hidden" name="sitterboard_no" value="${content.boardVo.sitterboard_no }">
                              <input type="text" class="form-control" name= "comment_content" value="" placeholder="댓글을 입력하세요." required>
                           </div>
                           <div class="col">
                              <button class="btn" style="width:100%;background-color:#004ba0;border-color:#004ba0;color:#ffffff">입력</button>
                           </div>
                        </div>
                  </form>
               </c:if>   
                  <hr>   
               <div class="row">
               <h6>댓글 수 : ${commentCount }</h6>
               </div>
                  <hr>
               <div class="row mt-1">
                  <c:forEach items="${comment }" var="comment">
                     
                        <div class="row mb-1">
                           <div class="col-3"> ${comment.memberVo.nick }</div>
                           <div class="col"></div>
                           <div class="col-3" style="text-align:right;">작성일  : <fmt:formatDate value="${comment.commentVo.writeDate }" pattern="MM.dd" /> </div>
                        </div>
                     
                     
                        <div class="row">
                           <c:choose>
                              <c:when test="${comment.memberVo.gender == 'M' }">
                                 <div class="col-1"><i class="bi bi-person-fill"></i></div>
                              </c:when>
                              <c:otherwise>
                                 <div class="col-1"><i class="bi bi-person"></i></div>
                              </c:otherwise>
                           </c:choose>
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
                                 <input type="hidden" name="sitterboard_no" value="${content.boardVo.sitterboard_no }">
                                 </form>
                              </div>
                              <div class="col-1">   
                                 <form action="updateHE_sitterBoardCommentPage.do" method="get">
                                 <button class="btn btn-primary"><i class="bi bi-pen"></i></button>
                                 <input type="hidden" name="comment_no" value="${comment.commentVo.comment_no }">
                                 <input type="hidden" name="sitterboard_no" value="${content.boardVo.sitterboard_no }">
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
               </div>   
            <div class="col"></div>
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