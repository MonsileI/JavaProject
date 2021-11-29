<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
    <title>WebProject</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="../resources/mangae/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../resources/mangae/img/favicon.ico">

    <link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/mangae/css/templatemo.css?ver=2222">
    <link rel="stylesheet" href="../resources/mangae/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="../resources/mangae/css/fontawesome.min.css">

</head>

<body>

<jsp:include page="../include/headerbar.jsp"></jsp:include>

    <section class="bg-success py-5">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8 text-white">
                    <h1>구매(재고)수량 부족</h1>
                    <p>
                        	이용에 불편을 드려 죄송합니다   준비한 물량이 모두 소진되었습니다.<br>
							빠른 시일 내에 준비하여 새로운 모습으로 보여드리겠습니다.<br>
							다시 한번 ManGae를 이용해 주셔서 감사드립니다.
                    </p>
                </div>
                <div class="col-md-4">
                    <img class="img-fluid" src="../resources/mangae/img/count.png" alt="">
                </div>
            </div>
        </div>
    </section>
    <!-- Close Banner -->

    <!-- Start Section -->
    <section class="container py-5">
        <div class="row text-center pt-5 pb-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">ManGae Service</h1>
                <p>
                    	보다 더 좋은 서비스를 위해 노력하겠습니다.
                </p>
            </div>
        </div>
        <div class="row">

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-truck fa-lg"></i></div>
                    <h2 class="h5 mt-4 text-center">Delivery Service</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fas fa-exchange-alt"></i></div>
                    <h2 class="h5 mt-4 text-center">Shipping & Return</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-percent"></i></div>
                    <h2 class="h5 mt-4 text-center">Promotion</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-user"></i></div>
                    <h2 class="h5 mt-4 text-center">24 Hours Service</h2>
                </div>
            </div>
        </div>
    </section>
    <!-- End Section -->

    <jsp:include page="../include/footerbar.jsp"></jsp:include>

    <!-- Start Script -->
    <script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
    <script src="../resources/mangae/js/templatemo.js?ver=222"></script>
    <script src="../resources/mangae/js/custom.js"></script>
    <!-- End Script -->
    
</body>
</html>