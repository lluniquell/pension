<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
	text-align: center;
}

#section input[type=text] {
	width: 300px;
	height: 40px;
	border: 1px solid purple;
	outline: none;
}

#section input[type=password] {
	width: 300px;
	height: 40px;
	border: 1px solid purple;
	outline: none;
}

#section input[type=submit] {
	width: 300px;
	height: 40px;
	border: 1px solid purple;
	outline: none;
}

#userid_form, #pwd_form {
	display: none;
}
</style>
<script>
	function userid_func() {
		document.getElementById("userid_form").style.display = "block";
		document.getElementById("pwd_form").style.display = "none";
		document.pf.userid.value = "";
		document.pf.name.value = "";
		document.pf.phone.value = "";
	}
	function pwd_func() {
		document.getElementById("pwd_form").style.display = "block";
		document.getElementById("userid_form").style.display = "none";
		document.uf.name.value = "";
		document.uf.phone.value = "";
	}
</script>


<c:import url="../top.jsp" />
<br>
<p>
	<br>
<div id="section">
	
	<form method="post" action="login_ok.jsp">
		<input type="text" name="userid" placeholder="ID">
		<p>
			<input type="password" name="pwd" placeholder="PASSWORD">
		<p>
			<input type="submit" value="로그인">
	</form>
	<div id="search">
		<span id="btn" onclick="userid_func()">아이디 찾기</span> | 
		<span id="btn" onclick="pwd_func()">비밀번호 찾기</span>
	</div>
	
	<c:if test="${chk ==1}">
    <div id="msg_print">당신의 아이디는 ${imsiuser} 입니다.</div>
    </c:if>
    
    <c:if test="${chk == 2}">
    <div id="msg_print">이름과 전화번호 정보가 일치하지 않습니다.</div>
    </c:if>
    	<c:if test="${chk == 3}">
    <div id="msg_print">당신의 비밀번호는 ${imsipwd} 입니다.</div>
    </c:if>
    	<c:if test="${chk == 4}">
    <div id="msg_print">이름과 전화번호 정보가 일치하지 않습니다.</div>
    </c:if>    
    <%
    	session.removeAttribute("imsiuser");
    	session.removeAttribute("chk");
    	session.removeAttribute("imsipwd");
    %>
        
        
        
    	<div id="userid_form">
		<form name="uf" method="post" action="userid_search.jsp">
			<input type="text" name="name" placeholder="이름"><p>
			<input type="text" name="phone" placeholder="전화번호"><p>
			<input type="submit" value="ID찾기">
		</form>
	</div>
	
	<div id="pwd_form">
		<form name="pf" method="post" action="pwd_search.jsp">
			<input type="text" name="userid" placeholder="ID"><p>
			<input type="text" name="name" placeholder="이름"><p>
			<input type="text" name="phone" placeholder="전화번호"><p>
						<input type="submit" value="비밀번호 찾기">
		</form>
	</div>
</div>
<c:import url="../bottom.jsp" />