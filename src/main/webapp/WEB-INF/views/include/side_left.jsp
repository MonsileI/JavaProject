<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" type="text/css" href="../resources/css/side.css">
<style>



#sideBar{

   position:fixed;
   top:80%;
   left:1%;
   z-index:3;
   

    width: 120px;
    border-radius:0%;
    overflow:scroll-y;
    
    background-color:#F6F6F6
    

}

</style>

	<div class="container" id="sideBar" style="opacity:60%;">

		<div class="row justify-content-center">
             <div class="col py" style="width: 80px;background-color:#ff6666;color:#FFFFFF;margin-bottom:5px;border-radius:1%;">
            	 <h5 style="font-size:13px;margin-top:5px;text-align:center;">임시보호자</h5>
             		 </div>
             			</div>

      
            <div class="row">
            
      
               <!-- sitterBoard 최신글 3개만 보여주기 -->
               <c:forEach items="${sitterList}" var="sitter" begin="0" end="2" >
               
                  <div class="col" style="text-align:center;">
                     <c:choose>
                                   <c:when test="${sitter.sitterCount == 0}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterNormal.png"
                                      alt="Generic placeholder image" width="80" height="60" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 1}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_1.png"
                                       alt="Generic placeholder image" width="80" height="60" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 2}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_Bronze.png"
                                       alt="Generic placeholder image" width="80" height="60" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 3}">
                                        <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_Silver.png"
                                       alt="Generic placeholder image" width="80" height="60" style="border-radius:5%;"></a>
                                   </c:when>
                                   <c:when test="${sitter.sitterCount == 4}">
                                         <a href="../sitterboard/readHE_SitterPage.do?sitterboard_no=${sitter.boardVo.sitterboard_no}">
                                      <img src="../resources/img/sitterLevel_Gold.png"
                                       alt="Generic placeholder image" width="80" height="60" style="border-radius:5%;"></a>
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
            
            
            <!-- div class="row justify-content-center">
                  <div class="col py-1" style="width: 80px;background-color:#ff6666;color:#FFFFFF;margin-bottom:10px;border-radius:1%;">
                  <h5 style="text-align:center;">임시보호자</h5>
                </div>
             </div-->

         </div>
            
        