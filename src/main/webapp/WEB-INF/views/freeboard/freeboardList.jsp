<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%! String likeValue; %>
<%
Cookie[] cookies = request.getCookies();

if (cookies != null) {
	

	for (Cookie cf : cookies) {
		System.out.println(cf.getName()+":"+cf.getValue());
		
		if (cf.getName().equals("like") && cf.getValue().equals("yes")) {
			likeValue = "-1";
			System.out.println("jsp:"+likeValue);
			
			Cookie cookie = new Cookie("like", "no");
			cookie.setMaxAge(60*60*24);
			response.addCookie(cookie);
			System.out.println("setting no");
		}
		else if(cf.getName().equals("like") && cf.getValue().equals("no")){
			likeValue = "1";	
			System.out.println("jsp:"+likeValue);

			Cookie cookie = new Cookie("like", "yes");
			cookie.setMaxAge(60*60*24);
			response.addCookie(cookie);
			System.out.println("setting yes");

	}
	}
}
%>

	<form action="./freeTestProcess.do" method="post">
	
	닉네임: <input type="text" name="nick">
	좋아요: <input type="hidden" name="likeCheck" value="<%=likeValue%>">
	
	<input type="submit">
	</form>


</body>
</html>