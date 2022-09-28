<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.MemberDao" %>    
<%
    // login_ok()메소드를 호출하여 회원여부 체크
    MemberDao mdao=new MemberDao();
    mdao.login_ok(request,session,response);
%>   