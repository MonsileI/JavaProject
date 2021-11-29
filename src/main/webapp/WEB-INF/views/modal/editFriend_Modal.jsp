<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							
							<!-- -------------- modal2 ------------------ -->
							<!-- friend -->
							<div id="friendModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
										
											<h4 class="modal-title" id="myModalLabel" style="color:#004ba0;">친구 관리</h4>
											
										
											<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
												style="font-size: 2rem; color:gray;"></i>
										
										
										</div>
										
										<div class="modal-body">
											
												<form action="../member/deleteFriendProcess.do" method="post">
													<input type="hidden" class="form-control"  name="grouplist_no" id="friendModal_before_grouplist_no_delete">
													<input type="hidden" name="friend_no" id="friendModal_friend_no_delete">
													<button value="삭제" style="background-color:rgb(0,0,0,0); border:0px;">
														<i class="bi-person-dash" style="font-size: 3rem; color:gray;"></i>
													</button>
												</form>
											
												<form action="../member/updateFriendGroupProcess.do" method="post">
												
													<input type="hidden" class="form-control" name="before_grouplist_no" id="friendModal_before_grouplist_no">
													<input type="hidden" name="grouplist_no" id="friendModal_after_grouplist_no">
													<input type="hidden" name="friend_no" id="friendModal_friend_no">
													
													<div class="row">
													
														<div class="col-3">
															그룹 변경: 
															<select class="form-select" id="friendModal_group_selectList" required aria-label="select example" onchange = "friendModalSelectGroup(this);"
																	style="width:100%;">
															
																<c:forEach items="${groupList}" var="group">
																	<c:forEach items="${group}" var="friend">
																		<option value="${friend.key.grouplist_no}">${friend.key.group_name}
																		</option>
																	</c:forEach>
																</c:forEach>
																
														  	</select>
													  	</div>
													  	<div class="col">
														<!-- button type="submit" id="changeFriendGroupBtn" class="btn btn-primary">확인</button-->
														<button id="changeFriendGroupBtn" value="확인" style="background-color:rgb(0,0,0,0); border:0px;">
															<i class="bi-check" style="font-size: 3rem; color:gray;"></i>
														</button>
														</div>
														
													</div>
												</form>
												
										</div>
											
									</div>
								</div>
							</div>
							
							<script>
							
								var thisModal = document.getElementById("friendModal");
						
								thisModal.addEventListener('show.bs.modal', function(e){
									
									  var button = e.relatedTarget; // 모달 윈도우를 오픈하는 버튼
									  
									  var groupNo = button.getAttribute('data-value1');
									  var groupName = button.getAttribute('data-value2');
									  var friendNo = button.getAttribute('data-value3');
									  var friendId = button.getAttribute('data-value4');
									  var friendNick = button.getAttribute('data-value5');
					
									  //var modal = $(this);
									 // modal.find('.modal-title').text('Friend_' + friendNick + "(" + friendId + ")"); // 모달위도우에서 .modal-title을 찾아 원하는 변수 값으로 치환
									 
									  document.querySelector("#friendModal_before_grouplist_no").value = groupNo;
									  document.querySelector("#friendModal_before_grouplist_no_delete").value = groupNo;
									  document.querySelector("#friendModal_friend_no").value = friendNo;
									  document.querySelector("#friendModal_friend_no_delete").value = friendNo;
									  
									  //console.log("test");
									  //console.log(friendNick);
									
								});
								
							</script>