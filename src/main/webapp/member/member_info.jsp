<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dao.MemberDao"%>
<%
MemberDao mdao = new MemberDao();
mdao.member_info(session, request);

//jsp에 출력할 내용은 request 객체에서 저장됨
// EL 표현식으로 접근, jstl을 사용
%>
<!-- index.jsp -->

<c:import url="../top.jsp" />
<div align="center">
<table style="width:500px;" >
	<caption>
		회원 정보
	</caption>

	<tr>
		<td>아이디</td>
		<td>${userid}</td>

	</tr>
	<tr>
		<td>이름</td>
		<td>${name}</td>
	</tr>
	<tr>
		<td>이메일</td>
		<td>${email}</td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td>${phone}</td>
	</tr>
	<tr>
		<td colspan="2">
		<span onclick="location='info_change.jsp'"> 정보수정</span>
		<span onclick="location='pwd_change.jsp'"> 비밀번호 변경</span>
		<span onclick="location='member_quit.jsp'"> 회원 탈퇴</span>
		</td>
	</tr>

</table>
</div>
<c:import url="../bottom.jsp" />