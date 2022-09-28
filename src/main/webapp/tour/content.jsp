<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.TourDao"%>
<%
TourDao tdao = new TourDao();
tdao.content(request);

%>

<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
#section table, #section tr, #section td{
	border-top:1px solid gray;
	border-bottom:1px solid gray;
	border-collapse: collapse;
	text-align:center;
}


</style>
<br>
<div id="section" align="center">
	<table style="width: 500px">
		<tr>
			<td>제목</td>
			<td colspan="5">${tdto.title}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${tdto.userid}</td>
			<td>작성일</td>
			<td>${tdto.writeday}</td>
			<td>조회수</td>
			<td>${tdto.readnum}</td>
		</tr>
		<tr>
			<td colspan="6">

			<c:forEach items="${tdto.file}" var="my">
			<img width="100" src="../tour/img/${my}">
			</c:forEach>
			
				<hr> ${tdto.content}</td>
		</tr>
		<c:if test="${!(userid==null)}">
			<tr>
				<td colspan="2"><a href="../tour/list.jsp">목록</a></td>
				
				<c:if test="${tdto.userid==userid}">				
				<td colspan="2"><a href="../tour/update.jsp?id=${tdto.id}">수정</a></td>
				<td colspan="2"><a href="../tour/delete.jsp?id=${tdto.id}">삭제</a></td>
				</c:if>
			</tr>
		</c:if>
		<c:if test="${(userid==null)}">
			<tr>
				<td colspan="6"><a href="../tour/list.jsp">목록</a></td>
			</tr>
		</c:if>



	</table>
</div>



<c:import url="../bottom.jsp" />