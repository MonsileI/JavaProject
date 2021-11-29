<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <img class="img-fluid" src="../resources/mangae/img/logo1.png" alt="">
            <h5>ManGae</h5>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="../shop/index.do">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../store/storeList.do">상점</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">사료</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">캔/간식</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">장난감</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">공지사항</a>
                        </li>
                    </ul>
                </div>
                <div class="navbar align-self-center d-flex">
                    <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                        <div class="input-group">
                            <input type="text" class="form-control" id="inputMobileSearch" placeholder="Search ...">
                            <div class="input-group-text">
                                <i class="fa fa-fw fa-search"></i>
                            </div>
                        </div>
                    </div>
                    <a class="nav-icon d-none d-lg-inline" href="#" data-bs-toggle="modal" data-bs-target="#templatemo_search">
                        <i class="fa fa-fw fa-search text-dark mr-2"></i></a>
                        	<c:choose>
						
							<c:when test="${!empty sessionUser}">

								<a href="#">${sessionUser.nick}님</a>&nbsp;&nbsp;&nbsp;
								<a href="../shop/logoutProcess.do">로그아웃</a>
							</c:when>
							<c:otherwise>
								<!-- login -->
								<a class="nav-icon position-relative text-decoration-none" href="../shop/loginPage.do">로그인</a>
                    			<a class="nav-icon position-relative text-decoration-none" href="../shop/joinMemberPage.do">회원가입</a>
							</c:otherwise>
							
						</c:choose>
                    
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->