<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.left {
	width: 130px;
	height: 25px;
	background: rgb(250, 249, 244);
}
</style>
<script>
	function input_email(){
		var email2=document.getElementById("email2");
		var email3=document.getElementById("email3");
		 
		email2.value=email3.value;
		
		 if(email3.selectedIndex==0)
	    {   
			email2.innerText="";
			email2.readOnly=false;			
	    } else {
	    	email2.readOnly=true;
	    } 	    	
		 
	}
	 

</script>

</head>
<body>
	<div align="center">
		<form method="post" action="join_ok">
			<table width="800px">
				<tr>
					<td align="left">기본 입력</td>
					<td align="right"><span style="color: red">*</span> 표시 필수입력사항</td>

				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>성명(국문)</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>생년월일</td>
					<td><select name="yy">
							<c:forEach var="i" begin="1900" end="2022" step="1">
								<option>${i}</option>
							</c:forEach>
					</select> 년 <select name="mm">
							<c:forEach var="i" begin="1" end="12" step="1">
								<option>${i}</option>
							</c:forEach>
					</select> 월 <select name="dd">
							<c:forEach var="i" begin="1" end="31" step="1">
								<option>${i}</option>
							</c:forEach>
					</select> 일</td>
				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>이메일</td>
					<td>
						<input type="text" name="email1"> @ 
						<input type="text" id="email2" name="email2" readonly >  
						<select id="email3" onchange="input_email()">
							<option>직접입력</option>
							<option>naver.com</option>
							<option>hanmail.net</option>
							<option>nate.com</option>
							<option>gmail.com</option>
							<option>hotmail.com</option>
							<option>yahoo.com</option>
						</select>						
						
						<input type="button" value="이메일 중복확인"></td>
				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>휴대전화</td>
					<td>010-셀렉트박스 - <input type="text" name="phone2"> - <input
						type="text" name="phone3"></td>
				</tr>
				<tr>
					<td class="left">자택전화</td>
					<td>선택 - <input type="text" name="hphone2"> - <input
						type="text" name="hphone3"></td>
				</tr>
				<tr>
					<td class="left">자택주소</td>
					<td></td>
				</tr>
			</table>
			<br>
			<table width="800px">
				<tr>
					<td colspan="2">웹사이트 비밀번호 입력</td>
				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>아이디</td>
					<td><input type="text" name="userid"><input
						type="button" value="아이디 중복확인"> 5~12자 이내 영문 또는 영문/숫자 조합</td>
				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>비밀번호</td>
					<td><input type="text" name="pwd"> 8~20자 이내 영문/숫자
						조합(특수문자 입력 가능)</td>
				</tr>
				<tr>
					<td class="left"><span style="color: red">*</span>비밀번호 확인</td>
					<td><input type="text" name="pwd1">
				</tr>
				<tr>
					<td colspan="2"><input align="center" type="submit"
						value="가입 신청"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>