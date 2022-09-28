<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
<input type="button" onclick="add()" value="추가">
<input type="button" onclick="del()" value="삭제">
<hr>
<div id="outer">
	<p class="fname"><input type="file" name="fname1"></p>
	</div>


</body>
</html>