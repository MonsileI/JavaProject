<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!--======================= 외부 api ==============================================-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- 부트스트랩 5 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!--======================= custom ==============================================-->
<!-- custom css -->
<link rel="stylesheet" type="text/css" href="../resources/css/header.css">
<link rel="stylesheet" type="text/css" href="../resources/css/side.css">
<!-- custom js -->
<script src="../resources/js/notePage.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<!--======================= html ==============================================-->


<!-- address modal menu -->
<jsp:include page="../modal/address_Modal.jsp"></jsp:include>
<!-- group modal menu -->
<jsp:include page="../modal/editGroup_Modal.jsp"></jsp:include>
<!-- friend modal menu -->
<jsp:include page="../modal/editFriend_Modal.jsp"></jsp:include>


<!-- ------------------------------------------------------------- 1번째 navbar ----------------------------------------------------------------------- -->
<div style="width:1800px; margin: 100px auto;">
 
     <div class="row justify-content-center">
        <div class="col-12">
    
	       <nav class="navbar navbar-expand-lg">
	       
	        
	        <div class="container-fluid">
	          <div class="collapse navbar-collapse" id="navbarSupportedContent">
	          
	            <ul class="navbar-nav me-auto mb-4 mb-lg-0">
	            </ul>
	            
	            <!-- form class="d-flex">
	              <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
	              <button class="btn btn-outline-success" type="submit">Search</button>
	            </form-->
	            
	            <c:choose>
	               <c:when test="${!empty sessionUser}"> 
	                  <li class="dropdown mt-3" style="list-style:none;" >
	                  <li class="nav-item dropdown">
	                  <a class="nav-link dropdown-toggle" id="navbarDarkDropdownMenuLink" role="button"
	                  data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 13px;background-color:rgb(0,0,0,0);color:#909090;padding:0px;">${sessionUser.nick}님 환영합니다! </a>
	               <ul class="dropdown-menu dropdown-menu-dark dropdown-pull-right" id="dropdown_background" aria-labelledby="navbarDarkDropdownMenuLink" >
	                  <li><a class="dropdown-item" href="../mypage/myPage.do" style="font-size: 13px;color:#333333;">마이페이지</a></li>
	                  <li><a class="dropdown-item" href="../member/notePage.do" style="font-size: 13px;color:#333333;">쪽지함</a></li>
	                  <li><a class="dropdown-item" href="#myModal" data-bs-toggle="modal" style="font-size: 13px;color:#333333;">주소록</a></li>
	                  <li><a class="dropdown-item" href="../chattingboard/HE_ChattingBoardList.do" style="font-size: 13px;color:#333333 ;">채팅</a></li>
	               </ul>
	               </li>
	               
	               <li class="btn mt-3 ">
	                  <a href="../main/logoutProcess.do" style="font-size: 13px;text-decoration-line:none;color:#909090;">Sign out</a>
	               </li>
	            
	            </c:when>
	            <c:otherwise>
	               <!-- login -->
	               <li class="btn">
	                  <a href="../main/loginPage.do" id="signBtn" style="font-size: 13px;text-decoration-line:none;color:#909090;float:right;text-align:right;">Sign in</a>
	               </li>
	               <li class="btn">
	                  <a href="../main/joinMemberPage.do" style="font-size: 13px;padding-right: 50px;text-decoration-line:none;color:#909090;float:right;text-align:right;">Sign up</a>
	               </li>
	               <!--===================datetime===================!-->
	               
	               
	               
	            </c:otherwise>
	            
	         </c:choose>
	      
	          </div>
	        </div>
	      </nav>
  
   
	    <!-- ------------------------------------------------------------- 2번째 navbar ----------------------------------------------------------------------- -->
	   
	
	      <nav class="navbar navbar-expand-lg" ><!-- class="navbar navbar-expand-lg navbar-dark bg-dark" -->
	      
	         
	         <div class="container-fluid">
	        
	            <a class="navbar-brand-md" id="mainLogo" href="../main/main.do" style="font-size:35px;text-decoration-line:none;color:#004ba0;font-weight:bold;">
	            <img src="../resources/img/logo.png">ManGae</a>
	      
	            <div class="collapse navbar-collapse " id="navbarNavDarkDropdown">
	            
	            <!--  div  class="container justify-content-center"-->
	               <ul class="navbar-nav" ><!--  navbar-center -->
	      
	                    <li class="nav-item">
	                      <a class="nav-link" href="#" style="font-size: 20px;color:#333333 ;">단체소개</a>
	                    </li>
	            
	                  <li class="nav-item dropdown">
	                     <a class="nav-link dropdown-toggle" href="#"
	                     id="navbarDarkDropdownMenuLink" role="button"
	                     data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 20px;color:#333333 ;"> 힐링공간 </a>
	      
	                     <ul class="dropdown-menu dropdown-menu-dark" id="dropdown_background"
	                        aria-labelledby="navbarDarkDropdownMenuLink">
	                        <li><a class="dropdown-item" href="#" style="font-size: 13px;color:#333333 ;">강아지자랑</a></li>
	                        <li><a class="dropdown-item" href="#" style="font-size: 13px;color:#333333 ;">강아지추모</a></li>
	                     </ul></li>
	                     
	                     
	      
	                  <li class="nav-item dropdown"><a
	                     class="nav-link dropdown-toggle" href="#"
	                     id="navbarDarkDropdownMenuLink" role="button"
	                     data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 20px;color:#333333 ;"> 경험나눔 </a>
	      
	                     <ul class="dropdown-menu dropdown-menu-dark" id="dropdown_background"
	                        aria-labelledby="navbarDarkDropdownMenuLink">
	                        <li><a class="dropdown-item" href="#" style="font-size: 13px;color:#333333 ;">꿀팁</a></li>
	                        <li><a class="dropdown-item" href="#" style="font-size: 13px;color:#333333 ;">재능기부</a></li>
	                     </ul></li>
	      
	      
	                    <li class="nav-item">
	                      <a class="nav-link" href="../lostdogboard/lostdogList.do" style="font-size: 20px;color:#333333 ;">강아지찾기</a>
	                    </li>
	            
	                    <li class="nav-item">
	                      <a class="nav-link" href="../finddogboard/HE_FinddogBoardList.do" style="font-size: 20px;color:#333333 ;">주인찾기</a>
	                    </li>
	      
	      
	                  <li class="nav-item dropdown">
	                     <a class="nav-link dropdown-toggle" href="#"
	                     id="navbarDarkDropdownMenuLink" role="button"
	                     data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 20px;color:#333333 ;"> 임시보호 </a>
	                     
	      
	                     <ul class="dropdown-menu dropdown-menu-dark" id="dropdown_background"
	                        aria-labelledby="navbarDarkDropdownMenuLink">
	                        <li><a class="dropdown-item" href="../sitterboard/HE_SitterBoardList.do" style="font-size: 13px;color:#333333 ;">임시보호자 등록 & 요청</a></li>
	                        <li><a class="dropdown-item" href="../reviewboard/HE_ReviewBoardList.do" style="font-size: 13px;color:#333333 ;">후기게시판</a></li>
	                     </ul></li>
	      
	      
	      	           <li class="nav-item">
	                      <a class="nav-link" href="../shop/index.do" style="font-size: 20px;color:#333333 ;">쇼핑몰</a>
	                    </li>
	                  
	      
	                  <li class="nav-item dropdown"><a
	                     class="nav-link dropdown-toggle" href="#"
	                     id="navbarDarkDropdownMenuLink" role="button"
	                     data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 20px;color:#333333 ;"> 정보소식 </a>
	      
	                     <ul class="dropdown-menu dropdown-menu-dark" id="dropdown_background"
	                        aria-labelledby="navbarDarkDropdownMenuLink">
	                        <li><a class="dropdown-item" href="../noticeboard/HE_NoticeBoardList.do" style="font-size: 13px;color:#333333 ;">공지사항</a></li>
	                        <li><a class="dropdown-item" href="../articleboard/HE_ArticleBoardList.do" style="font-size: 13px;color:#333333 ;">보도자료</a></li>
	                     </ul></li>
	      
	               </ul>
	      
	      
	            </div>
	         
	         </div>
	      
	      
	      </nav>
      
      	</div>
      </div>
   </div>
   
   
      
      