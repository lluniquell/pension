//pension.js

// member_input.jsp
function userid_check(userid){
	var chk=new XMLHttpRequest();
	
	if(userid.trim()!="")
	{
	chk.open("get","userid_check.jsp?userid="+userid);
	chk.send();
	
		chk.onreadystatechange=function(){
			if(chk.readyState==4){
				if(chk.responseText.trim()=="0"){
					document.getElementById("id_err").innerText="사용가능한 아이디";
				}else{
					document.getElementById("id_err").innerText="사용이 불가능한 아이디";
				}
			}
		}
	}
}

function pwd_chk(pwd1,pwd2){

	if(pwd1.value==pwd2.value){
		document.getElementById("pwd_err").innerText="비밀번호가 일치합니다.";
	}else{
		document.getElementById("pwd_err").innerText="비밀번호가 일치하지 않습니다.";
	}
}
	
