<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>회원 정보 입력</title>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
		
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
					alert("이메일이 중복됩니다");
					return;
				}
				
				alert("사용할 수 있는 이메일입니다.");
				
				var email = document.getElementById("email");
				var input_email = document.getElementById("email-input");
				
				email.value = input_email.value;
				
				location.href = "#close_input";
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
			
			// 전화번호 인증 여부
			
			
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
										<input type="text" id="email" name="email" placeholder="example@studynet.com" readonly>
									</td>
									<td>
										<input class="my-btn black-white" name="" type="button" value="이메일 입력" onClick="location.href='#open_input'">
											<div class="info_content input" id="open_input">
												<div>
													<p class="section-discription tal">
														입력된 이메일은 아이디로 사용되오니 꼭 실제 사용하시는 이메일을 기입해주시기 바랍니다. <br><br>
														<input type="text" id="email-input" placeholder="example@studynet.com">
													</p>
													<input type="button" class="my-btn yellow-black" onClick="verify();" value="중복 확인"/>
													<input type="button" class="my-btn yellow-black" onClick="location.href='#close_input'" value="취소"/>
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
										<input type="text" name="phone" placeholder="'-'을 제외하고 입력해주세요.">
									</td>
									<td>
										<input class="my-btn black-white" name="" type="button" value="본인 인증">							
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