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

<!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-5 mt-5">
                    <div class="card mb-3">
                        <img class="card-img img-fluid" src="/upload/${content.productVo.product_image }" alt="Card image cap" id="product-detail">
                    </div>
                </div>
                <!-- col end -->
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">${content.productVo.product_name }</h1>
                            <p class="h3 py-2">${content.productVo.product_price }원</p>
                            <p class="py-2">
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-warning"></i>
                                <i class="fa fa-star text-secondary"></i>
                                <i class="fa fa-star text-secondary"></i>
                                <span class="list-inline-item text-dark">등급 3.2 | 36 댓글</span>
                            </p>                           
                            <ul class="list-inline">
                                <li class="list-inline-item">
                                    <h6>총 판매 수량 :</h6>
                                </li>
                                <li class="list-inline-item">
                                    <p class="text-muted"><strong>${content.productVo.product_amount }</strong></p>
                                </li>
                                <li class="list-inline-item">
                                    <h6>남은 수량 :</h6>
                                </li>
                                <li class="list-inline-item">
                                    <p class="text-muted"><strong>${remainAmount }</strong></p>
                                </li>
                            </ul>

                           <h6>물품설명:</h6>
                            <p>${content.productVo.product_content }</p>

                            <form action="./buyProduct.do" method="post">
                                <input type="hidden" name="product_no" value="${product_no }">
                                <div class="row">
                                    <div class="col-auto">
                                        <ul class="list-inline pb-3">
                                            <li class="list-inline-item text-right">
                                               			 구매수량
                                                <input type="hidden" name="buy_amount" id="buy_amount" value="1">
                                            </li>
                                            <li class="list-inline-item"><span class="btn btn-success" id="btn-minus">-</span></li>
                                            <li class="list-inline-item"><span class="badge bg-secondary" id="var-value">1</span></li>
                                            <li class="list-inline-item"><span class="btn btn-success" id="btn-plus">+</span></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col d-grid">
                                         <button type="submit" class="btn btn-success btn-lg">구매하기</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Close Content -->
    
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