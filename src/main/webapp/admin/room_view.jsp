<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page import="dao.AdminDao" %>
<%
	AdminDao adao=new AdminDao();
	adao.room_view(request);
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
<script>
function content_view(id){
	var chk=new XMLHttpRequest();
	var top=event.pageX;
	var left=event.pageY;
	chk.open("get","content_view.jsp?id="+id);
	chk.send();
	chk.onreadystatechange=function(){
		if(chk.readyState==4){
			document.getElementById("content_Layer").innerHTML=chk.responseText;
			document.getElementById("content_Layer").style.top=top+px;
			document.getElementById("content_Layer").style.left=left+px;
		}
	}
}
function content_hide(){
	document.getElementById("content_Layer").style.visibiltiy="hidden";
}

</script>
<div id="content_Layer"></div>
<br>
<div id="section" align="center">
<table>
	<tr>
		<td>방이름</td>
		<td>최소인원</td>
		<td>최대인원</td>
		<td>1박 가격</td>
		<td>상태</td>
		<td>수정</td>
		<td>삭제</td>
	</tr>
	<c:forEach items="${rlist}" var="rdto">
		<tr>
		<td onmouseover="content_view(${rdto.id})" onmouseout="content_hide()">${rdto.bang}</td>
		<td>${rdto.min}</td>
		<td>${rdto.max}</td>
		<td><fmt:formatNumber value="${rdto.price}" /></td>
		<td>
	<c:if test="${rdto.state == 0}">
		정상운영
	</c:if>
	<c:if test="${rdto.state == 1}">
		공사중
	</c:if>
	</td>
	<td>
	<a href="room_edit.jsp?id=${rdto.id}">수정</a>
	</td>
    <td>
	<a href="room_edit.jsp?id=${rdto.id}">삭제</a>
	</td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="7"><a href="">객실 추가</a></td>
	</tr>

</table>

</div>
<c:import url="../bottom.jsp" />