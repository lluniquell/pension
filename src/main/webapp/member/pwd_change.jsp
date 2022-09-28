<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
#section table, #section tr, #section td{


	text-align:center;
}

</style>
<script>
var pwd1=document.getElementsByClassName("pwd1")[0].value;
var pwd2=document.getElementsByClassName("pwd2")[0].value;
</script>
<c:import url="../top.jsp" />
<%	if(request.getParameter("chk") != null)
{
%>
<div> 입력한 비밀번호가 틀립니다.</div>
<%} %>
<br>
<div id="section" align="center">
	<form method="post" action="pwd_change_ok.jsp">
		<input type="password" name="old_pwd" placeholder="기존비밀번호">
		<p>
			<input type="password" name="pwd1" placeholder="변경할 비밀번호">
		<p>
			<input type="password" name="pwd2" placeholder="비밀번호 확인" onblur="pwd_chk(pwd1,pwd2)">
			<div id="pwd_err"></div>
		<p>
			<input type="submit" value="비밀번호 변경">
	</form>



</div>



<c:import url="../bottom.jsp" />