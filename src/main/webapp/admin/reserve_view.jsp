<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.AdminDao"%>
<%
AdminDao adao = new AdminDao();
adao.reserve_view(request);
%>

<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	margin: auto;
}
#section table, #section tr, #section td{
	border:1px solid gray;
	border-collapse: collapse;
	text-align:center;
}

</style>
<div id="section" align="center">
	<table style="align:center">
		<tr>
			<td>방이름</td>
			<td>입실일</td>
			<td>퇴실일</td>
			<td>예약자명</td>
			<td>연락처</td>
			<td>예약인원</td>
			<td>숯</td>
			<td>bbq</td>
			<td>총금액</td>
			<td>예약상태</td>
		</tr>
		<c:forEach items="${rlist}" var="rdto">
		<tr>
			<td>${rdto.bang_name}</td>
			<td>${rdto.inday}</td>
			<td>${rdto.outday}</td>
			<td>${rdto.user_name}</td>
			<td>${rdto.userphone}</td>
			<td>${rdto.inwon}</td>
			<td>${rdto.cpack}</td>
			<td>${rdto.bbqpack}</td>
			<td>${rdto.total}</td>
			<td>${rdto.state}</td>
		</tr>
		</c:forEach>
	</table>

</div>
<c:import url="../bottom.jsp" />