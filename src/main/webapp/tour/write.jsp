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
#submit{
text-align:center;
}
</style>
	<script>
 	var size=1;
 	function add(){
 		size++;
 		var inner="<p class='fname'><input type='file' name='fname"+size+"'></p>";
 		var outer=document.getElementById("outer");
 		outer.innerHTML=outer.innerHTML+inner;
 		
 	}
 	
 	function del(){
 		if(size<=1){
 			
 		}else{
 		document.getElementsByClassName("fname")[size-1].remove();
 		size--;
 		}
 	}
 	
 	</script>
<div id="section" align="center">
	<form method="post" action="write_ok.jsp" enctype="multipart/form-data">
		<table style="width: 500px">
			<caption>여행후기 작성</caption>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" size="41.8"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="40" rows="6" name="content"></textarea></td>
			</tr>
			<tr>
				<td>파일</td>
				<td id="outer">
				<input
					type="button" onclick="add()" value="추가"> <input
					type="button" onclick="del()" value="삭제">
				<p class="fname"><input type="file" name="fname"> </td>
			</tr>
			<tr>
				<td colspan="2" id="submit"><input type="submit" value="전송"></td>
			</tr>
		</table>
	</form>
</div>
<c:import url="../bottom.jsp" />