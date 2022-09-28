<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="dao.BoardDao"%>
<%@page import="dao.GongjiDao"%>
<%@page import="dao.TourDao"%>
<%
BoardDao bdao = new BoardDao();
bdao.getThree(request);

GongjiDao gdao = new GongjiDao();
gdao.getThree(request);

TourDao tdao = new TourDao();
tdao.getThree(request);
%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

$(function()
{
		function mainmove() 
		{
			ss = setInterval(function() 
			{
				$("#image #inner").animate(
				{
					marginLeft : "-1100px"
				},2000,	function() 
						{
							$("#image #inner").css("margin-left", "0px");
							$("#image #inner img").eq(0).insertAfter($("#image #inner img").eq(3));
						});
			}, 4000);
		}
		mainmove();
	});
</script>


<!-- index.jsp -->
<c:import url="../top.jsp" />
<div id="third" align="center">
	<div id="image">
		<div id="outer">
			<div id="inner">
				<img src="../img/롤링1.jpg" width="1100" height="400"><img src="../img/롤링2.jpg" width="1100" height="400"><img src="../img/롤링3.jpg" width="1100" height="400"><img src="../img/롤링4.jpg" width="1100" height="400"><img src="../img/롤링5.jpg" width="1100" height="400">
			</div>
		</div>
	</div>

</div>
<br>
<div id="fourth">
	<div id="gongji">
		공지사항
		<table>
			<c:forEach items="${glist}" var="gdto">
				<tr>
					<td><a href="../gongji/content.jsp?id=${gdto.id}">${gdto.title}</a></td>
					<td>${gdto.writeday}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="tour">
		여행후기
		<table>
			<c:forEach items="${tlist}" var="tdto">
				<tr>
					<td><a href="../tour/content.jsp?id=${tdto.id}">${tdto.title}</a></td>
					<td>${tdto.userid}</td>
					<td>${tdto.writeday}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div id="board">
		자유게시판
		<table>
			<c:forEach items="${blist}" var="bdto">
				<tr>
					<td><a href="../board/content.jsp?id=${bdto.id}">${bdto.title}</a></td>
					<td>${bdto.userid}</td>
					<td>${bdto.writeday}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<br>
<c:import url="../bottom.jsp" />
