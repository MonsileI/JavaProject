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
    <link rel="shortcut icon" type="image/x-icon" href="../resources/mangae/img/favicon.ico">

    <link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/mangae/css/templatemo.css">
    <link rel="stylesheet" href="../resources/mangae/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="../resources/mangae/css/fontawesome.min.css">

</head>
<body>

<jsp:include page="../include/headerbar.jsp"></jsp:include>

    <!-- Start Content Page -->
    <div class="container-fluid bg-light py-5">
        <div class="col-md-6 m-auto text-center">
            <h1 class="h1">물품 등록</h1>
	            <p>
	               	물품 등록 해주세요!
	            </p>
        </div>
    </div>

    <!-- Start Contact -->
    <div class="container py-5">
        <div class="row py-5">
            <form class="col-md-9 m-auto" action="./productWriteProcess.do" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="form-group col-md-6 mb-3">
                    <input type="hidden" name="store_no" value="${store_no }">
                        <label for="inputname">작성자</label>
                        <input type="text" class="form-control mt-1" id="name" name="name" placeholder="${sessionUser.nick }">
                    </div>
                     <div class="form-group col-md-6 mb-3">
                        <label for="inputname">물품명</label>
                        <input type="text" class="form-control mt-1" id="product_name" name="product_name" placeholder="물품명을 작성해주세요">
                    </div>
                </div>
                 
				<div class="mb-3">
                    <!--  <label for="inputsubject">카테고리</label>-->
                    <input type="hidden" class="form-control mt-1" id="category_no" name="category_no" placeholder="category_no" value="2">
                </div>
                  <div class="row">
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputname">가격</label>
                        <input type="number" class="form-control mt-1" id="product_price" name="product_price" placeholder="가격을 입력해주세요" >
                    </div>
                     <div class="form-group col-md-6 mb-3">
                        <label for="inputname">수량</label>
                        <input type="number" class="form-control mt-1" id="product_amount" name="product_amount" placeholder="수량을 입력해주세요">
                    </div>
                </div>
                <div class="mb-3">
                    <label for="inputmessage">물품 설명</label>
                    <textarea class="form-control mt-1" id="product_content" name="product_content" placeholder="내용을 입력해주세요" rows="8"></textarea>
                </div>
              	  로고 이미지
               <input name="abc" type="file" accept="image/*" >
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">등록</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- End Contact -->

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