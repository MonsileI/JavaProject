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

<script type="text/javascript" src="../resources/js/lostdogBoard.js"></script>

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
</head>

<body>

   <!-- top menu -->
   <jsp:include page="../include/header.jsp"></jsp:include>
   
   <!-- side menu -->
   <jsp:include page="../include/side.jsp"></jsp:include>

   
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
                   <a href="./lostdogList.do" style="text-decoration-line:none;text-decoration-line:none;color:#004ba0;"><i class="bi bi-list"></i>목록 </a>
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
                  <div class = "col" style="text-align:right;">
                          <c:choose>
                              <c:when test="${!empty sessionUser}">
                                  <c:choose>
                                     <c:when test="${sessionUser.member_no eq content.boardVo.member_no and content.boardVo.status eq 'ING'}">
                                        <input type="button" class = "btn btn-light" id="lostdogCompleteBtn" value="완료" onclick="completeLostdog(this);" 
                                        		style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                        			border-width:2px;border-color:#004ba0;">
                                        <input type="button" class = "btn btn-light" id="lostdogStatusBtn" value="진행중"
                                        		style="width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                        			border-width:2px;border-color:#004ba0;" disabled>
                                     </c:when>
                                     <c:when test="${sessionUser.member_no ne content.boardVo.member_no and content.boardVo.status eq 'ING'}">
                                 		<input type="button" class = "btn btn-light" id="lostdogStatusBtn" value="진행중" 
                                 				style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                        			border-width:2px;border-color:#004ba0;"disabled>
                                     </c:when>
                                     <c:when test="${sessionUser.member_no eq content.boardVo.member_no and content.boardVo.status eq 'Y'}">
                                     	<input type="button" class = "btn btn-light" id="lostdogCompleteBtn" value="완료취소" onclick="completeLostdog(this);"
	                                     		style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
	                                  			border-width:2px;border-color:#004ba0;">
										<input type="button" class = "btn btn-light" id="lostdogStatusBtn" value="완료" 
	                                     		style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
	                                  			border-width:2px;border-color:#004ba0;"disabled>
									</c:when>
									<c:when test="${sessionUser.member_no ne content.boardVo.member_no and content.boardVo.status eq 'Y'}">
										<input type="button" class = "btn btn-light" id="lostdogStatusBtn" value="완료" 
                                             	style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
		                                        			border-width:2px;border-color:#004ba0;" disabled>   
		                             </c:when>
                                 </c:choose>
                            </c:when>
                            <c:otherwise>
                            <c:choose>
                               	<c:when test="${content.boardVo.status eq 'ING'}">
                                            <input type="button" class = "btn btn-light" id="lostdogStatusBtn" value="진행중"  
                                            		style="margin-right:10px;width:80px;height:60px;font-size:17px;font-weight:bold;background-color:#ffffff;color:#004ba0;
                                        			border-width:2px;border-color:#004ba0;"	disabled>
                                         </c:when>
                                       <c:when test="${content.boardVo.status eq 'Y'}">
                                             <input type="button" class = "btn btn-light" id="lostdogStatusBtn" value="완료" 
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
         
         
         <div class="row">
            
         </div>
         <div class="row mt-3" style=" padding:7px;  background-color:#F8F9FA;">
            <div class="col">
               <c:if test="${!empty content.boardVo.content }">
                  <div class="row">&nbsp;내용</div>
                  <div class="row mt-4">
                  </div>
                  <div class="row">
                  </div>
                  <div class="row-8">${content.boardVo.content }</div>
                     </c:if>
            </div>
            
        <div class="col" style="margin-top:10px;">
               <div class="row" style="color:#004ba0;">
                     <c:if test="${!empty content.boardVo.lostDate }">
                     	<span><i class="bi bi-calendar-check" style="font-weight:bold;"></i>&nbsp;&nbsp;&nbsp;잃어버린 날짜 &nbsp;|&nbsp; <fmt:formatDate  value="${content.boardVo.lostDate}" pattern="yy년 MM월 dd일"/></span>
                     </c:if>      
               </div>
               <div class="row" style="color:#004ba0;">
                  <c:if test="${!empty content.boardVo.lostPlace }">
                  	<span><i class="bi bi-pin-map-fill" style="font-weight:bold;"></i>&nbsp;&nbsp;&nbsp;잃어버린 장소&nbsp; |&nbsp; ${content.boardVo.lostPlace }</span>
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
                     <i id="emptyHeart" class="bi bi-heart text-danger fs-1" onclick="processRecommend()"></i>
                     <i id="fillHeart" class="bi bi-heart-fill text-danger fs-1 d-none" onclick="processRecommend()"></i> 
               </div>
               <span id="totalCountBox"></span>
                  <div class="row mb-1">
                        <c:if test="${!empty sessionUser  && sessionUser.member_no == content.memberVo.member_no }">
                           <div class="col-10"></div>
                      <!-- boardVo_member_no써도 상관없음   -->
                           <div class="col-1"><a style="text-decoration-line:none;color:#004ba0;" href="./deleteContentProcess.do?lostdogboard_no=${content.boardVo.lostdogboard_no }"><i class="bi bi-trash-fill"></i>삭제</a></div> <!-- 얘는 걍 삭제만 되면 됨 -->
                           <div class="col-1"><a style="text-decoration-line:none;color:#004ba0;" href="./updateHE_LostDogPage.do?lostdogboard_no=${content.boardVo.lostdogboard_no }"><i class="bi bi-box-arrow-in-up"></i>수정</a></div><!--  얘는 뭔가 페이지가 있어야됨 -->
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
                                          <button class="btn btn-secondary" style="width:100%;background-color:#004ba0;border-color:#004ba0;color:#ffffff" onclick="writeComment()" >입력</button>
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