<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 가입 완료</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="user-join-complete body-bgcolor-set">

		<div>
			<div class="inner-box pt190">
				<div class="contents-box board">
					<div class="line-bottom">
						<p class="section-title tac">귀중한 시간 내어주셔서 감사합니다.</br>
							<span class="section-title blue tac">${res}</span> 님의 회원가입이 완료되었습니다.
							<p class="section-discription">가입하신 아이디로 로그인해주시길 바랍니다.</p>
						</p>
						<div class="section-discription">
							<span class="sub-section-title">[ sns 로그인의 경우 ]</span><br><br>
							&nbsp;sns 로그인 대신 이메일 로그인을 사용하고싶으시다면  <br>
							최초 1회에 한해 초기 비밀번호를 이메일로 받으신 후,  <br>
							해당 비밀번호를 마이 페이지에서 재설정해주시길 바랍니다.  <br><br>
 
							&nbsp;또한 스터디 신청을 위해서는 마이 페이지에서 기본 정보들을 <br>
							추가로 입력해주셔야 합니다. 커뮤니티 활동은 자유롭게 가능합니다.

						</div>
					</div>
					<div class="tac mb40">
						<input class="my-btn black-white mb20" type="button" value="메인페이지" onClick="location.href='index.do'"/>
						<input class="my-btn yellow-black mb20" type="button" value="로그인 하기" onClick="location.href='user_login_form.do'"/>
					</div>
				</div>
			</div>

		</div>

	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>

</html>