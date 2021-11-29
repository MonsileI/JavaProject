<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- for문 if문 등등 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- date 타입을 예쁘게 바꿔주기위해 사용하는 tag library -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="../resources/mangae/css/bootstrap.min.css">

<script src="../resources/js/finddogBoard.js"></script>

<!-- kakao api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e0ca20a32e17caba9fe0222b2414c5e0&libraries=services"></script>



</head>
<!-- NAVBAR
================================================== -->
<body>

	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>
	
	<!-- side menu -->
	<jsp:include page="../include/side.jsp"></jsp:include>


	<div style="width:1200px; margin: 100px auto;">
	
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				
	
	
				<h1>게시글 쓰기</h1>
				
				<form action = "./writeHE_FinddogProcess.do" method="post" enctype="multipart/form-data">
				
					작성자 : ${sessionUser.nick }<br>
				
					<div class="mb-3">
						<label for="title">제목</label> 
						<input type="text" class="form-control" name= "title" value="" placeholder="title" required>
					</div>
					<div class="mb-3">
						<label for="content">내용</label> 
						<textarea name= "content" style="width:100%; height: 500px; resize: vertical;"></textarea>
					</div>
					
					<!--++++++++++지도test++++++++++++-->
					<div class="mb-3">
						<label for="findPlace">발견 장소</label> 
			            <input type="text" class="form-control" name="findPlace" id="findPlace">  
			            
			 			<button type="button" style="background-color:rgb(0,0,0,0); border:0px;font-size: 20px;font:bold;">
							찾기
						</button>
						
					</div>
					
					<!--지도를 표시할 div 입니다-->
					<div id="map" style="width:100%;height:350px;"></div>
					
					<script>

					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(37.4996255368181, 127.0305029454302), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };

					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();
	
					// 지도를 클릭한 위치에 표출할 마커입니다
					var marker = new kakao.maps.Marker({ 
					    // 지도 중심좌표에 마커를 생성합니다 
					    position: map.getCenter() 
					}); 
					// 지도에 마커를 표시합니다
					marker.setMap(map);
	
					// 지도에 클릭 이벤트를 등록합니다
					// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
					kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
				    
				    // 클릭한 위도, 경도 정보를 가져옵니다 
				    var latlng = mouseEvent.latLng; 
				    
				    // 마커 위치를 클릭한 위치로 옮깁니다
				    marker.setPosition(latlng);
				    
				    //var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
				    //message += '경도는 ' + latlng.getLng() + ' 입니다';
				    
				    document.getElementById('latitude').value = latlng.getLat();
				    document.getElementById('longtitude').value = latlng.getLng();
				    
				    //var resultDiv = document.getElementById('clickLatlng'); 
				    //resultDiv.innerHTML = message;
				    
				    //geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
				    geocoder.coord2Address(latlng.getLng(), latlng.getLat() , function(result, status){
				    	//alert(result[0].address.address_name);
				    	document.getElementById("findPlace").value = result[0].address.address_name;
				    }); 
				    
				});
					</script>
					
					
					
					<div class="mb-3">
						
			            <input type="hidden" class="form-control" name="latitude" id="latitude">
					</div>
					<div class="mb-3">
						
			            <input type="hidden" class="form-control" name="longtitude"id="longtitude">
					</div>
					
					<div class="mb-3">
						<label for="findDate">발견날짜</label> 
			            <input type="date" class="form-control" name="findDate" id="findDate">
			            <script>
							document.getElementById('findDate').valueAsDate = new Date();
						</script>
					</div>
					<div>
						<label for="petGender">성별</label> 
							<input type="radio" name="petGender" id="" value="M">수컷
							<input type="radio" name="petGender" id="" value="F">암컷
							<input type="radio" name="petGender" id="" value="Q" checked>알수없음
						</div>
					<div class="mb-3">
						<label for="petName">이름</label> 
			            <input type="text" class="form-control" name="petName" value="">
					</div>
					<div class="mb-3">
						<label for="petAge">나이</label>
						<input type="number" class="form-control" name="petAge">  
					</div>
					
					<div class="mb-3">
						<label for="species_no">견종</label>
						<!--  input type="hidden" name="species_no" id="species_no" value="${-1}"-->
						<!--  onclick = "selectSpecies(this);" -->
						<select class="form-select" name="species_no" id="species_selectList" required aria-label="select example">
							<option value="${-1}" selected>알수없음</option>
							<c:forEach items="${speciesCategoryList}" var="pet">
								<option value="${pet.species_no}">${pet.species}</option>							
							</c:forEach>
						</select>
						
						<!--  script>
							function selectSpecies(pet){
								pet_no = $("#species_selectList").find(":selected").val();
								console.log(pet_no);
								$("#species_no").attr("value", pet_no);
								console.log($('#species_no').val());
							} 
						</script-->
						
					</div>
					<div class="mb-3">
						<label for="contact">연락처(hp, email etc.)</label>
						<input type="text" class="form-control" name="contact" value="">
					</div>
			
					 <div class="mb-3">
						 <!-- 파일 업로드(accept : 업로드 파일 형태 지정), multiple : 여러개 업로드 가능 -->
						 <input name = "board_files" type="file" accept="image/*" multiple >  <!-- 파일 타입 + 멀티는 옵션 -->
					 </div>
					 <div class="mb-3">
			 			<button class="btn" type="submit" style="background-color:#004ba0;border-color:#004ba0;color:#ffffff">저장</button>
					 </div>	 
				</form>

	
	
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