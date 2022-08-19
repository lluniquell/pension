<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PENSION GOGURYE</title>
<link rel="icon" type="image/jpg" href="logo.jpg">
<style>

a {
	text-decoration:none;
	color:black;
}

a:visited { 
	text-decoration:none;
	color:black;
}

a:hover {
	text-decoration:underline;
	color:black;
}
#first {
	width: 900px;
	height: 50px;
	background: purple;
	margin: auto;
}

#second {
	width: 900px;
	height: 60px;
	background: yellow;
	margin: auto;
}

#third {
	width: 900px;
	height: 100px;
	background: blue;
	margin: auto;
}

#fourth {
	width: 900px;
	height: 400px;
	background: red;
	margin: auto;
}

#fifth {
	width: 900px;
	height: 200px;
	background: black;
	margin: auto;
}
</style>
</head>
 	<decorator:head/>
<body>
	<div id="first">
		오픈 기념 할인 배너 x로 슬라이드 되며 닫힘	
	
	</div>
	<div id="second">
	로그인 | <a href="join">회원 가입</a> 
	</div>
	<div id="third"></div>
	예약 이미지   가운데에 메인 로고  펜션고구려 소개 고객문의  고구려리워즈 
	<decorator:body/>
	
	
	
	
	
	<div id="fifth"></div>
</body>
</html>
	