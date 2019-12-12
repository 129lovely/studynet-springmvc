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
									<th>아이디</th>
									<td>
										<input type="text" id="id-input" name="" placeholder="아이디는 8자 이상 영문 +숫자 조합">
									</td>
									<td>
											<input class="my-btn black-white" name="" type="button" value="중복체크">
									</td>
								</tr>
									
								<tr>	
									<th>이름</th>
									<td>
										<input type="text" id="name-input" name="" placeholder="본명을 입력해주세요.">
									</td>
								</tr>
								
								<tr>	
									<th>비밀번호</th>
									<td>
										<input type="password" id="pwd-input" name="" placeholder="비밀번호는 8자 이상 특수 기호 포함" >
									</td>
								</tr>
								
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input  id="pwd_check-input" name="" placeholder="비밀번호를 다시 한번 입력해주세요." type="password">
									</td>
								</tr>
								
								<tr>	
									<th>이메일</th>
									<td>
										<input type="text" id="email-input" name="" placeholder="example@studynet.com">
									</td>
								</tr>
								
								<tr>	
									<th>전화번호</th>
									<td>
										<input type="text" id="tel-input" name="" placeholder="'-'을 제외하고 입력해주세요.">
									</td>
									<td>
										<input class="my-btn black-white" name="" type="button" value="번호인증">
									</td>
								</tr>
								
								<tr>	
									<th>직업</th>
									<td>
										<div class="join-radio-box">
											<div>
												<input type="radio" name="job-type" id="job-type-student">
												<label for="job-type-student">학생</label>
											</div>
											
											<div>
												<input type="radio" name="job-type" id="job-type-job_seeker">
												<label for="job-type-job_seeker">취준생</label>
											</div>
											
											<div>
												<input type="radio" name="job-type" id="job-type-office_worker">
												<label for="job-type-office_worker">직장인</label>
											</div>
											
											<div>
												<input type="radio" name="job-type" id="job-type-etc">
												<label for="job-type-etc">기타</label>
											</div>
											
										</div>
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
										<input class="my-btn yellow-black mb20" type="button" value="가입하기">												
										<input class="my-btn yellow-black mb20" type="button" value="돌아가기">											
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
</body>

</html>