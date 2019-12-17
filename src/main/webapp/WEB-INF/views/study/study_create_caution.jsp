<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스터디 생성 안내</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="study-guide body-bgcolor-set">
		<div>
			<!-- 스터디 생성 동의 안내 페이지 -->
			<div class="study-guide-box">
				<div class="inner-box pt190">
					<div class="contents-box board">
						<div>
							<h2 class="section-title blue tac mb40">스터디룸 생성 안내</h2>
							<div class="line-bottom flex-box">
								<p class="section-discription">
									생성된 스터디룸은  마이페이지에서 관리할 수 있습니다.
									대기 중인 신청 인원이 있을 경우 글을 수정할 수 없고,
									참여 인원이 0명일 경우에만 모집글을 삭제하실 수 있습니다.
								</p>
								<div class="tg">
										<input type="checkbox" id="cb1" class=tgl-skewed>
										<label class="tgl-btn" data-tg-off="비동의" data-tg-on="동의" for="cb1"></label>
								</div>
							</div>
							<div class="line-bottom flex-box">
								<p class="section-discription">
									스터디 신청이 들어오면 스터디 관리 - 인원 관리에서
									신청을 승인하거나 거절할 수 있습니다.
								</p>
								<div class="tg">
										<input type="checkbox" id="cb2" class=tgl-skewed>
										<label class="tgl-btn" data-tg-off="비동의" data-tg-on="동의" for="cb2"></label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 등록/취소 버튼 -->
				<div class="tac btn-box">
					<input class="my-btn black-white" type="button" value="등록하기" />
					<input class="my-btn black-white" type="button" value="취소하기" />
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>