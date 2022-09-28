<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.GongjiDao"%>
<%
GongjiDao gdao = new GongjiDao();
gdao.list(request);
%>

<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}

#section #tb, #section #tb tr, #section #tb td{
	border:1px solid gray;
	border-collapse:collapse;
	text-align:center;
}
</style>
<div id="section" align="center">
<br>
	<table id="tb" style="width: 600px;">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
		</tr>
		<c:forEach items="${list}" var="gdto">
			<tr>
				<td>${gdto.id}</td>
				<td>
					<c:if test="${gdto.gubun == 1}">
						<img src="../img/gg.png">
					</c:if>
					<a href="content.jsp?id=${gdto.id}">
					${gdto.title}</a></td>
				<td>관리자</td>
				<td>${gdto.writeday}</td>
			</tr>
		</c:forEach>
		<c:if test="${userid == 'admin'}">
			<tr>
				<td colspan="4"><a href="../gongji/write.jsp">공지글 쓰기</a></td>
			</tr>
		</c:if>

	</table>

</div>
<c:import url="../bottom.jsp" />