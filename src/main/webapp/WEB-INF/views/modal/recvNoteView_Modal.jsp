<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



						<!-- -------------- modal ------------------ -->
							<!-- recvNoteView Modal -->
							<div id="recvNoteViewModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document" style="width:70vw;max-width: none;">
									<div class="modal-content">
										
										<div class="modal-header">
											<div class="col">
												<h4 class="modal-title" style="float:left;color:#004ba0;">받은 쪽지함</h4>
											</div>
											<div class="col-1">
												<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
													style="font-size: 2rem; color:gray;float:right;"></i>
											</div>
										
										</div>
											
											
										<!-------------------------------------------------->
										<div class="row mt-3 py-3" style="margin-left:2%;width: 67vw;background-color:#EAEAEA;">
										
											<input type="hidden" id="friendNo_recvView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
											
											<div class="col-md-1">
												<Label>번호</Label>
											</div>
											
											<div class="col-md-5">
												<Label>내용</Label>
											</div>
											<div class="col-md-2">
												<Label>보낸이</Label>
											</div>
											<div class="col-md-2">
												<Label>작성일</Label>
											</div>
											<div class="col-md-2">
												<Label>확인일</Label>
											</div>
											
										</div>	
										
										
										<div class="row mt-0 mb-3 py-0" style="margin-left:2%;width: 67vw;border:1px;background-color:#D5D5D5;">
										
											<div class="col-md-1">
												<input type="text" id="no_recvView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
											</div>
											<div class="col-md-5">
												<input type="text" id="content_recvView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
												<!-- td class="col"><input type="text" id="nick_recvView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;"></td-->		
											</div>
											<div class="col-md-2">
												<input type="button" data-bs-toggle="modal" 
															data-bs-target="#sendNoteConnectModal"
															id="nick_recvView"
															data-value1="nick_recvView" 
															style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
											</div>
											<div class="col-md-2">
												<input type="text" id="writeDate_recvView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
											</div>
											<div class="col-md-2">
												<input type="text" id="readDate_recvView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
											</div>
										
										</div>
											
											
																		        		
										
										</div>
								   	</div>
								</div>
										
							<script>
								
								var thisModal =  document.getElementById('recvNoteViewModal');
								
								thisModal.addEventListener('shown.bs.modal', function (e) {
									
									var button = e.relatedTarget; // 모달 윈도우를 오픈하는 버튼
									
									var no = button.getAttribute('data-value1');
									var nick = button.getAttribute('data-value2');
									var notebox = button.getAttribute('data-value3'); 
									var content = button.getAttribute('data-value4');
									var writeDate = button.getAttribute('data-value5');
									var readDate = button.getAttribute('data-value6'); 
									 
							
									
									  
									//console.log(nick, notebox, writeDate, readDate);
					
									//var modal = $(this);
									//var modal = thisModal;
									//document.getElementsByClassName('modal-title').innerHTML = "NO. " + notebox; // 모달윈도우에서 .modal-title을 찾아 원하는 변수 값으로 치환
									 
									 
									document.querySelector("#friendNo_recvView").value = no;
									document.querySelector("#no_recvView").value = notebox;
									document.querySelector("#nick_recvView").value = nick;
									  
									document.querySelector("#content_recvView").value = content;
									document.querySelector("#writeDate_recvView").value = writeDate;
									document.querySelector("#readDate_recvView").value = readDate;
									  
	
								// console.log(document.querySelector("#nick_recvView").value);
									  
									  
								})
							</script>














