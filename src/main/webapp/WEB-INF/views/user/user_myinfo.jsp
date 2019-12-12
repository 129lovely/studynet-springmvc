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
								<a href="#" class="menu room sub-section-title black tac" onmouseover="move_left();" onmouseout="move_right();">내 스터디룸</a>
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
							<table>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" readonly id="email" placeholder="example@email.com" title="id">
										<input class="my-btn black-white" name="" type="button" value="인증">
									</td>
								</tr>
									
								<tr>	
									<th>이름</th>
									<td>
										<input type="text" readonly id="name" placeholder="" title="이름"> 
									</td>
								</tr>

								<tr>
									<th>  </th>
									<td>
										<input class="my-btn black-white" name="" type="button" value="초기 비밀번호 받기">									
										<p class="section-discription">* sns 로그인 유저만 1회에 한해 이메일로 받으실 수 있습니다.</p>
									</td>
								</tr>

								<tr>	
									<th>현재 비밀번호</th>
									<td>
										<input type="password" id="pwd" title="현재 비밀번호" placeholder="특수기호 포함 영숫자 조합 8자 이상 " >
									</td>
								</tr>

								<tr>
									<th>바꿀 비밀번호</th>
									<td>
										<input   type="password" id="new_pwd" title="바꿀 비밀번호" placeholder="바꿀 비밀번호를 입력해주세요.">
									</td>
								</tr>

								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input   type="password" id="pwd_check" title="비밀번호 확인" placeholder="바꿀 비밀번호를 다시 한번 입력해주세요.">
									</td>
								</tr>
								
								<tr>	
									<th>전화번호</th>
									<td>
										<input type="text" id="tel-input" title="전화번호 입력" placeholder="'-'을 제외하고 입력해주세요.">
									</td>
								</tr>
								
								<tr>	
									<th>직업</th>
									<td>
										<select title="직업 선택">
											<option>선택하세요</option>
											<option>학생</option>
											<option>취준생</option>
											<option>직장인</option>
											<option>기타</option>
										</select>
									</td>
								</tr>
								
								<tr>	
									<th>지역</th>
									<td class="select-region">
										<div>
											<select>
												<option>지역</option>
											</select>
										</div>	
									</td>
								</tr>
								
								<tr>
									<td colspan="3" class="tac">
										<input class="my-btn yellow-black mb20" type="button" value="수정하기">												
										<input class="my-btn yellow-black mb20" type="button" value="돌아가기">											
									</td>
								</tr>
							</table>	
						</form>
					</div>

					<!-- 회원탈퇴 여부 -->
					<div class="line-bottom"></div>
					<div class="line-bottom">
							<h1 class="sub-section-title"> 회원탈퇴</h1>
					</div>
					<form class="get-out-form tac">
						<p class="section-discription">
							신청 / 참여 / 개설 중인 스터디들이 없어야 탈퇴가 가능합니다.<br>
							회원을 탈퇴하시면 1년 후, 모든 정보가 사라집니다.<br>
							정말 탈퇴를 진행하시려면 비밀번호를 재입력해주세요.
						</p>	
					
						<input type="text" id="pwd" title="비밀번호 재입력" placeholder="현재 비밀번호를 입력해주세요.">
						<input  type="button" class="my-btn black-white" title="회원 탈퇴" value="탈퇴">
					</form>		
				</div>
			</div>		
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>

</html>