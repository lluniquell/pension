<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.TourDao"%>
<%
TourDao tdao = new TourDao();
tdao.list(request);
%>
<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
</style>
<div id="section" align="center">
	<table style="width: 500px">
		<tr>

			<td>번호</td>
			<td>사진</td>
			<td>제목</td>
			<td>작성자</td>
			<td>조회수</td>
			<td>작성일</td>
		</tr>

		<c:forEach items="${list}" var="tdto">

		<tr>
			<td>${tdto.id}</td>
			<td><img src="../tour/img/${tdto.fname}" width="50"></td>
			<td><a href="../tour/readnum.jsp?id=${tdto.id}">${tdto.title}</a></td>
			<td>${tdto.userid}</td>
			<td>${tdto.readnum}</td>
			<td>${tdto.writeday}</td>
		</tr>
		</c:forEach>
		<c:if test="${!(userid == null)}">
		<tr>
		<td colspan="5"><a href="../tour/write.jsp">새글쓰기</a></td>
		</tr>
		
		</c:if>
	</table>


</div>
<c:import url="../bottom.jsp" />