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

<style>
/*pagination*/
   .my.pagination > .active > a, 
   .my.pagination > .active > span, 
   .my.pagination > .active > a:hover, 
   .my.pagination > .active > span:hover, 
   .my.pagination > .active > a:focus, 
   .my.pagination > .active > span:focus {
     background: #004ba0;
     border-color:#004ba0;
}

</style>


<script>

//var sitterboard_no =  ${content.boardVo.sitterboard_no};

var myFinddogAuthority = null;

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


function init(){
   checkSession();
}

</script>

</head>
<!-- NAVBAR
===================== -->
<body onload="init()">

   <!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>

   
   <div style="width:1800px; margin:100px auto;">
      <div class="row">
         <!--  -->
         <div class="col"></div>
         <div class="col-8">
            <div class="row mt-5 mb-3"><!-- 배너 -->
               <div class="col"></div>
               <div class="col-8" style="text-align:center;"><h1>임시보호 요청하세요</h1></div>
               <div class="col"></div>
            </div>
            
                  
			<form action="./HE_SitterBoardList.do" method="get">
               <div class="row mt-3 mb-3"><!--  검색 -->
                  <div class="col">
                     <select name="search_type" class="form-select">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="nick">닉네임</option>
                     </select>
                  </div>

               <div class="col-9">
                  <input type="text" class="form-control" name= "search_word" value="" placeholder="검색해보세요.">
               </div>
               <div class="col" style="text-align:right;">
                  <input type="submit" value="검색" class="btn" style="width:100%;background-color:#004ba0;border-color:#004ba0;color:#ffffff">
               </div>
            </div>
         
            <div class="row mt-5">
               <div class="col mt-3"></div>
            </div>
            
            
            <div class="row mt-4">
               <c:forEach items="${contentList }" var="data">
                  <div class="row" style="width:300px; height:400px;margin-left:10px;">
                     <div class="col"></div>
                      <div class="col-8" style="text-align:center;">
                             <div class="row-4" style="font-size:20px;">
                              <a style="text-decoration-line:none;" href="./readHE_SitterPage.do?sitterboard_no= ${data.boardVo.sitterboard_no }">
                              ${data.memberVo.nick}
                              </a>
                          </div>
                          <div class="row-8 mt-2">
                             <div class="col"></div>
                             <div class="col">
                                <c:choose>
                                   <c:when test="${data.sitterCount == 0}">
                                      <img src="../resources/img/sitterNormal.png" style="width:150px;">
                                   </c:when>
                                   <c:when test="${data.sitterCount == 1}">
                                      <img src="../resources/img/sitterLevel_1.png" style="width:150px;">
                                   </c:when>
                                   <c:when test="${data.sitterCount == 2}">
                                      <img src="../resources/img/sitterLevel_Bronze.png" style="width:150px;">
                                   </c:when>
                                   <c:when test="${data.sitterCount == 3}">
                                      <img src="../resources/img/sitterLevel_Silver.png" style="width:150px;">
                                   </c:when>
                                   <c:when test="${data.sitterCount == 4}">
                                      <img src="../resources/img/sitterLevel_Gold.png" style="width:150px;">
                                   </c:when>
                                </c:choose>
                             </div>
                             <div class="col-3"></div>
                          </div>
                          <div class="row" style="background-color: #5587ED;border-radius:5%">
                             <div class="col">
                                <div class="row">&nbsp;</div>
                                <div class="row-9">
                                     ${data.boardVo.title }
                                  </div>
                                  <div class="row-1" style="font-weight:bold" >
                                     시터횟수 : ${data.sitterCount}
                                  </div>
                                  <div class="row">&nbsp;</div>
                               </div>
                          </div>
                           </div>
                        <div class="col"></div>
                   </div> 
               </c:forEach>
            </div>
            
         
         
            <div class="row"><!-- 페이징 및 글쓰기 버튼 -->
               <div class="col-2"></div>
               <div class="col">
 					<nav aria-label="Page navigation example">
                       <ul class="pagination mb-0 pagination my">
                       
                         <c:choose>
                             <c:when test="${beginPage <= 1 }">
                                <li class="page-item disabled"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${beginPage-1 }${addParam}">&lt;</a></li>
                             </c:when>
                             <c:otherwise>
                                <li class="page-item"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${beginPage-1 }${addParam}">&lt;</a></li> <!-- 비긴 페이지 ex)6에서 1빼줘야지 -->
                             </c:otherwise>
                          </c:choose>
                         
                         <c:forEach begin="${beginPage }" end="${endPage }" var = "i"> <!-- begin end 반복문임!!!! 여기서 반복 설정 -->
                               <c:choose>
                                  <c:when test="${currentPage == i }">
                                     <li class="page-item active"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${i }${addParam}">${i }</a></li> <!-- 현재 클릭한 페이지 -->   
                                  </c:when>
                                  <c:otherwise>
                                     <li class="page-item"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${i }${addParam}">${i }</a></li>
                                  </c:otherwise>
                               </c:choose>
                               
                         </c:forEach>
                         <c:choose>
                             <c:when test="${endPage >= totalPageCount }">
                                <li class="page-item disabled"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${endPage +1 }${addParam}">&gt;</a></li><!-- 엔드 페이지ex)10에서 1더해줘야지 -->
                             </c:when>
                             <c:otherwise>
                                <li class="page-item"><a class="page-link" href="./HE_SitterBoardList.do?page_number=${endPage+1 }${addParam}">&gt;</a></li>
                             </c:otherwise>
                          </c:choose>
                       </ul>
                  </nav>
               </div>
               <div class="col-2 d-grid">
                  <c:if test="${!empty sessionUser }">
                  <a class = "btn" style="background-color:#004ba0;border-color:#004ba0;color:#ffffff" href="./writeHE_SitterPage.do">글쓰기</a> <!-- d-grid : 공간 꽉꽉 채우는거(보통 버튼 만들땐 이거 쓰자) -->
                  </c:if>
               </div>
            </div>
         </form><!-- 검색 폼태그 -->
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