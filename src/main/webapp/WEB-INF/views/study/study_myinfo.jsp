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
		<div class="mypage-studyroom">

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
								<a href="#" class="menu room sub-section-title black tac">내 스터디룸</a>
								<a href="#" class="menu info sub-section-title black tac" onmouseover="move_right();" onmouseout="move_left();">회원 정보</a>
							</div>
							<div id="bar" class="left"></div>
						</div>
					</div>
					
					<!-- 내 스터디룸 목록 -->
					<div class="line-bottom">
						<h1 class="sub-section-title">스터디 룸</h1>
					</div>
					<div class = "study-room-box">
						<div class="flex-box">
							<div class = "study-room">
								<a class = "study-name" href="#">
								<span class="status my-btn black-white">승인 대기</span>
								[오프라인] 냥냥이냥냥냐스터디제목이냥</a>
								<div class="accordion">
									<table class="study-info"> 
										<tr>
											<th>
												스터디 기간
											</th>
											<td>
												| 2019.12.06 - 2019.12.29
											</td>
										</tr>
										<tr>
											<th>
												오픈 카톡
											</th>
											<td>
												| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>
												| 개설자 명
											</th>
											<td>
												| 2019.12.06 - 2019.12.29
											</td>
										</tr>
									</table>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>		
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>