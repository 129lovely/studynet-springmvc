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
	<!-- 페이지-->
	<div class="user-find">
		<!-- id찾기 -->
		<form class="contents-box inner-box pt190">
			<p class="section-title blue">아이디 찾기</p> 
			<div class="find-input line-bottom">
				<div class="find-input-text">
					<div>
						<label>이름&nbsp;&nbsp;
							<input type="text" name="name" placeholder="이름을 입력해주세요.">
						</label>
					</div>
					<div>
						<label>전화번호&nbsp;&nbsp;
								<input type="text" name="pNum"" placeholder="'-'를 빼고 입력해주세요.">
						</label>
					</div>
				</div>	
				<input type="button" value="찾기" class="my-btn yellow-black">
			</div>
		</form>
	<!-- pw 찾기 -->
		<form class="contents-box inner-box">
			<p class="section-title blue">비밀번호 찾기</p> 
			<div class="find-input line-bottom">
				<div class="find-input-text">
					<div>
						<label>아이디&nbsp;&nbsp;
							<input type="text" name="name" placeholder="아이디를 입력해주세요.">
						</label>
					</div>
					<div>
						<label>이메일&nbsp;&nbsp;
								<input type="text" name="email" placeholder="example@email.com">
						</label>
					</div>
				</div>	
				<input type="button" value="찾기" class="my-btn yellow-black">
			</div>
		</form>
		<div class="inner-box">
			<div class="page-button">
				<input type="button" class="my-btn black-white" value="메인으로" onClick="location.href='index.do'">
				<input type="button" class="my-btn black-white" value="로그인하기" onClick="location.href='user_login_form.do'"> 
			</div>
		</div>
	 </div>
	 <jsp:include page="../footer.jsp"></jsp:include>
</body>

</html>