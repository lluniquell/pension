<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<script src="../etc/pension.js"></script>

<link rel="stylesheet" href="../etc/pension.css">
<script>
	function view(n) {
		document.getElementsByClassName("sub")[n].style.visibility = "visible";
	}

	function hide(n) {
		document.getElementsByClassName("sub")[n].style.visibility = "hidden";
	}
	
	function hide_top(){
		document.getElementById("first").style.display="none";
		
	}
</script>
<meta charset="UTF-8">
</head>
<body>
	<div id="first">
		펜션 오픈 기념 1박에 1만원!! <span id="aa" onclick="hide_top()">X</span>
	</div>
	<div id="second">
		<div id="left"><br>
			&nbsp;&nbsp;&nbsp;<a href="../main/index.jsp">HOME</a>
		</div>
		<div id="right">
			<ul>
				<li id="main" onmouseover="view(0)" onmouseout="hide(0)">펜션소개
					<ul class="sub">
						<li><a href="../introduce/sayhello.jsp">인삿말</a></li>						
					</ul>
				</li>
				<li id="main" onmouseover="view(1)" onmouseout="hide(1)">여행정보
					<ul class="sub">
						<li><a href="../introduce/cota.jsp">코타</a></li>
						<li><a href="../introduce/kuala.jsp">쿠알라</a></li>
					</ul>
				</li>
				<li id="main" onmouseover="view(2)" onmouseout="hide(2)">예약관련
					<ul class="sub">
						<li><a href="../reserve/reserve.jsp">예약하기</a></li>
						<li><a href="../reserve/reserve_view_all.jsp">예약내역</a></li>
					</ul>
				</li>
				<li id="main" onmouseover="view(3)" onmouseout="hide(3)">커뮤니티
					<ul class="sub">
						<li><a href="../gongji/list.jsp">공지사항</a></li>
						<li><a href="../tour/list.jsp">여행후기</a></li>
						<li><a href="../board/list.jsp">자유게시판</a></li>
					</ul>
				</li>
			
				<c:if test="${userid == null}">
         		<li>
        			 <!-- 로그인을 하지 않은 경우 -->
          			<a href="../member/login.jsp"> 로그인 </a>
          			<a href="../member/member_input.jsp"> 회원가입 </a>
        		</li>
        		</c:if>
        
        		<c:if test="${userid == 'admin'}">
          		<li id="main" onmouseover="view(4)" onmouseout="hide(4)"> 관리자메뉴
					<ul class="sub">
						<li><a href="../admin/room_view.jsp">객실관리</a></li>
						<li><a href="../admin/reserve_view.jsp">예약관리</a></li>
						<li><a href="../admin/member_view.jsp">회원관리</a></li>
					</ul>          
          		</li>
          	 	</c:if>
        		
        		<c:if test="${userid != null}"> 
         		<li>
          		${name}님 
          		<a href="../member/logout.jsp"> 로그아웃 </a>
          		<a href="../member/member_info.jsp"> 회원정보 </a>
          		</li>
        		 <!-- 로그인을 한 경우 -->
         		 <!-- 어드민인 경우 -->
         		 </c:if>
         		     			
			</ul>
		</div>
	</div>