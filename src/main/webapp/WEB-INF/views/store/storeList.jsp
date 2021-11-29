<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Mangae</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="../resources/mangae/img/apple-icon.png">
<link rel="shortcut icon" type="image/x-icon"
	href="../resources/mangae/img/favicon.ico">

<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/mangae/css/templatemo.css">
<link rel="stylesheet" href="../resources/mangae/css/custom.css">

<!-- Load fonts style after rendering the layout styles -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="../resources/mangae/css/fontawesome.min.css">

</head>

<style type="text/css">
.line{
	border-left: 2px solid #dee2e6;
	height: 100%;;
}

</style>

<body>

	<jsp:include page="../include/headerbar.jsp"></jsp:include>

	<!-- Start Content-->
	<div class="container py-5">
		<div class="row">
			<div class="col-lg-3">
				<h1 class="h2 pb-4">Category</h1>
				<ul class="list-unstyled templatemo-accordion">
					<li class="pb-3"><a
						class="collapsed d-flex justify-content-between h3 text-decoration-none"
						href="#"> 상점둘러보기 <i
							class="fa fa-fw fa-chevron-circle-down mt-1"></i>
					</a>
						<ul class="collapse show list-unstyled pl-3">
							<li><a class="text-decoration-none" href="#">상점이름1</a></li>
							<li><a class="text-decoration-none" href="#">상점이름2</a></li>
						</ul></li>
					<li class="pb-3"><a
						class="collapsed d-flex justify-content-between h3 text-decoration-none"
						href="#"> 내 상점 관리 <i
							class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
					</a>
						<ul id="collapseTwo" class="collapse list-unstyled pl-3">
							<li><a class="text-decoration-none" href="#">등등</a></li>
							<li><a class="text-decoration-none" href="#">등등</a></li>
						</ul></li>
					<li class="pb-3"><a
						class="collapsed d-flex justify-content-between h3 text-decoration-none"
						href="#"> 구매목록관리 <i
							class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
					</a>
						<ul id="collapseThree" class="collapse list-unstyled pl-3">
							<li><a class="text-decoration-none" href="#">장난감</a></li>
							<li><a class="text-decoration-none" href="#">간식</a></li>
							<li><a class="text-decoration-none" href="#">사료</a></li>
						</ul></li>
				</ul>
			</div>
			<!--  <div class="line"></div>-->
			<div class="col-lg-9">
				<div class="row">
					<div class="col-md-6">
						<ul class="list-inline shop-top-menu pb-3 pt-1">
							<li class="list-inline-item"><a
								class="h3 text-dark text-decoration-none mr-3" href="#">All</a>
							</li>
							<li class="list-inline-item"><a
								class="h3 text-dark text-decoration-none mr-3" href="#">상점</a></li>
							<li class="list-inline-item"><a
								class="h3 text-dark text-decoration-none" href="#">물품</a></li>
						</ul>
					</div>
				</div>

				<!-- 카드형 시작 -->
				<div class="row">
					<c:forEach items="${contentList }" var="data">
						<div class="col-4">
							<div class="card rounded-0">
							<a href="./storeView.do?store_no=${data.storeVo.store_no }"
									class="h3 text-decoration-none">
								<img class="card-img rounded-0 img-fluid"
									src="/upload/${data.storeVo.logo_link }"></a>
							</div>
							<div class="card-body">
								${data.storeVo.store_name }
								<!--  <ul
									class="w-100 list-unstyled d-flex justify-content-between mb-0">
									<li>${data.storeVo.store_content }</li>
								</ul>-->
							</div>
						</div>
					</c:forEach>
				</div>
				
				<!-- 페이징 버튼만 넣어두기 -->
				<div class="row">
					<div class="col"></div>
					<div class="col">
						<ul class="pagination pagination-lg justify-content-center">
							<li class="page-item disabled"><a
								class="page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0"
								href="#" tabindex="-1">1</a></li>
							<li class="page-item"><a
								class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark"
								href="#">2</a></li>
							<li class="page-item"><a
								class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
								href="#">3</a></li>
						</ul>
					</div>
					<div class="col" style="text-align:right;">
					<c:if test="${!empty sessionUser }">
						<a class="btn btn-secondary" href="../store/storeMake.do">상점 등록</a>
					</c:if>
					</div>
				</div>
				<!--페이징 버튼  -->
			</div>
		</div>
	</div>
	<!-- End Content -->
	<jsp:include page="../include/footerbar.jsp"></jsp:include>

	<!-- Start Script -->
	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
	<script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
	<script src="../resources/mangae/js/templatemo.js"></script>
	<script src="../resources/mangae/js/custom.js"></script>
	<!-- End Script -->
</body>

</html>