<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




								<!-- -------------- modal0 ------------------ -->
								<!-- +친구 -->
								<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								
									<div class="modal-dialog" role="document" style="width:21vw;max-width: none;">
									
										<div class="modal-content">
											<div class="modal-header">
											
												<h4 class="modal-title" id="myModalLabel" style="color:#004ba0;">주소록</h4>
												
												<i class="bi-x" role="button"  class="close" data-bs-dismiss="modal" aria-label="Close" 
														style="font-size: 2rem; color:gray;"></i>
										
										
											</div>
											
											<!--ㅡmodal body -->
											<div class="modal-body">
											
												<!-- friend list -->
												<div class="col">
									
													<c:forEach items="${groupList}" var="group">
														<c:forEach items="${group}" var="friend">
															
															<!-- 모달을 열기 위한 버튼 -->
															<c:choose>
																<c:when test="${friend.key.group_name eq '기본'}">
																	<button type="button" data-bs-toggle="modal" data-bs-target="#groupModal" 
																			data-title="${friend.key.grouplist_no}"
																			data-value="${friend.key.group_name}" 
																			style="background-color:rgb(0,0,0,0); border:0px;font-size: 20px;font:bold;" disabled>
																			${friend.key.group_name}
																	</button>
																	<br>
																	
																	<c:forEach items="${friend.value}" var="vo">
																	
																		<button type="button" data-bs-toggle="modal" data-bs-target="#friendModal"
																	 			data-value1="${friend.key.grouplist_no}" 
																		 		data-value2="${friend.key.group_name}" 
																		 		data-value3="${vo.member_no}"
																				data-value4="${vo.id}"
																	 			data-value5="${vo.nick}"
																	 			style="background-color:rgb(0,0,0,0);border:0px;font-size:13px;">
																	 			-${vo.nick}
																	 	</button>
																		<br>
																		
																	</c:forEach>	
																</c:when>
																<c:otherwise>
																	<button type="button" data-bs-toggle="modal" data-bs-target="#groupModal" 
																			data-title="${friend.key.grouplist_no}"
																			data-value="${friend.key.group_name}"
																			style="background-color:rgb(0,0,0,0);border:0px;font-size: 20px;font:bold;">
																			${friend.key.group_name}
																	</button>
																	<br>
																	
																	<c:forEach items="${friend.value}" var="vo">
																		<button type="button" data-bs-toggle="modal" data-bs-target="#friendModal"
																	 			data-value1="${friend.key.grouplist_no}" 
																	 			data-value2="${friend.key.group_name}" 
																	 			data-value3="${vo.member_no}"
																	 			data-value4="${vo.id}"
																	 			data-value5="${vo.nick}"
																	 			style="background-color:rgb(0,0,0,0);border:0px;font-size:15px;">
																	 			-${vo.nick}
																	 	</button>
																		<br>
																		
																	</c:forEach>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:forEach>
												</div>
												<hr>
												
												
												<!-- button table -->
												<div class="col-1">
													<table>
														
														<tr>
															<td>
																<form action="../member/addFriendProcess.do" method="post">
																	<button type="submit" id="addFriendBtn" value="추가" style="background-color:rgb(0,0,0,0); border:0px;">
																		<i class="bi-person" style="font-size: 3rem; color:gray;"></i>
																	</button>
															</td>
															<td>
																<span style="margin-left:0px;margin-right:10px;font-size: 2rem; color:gray;">+</span>
															</td>
															<td>
																
																<input type="text" id="friendId" name="id" placeholder="ID" 
																		oninput="checkFriendId(this, '${sessionUser.id}');" required>
															</td>
															<td>		
																<!--  input type="hidden" class="form-control" name="grouplist_no" id="base_grouplist_no" value=""-->
																<input type="hidden" class="form-control" name="group_name" id="base_group_name" value="기본" style="width:150px;"> 
															</td>
															<td>
																<!--select class="form-select" id="base_group_selectList" required aria-label="select example" onclick = "selectGroup(this);"-->
																<select class="form-select" name="grouplist_no" id="group_selectList" required aria-label="select example" style="width:80px;">
																	
																	<c:forEach items="${groupList}" var="group">
																		<c:forEach items="${group}" var="friend">
																			<option value="${friend.key.grouplist_no}">${friend.key.group_name}
																			</option>
																		</c:forEach>
																	</c:forEach>
																	
															  	</select>
															  	</form>
															</td>
															<td>			
																
															</td>
														
														</tr>
														
														<tr>
															<td>
																<button id="addGroupBtn_popup" value="그룹+" onclick="addGroup(this);" style="background-color:rgb(0,0,0,0); border:0px;">
																	<i class="bi-people" style="font-size: 3rem; color:gray;"></i>
																		
																</button>
															</td>
															<td>
																<span style="margin-left:0px;margin-right:10px;font-size: 2rem; color:gray;">+</span>
														
															</td>
															<td>
																<input type="text" name="group_name" id="addGroupInput_popup" style="display:none"> <!-- oninput="checkId()"  -->
															</td>
															<td>
																<input type="hidden" name="member_no" id="addMemberNo_popup" value="${sessionUser.member_no}">
															</td>
															<td></td>
															<td></td>
															<td></td>
														</tr>
														
														<tr>
															<td>		
															
															<!--========================================include===================================-->
																<!-- sendNoteModal menu -->
																<jsp:include page="../modal/sendNote_Modal.jsp"></jsp:include>	
															<!--==================================================================================-->	
															  	
																<!-- 모달 open 버튼 -->
																<button type="button" data-bs-toggle="modal" data-bs-target="#sendNoteModal" value="쪽지보내기"
																		data-value1="${friend.key.grouplist_no}" 
																 		data-value2="${friend.key.group_name}" 
																 		data-value3="${vo.member_no}"
																		data-value4="${vo.id}"
															 			data-value5="${vo.nick}"
																 		style="background-color:rgb(0,0,0,0); border:0px;">
																		<i class="bi-pencil-square" style="font-size: 3rem; color:gray;"></i>
																</button>
																
															</td>
														
														</tr>
													
														
													</table>
												
												</div>
											</div>

								
											
										</div>
									</div>
								</div>
					