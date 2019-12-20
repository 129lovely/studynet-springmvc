<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>회원 정보 입력</title>
	
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
			
			var phoneNum = document.getElementById('phone-input');
			
			phoneNum.onkeyup = function(){
			  	console.log(this.value);
			  	this.value = autoHypenPhone( this.value ) ;  
			}
		};
		
	</script>
	
	<script type="text/javascript">
	
		// 이메일 중복 체크 메서드
		function verify( ) {
			var input_email = document.getElementById("email-input");
			var xmlhttp, res;
			var email_patt = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if ( !input_email.value ) {
				alert("이메일을 입력해주세요.");	
				return;
			}
			
			if ( ! email_patt.test( input_email.value ) ) {
				alert("이메일 형식이 올바르지 않습니다. ");
				return;
			}
			
			var url = "email_check.do";
			var param = "input_email=" + input_email.value;
			sendRequest( url, param, verify_result, "GET");
		}
		
		// resultFn()
		function verify_result() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var res = xhr.responseText;
				
				if( res == 'yes' ){
					alert("콜백");
					return;
				}
				
				alert("사용할 수 있는 이메일입니다.");
				
				var email = document.getElementById("email");
				var input_email = document.getElementById("email-input");
				
				email.value = input_email.value;
				
				location.href = "#close_email";
			}
		}
		
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
		
			document.getElementById("phone").value = input_phone.value ;
			
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
				var key_input = document.getElementById("key-input");
				
				
				var res = JSON.parse(xhr.responseText);
				
				if ( res.tempKey != null && res.phone != null ){
					alert("입력하신 전화번호로 인증키가 발송되었습니다. SMS를 확인해주세요. ");
					var key = res.tempKey;
					var phoneNum = res.phone;
					
					alert("key:" + key);
					alert("phoneNum:" + phoneNum);
					
					document.getElementById("certificateBtn").onClick = function () {
						if( key_input.value == "" ){
							alert("인증키를 입력해주세요.");
							return;
						} 
						
						if ( key.equals(key_input.value) ) {
							phone.value = phoneNum;
							alert("인증되었습니다.");
							location.href="#close_key";
							return;
							
						}
					}
					
				} else {
					alert("문제가 발생했습니다... 재시도해주십시오.");
					return;
				} 
			}
		}
		
		// 폼 전체 유효성 검사
		function send( f ) {
			var email = f.email;
			var name = f.name;
			var password = f.password;
			var pwd_check = document.getElementById("pwd_check")
			var phone = f.phone.value;

			// 혹시라도 이메일이 비어있는지 확인
			if ( !email.value ) {
				alert("이메일을 확인해주세요.");
				email.focus();
			}
			
			// 혹시라도 전화번호가 비어있는지 확인
			if ( !phone.value ) {
				alert("전화번호를 확인해주세요.");
				phone.focus();
			}
			
			
			// 이름 입력했는지 확인
			if ( ! name.value ) {
				alert("이름을 입력해주세요.")
				name.focus();
				return;
			}
			
			// 비밀번호
			var pwd_patt = /^(?=.*[a-zA-Z0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,}$/;
			
			if( ! pwd_patt.test(password.value) ) {
				alert("비밀번호 형식이 올바르지 않습니다. ");
				password.focus();
				return;
			}
			
			// 비밀번호 확인
			if ( ! pwd_check.value ) {
				alert("비밀번호를 확인해주세요.");
				pwd_check.focus();
				return;
			} else if ( password.value != pwd_check.value ) {
				alert("비밀번호가 일치하지 않습니다.")
				pwd_check.focus();
				return;
			}
			
			
			// 직업
			var job_type = document.all("job");
			
			var student = job_type[0];
			var job_seeker = job_type[1];
			var office_worker = job_type[2];
			var job_etc = job_type[3];
			
			if ( !student.checked && !job_seeker.checked && !office_worker.checked && !job_etc.checked ) {
				alert("직업군을 선택해주세요.");
				return;
			}
			
			// 지역 
			if( f.region.selectedIndex == 0 ){
			    alert('지역을 선택해주세요.');
			    f.region.options[0].focus();
				return;
			}
			
			f.action = "user_insert.do";
			//f.method = "post";
			f.submit();
			
		}
	</script>
	
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="body-bgcolor-set">
		<div class="study-join">
			
			<div class="inner-box pt190">
				<div class="contents-box">
				
					<!-- 회원가입 안내문 -->
					<div class="flex-box join-description">
						<h2 class="section-title tac">스터디넷 회원가입</h2>
						<span class="icon icon-join-study"></span>
					</div>
					<p class="section-discription mb40">
						회원 정보를 입력해 스터디넷에 가입하시면<br>
						페이지의 모든 서비스를 이용하실 수 있습니다.
					</p>
					<div class="line-bottom">
						<h2 class="sub-section-title black">회원 정보 입력</h2>
					</div>

					<!-- 회원가입 폼 -->
					<div class="table-indent">
						<form class="study-join-form">
							<table>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" id="email" name="email" placeholder="중복 확인을 통해 입력해주세요." readonly>
									</td>
									<td>
										<input class="my-btn black-white" name="" type="button" value="중복 확인" onClick="location.href='#open_email'">
											<div class="info_content input" id="open_email">
												<div>
													<p class="section-discription tal">
														입력된 이메일은 아이디로 사용되오니 꼭 실제 사용하시는 이메일을 기입해주시기 바랍니다. <br>
														또한 참여하는 스터디와 관련된 정보가 메일로 발송됩니다. <br><br>
														<input type="text" id="email-input" placeholder="example@studynet.com">
													</p>
													<input type="button" class="my-btn yellow-black" onClick="verify();" value="중복 확인"/>
													<input type="button" class="my-btn yellow-black" onClick="location.href='#close_email'" value="취소"/>
												</div>
											</div>
									</td>
								</tr>
									
								<tr>	
									<th>이름</th>
									<td>
										<input type="text" name="name" placeholder="본명을 입력해주세요.">
									</td>
								</tr>
								
								<tr>	
									<th>비밀번호</th>
									<td>
										<input type="password" name="password" placeholder="비밀번호는 8자 이상 특수 기호 포함" >
									</td>
								</tr>
								
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input id="pwd_check" placeholder="비밀번호를 다시 한번 입력해주세요." type="password" >
									</td>
								</tr>
								
								<tr>	
									<th>전화번호</th>
									<td>
										<input type="text" name="phone" id="phone" placeholder="본인 인증을 통해 입력해주세요." readonly>
									</td>
									<td>
										<input class="my-btn black-white" onClick="location.href='#open_phone'" type="button" value="본인 인증">		
										<div class="info_content input" id="open_phone">
											<div>
												<p class="section-discription tal">
													본인의 휴대폰 번호를 입력해주세요.<br><br>
													<input type="text" id="phone-input" placeholder="'-'이 자동으로 입력됩니다." maxlength="13">
												</p>
												<input type="button" class="my-btn yellow-black" onClick="do_certificate();" value="인증"/>
												<input type="button" class="my-btn yellow-black" onClick="location.href='#close_phone'" value="취소"/>
											</div>
										</div>		
										<div class="info_content input" id="open_key">
											<div>
												<p class="section-discription tal">
													문자가 오지 않는다면 재전송 버튼을 눌러주세요.<br>재전송은 1회만 가능합니다. <br><br>
													<input type="text" id="key-input" placeholder="SMS로 전송된 6자리 인증키를 입력해주세요.">
												</p>
												<input type="button" class="my-btn yellow-black" onClick="re_certificate();" value="재전송"/>
												<input type="button" class="my-btn yellow-black" id="certificateBtn" value="인증"/>
												<input type="button" class="my-btn yellow-black" onClick="location.href='#close_key'" value="취소"/>
											</div>
										</div>			
										<input type="hidden" value="1" name="is_phone_auth">
									</td>
								</tr>
								
								<tr>	
									<th>직업</th>
									<td>
										<div class="join-radio-box">
											<div>
												<input type="radio" name="job" value="학생" id="student">
												<label for="student">학생</label>
											</div>
											
											<div>
												<input type="radio" name="job" value="취준생" id="job_seeker">
												<label for="job_seeker">취준생</label>
											</div>
											
											<div>
												<input type="radio" name="job" value="직장인" id="office_worker">
												<label for="office_worker">직장인</label>
											</div>
											
											<div>
												<input type="radio" name="job" value="기타" id="job_etc">
												<label for="job_etc">기타</label>
											</div>
											
										</div>
									</td>
								</tr>
								
								<tr>	
									<th>지역</th>
									<td class="select-region">
										<div>
											<select name="region">
												<option value="" >지역 선택</option>
												<option value="서울" >서울</option>
												<option value="경기도" >경기도</option>
												<option value="대전" >대전</option>
												<option value="인천" >인천</option>
												<option value="부산" >부산</option>
												<option value="대구" >대구</option>
												<option value="광주" >광주</option>
												<option value="울산" >울산</option>
												<option value="세종" >세종</option>
												<option value="강원도" >강원도</option>
												<option value="충청도" >충청도</option>
												<option value="경상도" >경상도</option>
												<option value="전라도" >전라도</option>
												<option value="제주도" >제주도</option>
												<option value="해외" >해외 거주</option>
											</select>
										</div>	
									</td>
								</tr>
								
								<tr>
									<td colspan="3" class="tac">
										<input class="my-btn yellow-black mb20" type="button" value="가입하기" onClick="send(this.form);">												
										<input class="my-btn yellow-black mb20" type="button" value="돌아가기" onClick="location.href='index.do'">										
									</td>
								</tr>
							</table>	
						</form>
					</div>
				</div>
			</div>		
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	
</body>
	
</html>