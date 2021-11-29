<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


						<!-- -------------- modal3 ------------------ -->
							<!-- writeNote Modal -->
							<div id="sendNoteConnectModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document" >
									<div class="modal-content">
										
										<div class="modal-header">
										
											<h4 class="modal-title" id="sendNoteLabel" style="color:#004ba0;">글쓰기</h4>
											
											<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
												style="font-size: 2rem; color:gray;"></i>
										
											
										
											
										</div>
										
										<div class="modal-body">
										
										<!--===================글쓰기===================-->
											<form class="was-validated" action="../member/sendNoteProcess.do" method="post">
											
												<div class="mb-3">
													<input type="hidden" name="member_no" value="${sessionUser.member_no}">
													<input type="hidden" name="friend_no" id="friend_no_note">
													
													<textarea class="form-control is-invalid" name="content" placeholder="Content" style="width:50%;resize:vertical;" required></textarea>
												</div>
														
												<div class="mb-3">
												  	
												  	<button type="submit" value="전송" type="submit" style="background-color:rgb(0,0,0,0); border:0px;">
														<i class="bi-pencil-square" style="font-size: 2rem; color:gray;"></i>
													</button>
									
												</div>
												
											</form>
							
										</div>
											
											
									</div>
								</div>
							</div>
							
							<script>
							
								var thisModal = document.getElementById("sendNoteConnectModal");
								
								thisModal.addEventListener('show.bs.modal', function(e){
									
									var button = e.relatedTarget // 모달 윈도우를 오픈하는 버튼
									console.log("test:",button);
									
									var btnId = button.getAttribute('data-value1');
									console.log(btnId);
							
									if(btnId == "nick_recvView"){
										console.log("recvBTN");

										var nick = document.querySelector("#nick_recvView").value;

										var no = document.querySelector("#friendNo_recvView").value;
										document.querySelector("#friend_no_note").value = no;

										
									}else if(btnId == "nick_sentView"){
										console.log("sentBTN");
										

										var nick = document.querySelector("#nick_sentView").value;
										
										var no = document.querySelector("#friendNo_sentView").value;
										document.querySelector("#friend_no_note").value = no;
										
									}else{
										var no = button.getAttribute('data-value1');
										var nick = button.getAttribute('data-value2');
										console.log(no, nick);
										
										document.querySelector("#friend_no_note").value = no;
									}
									
									//var modal = $(this);
									//modal.find('.modal-title').text(nick + " 님에게 쪽지 보내기"); // 모달윈도우에서 .modal-title을 찾아 원하는 변수 값으로 치환
									
									console.log(document.querySelector("#friend_no_note").value);
							
								});
								
							</script>
	






