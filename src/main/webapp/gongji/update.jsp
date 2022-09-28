<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.GongjiDao" %>
<%
		GongjiDao gdao =new GongjiDao();
		gdao.content(request);
%>

<c:import url="../top.jsp" />
<c:if test="${userid != 'admin'}">
	<c:redirect url="../main/index.jsp"/>
</c:if>
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
</style>
<div id="section" align="center">
<form method="post" action="update_ok.jsp">
	<input type="hidden" name="id" value="${gdto.id}">
	<table style="width:500px" >
	<caption>공지사항 수정</caption>
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" value="${gdto.title}"></td>		
		</tr>
			<tr>
			<td>내용</td>
			<td><textarea cols="40" rows="5" name="content">
			${gdto.content}
			</textarea></td>		
		</tr>
				<tr>
			<td colspan="2">
			<c:if test="${gdto.gubun==1}">
				<c:set var="gu" value="checked"/>
			</c:if>
			<input type="checkbox" name="gubun" value="1" ${gu}>
			이글을 항상 첫페이지에 출력하려면 체크하세요
			</td>
			<td colspan="2"><input type="submit" value="수정"></td>		
		</tr>
	
	</table>
</form>
</div>
<c:import url="../bottom.jsp" />