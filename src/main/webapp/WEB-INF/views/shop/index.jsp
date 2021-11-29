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

    <!-- Start Banner Hero -->
    <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators">
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="1"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="../resources/mangae/img/dog.png" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left align-self-center">
                                <h1 class="h1 text-success">사지말고 입양하세요</h1>
                                <h3 class="h2">반려동물과 함께 살아요</h3>
                                <p>
                                  	구조된 동물의 결연자가 되어 따뜻한 보금자리를 만들어 주세요<br>
				    				동물과 사람이 함께 사는 삶을 위해 세상을 바꾸는 실천에 함께해 주세요
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="../resources/mangae/img/dog.png" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1">사지말고 입양하세요</h1>
                                <h3 class="h2">반려동물과 함께 살아요</h3>
                                <p>
                                                                        구조된 동물의 결연자가 되어 따뜻한 보금자리를 만들어 주세요<br>
				    				동물과 사람이 함께 사는 삶을 위해 세상을 바꾸는 실천에 함께해 주세요
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="../resources/mangae/img/dog.png" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1">사지말고 입양하세요</h1>
                                <h3 class="h2">반려동물과 함께 살아요</h3>
                                <p>
                                  	  구조된 동물의 결연자가 되어 따뜻한 보금자리를 만들어 주세요
				    				동물과 사람이 함께 사는 삶을 위해 세상을 바꾸는 실천에 함께해 주세요
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev text-decoration-none w-auto ps-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="prev">
            <i class="fas fa-chevron-left"></i>
        </a>
        <a class="carousel-control-next text-decoration-none w-auto pe-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="next">
            <i class="fas fa-chevron-right"></i>
        </a>
    </div>
    <!-- End Banner Hero -->


    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">BEST ManGae Store</h1>
                <p>
                   	이달의 우수 BEST ManGae 상점들입니다!
                </p>
            </div>
        </div>
        <div class="row">
        
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="../resources/mangae/img/JoongAng.png" class="rounded-circle img-fluid border"></a>
                <h2 class="h5 text-center mt-3 mb-3">중앙트릿</h2>
                <p class="text-center"><a class="btn btn-success">구경하기</a></p>
            </div>
            
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="../resources/mangae/img/petstory.png" class="rounded-circle img-fluid border"></a>
                <h5 class="text-center mt-3 mb-3">펫스토리</h5>
                <p class="text-center"><a class="btn btn-success">구경하기</a></p>
            </div>
                        
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="../resources/mangae/img/meong.png" class="rounded-circle img-fluid border"></a>
                <h2 class="h5 text-center mt-3 mb-3">멍멍냥냥</h2>
                <p class="text-center"><a class="btn btn-success">구경하기</a></p>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->

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