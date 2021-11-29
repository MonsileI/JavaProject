<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



						<!-- -------------- modal3 ------------------ -->
							<!-- writeNote Modal -->
							<div id="sendNoteModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							
								<div class="modal-dialog" role="document" style="width:70vw;max-width:450px;">
								
									<div class="modal-content">
										
										<div class="modal-header">
										
										
											<h4 class="modal-title" id="sendNoteLabel" style="color:#004ba0;">쪽지보내기</h4>
										
											<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
												style="font-size: 2rem; color:gray;" onclick="close_noteModal();"></i>
										
											
										</div>
										
										<div class="modal-body">
										
										
											<!--===================글쓰기===================-->
											<div class="row mb-1">
					
												<div class="col-12">
													<input type="text" id="friendId_two" placeholder="ID" oninput="checkFriendId(this, '${sessionUser.id}');">
												</div>
											</div>
													
																			
											<form class="was-validated" action="../member/sendNoteProcess.do" method="post">
																			
											<div class="row mb-1">
												<div class="col">
													<input type="hidden" name="member_no" value="${sessionUser.member_no}">
													<input type="text" id="friend_id_two" placeholder="Receiver">
												</div>
											</div>
											
											<div class="row mb-1">
												<div class="col-12">
													<input type="hidden" id="friend_no_two" name="friend_no">
												</div>	
											</div>		
															
											<div class="row mb-2">
												<div class="col-10">
													<textarea class="form-control is-invalid" name="content" id="content" placeholder="Content" style="width:92%;resize:vertical;" required></textarea>
												</div>
																				
															<!-- div class="row">
																<div class="col-3"-->
																	<!--  select class="form-select" id="friend_selectList" required aria-label="select example" onclick = "selectFriend(this);"-->
																	<!--select class="form-select" id="friend_selectList_two" aria-label="select example" onclick = "selectFriend(this);">
																		<c:forEach items="${groupList}" var="group">
																			<c:forEach items="${group}" var="friend">
																				<optgroup label="${friend.key.group_name}" data-max-options="2">
																					<c:forEach items="${friend.value}" var="vo">
																						<option value="${vo.member_no}++${vo.nick}">${vo.nick}</option>
																					</c:forEach>
																				</optgroup>
																				
																			</c:forEach>
																		</c:forEach>
																	</select-->
																<!--/div>
																<div class="col"-->
												<div class="col mb-3" style="text-align:left;">
													<button type="submit" value="전송" type="submit" id="sendBtn_two" style="background-color:rgb(0,0,0,0); border:0px;">
														<i class="bi-pencil-square" style="font-size: 2rem; color:gray;"></i>
													</button>
												</div>		
											</div>
														
											</form>
														
										</div>
									</div>
															
											
								</div>
							</div>
										
										
										
							
							
							<script>
							
								var thisModal = document.getElementById("sendNoteModal");
								
								thisModal.addEventListener('show.bs.modal', function(e){
									
									var button = e.relatedTarget // 모달 윈도우를 오픈하는 버튼
									
									var groupNo = button.getAttribute('data-value1');
									var groupName = button.getAttribute('data-value2');
									var memberNo = button.getAttribute('data-value3');
									var friendId = button.getAttribute('data-value4');
									var nick = button.getAttribute('data-value5');
							
									//var modal = $(this);
									//modal.find('.modal-title').text("쪽지 보내기"); // 모달윈도우에서 .modal-title을 찾아 원하는 변수 값으로 치환
									
									//console.log("test");
									//console.log(groupNo);
								});
								
							 	
							 	function close_noteModal(){

							 	   	document.getElementById("friendId").value = ""
							 	  	//document.getElementById("friendId_one").value = ""
							 	  	document.getElementById("friendId_two").value = ""
							 	  	document.getElementById("friend_id_two").value = ""
							 	  	document.getElementById("content").value = ""
							 	  	
							 	 }

							</script>