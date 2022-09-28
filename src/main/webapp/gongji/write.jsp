<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

table,table tr, table td{
	text-align:center;
}
</style>
<div id="section" align="center">
<form method="post" action="write_ok.jsp">
<br>
	<table style="width:500px" >
	<caption>공지사항 글쓰기</caption>
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" style="width :305px"></td>		
		</tr>
			<tr>
			<td>내용</td>
			<td><textarea cols="40" rows="5" name="content"></textarea></td>		
		</tr>
		<tr>
			<td colspan="2">
			<input type="checkbox" name="gubun" value="1">
			이글을 항상 첫페이지에 출력하려면 체크하세요
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="저장"></td>		
		</tr>
	
	</table>
</form>
</div>
<c:import url="../bottom.jsp" />