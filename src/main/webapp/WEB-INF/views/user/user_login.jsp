<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
									<form>
										<div class="mb30">
											<input type="text" class="id-input" placeholder="ID를 입력하세요.">
											<input type="password" class="pwd-input" placeholder="Password를 입력하세요.">
										</div>
										<div>
											<input type="button" class="my-btn black-white" value="로그인"/>
											<input type="button" class="my-btn black-white" value="회원가입" onclick="location.href='user_join.html'"/>
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