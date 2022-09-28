<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.AdminDao"%>
<%
AdminDao adao = new AdminDao();
adao.content_view(request, out);
%>
<div style="width: 100px; height: 100px; border: 1px solid red; background: white">
	<%-- <%=content%> --%>
</div>