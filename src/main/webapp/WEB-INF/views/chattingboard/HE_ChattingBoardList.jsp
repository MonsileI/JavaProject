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
/*pagination*/
   .my.pagination > .active > a, 
   .my.pagination > .active > span, 
   .my.pagination > .active > a:hover, 
   .my.pagination > .active > span:hover, 
   .my.pagination > .active > a:focus, 
   .my.pagination > .active > span:focus {
     background: #004ba0;
     border-color: #004ba0;
}
</style>
</head>
<!-- NAVBAR
================================================== -->
<body>

   <!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>
   
   
   <div style="width:1100px; margin: 100px auto;">
      <div class="row">
         <div class="col"></div>
         <div class="col-8">
            <div class="row mt-5"><!-- 배너 -->
               <div class="col">배너 공간</div>
            </div>
            <form action="HE_ChattingBoardList.do" method="get">
            <div class="row mt-2"><!--  검색 -->
               <div class="col">
                  <select name="search_type" class="form-select">
                     <option value="title">제목</option>
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
            <div class="row mt-3"><!--  데이터 테이블 -->
               <div class="col">
                  <table class="table">
                     <tr>
                        <td>채팅방 번호</td>
                        <td>방 제목</td>
                        <td>개설자</td>
                        <td>개설일</td>
                     </tr>
                     <tr>
                        <c:forEach items="${contentList }" var="data">
                           <tr>
                              <td>${data.boardVo.chattingboard_no }</td>
                              <td><a href="./joinChattingRoomPage.do?chattingboard_no= ${data.boardVo.chattingboard_no }">${data.boardVo.title }</a></td>
                              <td>${data.memberVo.nick }</td>
                              <td><fmt:formatDate value="${data.boardVo.writedate }" pattern="MM.dd" /></td>
                           </tr>
                        </c:forEach>
                     
                     </tr>
                  </table>
               </div>
            </div>
                  <div class="row mt-2"><!-- 페이징 및 글쓰기 버튼 -->
                        <div class="col-2"></div>
                  <div class="col">
 					<nav aria-label="Page navigation example">
                       <ul class="pagination mb-0 pagination my">
                          
                            <c:choose>
                                <c:when test="${beginPage <= 1 }">
                                   <li class="page-item disabled"><a class="page-link" href="./HE_ChattingBoardList.do?page_number=${beginPage-1 }${addParam}">&lt;</a></li>
                                </c:when>
                                <c:otherwise>
                                   <li class="page-item"><a class="page-link" href="./HE_ChattingBoardList.do?page_number=${beginPage-1 }${addParam}">&lt;</a></li> <!-- 비긴 페이지 ex)6에서 1빼줘야지 -->
                                </c:otherwise>
                             </c:choose>
                            
                            <c:forEach begin="${beginPage }" end="${endPage }" var = "i"> <!-- begin end 반복문임!!!! 여기서 반복 설정 -->
                                  <c:choose>
                                     <c:when test="${currentPage == i }">
                                        <li class="page-item active"><a class="page-link" href="./HE_ChattingBoardList.do?page_number=${i }${addParam}">${i }</a></li> <!-- 현재 클릭한 페이지 -->   
                                     </c:when>
                                     <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="./HE_ChattingBoardList.do?page_number=${i }${addParam}">${i }</a></li>
                                     </c:otherwise>
                                  </c:choose>
                                  
                            </c:forEach>
                            <c:choose>
                                <c:when test="${endPage >= totalPageCount }">
                                   <li class="page-item disabled"><a class="page-link" href="./HE_ChattingBoardList.do?page_number=${endPage +1 }${addParam}">&gt;</a></li><!-- 엔드 페이지ex)10에서 1더해줘야지 -->
                                </c:when>
                                <c:otherwise>
                                   <li class="page-item"><a class="page-link" href="./HE_ChattingBoardList.do?page_number=${endPage+1 }${addParam}">&gt;</a></li>
                                </c:otherwise>
                             </c:choose>
                          </ul>
                     </nav>
                  </div>
               <div class="col-2 d-grid">
                  <c:if test="${!empty sessionUser }">
                  <a class = "btn" style="background-color:#004ba0;border-color:#004ba0;color:#ffffff" href="./HE_MakeChattingPage.do">글쓰기</a> <!-- d-grid : 공간 꽉꽉 채우는거(보통 버튼 만들땐 이거 쓰자) -->
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
</html>s