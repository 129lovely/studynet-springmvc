<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../login_check.jsp" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>마이 페이지 | 내 스터디 룸</title>
	
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
									- 신청한 스터디의 현재 상태를 확인하거나, 승인되지 <br>않은 스터디의 신청을 취소할 수
									있습니다. <br>
									<br> - 또한 삭제 가능한 상태( 승인 거부, 폐쇄, 종료, 개설 취소 )의<br>
									스터디는 삭제하실 수 있습니다.<br>
									<br> - 진행 중이거나 종료된 스터디는 스터디 룸 버튼을 눌러 <br>해당 스터디의
									룸에서 스터디의 정보를 확인하고<br> (진행 중일 경우) 투두 리스트를 작성하거나 출석 체크를 할 수 있습니다.<br>
									<br> - 직접 개설/운영 중인 스터디의 경우 관리 페이지에서 <br> 공지 작성,
									일정/인원 관리 등 스터디를 관리할 수 있습니다.
								</p>
								<a href="#close" class="my-btn yellow-black">알겠어요</a>
							</div>
						</div>

					</div>
						
							<c:forEach var="study" items="${list}">
								<div class="study-room-box ">
									<div>
												
											<!-- if status == 승인대기 -->
											<div class="study-room ready-confirm">
												<a class="study-name" href="study_list_detail.do?idx=${study.study_idx}">
													<span class="status my-btn black-white">${ study.study_status }</span>
													<c:if test="${study.is_online eq 0}">[오프라인]</c:if>
													<c:if test="${study.is_online eq 1}">[온라인]</c:if>
													<c:if test="${study.is_online eq 2}">[복합]</c:if>
													${study.title}
												</a>
												<div class="accordion">
													<table class="study-info">
														<tr>
															<th>내 상태</th>
															<td>| 
																  ${ study.mem_status }	 														
															</td>
														</tr>
														<tr>
															<th>스터디 기간</th>
															<td>| 
																  <fmt:parseDate var="dateStart" value="${study.start_date}" pattern="yyyy-MM-dd HH:mm:ss.SSS" />
																  <fmt:parseDate var="dateEnd" value="${study.end_date}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
																  <fmt:formatDate value="${dateStart}" pattern="yyyy.MM.dd" /> - <fmt:formatDate value="${dateEnd}" pattern="yyyy.MM.dd" />	 														
															</td>
														</tr>
														<tr>
															<th>오픈 카톡</th>
															<td>| <a href="${study.open_kakao}">${study.open_kakao}</a>
															</td>
														</tr>
														<tr>
															<th>모집 기간</th>
															<td>|
																  <fmt:parseDate var="dateDeadline" value="${study.deadline}" pattern="yyyy-MM-dd HH:mm:ss.SSS" />
																  <fmt:formatDate value="${study.created_at}" pattern="yyyy.MM.dd"/> - <fmt:formatDate value="${dateDeadline}" pattern="yyyy.MM.dd" />																
															</td>
														</tr>
														<tr>
															<th>모집 인원</th>
															<td>| ${study.max_count}명</td>
														</tr>
													</table>
		
													<div class="room-btn-box">
														<!-- 관리자일 때 -->
														<c:if test="${study.is_admin eq 1}">
															<c:if test="${ study.study_status eq '개설대기' and study.apply_count eq 0 and study.approve_count eq 1 }">
															<input type="button" class="my-btn yellow-black" value="개설 취소" onclick="">
															<input type="button" class="my-btn yellow-black" value="모집글 수정" onclick="location.href='study_create_modify_form.do?study_idx=${study.study_idx}'">
															</c:if>
															
															<c:if test="${ study.study_status eq '개설대기'}">
															<input type="button" class="my-btn yellow-black" value="스터디 룸" onclick="location.href='study_room_manage.do?study_idx=${study.study_idx}'">
															</c:if>
															
															<c:if test="${ study.study_status eq '개설대기' and study.approve_count >= study.min_count }">
															<input type="button" class="my-btn yellow-black" value="모집 마감" onclick="">
															</c:if>
															
															<c:if test="${ study.study_status eq '진행중' or study.study_status eq '폐쇄대기' or study.study_status eq '종료' }">
															<input type="button" class="my-btn yellow-black" value="스터디 룸" onclick="location.href='study_room_manage.do?study_idx=${study.study_idx}'">														
															</c:if>
															
															<c:if test="${ study.study_status eq '폐쇄대기'}">
															<input type="button" class="my-btn yellow-black" value="동의 현황" onclick="location.href='#open_agree'">														
																<!-- 폐쇄 동의 인원 확인 -->
																<div class="info_content agree_close list" id="open_list">
																	<div>
																		<h1 class="section-title blue line-bottom">동의 현황 확인</h1>
																		<table>
																			<!-- 내용 가져와야 함 -->
																		
																		</table>
																		<a href="#open_agree" class="my-btn black-white">닫기</a>
																	</div>
																</div>
															</c:if>
															
															<c:if test="${ study.study_status eq '폐쇄' }">
															<input type="button" class="my-btn yellow-black" value="스터디 룸" onclick="location.href='study_room_manage.do?study_idx=${study.study_idx}'">
															<input type="button" class="my-btn yellow-black" value="삭제하기" onclick="">													
															</c:if>	
														</c:if>
														
														<!-- 관리자가 아닐때 -->
														<c:if test="${study.is_admin eq 0}">
															<c:if test="${ study.mem_status eq '승인대기'}">
															<input type="button" class="my-btn yellow-black" value="신청 취소" onclick="">
															</c:if>
															
															<c:if test="${ study.mem_status eq '승인거부' or study.study_status eq '개설취소' or study.study_status eq '종료' }">
															<input type="button" class="my-btn yellow-black" value="삭제하기" onclick="">
															</c:if>
															
															<c:if test="${ study.mem_status eq '승인' or study.study_status eq '진행중' }">
															<input type="button" class="my-btn yellow-black" value="스터디 룸" onclick="location.href='study_room_detail.do?study_idx=${study.study_idx}'">
															</c:if>
															
															<c:if test="${ study.study_status eq '폐쇄대기' }">
																<input type="button" class="my-btn yellow-black" value="폐쇄 동의" onclick="location.href='#open_agree'">
																
																<!-- 폐쇄 동의 모달창 -->
																<div class="info_content agree_close" id="open_agree">
																	<div>
																		<h1 class="section-title blue line-bottom">스터디 폐쇄 진행 안내</h1>
																		<!-- 폐쇄 사유 -->
																		<h4 class="sub-section-title black">폐쇄 사유</h4>
																		<p class="section-discription">
																			어쩌구 저저구 폐쇄 사유입니당 <br>
																			흑흑ㅎ그흑흑 죄송함니다
																		</p>
																		
																		<!-- 동의 현황 -->
																		<br>
																		<h4 class="sub-section-title black">동의 현황</h4>
																		<p class="section-discription">
																			3 / 15 명 동의 ( 20% ) 	
																		</p>
																		
																		<!-- 폐쇄 안내 -->
																		<p class="section-discription">
																			폐쇄에 동의하기 위해서는 아래의 폐쇄 동의 버튼을 누르시면 됩니다. <br>
																			한 번 동의하면 되돌릴 수 없으니 신중히 동의해주시기 바랍니다. <br>
																			전체 인원의 80% 이상이 동의하면 폐쇄되며, 스터디 룸에서 삭제하실 수 있습니다. 
																		</p>
																		
																		<!-- 버튼 -->
																		<a href="javascript:void(0)" class="my-btn black-white">동의</a>
																		<a href="#close_agree" class="my-btn black-white">취소</a>
																	</div>
																</div>
																
															
															</c:if>												
																				
														</c:if>
														
														
													</div>
												</div>
											</div>
													
									</div>
								</div>
								
							</c:forEach>
			
						
							<c:if test="${user.study eq 0}">
							<!-- study가 아예 없을 경우 -->
								<div class="study-room none">
									<p class="study-name">참여중인 스터디가 존재하지 않습니다.</p>
	
									<div class="room-btn-box">
										<input type="button" class="my-btn yellow-black" value="스터디 찾아보기" onclick="location.href='study_list.do'"> 
										<input type="button" class="my-btn yellow-black" value="스터디 개설하기" onclick="location.href='study_create_caution.do'">
									</div>
								</div>
							</c:if>
						
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

	<script type="text/javascript">
		//마이페이지 메뉴 슬라이드 바
		function move_right(){
		    var bar = document.getElementById("bar");
		    bar.classList.add("right");
		    bar.classList.remove("left");
		}
	
		function move_left(){
		    var bar = document.getElementById("bar");
		    bar.classList.remove("right");
		    bar.classList.add("left");
		}
	
	</script>

</body>

</html>