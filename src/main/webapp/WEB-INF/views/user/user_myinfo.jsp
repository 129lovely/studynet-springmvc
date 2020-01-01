<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지 | 내 정보</title>		
				
	<script type="text/javascript">
		// 핸드폰 본인 인증
		function do_certificate() {
			var input_phone = document.getElementById("phone-input");
			
			// '-'이 바르게 들어갔는지 확인
			if( input_phone.value == null  ) {
				alert("전화번호를 입력해주세요.");
				return;
			}
			
			// 하이픈이 올바르게 들어갔는지 확인
			var patt = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
			
			if ( ! patt.test(input_phone.value) ) {
				alert("전화번호 형식이 올바르지 않습니다.");
				return;
			}
			
			location.href = "#close_phone";
			location.href="#open_key";
			
			var url = "user_join_certificate.do";
			var param = "phone=" + encodeURIComponent(input_phone.value)
			sendRequest(url, param, certificate_result, "get");
		}
		
		// 폰 인증 resultfn 
		function certificate_result() {
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var phone = document.getElementById("phone");
				
				var res = JSON.parse(xhr.responseText);
				
				
				if ( res.tempKey != null && res.phone != null ){
					
					if ( res.tempKey == "member" ) {
						location.href="#close_key";
						alert("이미 회원 정보가 있는 전화번호입니다. ");
						return;
					}
					
					alert("입력하신 전화번호로 인증키가 발송되었습니다. SMS를 확인해주세요. ");
					
					var key = res.tempKey;
					var phoneNum = res.phone;
					
					// body 내부에 input hidden으로 결과값을 숨겨둔다.
					  var key_tag = document.createElement("input");
					  key_tag.setAttribute("type", "hidden");
					  key_tag.setAttribute("id", "key");
					  key_tag.setAttribute("value", key);
				      document.forms[0].appendChild(key_tag);
				      
				      var phone_tag = document.createElement("input");
				      phone_tag.setAttribute("type", "hidden");
				      phone_tag.setAttribute("id", "phoneNum");
				      phone_tag.setAttribute("value", phoneNum);
				      document.forms[0].appendChild(phone_tag);
					
				} else {
					alert("문제가 발생했습니다... 재시도해주십시오.");
					return;
				} 
			}
		}
		
		// 본인 인증 재전송 여부	
		var re_certi = false;
		
		// 본인 인증키 재전송 
		function re_certificate() {
			
			if ( re_certi == true ) {
				alert("이미 인증키 재전송을 하셨습니다. ");
			}
			
			re_certi = true;
			
			
			var input_phone = document.getElementById("phone-input");
			
			var url = "user_join_certificate.do";
			var param = "phone=" + encodeURIComponent(input_phone.value)
			sendRequest(url, param, certificate_result2, "get");
			
		}
		
		// 본인 인증키 재전송 resultFn 
		function certificate_result2() {
			if( xhr.readyState == 4 && xhr.status == 200 ){

				
				var res = JSON.parse(xhr.responseText);
				
				if ( res.tempKey != null && res.phone != null ){
					alert("인증키가 재전송되었습니다. SMS를 확인해주세요. ");
					var key = res.tempKey;
					var phoneNum = res.phone;
					
					// body 내부에 input hidden으로 숨겨뒀던 값을 새 키로 바꿔준다.
					  var key_tag = document.getElementById("key");
					  key_tag.setAttribute("value", key);
					  
				} else {
					alert("문제가 발생했습니다... 재시도해주십시오.");
					return;
				} 
			}
		}
		
		
		// 본인 인증키 인증 버튼
		function certificateBtn( ) {
			var key_input = document.getElementById("key-input");
			
			// hidden으로 숨겨둔 값들 불러오기
			var key = document.getElementById("key").value;
			var phoneNum = document.getElementById("phoneNum").value;
			
			if( key_input.value == "" ){
				alert("인증키를 입력해주세요.");
				return;
			} 
			
			if ( key == key_input.value ) {
				document.getElementById("phone").value = phoneNum;
				alert("인증되었습니다.");
				location.href="#close_key";
				
				return;
				
			} else {
				alert("인증키가 올바르지 않습니다.");
				return;
			}
		}			
	
		
		// 회원 정보 수정 유효성 검사 
		function send( f ) {
			
			var original_pwd = document.getElementById("original_pwd");
			var password = f.password;
			var pwd_check = document.getElementById("pwd_check");

			if (password.value != "" ){
				
				//현재 비밀번호 비교
				if ("${user.password}" != original_pwd.value ){
					alert("비밀번호가 일치하지 않습니다.")
					original_pwd.focus();
					return;
				}
				
				// 비밀번호
				var pwd_patt = /^(?=.*[a-zA-Z0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,}$/;
							
				if( ! pwd_patt.test(password.value)) {
					alert("비밀번호 형식이 올바르지 않습니다. ");
					password.focus();
					return;
				}
				if (original_pwd.value == password.value){
					alert("현재 비밀번호와 동일합니다 다시 입력해주세요. ");
					password.focus();
					return;
				}
				
				// 비밀번호 확인
				if ( ! pwd_check.value ) {
					alert("비밀번호를 재입력해주세요.");
					pwd_check.focus();
					return;
				} else if ( password.value != pwd_check.value ) {
					alert("비밀번호가 일치하지 않습니다.")
					pwd_check.focus();
					return;
				}
				
			}			

			alert("회원 정보가 수정되었습니다.");
			
			// 비밀번호를 변경하지 않았을 경우 기본값 넣어주기
			if ( password.value == "" ) {
				password.value = "${user.password}";
			}
			
			f.action = "user_update.do";
			f.method = "post";
			f.submit();
			
		}
		
		
		/* 회원탈퇴  */
		function b_delete() {
		
			var del_pwd = document.getElementById("del_pwd");
			var password = "${user.password}";
			
			if (del_pwd.value != password){
				alert("비밀번호가 일치하지 않습니다.")
				pwd_check.focus();
				return;
			}						
			else {
				var check = confirm("정말 탈퇴하시겠습니까?");
				
				if ( ! check ) {
					return;
				}
				
				location.href="user_del.do?idx=${ user.idx }";				
			}
		}

	</script>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="body-bgcolor-set">
		<div class="mypage-userinfo">
			
			<div class="inner-box pt190">
				<div class="contents-box board">
					<!-- 마이 페이지 메뉴 -->
					<div class="flex-box">
						<span class="icon icon-my-page tal"></span>
						<h2 class="section-title">마이페이지</h2>
					</div>

					<div class="line-bottom">
						<div class="menu-bar-box">
							<div class="mypage-menu-box">
								<a href="study_myinfo.do" class="menu room sub-section-title black tac" onmouseover="move_left();" onmouseout="move_right();">내 스터디룸</a>
								<a href="#" class="menu info sub-section-title black tac" >회원 정보</a>
							</div>
							<div id="bar" class="right"></div>
						</div>
					</div>

					<div class="line-bottom">
						<h1 class="sub-section-title">정보 수정</h1>
					</div>

					<!-- 정보 수정 -->
					<div class="table-indent ">
						<form class="mypage-userinfo-form ">
							<input type="hidden" name="idx" value="${user.idx}">
							<table>
								<tr>
									<th>이메일</th>
									<td><input type="text" readonly id="email"
										title="id" value ="${user.email}"></td>
								</tr>
									
								<tr>	
									<th>이름</th>
									<td><input type="text" readonly id="name"
										title="이름" value ="${user.name}"></td>
								</tr>

								<tr>	
									<th>현재 비밀번호</th>
									<td><input type="password" id="original_pwd" title="현재 비밀번호" placeholder="특수기호 포함 영숫자 조합 8자 이상 "></td>
								</tr>

								<tr>	
									<th></th>
									<td><span class="section-discription">SNS 회원님의 경우 비밀번호 찾기를 통해 초기 비밀번호를 발급받아주세요.</span><br><br>
									<input type="button" class="my-btn black-white" value="비밀번호 찾기" onClick="location.href='user_find.do'"></td>
								</tr>
								
								<tr>
									<th>바꿀 비밀번호</th>
									<td><input type="password" name="password" title="바꿀 비밀번호" placeholder="바꿀 비밀번호를 입력해주세요."></td>
								</tr>

								<tr>
									<th>비밀번호 확인</th>
									<td><input type="password" id="pwd_check" title="비밀번호 확인" placeholder="바꿀 비밀번호를  재입력해주세요."></td>
								</tr>
								
								<tr>	
									<th>전화번호</th>
									<td><input type="text" id="tel-input" name="phone" value = "${user.phone}"></td>
									<td>
										<input class="my-btn black-white" onClick="location.href='#open_phone'" type="button" value="번호 변경">
										<div class="info_content input" id="open_phone">
											<div>
												<p class="section-discription tal">
													번호를 변경하기 위해서는 인증이 필요합니다. <br>변경할 휴대폰 번호를 입력해주세요.<br><br>
													<input type="text" id="phone-input" placeholder="'-'이 자동으로 입력됩니다." maxlength="13">
												</p><br>
												<input type="button" class="my-btn yellow-black" onClick="do_certificate();" value="인증"/>
												<input type="button" class="my-btn 0yellow-black" onClick="location.href='#close_phone'" value="취소"/>
											</div>
										</div>		
										<div class="info_content input" id="open_key">
											<div>
												<p class="section-discription tal">
													문자가 오지 않는다면 재전송 버튼을 눌러주세요.<br>재전송은 1회만 가능합니다. <br><br>
													<input type="text" id="key-input" placeholder="SMS로 전송된 6자리 인증키를 입력해주세요.">
												</p>
												<input type="button" class="my-btn yellow-black" onClick="re_certificate();" value="재전송"/>
												<input type="button" class="my-btn yellow-black" onClick="certificateBtn();" value="인증"/>
												<input type="button" class="my-btn yellow-black" onClick="location.href='#close_key'" value="취소"/>
											</div>
										</div>			
									</td>
								</tr>
								
								<tr>	
									<th>직업</th>
									<td>	
											<input type="radio" name="job" value="학생" id="student"
											<c:if test="${ user.job eq '학생'}">checked</c:if>>
											<label for="student">학생</label>
										
			
											<input type="radio" name="job" value="취준생" id="job_seeker"
											<c:if test="${ user.job eq '취준생'}">checked</c:if>>
											<label for="job_seeker">취준생</label>
						
										
											<input type="radio" name="job" value="직장인" id="office_worker"
											<c:if test="${ user.job eq '직장인'}">checked</c:if>>
											<label for="office_worker">직장인</label>
							
											<input type="radio" name="job" value="기타" id="job_etc"
											<c:if test="${ user.job eq '기타'}">checked</c:if>>
											<label for="job_etc">기타</label>

									</td>
								</tr>
								
								<tr>	
									<th>지역</th>
									<td class="select-region">
										<div>
											<select name="region" id="region">
												<option value="">지역 선택</option>
												<option value="서울">서울</option>
												<option value="경기도">경기도</option>
												<option value="대전">대전</option>
												<option value="인천">인천</option>
												<option value="부산">부산</option>
												<option value="대구">대구</option>
												<option value="광주">광주</option>
												<option value="울산">울산</option>
												<option value="세종">세종</option>
												<option value="강원도">강원도</option>
												<option value="충청도">충청도</option>
												<option value="경상도">경상도</option>
												<option value="전라도">전라도</option>
												<option value="제주도">제주도</option>
												<option value="해외">해외 거주</option>
											</select>
										</div>
									</td>
								</tr>
								
								<tr>
									<td colspan="3" class="tac">
									<input class="my-btn yellow-black mb20" type="button" value="수정하기" onClick="send(this.form);">
										<input class="my-btn yellow-black mb20" type="button"
										value="돌아가기" onClick="location.href='index.do'"></td>
								</tr>
							</table>	
						</form>
					</div>

					<!-- 회원탈퇴 여부 -->
					<div class="line-bottom"></div>
					<div class="line-bottom">
						<h1 class="sub-section-title">회원탈퇴</h1>
					</div>
					<input type="hidden" name="userId" value="${user.idx}">
					<form class="get-out-form tac">
						<p class="section-discription">
							신청 / 참여 / 개설 중인 스터디들이 없어야 탈퇴가 가능합니다.<br> 회원을 탈퇴하시면 1년 후, 모든
							정보가 사라집니다.<br> 정말 탈퇴를 진행하시려면 비밀번호를 재입력해주세요.
						</p>

						<input type="text" id="del_pwd" title="비밀번호 재입력" placeholder="현재 비밀번호를 입력해주세요."> 
						<input type="button" class="my-btn black-white" title="회원 탈퇴" value="탈퇴" onclick="b_delete();">
					</form>
				</div>
			</div>		
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
	
		//마이페이지 메뉴 슬라이드 바
		function move_right(){
			var bar = document.getElementById("bar");
			bar.classList.add("right");
			bar.classList.remove("left");
		}
	
		function move_left(){
			var bar = document.getElementById("bar");
			bar.classList.remove("right");
			bar.classList.add("left");
		}
		
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
			
			var phoneNum = document.getElementById('phone-input');
			
			phoneNum.onkeyup = function(){
			  	console.log(this.value);
			  	this.value = autoHypenPhone( this.value );  
			}
			
			// 셀렉트 태그 DB값 불러오기 
			document.getElementById("region").value = "${user.region}";
			
		};
	
	</script>
</body>

</html>