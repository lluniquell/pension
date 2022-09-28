<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dao.ReserveDao"%>
<%
ReserveDao rdao = new ReserveDao();
rdao.reserve_next(request);
//reserve_next 에서 rdto 생성해서 request 업로드
//만들어진 rdto를 getSuk에서 다시 불러와서 사용

rdao.getSuk(request);
%>

<c:import url="../top.jsp" />
<style>
#section {
	width: 1100px;
	height: 500px;
	margin: auto;
}

#section table, td, tr{
	text-align:center;
}



</style>
<script>
	function total_price(){ // 총가격 구하는 함수
	
		// 숙박, 인원, 숯, bbq의 선택값을 가져와서 각각 금액을 구한다
		//숙박
		var ss=document.reser.suk.value;
		var ssprice=ss*${rdto.price};
		
		var ii=document.reser.inwon.value;
		var iiprice=(ii-${rdto.min})*20000;
		
		var cc=document.reser.cpack.value;
		var ccprice=cc*20000;
		
		var bb=document.reser.bpack.value;
		var bbprice=bb*50000;
		
		var tt=ssprice+iiprice+ccprice+bbprice;
		//total
		document.getElementById("cal1").innerText=comma(ssprice);
		document.getElementById("cal2").innerText=comma(iiprice);
		document.getElementById("cal3").innerText=comma(ccprice);
		document.getElementById("cal4").innerText=comma(bbprice);
				
		document.getElementById("total").innerText=comma(tt);
		
		// form 태그내에 총금액을 전달
		document.reser.total.value=tt;
		}
	
	function comma(pp){
		return new Intl.NumberFormat().format(pp);
	}
	
	
		
</script>

<div id="section" align="center" >
	<form name="reser" method="post" action="reserve_ok.jsp">
	<input type="hidden" name="inday" value="${ymd}">
	<input type="hidden" name="bang_id" value="${rdto.id}">
	<input type="hidden" name="total" value="${rdto.price}">
	<br>
	<table style="width: 600px;">
		<tr>
			<td>입실일</td>
			<td>${ymd}</td>
			<td>숙박일수</td>
			<td><select name="suk" onchange="total_price()">
					<c:forEach begin="1" end="${chk}" var="i"> 
					<option value="${i}">${i}박</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td>인원</td>
			<td>최소인원 : ${rdto.min}<br>
				최대인원 : ${rdto.max}
			</td>
			<td>입실인원</td>
			<td><select name="inwon" onchange="total_price()">
					<c:forEach begin="${rdto.min}" end="${rdto.max}" var="i">
						<option value="${i}">${i}명</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr><td colspan="4">&nbsp;</td></tr>
		<tr>
			<td colspan="4">
			 숯패키지	
			<select name="cpack" onchange="total_price()" class="chk" >
			
					<option value="0">없음</option>
					<option value="1">1개</option>
					<option value="2">2개</option>
					<option value="3">3개</option>
					<option value="4">4개</option>
					<option value="5">5개</option>
			</select> 
			bbq
			<select name="bpack" onchange="total_price()" class="chk">
					<option value="0">없음</option>
					<option value="1">1개</option>
					<option value="2">2개</option>
					<option value="3">3개</option>
					<option value="4">4개</option>
					<option value="5">5개</option>
			</select>
				<p></td>
		</tr>
		<tr>
			<td></td>
			<td>숙박 가격</td>
			<td colspan="2"><span id="cal1">${rdto.price}</span>원</td>
		</tr>
		<tr>
			<td></td>
			<td>인원 추가</td>
			<td colspan="2"><span id="cal2">0</span>원</td>
		</tr>
		<tr>
		<td></td>
			<td>숯 패키지</td>
			<td colspan="2"><span id="cal3">0</span>원</td>
		</tr>
		<tr>
		<td></td>
			<td>bbq</td>
			<td colspan="2"><span id="cal4">0</span>원</td>
		</tr>
		<tr>
		<td></td>
			<td>총 합계</td>
			<td colspan="2"><span id="total">0</span>원</td>
		</tr>
		<tr><td colspan="4">&nbsp;</td></tr>
		<tr>
			<td colspan="4"><input type="submit" value="결제하기"></td>
		</tr>
	</table>
</form>



</div>
<c:import url="../bottom.jsp" />