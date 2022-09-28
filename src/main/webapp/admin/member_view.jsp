<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.AdminDao"%>
<%
AdminDao adao = new AdminDao();
adao.member_check(request);



%>
<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}

#section table, #section tr, #section td{
	border:1px solid gray;
	border-collapse: collapse;
	text-align:center;
}

</style>
<div id="section" align="center">
	<table>
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>전화번호</td>
			<td>이메일</td>
			<td>가입일</td>
			<td>회원상태</td>
		</tr>
		<c:forEach items="${mlist}" var="mdto">
			<tr>
				<td>${mdto.userid}</td>
				<td>${mdto.name}</td>
				<td>${mdto.phone}</td>
				<td>${mdto.email}</td>
				<td>${mdto.writeday}</td>
				<td>
				<c:if test="${mdto.state == 0}">		
				정상회원
				</c:if>
				<c:if test="${mdto.state == 1}">					
				탈퇴요청회원 <a href="../member/member_quit.jsp">탈퇴처리</a>
				</c:if>
				<c:if test="${mdto.state == 2}">		
				탈퇴회원
				</c:if></td>
			</tr>
		</c:forEach>



	</table>


</div>
<c:import url="../bottom.jsp" />