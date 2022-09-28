<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dao.ReserveDao"%>
<%
ReserveDao rdao = new ReserveDao();
rdao.reserve_view(session, request);
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
<br>
	<table style="width: 800px">
		<tr>
			<td>예약번호</td>
			<td>총인원</td>
			<td>방이름</td>
			<td>입실일</td>
			<td>퇴실일</td>
			<td>숯패키지</td>
			<td>bbq</td>
			<td>결제금액</td>
			<td>신청일</td>
			<td>예약 상태</td>
		</tr>
		<c:forEach items="${rlist}" var="rdto">
		<tr>
			<td>${rdto.id}</td>
			<td>${rdto.inwon}</td>
			<td>${rdto.bang_name}</td>
			<td>${rdto.inday}</td>
			<td>${rdto.outday}</td>
			<td>${rdto.cpack}</td>
			<td>${rdto.bbqpack}</td>
			<td>${rdto.total}</td>
			<td>${rdto.writeday}</td>
			<td>
				<c:if test="${rdto.state==0 and rdto.outday > ttoday}">
					예약완료					
					<input type="button" onclick="location='state_change.jsp?id=${rdto.id}&state=1'" value="예약취소">				
				</c:if>
				
				<c:if test="${rdto.state==1}">
					취소요청
					<input type="button" onclick="location='state_change.jsp?id=${rdto.id}&state=0'" value="취소철회">					
				</c:if>
				
				<c:if test="${rdto.state==2}">
					취소완료
				</c:if>
				<c:if test="${rdto.state==3}">
					사용완료
				    <input type="button" onclick="location='../tour/write.jsp'" value="후기쓰기">					
				</c:if>
			</td>
			
		</tr>
	 	</c:forEach>
	</table>

</div>
<c:import url="../bottom.jsp" />