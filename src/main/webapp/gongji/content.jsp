<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dao.GongjiDao" %>
<%
		GongjiDao gdao =new GongjiDao();
		gdao.content(request);
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
<table style="width:500px;">
	<tr>
		<td>${gdto.title}</td>
		<td>${gdto.writeday }</td>
	</tr>
	<tr>
		<td colspan="2">
		${gdto.content}
		</td>
	</tr>	
	<tr>
		<td colspan="2">
		<a href="../gongji/list.jsp">목록</a> 
		<c:if test="${userid == 'admin'}">
			<a href="../gongji/update.jsp?id=${gdto.id}">
			수정</a>
			<a href="../gongji/delete.jsp?id=${gdto.id}">삭제
			</a>
			
			 
		</c:if>
		</td>
	</tr>
	
	

</table>

</div>
<c:import url="../bottom.jsp" />