<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dao.TourDao"%>
<%
TourDao tdao = new TourDao();
tdao.content(request);
%>
<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}
</style>
<script>
	var size=1;
	function add_file(){
		size++;
		var outer=document.getElementById("outer");
		var inner="<p class='fname'><input type='file' name='fname"+size+"'></p>";

		outer.innerHTML=outer.innerHTML+inner;		
	}
	
	function del_file(){
		if(size>1){
			document.getElementsByClassName("fname")[size-1].remove();
			size--;
		}
	}
	
 	function del_add(n,my)
 	{
 		if(my.checked){
 		document.getElementsByClassName("cimg")[n].style.opacity="0.3";
 		} else {
 		document.getElementsByClassName("cimg")[n].style.opacity="1";
 		}
 	}
 	
 	function check(upform)
 	{
 		var len=document.getElementsByName("chk").length;
 		var del=""; // 삭제할 파일을 저장
 		var str=""; // 삭제하지 않을 파일을 저장
 		
 		for(i=0;i<len;i++)
        {
 			if(document.getElementsByName("chk")[i].checked)
 				{
 				 del=del+document.getElementsByName("chk")[i].value+",";
 				}else{
 		         str=str+document.getElementsByName("chk")[i].value+",";
 				}
        } 	
 		

 	
 		upform.del.value=del;
 		upform.str.value=str;
 		
 		return true;
 	}
 	
 	</script>

<div id="section">
	<form method="post" action="update_ok.jsp" onsubmit="return check(this)" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${tdto.id}">
		<input type="hidden" name="del">
		<input type="hidden" name="str">
		
		<table style="width:500px">
			<caption>여행후기 수정</caption>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title" size="40" value="${tdto.title}">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="40" rows="6" name="content">${tdto.content}</textarea></td>
			</tr>
			<tr>
				<td>사진</td>
				<td>
					<c:set var="t" value="0"/>
						<c:forEach items="${tdto.file}" var="img">
							<img src="img/${img}" width="50" height="50" class="cimg">
							<input type="checkbox" onclick="del_add(${t},this)" name="chk" value="${img}" >
							<c:set var="t" value="${t+1}"/>
						</c:forEach>
					<p><span>삭제하시려면 체크하세요</span>
				</td>
			</tr>
			<tr>
				<td>추가</td>
				<td id="outer">
					<input type="button" onclick="add_file()" value="추가">
					<input type="button" onclick="del_file()" value="삭제">
					<p class="fname">
						<input type="file" name="fname1"></p>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="수정"></td>
			</tr>
		</table>
	</form>
</div>

<c:import url="../bottom.jsp" />