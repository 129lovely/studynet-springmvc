<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	
	<script type="text/javascript">
	
		// 혹시라도 로그인 한 유저가 로그인 url을 통해 접근했을 경우를 막기 위한 부분
		window.onload = function () {
			if ( ${ !empty user } ) {
				alert("잘못된 접근입니다.");
				location.href = "index.do";
			}	
		}
		
		// 로그인 버튼 기능
		function login( f ) {

			var email = f.email;
			var password = f.password;
			
			// 유효성 체크 - 1
			if( email.value == "" ){
				alert("이메일을 입력해주세요.");
				email.focus();
				return;
			} else if( password.value == "" ){
				alert("비밀번호를 입력해주세요.");
				password.focus();
				return;
			}
			
			// 유효성 체크  - 2
			var email_patt = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			var pwd_patt = /^(?=.*[a-zA-Z0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,}$/;
			
			if ( ! email_patt.test( email.value ) ) {
				alert("이메일 형식이 올바르지 않습니다. ");
				email.focus();
				return;
				
			} else if( ! pwd_patt.test( password.value ) ) {
				alert("비밀번호 형식이 올바르지 않습니다. ");
				password.focus();
				return;
			}
			
			var url = "user_login.do";
			var param = "email=" + encodeURIComponent(email.value) + "&password=" + encodeURIComponent(password.value) ;
			sendRequest(url, param, login_result, "post");
			
		}
	
		// resultFn
		function login_result(){
			if ( xhr.readyState == 4 && xhr.status == 200 ){
				var res = xhr.responseText;
				var f = document.login_form;
				
				if ( res == "no_email" ) {
					alert("회원 정보에 존재하지 않는 이메일입니다.");
					f.email.focus();
					return;
				} 
				
				if ( res == "no_password" ) {
					alert("비밀번호가 올바르지 않습니다.");
					f.password.focus();
					return;
				}
				
				alert("<c:out value='${user.name}'/> 님 반갑습니다. ");
					
				location.href = "${prevPage}";

			}
		}
	
	</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="body-bgcolor-set">
		<div class="study-login">
		
			<!-- 맨 위 문구  -->
			<div class="study-login-box">
				<div class="inner-box pt190">
					<div class="contents-box">				
						<div class="flex-box">
							<div class="black-bottom-line">
								<h2 class="section-title">함께하는 <span class="section-title blue">시작</span>,<br> 
									스터디넷에 <span class="section-title blue">로그인</span>하세요</h2>
								<span class="icon icon-login-study"></span>
							</div>
						</div>
						
					</div>				
				</div>
			</div>
			
			<div class="study-log-box">
				<div class="inner-box">
					<div class="contents-box">
						<div class="line-bottom">
							<div class="log-input tac">
								<div>
									<form name="login_form">
										<div class="mb30">
											<input type="text" name="email" placeholder="Email을 입력하세요.">
											<input type="password" name="password" placeholder="Password를 입력하세요.">
										</div>
										<div>
											<input type="button" class="my-btn black-white" value="로그인" onClick="login(this.form);"/>
											<input type="button" class="my-btn black-white" value="회원가입" onclick="location.href='user_join_caution.do'"/>
										</div>
									</form>
									<a href="#" class="icon icon-login-kakao"></a>
									<div class="link_find">
									<p class="section-discription">아이디나 비밀 번호를 잊으셨나요?</p>
									<p class="section-discription"><a href="#">아이디 / 비밀번호 찾기</a></p>
									</div>
								</div>
							</div>
						</div>	
					</div>		
				</div>
			</div>

			<div class="tac">
				
				
			</div>

		</div> <!-- study-login -->
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>




</body>

</html>