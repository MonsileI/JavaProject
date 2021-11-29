<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
.photo {
  width: 360px;
  height: 360px;
  object-fit: cover;
} 
</style>

<body>

<jsp:include page="../include/headerbar.jsp"></jsp:include>
	
 <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-5 mt-5">
                    <div class="card mb-3">
                        <img class="card-img img-fluid" src="/upload/${content.storeVo.logo_link }" alt="Card image cap" id="product-detail">
                    </div>
                </div>
                <!-- col end -->
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">${content.storeVo.store_name }</h1>
                            <p class="h3 py-2"> ${content.memberVo.nick }</p>
                            <p class="py-2">
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-secondary"></i>
                                <span class="list-inline-item text-dark">등급 4.2 |  94 댓글</span>
                            </p>
                            <!--  <ul class="list-inline">
                                <li class="list-inline-item">
                                    <h6>Brand:</h6>
                                </li>
                                <li class="list-inline-item">
                                    <p class="text-muted"><strong>${content.memberVo.nick }</strong></p>
                                </li>
                            </ul>-->

                            <h6>내용:</h6>
                            <p> ${content.storeVo.store_content }</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->

    <!-- 물품 목록 -->
    <section class="py-5">
        <div class="container">
        	<c:forEach items="${content.abc }" var="data">
        <div class="row border-top border-2" style="margin-bottom: 30px; padding-top: 30px;">        
        	<div class="col-4" >
        	<a href="../product/productView.do?product_no=${data.product_no }">
        		<img class="photo" src="/upload/${data.product_image }"></a></div>
        	<div class="col-5">
      		  	<div class="row">
        			<div class="col">
        				${data.product_name }
        			</div>
        	 	</div>
        	 	<div class="row">
        	 		<div class="col">
	               		<p class="py-2">
		                    <i class="fa fa-star text-warning"></i>
		                    <i class="fa fa-star text-warning"></i>
		                    <i class="fa fa-star text-warning"></i>
		                    <i class="fa fa-star text-secondary"></i>
		                    <i class="fa fa-star text-secondary"></i>
	                	</p>
        			</div>
        		</div>
        		<div class="row">
        			<div class="col">가격: ${data.product_price }</div>
        			<div class="col">수량: ${data.product_amount }</div>
        		</div>
          </div>
          <div class="col-3">
          	<div class="line">
        		<div class="linename" style="margin-left: 30px;">
        			작성일: <fmt:formatDate value="${data.register_date }" pattern="YY.MM.dd" />
        		</div>
        	</div>	     		
          </div>
       	</div>
       </c:forEach>  
        <div class="row">
    		<div class="col" style="text-align: right;">
		    	<!--  <a href="../store/storeList.do">목록으로</a>-->
				<a class="btn btn-secondary" href="../product/productWrite.do?store_no=${store_no }">물품등록</a>
			</div>
		</div> 	
        </div>
    </section>
    
 
    <!-- 물품 목록 끝 -->

	<!-- 푸터 -->
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