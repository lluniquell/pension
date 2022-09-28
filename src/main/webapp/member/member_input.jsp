<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
#err{

}
</style>
<script>
var pwd1=document.getElementsByClassName("pwd1")[0].value;
var pwd2=document.getElementsByClassName("pwd2")[0].value;
</script>
<c:import url="../top.jsp" />
<div id="section" align="center">
<form method="post" action="../member/member_input_ok.jsp">
	<table style="width:500px;" >
		<caption>
			회원 가입
		</caption>
		
		<tr>
			<td>아이디</td>
			<td>
			<input type="text" name="userid" onblur="userid_check(this.value)">
			<div id="id_err"></div>
			</td>
					
		</tr>

		<tr>
			<td>이름</td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="pwd1"></td>
		</tr>
		<tr>
			<td>비밀번호확인</td>
			<td><input type="password" name="pwd2" onblur="pwd_chk(pwd1,pwd2)"> <!--  -->
			<div id="pwd_err"></div>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="phone"></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="가입하기"> </td>
		</tr>

	</table>

</form>

</div>
<c:import url="../bottom.jsp" />