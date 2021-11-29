<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="icon" href="../favicon.ico">

<link rel="canonical" href="https://getbootstrap.kr/docs/5.0/examples/carousel/">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
<!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.0/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg">
<link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">


</head>


<body>

<script>

	var carousel_Modal = null;
	

	function openCarouselModal(btn,finddog){
		
		console.log(btn.id + finddog);
		carousel_Modal.show();

	function init(){
		carousel_Modal = new bootstrap.Modal(document.getElementById('carousel_Modal'));
		
	} 
	
	window.addEventListener('DOMContentLoaded', init);
	
	
</script>
 <!-- 테스트로 finddogBoard 최근 글 1개 띄우기 Modal -->
  <div class="modal fade" id="carousel_Modal" tabindex="-1" aria-labelledby="testModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="testModalLabel">Modal title</h5>

          <button type="button" 
	          class="btn-close" 
	          id="" data-bs-dismiss="modal" 
	          aria-label="Close"></button>
        </div>
        
        <div class="modal-body">
                    <c:forEach items="${finddogBoardList}" var="finddog" begin="0" end="0" >
		
			<div class="col">
			
				<c:choose>
					<c:when test="${!empty finddog.imageVo.imageboard_url}">
						<img class="img-circle"
						src="/upload/${finddog.imageVo.imageboard_url}"
						alt="Generic placeholder image" width="250" height="250">
					</c:when>
					<c:otherwise>
						<img class="img-circle"
						src="../resources/img/8.jpeg"
						alt="Generic placeholder image" width="250" height="250">
					</c:otherwise>
				</c:choose>
				
				<h2>${finddog.boardVo.title}</h2>
				<p>${finddog.boardVo.writeDate}</p>
				<p>
					<a class="btn btn-default" href="../finddogboard/readHE_FinddogPage.do?finddogboard_no=${finddog.boardVo.finddogboard_no}" role="button">상세보기
						&raquo;</a>
				</p>
			</div>
		
			
		
		</c:forEach>
                    
        </div>
       
      </div>
    </div>
  </div>
  
  

  
	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 1. Carousel start ================================================== -->
	
	<div style="width:1800px; margin: 100px auto;">
		<div class="row-12 justify-content-center">
	
			<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" 
						style="margin-top:100px;margin-bottom:50px;">
				  
				  <div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
				    
				  </div>
				  
				  <div class="carousel-inner">
				  
				  	<div class="carousel-item active" style="height:470px;background-color:#005ae6;text-align:center;">
			
				    			<Button onclick="openCarouselModal(this, ${finddogTotalList[0].boardVo.finddogboard_no})" id="carousel_one" style="margin-left:450px;">
				      				<img src="../resources/img/dog1.jpg" class="d-block w-100" alt="..." style="height:470px;background-size:auto;">
				    			</Button>
				    
				    <div class="container">
		          		<div class="carousel-caption text-start">
				            <h1>사랑스러운 반려견의 가족이 되어주세요.</h1>
				            <p style="font-size:20px;"></p>
				          </div>
		       		</div>		
				    	
				    	
				     <div class="carousel-caption d-none d-md-block">
				      </div>
				    </div>
				    <div class="carousel-item" style="height:470px;background-color:#6da0ce;text-align:left;">
				    	<Button onclick="openCarouselModal(this,${finddogTotalList[1].boardVo.finddogboard_no})" id="carousel_two" style="margin-left:250px;">
				      		<img src="../resources/img/dog2.jpg" class="d-block w-100" alt="..." style="height:470px;background-size:auto;">
				    	</Button>
				    	
				    	
				    <div class="container"  >
		          		<div class="carousel-caption text-end">
				            <h1>456 마리 -> 1045 마리 </h1>
				            <p style="display:inline;font-size:20px;">여름철 서울 유기견 수 '2배로 증가' - 서울시 생활경제과 통계</p>
				            <p style="display:inline;font-size:20px;">유기견 수가 급격히 증가하는 휴가철. 지금 이 순간에도 많은 개들이 자신의 재능을 꽃 피워보지도 못하고 마지막을 준비하고 있습니다.</p>
				          </div>
		       		</div>	
				    	
				      <div class="carousel-caption d-none d-md-block"></div>
				    </div>
				    
				    <div class="carousel-item" style="height:470px;background-color:#ff6666;text-align:left"><!-- 669966 -->
				    	<Button onclick="openCarouselModal(this,${finddogTotalList[2].boardVo.finddogboard_no})" id="carousel_three"  style="margin-left:200px;">
				      		<img src="../resources/img/dog3.jpg" class="d-block w-100" alt="..." style="background-size:auto;height:470px;">
				    	</Button>
				    	
				    	
				    <div class="container" >
		          		<div class="carousel-caption text-end">
				            <h1>유기견에서 반려견으로</h1>
				            <p style="font-size:20px;">사지말고 입양하세요!</p>
				          </div>
		       		</div>	
				    	
				      <div class="carousel-caption d-none d-md-block"></div>
				    </div>
				    
				  </div>
				  
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden" >Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				
				</div>
			</div>
		</div>
	<!-- 1. carousel end-->
	
	
	  <div style="width:1800px; margin: 100px auto;">
	  
	      <div class="row justify-content-center">
	         <div class="col-8">
	         
				<!-- 2. start -->
				
				<div class="row justify-content-center">
				
				
					<div class="col-12" style="margin-bottom:50px;">
					<!-- 광고 start-->
						<div class="row" style="height:150px;background-color:#1F51B7;">
						    <div class="col" style="margin-top:20px;margin-left:10px;text-align:left;color:#ffffff;">
					            <a href="#" style="text-decoration-line:none;color:#ffffff;font-size:40px;">
					            	단체소개 보러가기 <i class="bi bi-arrow-right"></i>
					            </a>
					            <p style="font-size:13px;">우리 커뮤니티는 정부후원금 없이 오직 시민의 후원으로 활동합니다.한국 애견보호가이드센터에서 동물단체 중 유일하게 책무성 및 투명성, 재무안정성 및 효율성 모두 최고 별점을 받았습니다.</p>
							</div>
						</div>
					</div>
					<!-- 광고 end-->
			
				
					<div class="col py-3" style="background-color:#6aaae4;color:#FFFFFF;margin-bottom:50px;border-radius:1%;">
						<h5 style="text-align:left;">주인을 찾습니다</h5>
				 	</div>
				 </div>
			
				<div class="container marketing" style="margin-top:10px;justify-content:center;text-align:center;">
		
					<div class="row">
					
						<!-- finddogBoard 최신글 3개만 보여주기 -->
						<c:forEach items="${finddogBoardList}" var="finddog" begin="0" end="3" >
						
							<div class="col">
							
								<c:choose>
									<c:when test="${!empty finddog.imageVo.imageboard_url}">
										<a href="../finddogboard/readHE_FinddogPage.do?finddogboard_no=${finddog.boardVo.finddogboard_no}">
										<img class="img-circle"
										src="/upload/${finddog.imageVo.imageboard_url}"
										alt="Generic placeholder image" width="200" height="200" style="border-radius:5%;"></a>
									</c:when>
									<c:otherwise>
										<a href="../finddogboard/readHE_FinddogPage.do?finddogboard_no=${finddog.boardVo.finddogboard_no}">
										<img class="img-circle"
										src="../resources/img/8.jpeg"
										alt="Generic placeholder image" width="200" height="200" style="background-color:#F6F6F6;border-radius:5%;"></a>
									</c:otherwise>
								</c:choose>
								
								<h6 style="margin-top:30px;"><a href="../finddogboard/readHE_FinddogPage.do?finddogboard_no=${finddog.boardVo.finddogboard_no}"
										style="text-decoration-line:none;font-size:15px;color:#333333;">${finddog.boardVo.title}</a></h6>
								<p style="font-size:10px;color:#909090;"><fmt:formatDate value="${finddog.boardVo.writeDate}" pattern="yy/MM/dd"/></p>
				
							</div>
						
						
						</c:forEach>
					</div>

				</div>
				
				
			</div>
			</div>
		</div>
		
		<!-- 2. end-->
		
		
		<!-- 시터 게시판 시작 -->
	<div style="width:1800px; margin: 100px auto;">
	  
	      <div class="row justify-content-center" style="background-color:#F6F6F6;">
	         <div class="col-8">
	         
	         
	         	<div class="row justify-content-center">
				
					<div class="col py-3" style="background-color:#6aaae4;color:#FFFFFF;margin-top:50px;border-radius:1%;">
						<h5 style="text-align:left;">임시보호자</h5>
				 	</div>
				 </div>
	         
	         
	         	<div class="container marketing" style="margin-top:10px;justify-content:center;text-align:center;">
		
					<div class="row">
						<!-- sitterBoard 최신글 3개만 보여주기 -->
						
						
						 <!-- sitterBoard 최신글 3개만 보여주기 -->
               <c:forEach items="${sitterList}" var="sitter" begin="0" end="4" >
               
                  <div class="col" style="text-align:center;">
                     <c:choose>
                                   <c:when test="${sitter.sitterCount == 0}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterNormal.png"
                                      alt="Generic placeholder image" width="80" height="80" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 1}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_1.png"
                                       alt="Generic placeholder image" width="80" height="80" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 2}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_Bronze.png"
                                       alt="Generic placeholder image" width="80" height="80" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 3}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_Silver.png"
                                       alt="Generic placeholder image" width="80" height="80" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 4}">
                                         <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_Gold.png"
                                       alt="Generic placeholder image" width="80" height="80" style="border-radius:5%;"></a>
                                   </c:when>
                                </c:choose>
                     
                     
                     <!--h6 style="margin-top:20px;"><a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}"
                           style="text-decoration-line:none;font-size:15px;color:#333333;">${sitter.boardVo.title}</a></h6-->
                     <h6 style="margin-top:5px;text-align:center"><a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}"
                           style="text-decoration-line:none;font-size:15px;color:#333333;">
                           ${sitter.memberVo.nick}</a></h6>
                     <p style="font-size:10px;color:#909090;text-align:center"><fmt:formatDate value="${sitter.boardVo.writeDate}" pattern="yy/MM/dd"/></p>
         
                  </div>
               
               
               </c:forEach>
						
						
						
					</div>

				</div>
	         
	        
        	</div>
		</div>
	</div> 
	<!-- 시터 게시판 끝 -->
		
		
		
		<div style="width:1800px; margin: 100px auto;">
	 
	      <div class="row justify-content-center">
	         
	         <div class="col-8">
	        
	
				<!-- 3. start-->
				<div class="row justify-content-center">
					<div class="col py-3" style="background-color:#6aaae4;color:#FFFFFF;border-radius:1%;margin-bottom:30px;">
						<h5 style="text-align:left;">정보</h5>
				 	</div>
				</div>		
				
				
				<div class="row" style="margin-top:10px;">
					<div class="col-7">
					
					
						<div>
								<ul class="nav nav-tabs" id="myTab" role="tablist">
			  						<li class="nav-item" role="presentation">
		
					   				<li>
					    				<button class="nav-link" id="tabBody2-tab" data-bs-toggle="tab" data-bs-target="#tabBody2" 
					    						type="button" role="tab" aria-controls="tabBody2" aria-selected="false"
					    						style="width:150px;margin:0px;border-color:#FFFFFF;background-color:#EAEAEA;color:#333333;text-decoration-line:none;">
					    						
					    					공지사항
					    				</button>
					   				</li>
					   				<li>
					  				 	<button class="nav-link" id="tabBody3-tab" data-bs-toggle="tab" data-bs-target="#tabBody3" 
					    						type="button" role="tab" aria-controls="tabBody3" aria-selected="false"
					    						style="width:150px;margin:0px;border-color:#FFFFFF;background-color:#EAEAEA;color:#333333;text-decoration-line:none;">
					    						
					    					보도자료
					    				</button>
					   				</li>
					   			</ul>
					   		</div>
					   	<!--하부 contents 영역 start-->
						<div class="container" >
					
						
							<!--===================전체 tabBody 영역 start===================-->
							<div class="tab-content" id="nav-tabContent">
						
						
		
		 				<!--===================tab2. 공지사항 영역 end===================-->
		                  <div class="tab-pane fade show active" id="tabBody2" role="tabpanel" aria-labelledby="tabBody2-tab">
		                  
		                  <!--=================== start===================-->
		                     <div>
		                        <!-- 글 목록 불러오기 start-->
		                        <div>
		                           
		                           <table class="table">
		                              <tr>
		                                 <th class="col">번호</th>
		                                 <th class="col-md-8">제목</th>
		                                 <th class="col">작성자</th>
		                                 <th class="col">작성일</th>
		                              </tr>
		                                    
		                              <c:forEach items="${noticeList}" begin="0" end="3" var="data">
		                                 <tr>
		                                    <td class="col" style="color:#909090;">
		                                                   ${data.boardVo.noticeboard_no}
		                                    </td>
		                                    <td class="col-md-8" style="color:#909090;">
		                                    	<a href="../noticeboard/readHE_NoticePage.do?noticeboard_no=${data.boardVo.noticeboard_no}"
		                                    		style="text-decoration-line:none;color:#909090;"
		                                   		 >${data.boardVo.title}</a></td>
		   
		                                    <td class="col" style="color:#909090;">
		                                       ${data.memberVo.nick }
		                                    </td>
		                                    <td class="col" style="color:#909090;"><fmt:formatDate value="${data.boardVo.writeDate}" pattern="MM.dd" /></td>
		                                 </tr>
		                              </c:forEach>
		                           </table>
		                        </div>
		                        <!-- 글 목록 불러오기 end-->
		                           
		                        </div>
		                        <!--=================== end===================-->
		                        
		                     </div>
		                     
		                     
		                     
		                     
		                     
		                     <!--===================tab2. 공지사항 영역 end===================-->
		
									
									<!--===================tab2. 보도자료 영역 end===================-->
									<!--===================tab2. 보도자료 영역 end===================-->
									
										
							</div>
						</div>
					</div>
					<!-- 3_1. end -->
			   		
			   		
					<!-- 3_2. start -->
					
					<div class="col" style="margin-left:20px;float:right;">
		
						<iframe id="player" type="text/html" width="380" height="250"
						  src="http://www.youtube.com/embed/videoID"
						  frameborder="0"></iframe>
						  
						<!-- p>
							<a class="btn btn-default" href="#" role="button">View details
								&raquo;</a>
						</p-->
					
					</div>
		
					
				</div>
			</div>
		</div>
					<!-- 3_2. end -->
			
		<div style="width:1800px; margin: 100px auto;">
	 
	      <div class="row justify-content-center" style="background-color:#EBF7FF">

	         <div class="col-8">
	         
	         
				   <div class="row justify-content-center">
				      <div class="col py-3" style="background-color:#6aaae4;color:#FFFFFF;border-radius:1%;margin-bottom:50px;margin-top:50px;">
				         <h5 style="text-align:left;">강아지를 찾습니다</h5>
				       </div>
				    </div>
				
				      
				      
				      <div class="row mt-3">
				               <c:forEach items="${lostdogBoardList }" var="data" begin="0" end="3">
				               
				               
				                 <div class="col">
				                <div class="thumbnail card" style="background-color:#6aaae4;border-width:1px;border-radius:3%;text-align:center;background-color:#F6F6F6;">
				                           <br>
				                <c:choose>
				                  <c:when test="${!empty data.imageVo.imageboard_url }">
				                     <img src="/upload/${data.imageVo.imageboard_url }"class="img-circle" style="border-radius : 20%;height: 200px; width: 200px; text-align:center; display:block; margin:auto;" ><br>   
				                  </c:when>
				                  <c:otherwise>
				                     <img src="../resources/img/8.jpeg"  class="img-circle" style="border-radius : 20%; height: 200px; width: 200px; display:block; margin:auto;"><br>   
				                  </c:otherwise>
				               </c:choose>
				                  <div class="caption">
				              <p><a href="../lostdogboard/readHE_LostDogPage.do?lostdogboard_no=${data.boardVo.lostdogboard_no }"
				               style="text-decoration-line:none;color:#090721">${data.boardVo.title }</a></p>
				
		
				              <h6 style="color: gray; "> 작성일 : <fmt:formatDate value="${data.boardVo.writeDate }" pattern="MM.dd" /></h6>
				                          <c:if test="${!empty data.boardVo.species_no}">
				                                 <c:forEach items="${speciesCategoryList}" var="pet">
				                                    <c:choose>
				                                    <c:when test="${pet.species_no eq data.boardVo.species_no}">
				                                       <h6 style="color: gray; "> 견종: ${pet.species}</h6>
				                                    </c:when>
				                                 </c:choose>      
				                              </c:forEach>
				                            </c:if>
				                            <c:if test="${data.boardVo.species_no eq -1}">
				                            	<h6 style="color: gray; "> 견종: 없음</h6>
				                           	</c:if>
		
				                            
				                 <div class="row">&nbsp;</div>           
				            </div>
				          </div>
				        </div>
				      
				      </c:forEach>
				      </div>
				      
				        <div class="row mt-3"  style="margin-top:150px;margin-bottom:200px;">
				               <c:forEach items="${lostdogBoardList }" var="data" begin="4" end="7">
				               
				               
				                 <div class="col">
				                <div class="thumbnail card" style="border-radius:3%;text-align:center;background-color:#F6F6F6;">
				                           <br>
				                <c:choose>
				                  <c:when test="${!empty data.imageVo.imageboard_url }">
				                     <img src="/upload/${data.imageVo.imageboard_url }"class="img-circle" style="border-radius : 20%;height: 200px; width: 200px; text-align:center; display:block; margin:auto;" ><br>   
				                  </c:when>
				                  <c:otherwise>
				                     <img src="../resources/img/8.jpeg"  class="img-circle" style="border-radius : 20%; height: 200px; width: 200px; display:block; margin:auto;"><br>   
				                  </c:otherwise>
				               </c:choose>
				                  <div class="caption">
				              <p><a href="../lostdogboard/readHE_LostDogPage.do?lostdogboard_no=${data.boardVo.lostdogboard_no }"
				               style="text-decoration-line:none;color:#090721">${data.boardVo.title }</a></p>
				
		
				              <h6 style="color: gray; "> 작성일 : <fmt:formatDate value="${data.boardVo.writeDate }" pattern="MM.dd" /></h6>
				                          <c:if test="${!empty data.boardVo.species_no}">
				                                 <c:forEach items="${speciesCategoryList}" var="pet">
				                                    <c:choose>
				                                    <c:when test="${pet.species_no eq data.boardVo.species_no}">
				                                       <h6 style="color: gray; "> 견종: ${pet.species}</h6>
				                                    </c:when>
				                                 </c:choose>      
				                              </c:forEach>
				                            </c:if>
				                            <c:if test="${data.boardVo.species_no eq -1}">
				                            	<h6 style="color: gray; "> 견종: 없음</h6>
				                           	</c:if>
		
				                            
				                 <div class="row" >&nbsp;</div>           
				            </div>
				          </div>
				        </div>
				      
				      </c:forEach>
				      </div>
				      
				   

		      <!-- 3. end -->
      
	
	
		
		
		
		
			</div>
			<!-- 3. end -->
		
				 </div>
			</div>
			
			
			
			<!-- 광고 시작 -->
			
			
					
		<div style="width:1800px; margin: 100px auto;">
	      <div class="row justify-content-center">
	         <div class="col-8">
	         
	         
	         
	         	<div class="row justify-content-center">
				
					<div class="col-12" style="margin-bottom:50px;">
					<!-- 광고 start-->
						<div class="row" style="height:200px;background-color:#ff6666;">
							<div class="col-8"> 
								<img src="../resources/mangae/img/dog.png" style="width:200px;margin-top:20px;margin-left:50px;">
							</div>
						    <div class="col" style="margin-top:20px;margin-left:10px;text-align:left;color:#ffffff;">
					            <a href="../shop/index.do" style="text-decoration-line:none;color:#ffffff;font-size:50px;">
					            	<i class="bi bi-arrow-left" ></i> 만개 쇼핑몰
					            </a>
						    	<p style="font-size:15px;">만개 쇼핑몰을 방문해 주세요. </p>
						    	<p style="font-size:15px;">회원님만의 상점을 개설하고 애견 용품을 거래할 수 있습니다.</p>     
							</div>
						</div>
					</div>
					<!-- 광고 end-->
			
				 </div>
	         
	         
	        	</div>
			</div>
		</div> 
			
			
			
			
			<!-- 광고 끝 -->
			
			
			
			
			
			
			
			
			
			
			
		</div>
	
		<!-- FOOTER -->
		
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
		<!-- Toast -->
	   	<jsp:include page="../include/toast.jsp"></jsp:include>
	   	
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
 	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
 		
</body>

</html>

