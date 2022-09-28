<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
</style>
<div id="section" align="center">
	<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
		<table style="width: 500px">
			<caption>여행후기 작성</caption>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" size="40"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="40" rows="6" name="content"></textarea></td>
			</tr>
			<tr>
				<td>파일</td>
				<td><input type="file" name="fname"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="전송"></td>
			</tr>
		</table>
	</form>
</div>
<c:import url="../bottom.jsp" />