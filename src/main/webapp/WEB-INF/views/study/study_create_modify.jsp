<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../login_check.jsp" %>

<!DOCTYPE html>

<html>

<head>
	<meta charset="UTF-8">
	<title>스터디 룸 수정</title>
	
	<!-- Flatpickr related files -->
	<link href="https://cdn.jsdelivr.net/npm/flatpickr@4/dist/flatpickr.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
	<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css">
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="body-bgcolor-set">
		<div>
			<form enctype="multipart/form-data">
				<!-- 스터디 룸 만들기  -->
				<div class="study-create-box">
					<div class="inner-box pt190">
						<div class="contents-box">
							<div class="line-bottom">
								<div class="flex-box">
									<h2 class="section-title tac">스터디 룸 수정하기</h2>
									<span class="icon icon-create-study"></span>
								</div>
								<p class="tac">
									여러분이 원하는 내용의 스터디를 <span>직접</span> 만들어 인원을 모집해보세요!
								</p>
							</div>
						</div>
					</div>
				</div>
		
				<!-- 스터디 기본 정보  -->
				<div class="study-info-box">
					<div class="inner-box">
						<div class="contents-box">
							<div class="line-bottom">
								<h2 class="sub-section-title">스터디 기본 정보</h2>
								<div class="table-indent">
									<input type="hidden" name="create_user_idx" value="${ study.create_user_idx }">
									<table>
										<tr>
											<th rowspan="9">스터디명</th>
											<td colspan="2"><input type="text" name="title" placeholder="스터디 이름을 간결하고 알기 쉽게 입력해주세요.(최대20글자)" maxlength="20" value="${study.title}"/></td>
										</tr>
										<tr>
											<td colspan="3">* 인원은 수용 가능한 범위에서 기입해주세요</td>
										</tr>
		
										<tr>
											<th>최소 인원</th>
											<td>
												<input type="text" class="number" name="min_count" value="${study.min_count}"/>
												<span>명</span>
											</td>
										</tr>
										<tr>
											<th>최대 인원</th>
											<td>
												<input type="text" class="number" name="max_count" value="${study.max_count}"/>
												<span>명</span>
											</td>
										</tr>
			
										<tr>
											<th>신청 마감</th>
											<td class="select-date">
												<div>
													<input type="text" id="deadLine" name="deadline" 
													<fmt:parseDate var="deadline" value="${study.deadline}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
													value='<fmt:formatDate value="${deadline}" type="date" pattern="YYYY-MM-dd"/>' >
												</div>
												<div>
													<input type="checkbox" id="always">
													<label for="recruit-type">상시 모집</label>
												</div>
											</td>
										</tr>						
									</table>
								</div>
							</div>
						</div>					
					</div>
				</div>
		
				<!-- 스터디 방식 선택 -->
				<div class="study-method-box">
					<div class="inner-box">
						<div class="contents-box">
							<div class="line-bottom">
								<div class="study-method-title flex-box">
									<h2 class="sub-section-title">스터디 방식 선택</h2>
									<div class="flex-box" id="myIs_online">
										<div>
											<input type="radio" name="is_online" id="study-type-online" value="1">
											<label for="study-type-online">온라인</label>
										</div>
										<div>
											<input type="radio" name="is_online" id="study-type-offline" value="0">
											<label for="study-type-offline">오프라인</label>
										</div>
										<div>
											<input type="radio" name="is_online" id="study-type-complex" value="2">
											<label for="study-type-complex">복합</label>
										</div>
									</div>
								</div>
								<div id="show_purpose">
									<ul class="flex-box" id="myPurpose">
										<li><input type="radio" name="purpose" value="공모전" id="purp_1" onClick="show();"/>
										<label class="my-btn select yellow-black" for="purp_1">공모전</label></li>
										<li><input type="radio" name="purpose" value="취업준비" id="purp_2" onClick="show();"/>
										<label class="my-btn select yellow-black" for="purp_2">취업준비</label></li>
										<li><input type="radio" name="purpose" value="기상/습관" id="purp_3" onClick="show();"/>
										<label class="my-btn select yellow-black" for="purp_3">기상/습관</label></li>
										<li><input type="radio" name="purpose" value="공부" id="purp_4" onClick="show();"/>
										<label class="my-btn select yellow-black" for="purp_4">공부</label></li>
										<li><input type="radio" name="purpose" value="기타" id="purp_5" onClick="show();"/>
										<label class="my-btn select yellow-black" for="purp_5">기타</label></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			
				<!-- 스터디 추가 정보 -->
			
				<div class="study-option-box">
					<div class="inner-box">
						<div class="contents-box">
							<div class="line-bottom">
								<h2 class="sub-section-title">추가 정보</h2>
								<div class="table-indent">
									<table id="p_table">
										<tr>
											<th>모임 장소</th>
											<td><input type="text" placeholder="모임 장소의 주소나 사용할 메신저를 적어주세요." name="place" value="${study.place}"/></td>
										</tr>
										
										<!-- 스터디 목적에 따라 바뀌는 부분 -->
											<tr id="op_1">
												<th>공모전 링크</th>
												<td><input type="text" name="extra_info"
												placeholder="참여를 준비하는 공모전의 안내 페이지를 링크해주세요." /></td>
											</tr>

											<tr id="op_2">
												<th>준비 분야</th>
												<td><input type="text" name="extra_info"
												placeholder="면접, 자소서 등 준비하는 분야를 간략히 적어주세요." /></td>
											</tr>

											<tr id="op_3">
												<th>스터디 목표</th>
												<td><input type="text" name="extra_info"
												placeholder="스터디 목표를 간략하게 적어주세요." /></td>
											</tr>

											<tr id="op_4">
												<th>스터디 과목</th>
												<td><input type="text" name="extra_info"
												placeholder="스터디 과목이나 분야, 자격증 명 등을 기입해주세요." /></td>
											</tr>

											<tr id="op_5">
												<th>스터디 과목</th>
												<td><input type="text" name="extra_info"
												placeholder="스터디 과목이나 분야, 자격증 명 등을 기입해주세요." /></td>
											</tr>


										<tr>
											<th>오픈 카톡</th>
											<td><input type="text" placeholder="오픈 카톡 주소를 입력해 주세요" name="open_kakao" value="${study.open_kakao}"/></td>
										</tr>
										<tr>
											<th>활동 시작</th>
											<td class="select-date">
												<div>
													<input type="text" id="startDate" name="start_date"
													<fmt:parseDate var="start_date" value="${study.start_date}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
													value='<fmt:formatDate value="${start_date}" type="date" pattern="YYYY-MM-dd"/>'>
												</div>
											</td>	
										</tr>	
										<tr>
											<th>활동 종료</th>
											<td class="select-date">
												<div>
													<input type="text" id="endDate" name="end_date" 
														<fmt:parseDate var="end_date" value="${study.end_date}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
													value='<fmt:formatDate value="${end_date}" type="date" pattern="YYYY-MM-dd"/>'>
												</div>
											</td>	
										</tr>
									</table>
								</div>	
							</div>
						</div>
					</div>
				</div>
			
				<!-- 모집 조건 -->
				<div class="study-condition-box">
					<div class="inner-box">
						<div class="contents-box">
							<div class="line-bottom">
								<h2 class="sub-section-title">모집 조건</h2>
								<div class="note-my-custom">
									<textarea class="summernote-study-condition-box" name="apply_condition">${study.apply_condition }</textarea>	
								</div>
							</div>
						</div>
					</div>	
				</div>		
			
				<!-- 상세 설명 -->
				<div class="study-explanation-box mb40">
					<div class="inner-box">
						<div class="contents-box">
							<h2 class="sub-section-title">상세 설명</h2>
							<div>
								<p class="section-discription tal">[ 대표 사진 업로드 ] <input type="file" name="photo_file" value="${study.photo}.jpg"> </p><br>
							</div>
							<div class="note-my-custom">
								<textarea class="summernote-study-explanation-box" name="detail_info">${study.detail_info}</textarea>	
							</div>
						</div>
					</div>	
				</div>
		
				<!-- 등록/취소 버튼 -->
				<div class="study-create-btn-box">
					<div class="inner-box">
						<div class="contents-box flex-box">
							<input class="my-btn black-white" type="button" value="수정" onClick="modify(this.form);"/>
							<input class="my-btn black-white" type="button" value="취소" onClick="location.href='index.do'"/>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>

	
	<script src="https://cdn.jsdelivr.net/npm/flatpickr@4/dist/flatpickr.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/summernote.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/summernote-ko-KR.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/study_modify.js"></script>
</body>
	



</html>