<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 / 비밀번호 찾기</title>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	
	<script type="text/javascript">
	// 하이픈 자동 입력 스크립트
	var autoHypenPhone = function(str){
      	str = str.replace(/[^0-9]/g, '');
      	
     	 	var tmp = '';
     	 	
      	if( str.length < 4){
          	return str;
          	
      	} else if(str.length < 7){
          	tmp += str.substr(0, 3);
          	tmp += '-';
          	tmp += str.substr(3);
          	return tmp;
          	
      } else if(str.length < 11){
          	tmp += str.substr(0, 3);
          	tmp += '-';
          	tmp += str.substr(3, 3);
          	tmp += '-';
          	tmp += str.substr(6);
          	return tmp;
          	
      } else {              
          	tmp += str.substr(0, 3);
          	tmp += '-';
          	tmp += str.substr(3, 4);
          	tmp += '-';
          	tmp += str.substr(7);
          	return tmp;
      }
  
      return str;
}

	// 적용
	window.onload = function () {
		
		var phone = document.getElementById('phone');
		
		phone.onkeyup = function(){
		  	console.log(this.value);
		  	this.value = autoHypenPhone( this.value ) ;  
		}
	};
	</script>
	
	<script type="text/javascript">
	
	// 아이디 찾기 - 정보 입력
	function find_id(f){
		var name = f.name_e;
		var phone = f.phone;
		
		
		if (!name.value) {
			alert("이름을 입력하세요");
			name.focus();
			return;
		}
		if (!phone.value) {
			alert("전화번호를 입력해주세요");
			phone.focus();
			return;
		}
		
		var patt = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
		
		if ( ! patt.test(phone.value) ) {
			alert("전화번호 형식이 올바르지 않습니다.");
			return;
		}
		 
		var conf = confirm("입력하신 번호로 인증 SMS를 발송할까요? ");
		
		if ( !conf ) {
			return;
		}
		
		var url = "user_find_phone_certificate.do";
		var param = "phone=" + encodeURIComponent(phone.value) + "&name=" + encodeURIComponent(name.value)
		sendRequest(url, param, phone_certificate, "get");
	}
	
	// 핸드폰 인증 resultFn
	function phone_certificate() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
		
			var phone = document.getElementById("phone");
			var res = JSON.parse(xhr.responseText);

			if ( res.tempKey != null ){
				
				if ( res.tempKey == "not_member" ) {
					alert("회원 정보로 등록되지 않은 정보입니다.");
					return;
				}
				
				alert("입력하신 전화번호로 인증키가 발송되었습니다. SMS를 확인해주세요. ");
				
				var key = res.tempKey;
				var email = res.email;
				
				location.href="#open_phone";
				
				// body 내부에 input hidden으로 결과값을 숨겨둔다.
				  var key_tag = document.createElement("input");
				
				  key_tag.setAttribute("type", "hidden");
				  key_tag.setAttribute("id", "key");
				  key_tag.setAttribute("value", res.tempKey);
			      document.forms[0].appendChild(key_tag);
			      
			      var email_tag = document.createElement("input");
					
			      email_tag.setAttribute("type", "hidden");
			      email_tag.setAttribute("id", "email");
			      email_tag.setAttribute("value", email);
			      document.forms[0].appendChild(email_tag);
				
			} else {
				alert("문제가 발생했습니다... 재시도해주십시오.");
				return;
			} 
		}
	}
	
	// 인증키 인증 버튼
	function certificateBtn_phone( ) {
		var key_input = document.getElementById("key-input");
		
		// hidden으로 숨겨둔 값 불러오기
		var key = document.getElementById("key").value;
		var email = document.getElementById("email").value;
		var email_info = document.getElementById("email_info");
		
		if( key_input.value == "" ){
			alert("인증키를 입력해주세요.");
			return;
		} 
		
		if ( key == key_input.value ) {
			
			email_info.value = email;
			
			alert("인증되었습니다.");
			
			location.href="#open_email_info";
			
			return;
			
		} else {
			alert("인증키가 올바르지 않습니다.");
			return;
		}
	}
	
	// 비번 찾기
	function find_pwd(f){
		var name = f.name_p;
		var email = f.email;
		
		if (!name.value) {
			alert("이름을 입력하세요");
			name.focus();
			return;
		}
		if (!email.value) {
			alert("이메일을 입력해주세요");
			email.focus();
			return;
		}
		
		var email_patt = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if ( ! email_patt.test( email.value ) ) {
			alert("이메일 형식이 올바르지 않습니다. ");
			return;
		}
		
		// 2. DAO에서 일치하는 이메일 정보가 있는지 확인 ( 이메일 중복 체크 메서드 사용하면 됨 )
		// 일치하는 vo의 name이 입력값과 일치하는지도 확인 !!
		// 전화번호 인증 메서드 참고하세여 ( 문자 보내는 메서드 빼고 )
		// 만약 일치하는 정보가 없다면 주석으로 회원 정보 없음 체크해놓고
		// 있으면 회원 정보 있음 이라고 체크해두세요.

	}
	
	
	</script>
	
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<!-- 페이지-->
	<div class="body-bgcolor-set">
		<div class="user-find pt190"><br><br>
			<!-- id찾기 -->
			<form class="contents-box inner-box" >
				<p class="section-title blue">아이디 찾기</p> 
				<div class="find-input line-bottom">
					<div class="find-input-text">
						<div>
							<label>이 &nbsp; &nbsp; &nbsp; 름&nbsp; &nbsp;
								<input type="text" name="name_e" placeholder="이름을 입력해주세요.">
							</label>
						</div>
						<div>
							<label>전화번호&nbsp; &nbsp;
									<input type="text" name="phone" id="phone" placeholder="'-'는 자동으로 입력됩니다.">
							</label>
						</div>
					</div>	
					<input type="button" value="SMS 인증" class="my-btn yellow-black" onClick="find_id(this.form);">
				</div>
			</form>

			<!-- 인증키 입력 모달 -->
			<div class="info_content input" id="open_phone">
				<div><br>
					<p class="section-discription tal">
						입력하신 전화번호로 인증 문자가 발송되었습니다. <br><br>
						<input type="text" id="key-input" placeholder="SMS로 전송된 6자리 인증키를 입력해주세요.">
					</p><br>
					<input type="button" class="my-btn yellow-black" onClick="certificateBtn_phone();" value="인증하기" />
					<input type="button" class="my-btn yellow-black" onClick="location.href='#close_phone'" value="취소" />
				</div>
			</div>
			
			<!-- 회원정보 안내 모달  -->
			<div class="info_content input" id="open_email_info">
				<div><br>
					<p class="section-discription tal">
						아래의 이메일로 로그인해주세요. <br>	
						<br> <input type="text" id="email_info" readonly value=""/>
					</p><br>
					<input type="button" class="my-btn yellow-black" onClick="location.href='#close_email_info'" value="닫기" />
				</div>
			</div> <br><br>
			
			<!-- pw 찾기 -->
			<form class="contents-box inner-box">
				<p class="section-title blue">비밀번호 찾기</p> 
				<div class="find-input line-bottom">
					<div class="find-input-text">
						<div>
							<label>이 &nbsp; 름&nbsp; &nbsp; 
								<input type="text" name="name_p" placeholder="이름을 입력해주세요.">
							</label>
						</div>
						<div>
							<label>이메일&nbsp; &nbsp;
									<input type="text" name="email" placeholder="example@email.com">
							</label>
						</div>
					</div>	
					<input type="button" value="메일 인증" class="my-btn yellow-black" onClick="find_pwd(this.form);">
				</div>
			</form>
			<div class="inner-box"><br>
				<div class="page-button">
					<input type="button" class="my-btn black-white" value="메인으로" onClick="location.href='index.do'">
					<input type="button" class="my-btn black-white" value="로그인하기" onClick="location.href='user_login_form.do'"> 
				</div>
			</div>
		 </div>
		</div>
	 <jsp:include page="../footer.jsp"></jsp:include>
</body>

</html>