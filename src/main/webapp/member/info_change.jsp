<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}

</style>

<c:import url="../top.jsp" />

<div id="section" align="center">
<form method="post" action="info_change_ok.jsp">
	<table>
		<tr>
			<td>ID</td>
			<td>${userid}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${name}</td>			
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email" placeholder="${mdao.email}"></td>			
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="phone" placeholder="${mdao.phone}"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="정보변경"></td>
		</tr>	
	
	</table>
</form>

</div>



<c:import url="../bottom.jsp" />