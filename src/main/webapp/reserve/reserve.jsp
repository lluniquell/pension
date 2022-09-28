<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@page import="dao.ReserveDao"%>
<%
ReserveDao rdao = new ReserveDao();
rdao.getCalendar(request,session,response);
rdao.getRoom(request);
%>
<c:import url="../top.jsp" />

<style>
#section {
	width: 1100px;
	margin: auto;
}

#section tr {
	height: 50px;
	
}

#section table, #section tr, #section td{
	border:1px solid gray;
	border-collapse: collapse;
	text-align:center;
}

</style>
<div id="section" align="center">

<br>
	<table style="width: 1100px;">
		<caption>

			<c:if test="${m==1}">
				<a href="reserve.jsp?y=${y-1}&m=12">◁</a>
			</c:if>

			<c:if test="${m!=1}">
				<a href="reserve.jsp?y=${y}&m=${m-1}">◁</a>
			</c:if>

			${y}년 ${m}월

			<c:if test="${m==12}">
				<a href="reserve.jsp?y=${y+1}&m=1">▷</a>
			</c:if>

			<c:if test="${m!=12}">
				<a href="reserve.jsp?y=${y}&m=${m+1}">▷</a>
			</c:if>


		</caption>
		<br>
		<tr valign="top">
			<td width="142">일</td>
			<td width="142">월</td>
			<td width="142">화</td>
			<td width="142">수</td>
			<td width="142">목</td>
			<td width="142">금</td>
			<td width="142">토</td>
		</tr>
		<c:set var="day" value="1" />
		<c:forEach var="i" begin="1" end="6">
			<tr valign="top">
				<c:forEach var="j" begin="0" end="6">
					<c:if test="${((j<yoil) && (i == 1)) || (chong < day) }">
						<td>&nbsp;</td>
					</c:if>

					<c:if test="${((j>=yoil) && (i==1) || i>1) && (chong >= day)}">
						<td>${day}
							<p>
								<%
								String y = request.getAttribute("y").toString();
								String m = request.getAttribute("m").toString();
								String d = pageContext.getAttribute("day").toString();
								String dday = y + "-" + m + "-" + d;
								
								rdao.getcheck(y,m,d,request);
								%>


								<c:if test="${tt==1}">
									<c:forEach items="${rlist}" var="rdto">
										<!--  방의 예약여부를 확인 ->dao메소드 년,월,일,방id -->
										<c:set var="bang_id" value="${rdto.id}" />
										
										<%
										String bang_id = pageContext.getAttribute("bang_id").toString();
										rdao.getEmpty(dday, bang_id, request);
										%>
										<c:if test="${cnt==0}">
											<a href="reserve_next.jsp?y=${y}&m=${m}&d=${day}&id=${rdto.id}">방이름
												: ${rdto.bang}</a>
											<br>
											가격 : ${rdto.price}<br>
											상태 :
											<c:if test="${rdto.state==0}">
											예약가능
											</c:if>
					    					<p>
										</c:if>

										<c:if test="${cnt>=1}">
											<span style="color: red">방이름 : ${rdto.bang}</span>
											<p>
										</c:if>
									</c:forEach>
								</c:if>
						</td>
						<c:set var="day" value="${day+1}" />
					</c:if>
				</c:forEach>
			</tr>
		</c:forEach>

	</table>
</div>
<c:import url="../bottom.jsp" />