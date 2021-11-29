<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<!-- custom css -->
<link rel="stylesheet" type="text/css" href="../resources/css/loginPage.css">

     <!--style>
      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style-->

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Sacramento&display=swap" rel="stylesheet">


<style>
.font-sacramento {
	font-family: 'Sacramento', cursive;
}

</style>
</head>
<!-- NAVBAR
================================================== -->
<body>
	<!-- top menu -->
	<jsp:include page="../include/header.jsp"></jsp:include>

	
	
	<div style="width:1200px; margin: 100px auto;background-color:#FFF5EA;">
	
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
	
		
			<main class="form-signin text-center" style="margin-top:100px;margin-bottom:200px;">
			
			
			<div class="card" style="background-color:;border-radius:50%;width:350px;"><!-- #E6FFFF -->
			
			  <form action="../main/loginProcess.do" method="post">
			  	<div class="row">
				    <div class="col" style="margin-top:20px;color:#004ba0;font-weight:bold;font-size:30px;margin-bottom:10px;
				    						font-family: 'Sacramento', cursive;">LoveDogs
				    </div>
				    <img src="../resources/mangae/img/dog.png" style="width:500px;">
			 	</div>
			 	
			 
			 	<div class="row">
				    <div class="col" style="color:#004ba0;font-size:30px;margin-bottom:50px;font-family: 'Sacramento', cursive;
				    ">Welcome to ManGae</div>
			 	</div>
		
			    <div class="form-floating">
			    
			    	<div class="col">
			     		<input type="text" class="form-control" name="id" id="floatingInput" placeholder="Id"  
			     			style="background-color:#090721;opacity:60%;color:#ffffff;border-radius:0%" required autofocus>

			      	</div>
			    </div>
			    
			    <div class="form-floating">
			    	<div class="col">
			   			<input type="password" class="form-control" name="pw" id="floatingPassword" placeholder="Password" 
			   				style="background-color:#090721;opacity:60%;color:#ffffff;border-radius:0%" required>

			      	</div>
			    </div>
			
			    <!--div class="checkbox mb-3" style="float:left;">
			    	<div class="col">
				    	<label>
				        	<input type="checkbox" value="remember-me" style="color:#090721;"> Remember me
				    	</label>
			    	</div>
			    </div-->
			    
			    <div class="row mb-3" style="">
			    	<div class="col">
			   			<button class="w-100 btn btn-lg btn-primary" id="loginBtn" type="submit" 
			   				style="background-color:#004ba0;color:#FFFFFF;border:0px;border-radius:0%">
			   				Sign in
			   			</button>
		       		</div>
		       </div>
		       
		        <div class="row" style="">
				    <div class="col-6" style="text-align:left;">
			       		<label><a href="./joinMemberPage.do" style="color:#6aaae4;text-decoration:none;">회원가입</a></label>
			        </div>
		        
			    	<div class="col-6" style="text-align:right;">
		        		<label><a href="./main.do" style="color:#6aaae4;text-decoration:none;">메인</a></label>
		        	</div>
		        </div>
		        
			    
			  </form>
			  
			  
			  	</div>
			  
			  
			  
			  
			  
			</main>
	
	
	
	
	
			</div>
			<div class="col"></div>
		</div>
	</div>
 
		<!-- FOOTER -->
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
		
			<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
 	<script src="../resources/mangae/js/jquery-1.11.0.min.js"></script>
    <script src="../resources/mangae/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="../resources/mangae/js/bootstrap.bundle.min.js"></script>
		
</body>
</html>

