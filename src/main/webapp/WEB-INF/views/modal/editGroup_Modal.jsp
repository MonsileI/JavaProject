<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--script src="../resources/js/notePage.js"></script-->

					
							<!-- -------------- modal1 ------------------ -->
							<!-- group -->
							<div id="groupModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
										
										
											<h4 class="modal-title" id="myModalLabel" style="color:#004ba0;">그룹 편집</h4>
											
											<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
												style="font-size: 2rem; color:gray;"></i>
										
											
										</div>
										
										<div class="modal-body">
											
											<form action="../member/deleteGroupProcess.do" method="post">
												<input type="hidden" name="before_grouplist_no" id="delete_group_no" value="">
		 										<!--button type="submit" class="btn btn-primary">삭제</button-->
		 										<button value="삭제" style="background-color:rgb(0,0,0,0); border:0px;">
													<i class="bi-people" style="font-size: 3rem; color:gray;">-</i>
												</button>
											</form>
												
											<form action="../member/updateGroupProcess.do" method="post">
												그룹명 변경: 
												<input type="hidden" name="grouplist_no" id="grouplist_no" value="">
												<input type="text" name="group_name" id="group_name" value="">
												<button value="확인" style="background-color:rgb(0,0,0,0); border:0px;">
													<i class="bi-check" style="font-size: 3rem; color:gray;"></i>
												</button>
											</form>
												
										</div>
										
										
										
									</div>
								</div>
							</div>
							
							<!-- Modal window option script -->
							
							<script>
							
								var thisModal = document.getElementById("groupModal");
								
								thisModal.addEventListener('show.bs.modal', function(e){
									
									var button = e.relatedTarget; // 모달 윈도우를 오픈하는 버튼
									
									var groupNo = button.getAttribute('data-title'); // 버튼에서 data-title 값을 변수에 저장
									var groupName = button.getAttribute('data-value'); // 버튼에서 data-value 값을 변수에 저장
									
									//var modal = $(this);
									//modal.find('.modal-title').text('Group_' + groupName); // 모달위도우에서 .modal-title을 찾아 groupName 값으로 치환
									
									document.querySelector("#delete_group_no").value = groupNo;
									document.querySelector("#grouplist_no").value = groupNo;
									document.querySelector("#group_name").value = groupName;
									
								});
							
							</script>