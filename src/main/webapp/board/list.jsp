<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.BoardDao"%>
<%
	BoardDao bdao=new BoardDao();
	bdao.list(request);
%>
<style>
#section {
	width: 1100px;
	height: 800px;
	margin: auto;
}

#section table, #section tr, #section td{
	border:1px solid gray;
	border-collapse: collapse;
	text-align:center;
}

</style>



<c:import url="../top.jsp" />
<div id="section" align="center">

	<table style="width:600px;" >
	 <caption> 게시판</caption> 
		<tr>
			<td>제목</td>
			<td>작성자</td>
			<td>조회수</td>
			<td>작성일</td>
		</tr>
		
		
		<c:forEach items="${list}" var="bdto">
		<tr>
			<td><a href="readnum.jsp?id=${bdto.id}">${bdto.title}</a></td>
			<td>${bdto.userid}</td>
			<td>${bdto.readnum}</td>
			<td>${bdto.writeday}</td>
		</tr>
		</c:forEach>
		<tr>
		<td colspan="4"><a href="../board/write.jsp">새글 쓰기</a></td>
		</tr>
	</table>

</div>
<c:import url="../bottom.jsp" />