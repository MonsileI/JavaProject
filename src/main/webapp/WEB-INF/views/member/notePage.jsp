<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">
<!--============= custom css & js =============-->
<!-- custom css -->
<link rel="stylesheet" type="text/css" href="../resources/css/noteBox.css">

	<!-- custom js -->
	<script src="../resources/js/notePage.js"></script>
	
</head>

<body>
	
	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	<!-- side menu -->
	<jsp:include page="../include/side.jsp"></jsp:include>
	
	<!-- modal -->
	<jsp:include page="../modal/recvNoteView_Modal.jsp"></jsp:include>
	
	<!-- modal -->
	<jsp:include page="../modal/sentNoteView_Modal.jsp"></jsp:include>
	
	<!-- sencNote modal menu -->
	<jsp:include page="../modal/sendNoteConnect_Modal.jsp"></jsp:include>
	
	
		<div style="width:1200px; margin: 100px auto;background-color:#FFF5EA;">
	
		<div class="row">
			<div class="col"></div>
			<div class="col-12">
	
	

	<!-- inner contents -->
	<!-- sideBar 영역 목차 & 링크 -->
	<div class="container">
	
		<div class="row justify-content-center">
		
			<!--contents 영역 start-->
			<div class="col-10">
			
				<!-- 상부 contents title 영역 start-->
				<div class="row">
				
			
						<ul class="nav nav-tabs" id="myTab" role="tablist">
	  						<li class="nav-item" role="presentation">
			    				<button class="nav-link active" id="tabBody1-tab" data-bs-toggle="tab" data-bs-target="#tabBody1" 
			    						type="button" role="tab" aria-controls="tabBody1" aria-selected="true"
			    						style="width:150px;margin:0px;border-color:#FFFFFF;background-color:#090721;border-radius:10% 70% 0 0;color:#FFFFFF;text-decoration-line:none;">
			    						
			    					<div>
			    						<i class="bi-telephone-inbound" style="font-size: 2rem; color:#FFFFFF;"></i>
			    					</div>
			    					받은 쪽지함
									<span class="badge rounded-pill" id="badge_recv" style="background-color:#FFFFFF;color:#090721">
    									<!--안읽은 메세지 기능추가 : js -->
										<script>setInterval(checkNewNote, 10000);</script>+
 									</span>
							
								</button>
			   				</li>
			   				<li>
			    				<button class="nav-link" id="tabBody2-tab" data-bs-toggle="tab" data-bs-target="#tabBody2" 
			    						type="button" role="tab" aria-controls="tabBody2" aria-selected="false"
			    						style="width:150px;margin:0px;border-color:#FFFFFF;border-radius:10% 70% 0 0;background-color:#090721;color:#FFFFFF;text-decoration-line:none;">
			    						
			    					<div>
			    						<i class="bi-telephone-outbound" style="font-size: 2rem; color:#FFFFFF;"></i>
			    					</div>
			    					보낸 쪽지함
			    				</button>
			   				</li>
			   				<li>
			  				 	<button class="nav-link" id="tabBody3-tab" data-bs-toggle="tab" data-bs-target="#tabBody3" 
			    						type="button" role="tab" aria-controls="tabBody3" aria-selected="false"
			    						style="width:150px;margin:0px;border-color:#FFFFFF;border-radius:10% 70% 0 0;background-color:#090721;color:#FFFFFF;text-decoration-line:none;">
			    						
			    					<div>
			    						<i class="bi-pencil-square" style="font-size: 2rem; color:#FFFFFF;"></i>
			    					</div>
			    					쪽지 작성
			    				</button>
			   				</li>
			   			</ul>
			   			
			
			
				</div>
		 		<!-- 상부 contents title 영역 end -->
					    
					    
					    
				<!--하부 contents 영역 start-->
				<div class="container">
			
				
					<!--===================전체 tabBody 영역 start===================-->
					<div class="tab-content" id="nav-tabContent">
				
				
						<!--===================tabBody1 영역 starts===================-->
						<div class="tab-pane fade show active" id="tabBody1" role="tabpanel" aria-labelledby="tabBody1-tab">
					
							<!--===================받은 쪽지함 start===================-->
							<div>
							
								<!-- 타이틀 및 검색 start -->
								<div class="row justify-content-center" >
									<div class="row">
										<div class="col-3">
											<h3 id="board_title" style="color:#004ba0;">받은 쪽지함</h3>
										</div>
									</div>
									<div class="row">
										<div class="col" id="total_search" style="color:#1F51B7;margin-bottom:50px;">
											▷ 총 ${recvCount} 개의 쪽지가 있습니다.
										</div>
									</div>
								</div>
								
								<div class="row justify-content-center">
									<!-- 검색 -->
									
											
										<div class="col-2" id="search_select" style="margin-bottom:30px;">
										
											<form action="./notePage.do" method="get">
											
											<select name="search_type_recv" style="height:23px;width:100%;">
												<option value="content">내용</option>
												<option value="nick">받는이</option>
											</select>
											
										</div>
											
										<div class="col-8" id="search_input">
											<input type="text" name="search_word_recv" style="width:100%;">
										</div>
								
										<div class="col-2" id="search_btn">
											<Button class="btn" style="background-color:#090721;color:#FFFFFF;border:0px;width:100%;">search</Button>
										</div>
										</form>	
									
								</div>
								<!-- 타이틀 및 검색 end -->
	
								<!-- 글 목록 불러오기 start-->
								<div>
									
									<table class="table" style="margin-bottom:50px;">
										<tr>
											<th class="col">
												<input class="form-check-input" type="checkbox" 
														id="checkAllRecvNote" 
														onclick="checkAllNote(this);">
											</th>
											<th class="col">번호</th>
											<th class="col-md-8">내용</th>
											<th class="col">보낸이</th>
											<th class="col">작성일</th>
											<th class="col">확인일</th>
										</tr>
												
										<c:forEach items="${recvList}" var="data">
											<tr>
												<td class="col">
													<input type="checkbox" 
															name = "notebox_no" id="notebox_no_recv" 
															value="${data.recvNoteBoxVo.notebox_no}" 
															onclick="checkNote(this);">
												</td>
												<td class="col">${data.recvNoteBoxVo.notebox_no}</td>
												<td class="col-md-8">			
													<button id="${data.recvNoteBoxVo.notebox_no}" 
															value="${data.recvNoteBoxVo.content}" 
															type="button" 
															data-bs-toggle="modal" 
															data-bs-target="#recvNoteViewModal"
															data-value1='${data.recvMemberVo.member_no}'
															data-value2='${data.recvMemberVo.nick}'
															data-value3='${data.recvNoteBoxVo.notebox_no}'
															data-value4='${data.recvNoteBoxVo.content}'
															data-value5='${data.recvNoteBoxVo.writeDate}'
															data-value6='${data.recvNoteBoxVo.readDate}'
															onclick="confirmNote(
																		'${data.recvMemberVo.nick}',
																		'${data.recvNoteBoxVo.notebox_no}',
																		'${data.recvNoteBoxVo.content}',
																		'${data.recvNoteBoxVo.writeDate}',
																		'${data.recvNoteBoxVo.readDate}');"
															style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
																	${data.recvNoteBoxVo.content}
													</button>
												</td>
												<td class="col">
													<button type="button" data-bs-toggle="modal" 
															data-bs-target="#sendNoteConnectModal"
															data-value1="${data.recvMemberVo.member_no}"
															data-value2="${data.recvMemberVo.nick}"
															style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
																	${data.recvMemberVo.nick}
													</button>
												</td>
												<td class="col"><fmt:formatDate value="${data.recvNoteBoxVo.writeDate}" pattern="MM.dd" /></td>
												<td class="col" ><fmt:formatDate value="${data.recvNoteBoxVo.readDate}" pattern="MM.dd" /></td>
												
											</tr>
										</c:forEach>
									</table>
								</div>
								<!-- 글 목록 불러오기 end-->
							
								<!-- 페이징 및 글 쓰기 start-->
								<div id="buttons" >
									
									<div class="col">
										
										<nav>
											
											<ul class="pagination">
												
												<c:choose>
													<c:when test="${recvBeginPage <= 1}">
														<li class="page-item disabled"><a class="page-link" 
															href="./notePage.do?page_num_recv=${recvBeginPage-1}${recvAddParam}"
															style="background-color:#090721;color:#FFFFFF;border:0px;">&lt;</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item"><a class="page-link"
															href="./notePage.do?page_num_recv=${recvBeginPage-1}${recvAddParam}"
															style="background-color:#090721;color:#FFFFFF;border:0px;">&lt;</a></li>
													</c:otherwise>
												</c:choose>
							
												<c:forEach begin="${recvBeginPage}" end="${recvEndPage}" var="i">
													<c:choose>
														<c:when test="${recvCurrentPage == i}">
															<li class="page-item active"><a class="page-link"
																href="./notePage.do?page_num_recv=${i}${recvAddParam}"
																style="background-color:#090721;color:#FFFFFF;border:0px;">${i}</a></li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link"
																href="./notePage.do?page_num_recv=${i}${recvAddParam}"
																style="background-color:#090721;color:#FFFFFF;border:0px;">${i}</a></li>
														</c:otherwise>
													</c:choose>
													
												</c:forEach>
													<c:choose>
														<c:when test="${recvEndPage >= recvTotalPageCount}">
															<li class="page-item disabled"><a class="page-link"
																href="./notePage.do?page_num_recv=${recvEndPage+1}${recvAddParam}"
																style="background-color:#090721;color:#FFFFFF;border:0px;">&gt;</a></li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link"
																href="./notePage.do?page_num_recv=${recvEndPage+1}${recvAddParam}"
																style="background-color:#090721;color:#FFFFFF;border:0px;">&gt;</a></li>
														</c:otherwise>
													</c:choose>
							
												</ul>
											</nav>
										</div>
											
										<!-- 삭제 버튼 추가하기 -->
										<div class="col">
											<div class="mb-3">
												<button class="btn btn-primary" type="submit" id="deleteNoteBtn_recv" 
													onclick="deleteNote(this);"
													style="margin-top:10px;background-color:#090721;color:#FFFFFF;border:0px;">삭제</button>
											</div>
										</div>
									</div>
									<!-- 페이징 및 글 쓰기 end -->
									
								</div>
								<!--===================받은 쪽지함 end===================-->
								
							</div>
							<!--===================tabBody1 영역 end===================-->
				
					
					
						<!--===================tabBody2 영역 start===================-->
						<div class="tab-pane fade" id="tabBody2" role="tabpanel" aria-labelledby="tabBody2-tab">
					
							<!--===================보낸 쪽지함 start===================-->						
							<div>
								<!-- 타이틀 및 검색 start -->
								<div class="row justify-content-center">
									<div class="row">
										<div class="col-3">
											<h3 id="board_title" style="color:#004ba0;">보낸 쪽지함</h3>
										</div>
									</div>
									<div class="row">
										<div class="col" id="total_search" style="color:#1F51B7;margin-bottom:50px;">
											▷ 총 ${sentCount} 개의 쪽지가 있습니다.
										</div>
									</div>
								</div>
								
								<div class="row justify-content-center">
									<!-- 검색 -->
									
									<div class="col-2" id="search_select" style="margin-bottom:30px;">
										
											<form action="./notePage.do" method="get">
											
											<select name="search_type_sent" style="height:23px;width:100%;">
												<option value="content">내용</option>
												<option value="nick">받는이</option>
											</select>
											
										</div>
											
										<div class="col-8" id="search_input">
											<input type="text" name="search_word_sent" style="width:100%;">
										</div>
								
										<div class="col-2" id="search_btn">
											<Button class="btn" style="background-color:#090721;color:#FFFFFF;border:0px;width:100%;">search</Button>
										</div>
										</form>	
									
								</div>
								<!--보낸 쪽지함 end-->
									
									
								<!-- 글 목록 불러오기 start -->
								<div>
									<table class="table" style="margin-bottom:50px;">
										<tr>
											<th class="col">
												<input class="form-check-input" type="checkbox" id="checkAllSentNote" onclick="checkAllNote(this);">
											</th>
											<th class="col">번호</th>
											<th class="col-md-8">내용</th>
											<th class="col">받는이</th>
											<th class="col">작성일</th>
											<th class="col">확인일</th>
										</tr>
										
										<c:forEach items="${sentList}" var="data">
										
											<tr>
												<td class="col">
													<input type="checkbox" name = "notebox_no" id="notebox_no_sent" value="${data.sentNoteBoxVo.notebox_no}" onclick="checkNote(this);">
												</td>
												<td class="col">${data.sentNoteBoxVo.notebox_no}</td>
												<td class="col-md-8">
													<button id="${data.sentNoteBoxVo.notebox_no}" 
															value="${data.sentNoteBoxVo.content}"
															type="button" data-bs-toggle="modal" 
															data-bs-target="#sentNoteViewModal"
															data-value1='${data.sentMemberVo.member_no}'
															data-value2='${data.sentMemberVo.nick}'
															data-value3='${data.sentNoteBoxVo.notebox_no}'
															data-value4='${data.sentNoteBoxVo.content}'
															data-value5='${data.sentNoteBoxVo.writeDate}'
															data-value6='${data.sentNoteBoxVo.readDate}'
																
															style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
																	${data.sentNoteBoxVo.content}
													</button>
														
												</td>
												<td class="col">
													<button type="button" data-bs-toggle="modal" 
															data-bs-target="#sendNoteConnectModal"
															data-value1="${data.sentMemberVo.member_no}"
															data-value2="${data.sentMemberVo.nick}"
															style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
																	${data.sentMemberVo.nick}
													</button>
												</td>
												<td class="col"><fmt:formatDate value="${data.sentNoteBoxVo.writeDate}" pattern="MM.dd" /></td>
												<td class="col"><fmt:formatDate value="${data.sentNoteBoxVo.readDate}" pattern="MM.dd" />
																<input type="hidden" id="${data.sentNoteBoxVo.notebox_no}_date" value="${data.sentNoteBoxVo.readDate}">
												</td>
												
											</tr>
										
										</c:forEach>
									</table>
									
								</div>
								<!-- 글 목록 불러오기 end -->
							
								<!-- 페이징 및 글 쓰기 start-->
								<div id="buttons">
									<div class="col">
						
										<nav>
											
											<ul class="pagination mb-0">
												
												<c:choose>
													<c:when test="${sentBeginPage <= 1}">
														<li class="page-item disabled"><a class="page-link"
															href="./notePage.do?page_num=#" style="background-color:#090721;color:#FFFFFF;border:0px;">&lt;</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item"><a class="page-link"
															href="./notePage.do?page_num=${sentBeginPage-1}${sentAddParam}" style="background-color:#090721;color:#FFFFFF;border:0px;">&lt;</a></li>
													</c:otherwise>
												</c:choose>
					
												<c:forEach begin="${sentBeginPage}" end="${sentEndPage}" var="i">
													<c:choose>
														<c:when test="${sentCurrentPage == i}">
															<li class="page-item active"><a class="page-link"
																href="./notePage.do?page_num=${i}${sentAddParam}" style="background-color:#090721;color:#FFFFFF;border:0px;">${i}</a></li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link"
																href="./notePage.do?page_num=${i}${sentAddParam}" style="background-color:#090721;color:#FFFFFF;border:0px;">${i}</a></li>
															</c:otherwise>
													</c:choose>
												</c:forEach>
					
												<c:choose>
													<c:when test="${sentEndPage >= sentTotalPageCount}">
														<li class="page-item disabled"><a class="page-link"
															href="./notePage.do?page_num=#" style="background-color:#090721;color:#FFFFFF;border:0px;">&gt;</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item"><a class="page-link"
															href="./notePage.do?page_num=${sentEndPage+1}${sentAddParam}" style="background-color:#090721;color:#FFFFFF;border:0px;">&gt;</a></li>
													</c:otherwise>
												</c:choose>
						
											</ul>
												
										</nav>
						
									</div>
										
									<!-- 삭제 버튼 추가하기 -->
									<div class="col-2">
										<div class="mb-3">
											<button class="btn btn-primary" type="submit" id="deleteNoteBtn_sent" 
												onclick="deleteNote(this);"
												style="margin-top:10px;background-color:#090721;color:#FFFFFF;border:0px;">삭제</button>
										</div>
									</div>
								</div>
								<!-- 페이징 및 글 쓰기 end-->
					
							</div>
							<!--===================보낸 쪽지함 end=============s======-->					
						</div>
						<!--===================tabBody2 영역 end===================-->
					
					
					
						<!--===================tabBody3 영역 start===================-->
						<div class="tab-pane fade" id="tabBody3" role="tabpanel" aria-labelledby="tabBody3-tab">
						
							<!--===================글쓰기 start===================-->
							
							
							
							<div class="row">
								<div class="col-3">
									<h3 id="board_title" style="color:#004ba0;">쪽지 보내기</h3>
								</div>
							</div>
							
							
							<div class="card" style="margin-bottom:50px;margin-top:50px;background-color:#E2F4FF">
							
							<div>
								<input type="text" id="friendId_one" placeholder=" ID search" oninput="checkFriendId(this, '${sessionUser.id}');" style="margin:10px;">
							</div>
						
							
							<form class="was-validated" action="./sendNoteProcess.do" method="post">
							
								<input type="hidden" name="member_no" value="${sessionUser.member_no}">
														
								<div class="mb-3">
									<input type="text" id="friend_id_one" placeholder=" Receiver" style="margin:10px;">
									<input type="hidden" id="friend_no_one" name="friend_no">
															
									<textarea class="form-control is-invalid" name="content" placeholder="Content" 
											style="width:98%;height:250px;resize:vertical;margin:10px;" required></textarea>
								</div>
														
								<div class="row">
									<!--  div class="col-1"-->
										<!--  select class="form-select" id="friend_selectList" required aria-label="select example" onclick = "selectFriend(this);"-->
										<!--select class="form-select" id="friend_selectList_one" aria-label="select example" onclick = "selectFriend(this);">
											<c:forEach items="${groupList}" var="group">
												<c:forEach items="${group}" var="friend">
													<optgroup label="${friend.key.group_name}" data-max-options="2">
														<c:forEach items="${friend.value}" var="vo">
															<option value="${vo.member_no}++${vo.nick}" selected>${vo.nick}</option>
														</c:forEach>
													</optgroup>
														
												</c:forEach>
											</c:forEach>
										</select-->	
									<!--/div-->	  
									<div class="col">
										<button type="submit" value="전송" type="submit" id="sendBtn_one" style="background-color:rgb(0,0,0,0); border:0px;">
											<i class="bi-pencil-square" style="font-size: 2rem; color:#090721;margin:10px;"></i>
										</button>
									</div>
								</div>
										
							</form>
							
							</div>
							<!--===================글쓰기 end===================-->
						
						
						</div>
						<!--===================tabBody3 영역 end===================-->
					
					
					
					</div>
					<!--===================전체 tabBody 영역 end===================-->
				
		
				</div>
				<!-- 하부 contents 영역 end-->
			
			</div>
			<!--contents 영역 end-->
	
		</div>
		<!--  class="row justify-content-center" end -->
				    	
	
	</div>
	
	
						</div>
			<div class="col"></div>
		</div>
	</div>
	
	
		<!-- FOOTER -->

		<jsp:include page="../include/footer.jsp"></jsp:include>
	<!-- /.container -->

		<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
 	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>