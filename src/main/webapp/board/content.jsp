<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dao.BoardDao"%>
<%
BoardDao bdao = new BoardDao();
bdao.content(request);
%>
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}

#del {
	display: none;
}
#section table, #section tr, #section td{
	border-top:1px solid gray;
	border-bottom:1px solid gray;
	border-collapse: collapse;
	text-align:center;
}

</style>
<script>
	function del_form() {
		document.getElementById("del").style.display = "table-row";

	}
</script>

<c:import url="../top.jsp" />
<div id="section" align="center">
	<table style ="width:500px;" >
		<tr>
			<td>제목</td>
			<td colspan="3">${bdto.title}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${bdto.userid}</td>
			<td>조회수</td>
			<td>${bdto.readnum}</td>
		</tr>
		<tr height="200">
			<td>내용</td>
			<td colspan="3">${bdto.content}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td colspan="3">${bdto.writeday}</td>
		</tr>
		<!-- 목록
			guest 인 경우
			- 테이블의 userid가 guest 인것만 수정 삭제가 보이게
			login 한 경우는 
			- guest는 보이고
			- guest가 아닌 경우 세션과 테이블의 userid가 같다면 보이게
			
		 -->

		<tr>
			<!-- board 테이블의 userid 필드가 admin인경우 -->
			<c:if test="${(userid == 'admin')}">
			<td colspan="2">
					<a href="../board/list.jsp">목록</a></td>
			<td colspan="2">		
					<a href="../board/delete.jsp?id=${bdto.id}">삭제</a>
			</td>			
			</c:if>
			<c:if test="${!(userid == 'admin')}">
			
			<c:if test="${(bdto.userid == 'guest') || (bdto.userid == userid)}">
				<td><a href="../board/update.jsp?id=${bdto.id}">수정</a></td>
				<td colspan="2">
					<a href="../board/list.jsp">목록</a>
					 <c:if test="${(bdto.userid=='guest')}">
						<a href="javascript:del_form()">삭제</a>
						<!-- guest일 경우 삭제 입력폼이 존재 -->
					</c:if>
					
				    <c:if test="${bdto.userid == userid}">
						<td>
							<a href="../board/delete.jsp?id=${bdto.id}">삭제</a> <!-- 로그인을 해서  -->
							</td>
					</c:if>
			</c:if>
			<c:if test="${!((bdto.userid == 'guest') || (bdto.userid == userid))}">
				<td colspan="4" align="center">
					<a href="../board/list.jsp">목록</a>		</td>
			</c:if>
			</c:if>
	
		</tr>
		<tr id="del">
			<td colspan="4">
				<form method="post" action="delete.jsp">
					<input type="hidden" name="id" value="${bdto.id}"> 
					<input type="password" name="pwd">
					<input type="submit" value="삭제">
				</form>
			</td>

		</tr>

	</table>



</div>
<c:import url="../bottom.jsp" />