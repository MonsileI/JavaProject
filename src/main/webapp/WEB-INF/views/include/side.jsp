<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" type="text/css" href="../resources/css/side.css">



<div class="row row-offcanvas row-offcanvas-right">

	<div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">

		<div class="list-group">


			<a href="../sitterboard/HE_SitterBoardList.do"
				class="list-group-item active" id="sideFirst">시터등록 
				<!-- input type="text" id="textFirst" value="시터 게시판에 등록을 합니다." disabled>-->
			</a>
			
			<a href="#" class="list-group-item active" id="sideSecond">요청대기
				<!-- input type="text" id="textSecond"
				value="시터 요청이 오기를 기다립니다. 마이페이지 시터관리에서 내역을 볼 수 있습니다."
				disabled-->
			</a> 
			
			<a href="../sitterboard_process/sitterAcceptListPage.do"
				class="list-group-item active" id="sideThird">요청수락 
				<!--input type="text" id="textThird"
				value="마이페이지 시터 관리의 수락 게시판에서 요청을 수락하거나 거절합니다." disabled-->
			</a> 
			
			<a href="../sitterboard_process/sitterAcceptListPage.do"
				class="list-group-item active" id="sideFour">임시보호 
				<!--input type="text" id="textFour" value="임시보호 시작일로부터 해당 유기견의 시터 역할을 수행합니다." disabled-->
			</a>



		</div>

	</div>

</div>
