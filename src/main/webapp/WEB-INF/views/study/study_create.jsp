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
		<div>
			<form>
				<!-- 스터디 룸 만들기  -->
				<div class="study-create-box">
					<div class="inner-box pt190">
						<div class="contents-box">
							<div class="line-bottom">
								<div class="flex-box">
									<h2 class="section-title tac">스터디 룸 만들기</h2>
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
									<table>
										<tr>
											<th rowspan="9">스터디명</th>
											<td colspan="2"><input type="text" placeholder="스터디 이름을 간결하고 알기 쉽게 입력해주세요.(최대20글자)" /></td>
										</tr>
										<tr>
											<td colspan="3">* 인원은 수용 가능한 범위에서 기입해주세요</td>
										</tr>
		
										<tr>
											<th>최소 인원</th>
											<td>
												<input type="text" class="number" title=""/>
												<span>명</span>
											</td>
										</tr>
										<tr>
											<th>최대 인원</th>
											<td>
												<input type="text" class="number" title=""/>
												<span>명</span>
											</td>
										</tr>
			
										<tr>
											<th>신청 마감</th>
											<td class="select-date">
												<div>
													<select>
														<option>년</option>
													</select>
													<select>
														<option>월</option>	
													</select>
													<select>
														<option>일</option>
													</select>
												</div>
												<div>
													<input type="checkbox" id="recruit-type" name="">
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
									<div class="flex-box">
										<div>
											<input type="radio" name="study-type" id="study-type-online">
											<label for="study-type-online">온라인</label>
										</div>
										<div>
											<input type="radio" name="study-type" id="study-type-offline">
											<label for="study-type-offline">오프라인</label>
										</div>
										<div>
											<input type="radio" name="study-type" id="study-type-complex">
											<label for="study-type-complex">복합</label>
										</div>
									</div>
								</div>
								<div>
									<ul class="flex-box">
										<li><a href="#"><span class="my-btn select yellow-black">공모전</span></a></li>
										<li><a href="#"><span class="my-btn select yellow-black">취업준비</span></a></li>
										<li><a href="#"><span class="my-btn select yellow-black">기상/습관</span></a></li>
										<li><a href="#"><span class="my-btn select yellow-black">공부</span></a></li>
										<li><a href="#"><span class="my-btn select yellow-black">기타</span></a></li>
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
									<table>
										<tr>
											<th>모임 장소</th>
											<td><input type="text" placeholder="모임 장소의 주소나 사용 메신저를 적어주세요." /></td>
										</tr>
										<tr>
											<th>옵션</th>
											<td><input type="text" placeholder="옵션 설명" /></td>
										</tr>
										<tr>
											<th>오픈 카톡</th>
											<td><input type="text" placeholder="오픈 카톡 주소를 입력해 주세요" /></td>
										</tr>
										<tr>
											<th>활동 시작</th>
											<td class="select-date">
												<div>
													<select>
														<option>년</option>
													</select>
													<select>
														<option>월</option>	
													</select>
													<select>
														<option>일</option>
													</select>
												</div>
											</td>	
										</tr>	
										<tr>
											<th>활동 종료</th>
											<td class="select-date">
												<div>
													<select>
														<option>년</option>
													</select>
													<select>
														<option>월</option>	
													</select>
													<select>
														<option>일</option>
													</select>
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
									<textarea class="summernote-study-condition-box" placeholder=""></textarea>	
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
							<div class="note-my-custom">
								<textarea class="summernote-study-explanation-box" placeholder="asdf"></textarea>	
							</div>
						</div>
					</div>	
				</div>
		
				<!-- 등록/취소 버튼 -->
				<div class="study-create-btn-box">
					<div class="inner-box">
						<div class="contents-box flex-box">
							<input class="my-btn black-white" type="button" value="등록" />
							<input class="my-btn black-white" type="button" value="취소" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>