<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

						<!-- -------------- modal ------------------ -->
							<!-- sitterRequest Modal -->
							<div id="sitterRequestModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
								<div class="modal-dialog" role="document" style="width:70%; display:table">
									<div class="modal-content">
										
										<div class="modal-header">
										
											<h4 class="modal-title" id="myModalLabel">요청 보내기</h4>
											
										
											<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
												style="font-size: 2rem; color:gray;"></i>
										
										
										</div>
										
										<div class="modal-body">
										
											<!--input type="hidden" name="endDate" id="endDate"-->
										<!--===================글쓰기===================-->
											<form class="needs-validation" action="../sitterboard_process/sitterRequest.do" method="post"><!-- ../sitterboard_process/sitterRequest.do -->
											
												<div class="mb-3">
												
													<input type="hidden" name="member_no" id="memberNo">
													<input type="hidden" name="sitterboard_no" id="sitterboard_no">
													
													대상 글: 
													<select class="form-control" name="finddogboard_no" id="finddogboard_selectList" required aria-label="select example"
															style="margin-top:10px;" >
															
															<!-- getFinddogAuthority() : ajax -> dom 에 화면 뿌리기 -->
															
													</select>
													
														
													<textarea class="form-control" name="message" placeholder="message" 
																style="width:100%;margin-top:10px;resize:vertical;" required></textarea>
													
													<div class="invalid-feedback">
	              										Please enter your shipping address.
	              									</div>
													
													
												</div>
														
												<div class="mb-3">
												  	
												  	<button type="submit" value="전송" type="submit"
												  			onclick="requestSitter()"
												  			style="background-color:rgb(0,0,0,0);margin-top:10px;border:0px;">
														<i class="bi-pencil-square" style="font-size:2em;color:gray;"></i>
													</button>
									
												</div>
												
											</form>
							
										</div>
											
											
									</div>
								</div>
							</div>
							
			                     <script>
                     
		                        //bootstrap - Example starter JavaScript for disabling form submissions if there are invalid fields
		                        (function () {
		                          'use strict'
		                        
		                          // Fetch all the forms we want to apply custom Bootstrap validation styles to
		                          var forms = document.querySelectorAll('.needs-validation')
		                        
		                          // Loop over them and prevent submission
		                          Array.prototype.slice.call(forms)
		                            .forEach(function (form) {
		                              form.addEventListener('submit', function (event) {
		                                if (!form.checkValidity()) {
		                                  event.preventDefault()
		                                  event.stopPropagation()
		                                }
		                        
		                                form.classList.add('was-validated')
		                              }, false)
		                            })
		                        })()   
		                     
		                        //Modal action
		                        var thisModal = document.getElementById("sitterRequestModal");
		                     
		                        thisModal.addEventListener('show.bs.modal', function(e){
		                           
		                           var button = e.relatedTarget; // 모달 윈도우를 오픈하는 버튼
		                           
		                           //getFinddogAuthority();
		                           
		                           //checkSession();
		                           
		                           
		                           
		                           var sitterboardNo = button.getAttribute('data-value1');
		                           document.querySelector("#sitterboard_no").value = sitterboardNo;
		                           var memberNo = button.getAttribute('data-value2');
		                           document.querySelector("#memberNo").value = memberNo;
		                           /*
		                           
		                           var sitterId = button.getAttribute('data-value3');
		                           var sitterNick = button.getAttribute('data-value4');
		                           
		                     
		                           document.querySelector("#sitter_id").value = sitterId;
		                           document.querySelector("#sitter_nick").value = sitterNick;
		                           */
		                           
		                           
		                           //var modal = $(this);
		                           //modal.find('.modal-title').text(sitterNick + " 님에게 시터 요청 글 보내기"); // 모달윈도우에서 .modal-title을 찾아 원하는 변수 값으로 치환
		                           
		                           
		                           //console.log("test");
		                           //console.log(document.querySelector("#sitterboard_no").value);
		                     
		                     
		                        });
                        
								
								
								function checkSitterRequest(){
									
									//var sitterboard_no = document.getElementById("sitterboard_no").value;
									var finddogboard_no = document.getElementById("finddogboard_selectList").value;
									//var sitterMember_no = document.getElementById("memberNo").value;
									//var endDate = document.getElementById("endDate").value;
									
									console.log("REQUEST_______sitter: ", sitterboard_no,"finddog: ",finddogboard_no,"memberNo: ",sitterMember_no);
									
								 	//myModal = new bootstrap.Modal(document.getElementById('sitterRequestModal'));
								 	
									var xmlhttp = new XMLHttpRequest();
									
									//서버에서 응답 후 처리 로직.
									xmlhttp.onreadystatechange = function(){
										if(xmlhttp.readyState==4 && xmlhttp.status==200){
											var result = JSON.parse(xmlhttp.responseText);
											
											console.log(result.data);
											
											if(result.data == 0){
												console.log("me");
												
											}else if(result.data == 1){
												console.log("twice");
												
											}else if(result.data == 2){
												console.log("endDate");
												
											}
											
											
										//+ "&finddogboard_no=" + finddogboard_no
										}
									}
									
									xmlhttp.open("get" , "../sitterboard_process/checkSitterRequest.do?sitterboard_no=" + sitterboard_no + "$finddogboard_no=" + finddogboard_no
													+"&sitterMember_no=" + sitterMember_no);
									//xmlhttp.send();
									
									
									
								}
								
		
							</script>