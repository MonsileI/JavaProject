<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


							<!-- -------------- modal ------------------ -->
							<!-- sentNoteView Modal -->
							<div id="sentNoteViewModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document" style="width:70vw;max-width: none;">
									<div class="modal-content">
										
										<div class="modal-header">
											<div class="col">
												<h4 class="modal-title" style="float:left;color:#004ba0;">보낸 쪽지함</h4>
											</div>
											<div class="col-1">
												<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
													style="font-size: 2rem; color:gray;float:right;"></i>
											</div>
										
										</div>
											<!------------------------------------------------->	
																					<!-------------------------------------------------->
										<div class="row mt-3 py-3" style="margin-left:2%;width: 67vw;background-color:#EAEAEA;">
										
											<input type="hidden" id="friendNo_sentView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
											
											<div class="col-md-1">
												<Label>번호</Label>
											</div>
											
											<div class="col-md-5">
												<Label>내용</Label>
											</div>
											<div class="col-md-2">
												<Label>받는이</Label>
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
												<input type="text" id="no_sentView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
											</div>
											<div class="col-md-5">
												<input type="text" id="content_sentView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
														
											</div>
											<div class="col-md-2">
												<input type="button" data-bs-toggle="modal" 
																	data-bs-target="#sendNoteConnectModal"
																	id="nick_sentView"
																	data-value1="nick_sentView" 
																	style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
											</div>
											<div class="col-md-2">
												<input type="text" id="writeDate_sentView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
											</div>
											<div class="col-md-2">
												<input type="text" id="readDate_sentView" style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;" disabled>
											</div>
										
										</div>
										
										
										
								
									</div>
								</div>
											
							</div>
											
						<script>
						
							var thisModal = document.getElementById("sentNoteViewModal");
							
							thisModal.addEventListener('show.bs.modal', function (e){
								
								var button = e.relatedTarget; // 모달 윈도우를 오픈하는 버튼
								
								var no = button.getAttribute('data-value1');
								var nick = button.getAttribute('data-value2');
								var notebox = button.getAttribute('data-value3');
								var content = button.getAttribute('data-value4');
								var writeDate = button.getAttribute('data-value5');
								var readDate = button.getAttribute('data-value6');
				
								//var modal = $(this);
								//var modal = thisModal;
								//modal.find('.modal-title').text("NO. " + notebox); // 모달윈도우에서 .modal-title을 찾아 원하는 변수 값으로 치환
								 
								  
								document.querySelector("#friendNo_sentView").value = no;
								document.querySelector("#no_sentView").value = notebox;
								document.querySelector("#nick_sentView").value = nick;
								document.querySelector("#content_sentView").value = content;
								document.querySelector("#writeDate_sentView").value = writeDate;
								document.querySelector("#readDate_sentView").value = readDate;
						
							});
							
						</script>














