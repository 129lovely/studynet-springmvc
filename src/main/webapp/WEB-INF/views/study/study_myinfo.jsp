<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>마이 페이지 | 내 스터디 룸</title>
	
	<link type="text/css" rel="stylesheet" href="css/common.css" />
	<link type="text/css" rel="stylesheet" href="css/reset.css" />
	<script src="js/sample.js"></script>

</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="body-bgcolor-set">
		<div class="mypage-studyroom">

			<div class="inner-box  pt190">
				<div class="contents-box board">

					<!-- 마이 페이지 메뉴 -->
					<div class="flex-box">
						<span class="icon icon-my-page tal"></span>
						<h2 class="section-title">마이페이지</h2>
					</div>

					<div class="line-bottom">
						<div class="menu-bar-box">
							<div class="mypage-menu-box">
								<a href="#" class="menu room sub-section-title black tac">내
									스터디룸</a> <a href="user_myinfo.do" class="menu info sub-section-title black tac"
									onmouseover="move_right();" onmouseout="move_left();">회원 정보</a>
							</div>
							<div id="bar" class="left"></div>
						</div>
					</div>

					<!-- 내 스터디룸 목록 -->
					<div class="line-bottom study-room-info">
						<!-- 스터디룸 알아보기 -->
						<a href="#open" class="section-discription my-study-room-info">
							Q. 내 스터디 룸 페이지에서는 뭘 할 수 있나요?</a>
						<div class="info_content" id="open">
							<div>
								<p class="section-title blue">내 스터디 룸 기능 알아보기</p>
								<p class="section-discription tal">
									- 신청한 스터디의 현재 상태를 확인하거나, - 승인되지 <br>않은 스터디의 신청을 취소할 수
									있습니다. <br>
									<br> - 또한 삭제 가능한 상태( 승인 거부, 폐쇄, 종료, 개설 취소)의<br> -
									스터디는 삭제하실 수 있습니다.<br>
									<br> - 진행 중이거나 종료된 스터디는 스터디 룸 - 버튼을 눌러 <br>해당 스터디의
									룸에서 스터디의 정보를 확인하고<br> - 투두 리스트를 작성하거나 출석 체크를 할 수 있습니다.<br>
									<br> - 직접 개설/운영 중인 스터디의 경우 관리 페이지에서 <br> - 공지 작성,
									일정/인원 관리 등 스터디를 관리할 수 있습니다.
								</p>
								<a href="#close" class="my-btn yellow-black">알겠어요</a>
							</div>
						</div>

					</div>
					
					
					<div class="study-room-box ">
						<div>
						
							<!-- if status == 승인대기 -->
							<div class="study-room ready-confirm">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">승인 대기</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black" value="신청 취소">
									</div>
								</div>
							</div>

							<!-- if status == 승인거부 -->
							<div class="study-room rejected">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">승인 거부</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">
										<input type="button" class="my-btn yellow-black" value="삭제하기">
									</div>
								</div>
							</div>

							<!-- if status == 개설 대기중 -->
							<div class="study-room ready-open">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">개설 대기</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자</th>
											<td>| 김꽁치 (010-2222-3333)</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">
										<!-- <input type="button" class="my-btn yellow-black" value="신청 취소"> -->
									</div>
								</div>
							</div>

							<!-- if status == 개설 취소 -->
							<div class="study-room cancle-open">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">개설 취소</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치 (010-2222-3333)</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black" value="신청 취소">
									</div>
								</div>
							</div>

							<!-- if status == 진행중 -->
							<div class="study-room open">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">진행 중</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모임 장소</th>
											<td>| 어디겡</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black"
											value="스터디 룸 가기">
									</div>
								</div>
							</div>

							<!-- if status == 폐쇄 대기중 -->
							<div class="study-room ready-close">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">폐쇄 대기</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black" value="폐쇄 동의">
									</div>
								</div>
							</div>

							<!-- if status == 폐쇄 -->
							<div class="study-room closed">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">폐쇄</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black" value="삭제하기">
									</div>
								</div>
							</div>

							<!-- if status == 종료 -->
							<div class="study-room end">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">종료</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">
										<input type="button" class="my-btn yellow-black"
											value="스터디 룸 가기"> <input type="button"
											class="my-btn yellow-black" value="삭제하기">
									</div>
								</div>
							</div>

							<!-- if status == 모집 중 -->
							<div class="study-room now-recruit">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">모집 중</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black"
											value="관리 페이지">
									</div>
								</div>
							</div>

							<!-- if status == 마감 가능 -->
							<div class="study-room ready-recruit-end">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">마감 가능</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">

										<input type="button" class="my-btn yellow-black"
											value="관리 페이지">
									</div>
								</div>
							</div>
							<!-- if status == 운영중 -->
							<div class="study-room running">
								<a class="study-name" href="#"> <span
									class="status my-btn black-white">운영 중</span> [오프라인]
									냥냥이냥냥냐스터디제목이냥냥냥
								</a>
								<div class="accordion">
									<table class="study-info">
										<tr>
											<th>스터디 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td>| <a href="#">https://open.kakao.com/o/s6K2bz7</a>
											</td>
										</tr>
										<tr>
											<th>개설자 명</th>
											<td>| 김꽁치</td>
										</tr>
										<tr>
											<th>모집 기간</th>
											<td>| 2019.12.06 - 2019.12.29</td>
										</tr>
										<tr>
											<th>모집 인원</th>
											<td>| 8 명</td>
										</tr>
									</table>

									<div class="room-btn-box">
										<input type="button" class="my-btn yellow-black"
											value="관리 페이지">
									</div>
								</div>
							</div>


							<!-- study가 아예 없을 경우 -->
							<div class="study-room none">
								<p class="study-name">참여중인 스터디가 존재하지 않습니다.</p>

								<div class="room-btn-box">
									<input type="button" class="my-btn yellow-black"
										value="스터디 찾아보기"> <input type="button"
										class="my-btn yellow-black" value="스터디 개설하기">
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