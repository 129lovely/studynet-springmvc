<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--  include file="../login_check.jsp" %> --> 

<!DOCTYPE html>

<html>

<head>
	<meta charset="UTF-8">
	<title>스터디 룸 생성</title>
	
	<!-- Flatpickr related files -->
	<link href="https://cdn.jsdelivr.net/npm/flatpickr@4/dist/flatpickr.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr@4/dist/flatpickr.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
	
	<!-- flatpickr -->
	<script>
	window.onload = function () {

			 var deadLine = flatpickr ("#deadLine", {
					minDate: "today"
	                }                 
	
		        );
			  
			 var startDate = flatpickr ("#startDate", {
					minDate: "today"
	                }                 

	            );
			  
			 var endDate = flatpickr ("#endDate", {
					minDate: "today",
	                }                 

	            );
			
		}
	</script>

	
	<script>
		
	 	function show() {
	 		var purpose = document.getElementsByName("purpose"); //라디오 name
	 		
	 		for ( var i = 0; i < purpose.length; i++) {
		 		 var design = document.getElementById("op_" + (i+1)); // 보여질내용
		 		 if(purpose[i].checked == true ){

		 			design.style.display = "";
		 			
		 		 }else{
		 			purpose[i].checked = false;
		 			design.style.display = "none";
		 		 }
	 		 }
	 	}
	 	
		// 생성 버튼을 누르면 유효성 검사 후, 정보를 가지고 안내 페이지로 간다.
		function create( f ) {
			
			var title = f.title;
			var min_count = f.min_count;
			var max_count = f.max_count;
			var deadline = f.deadline;
			var start_date = f.start_date;
			var end_date = f.end_date;
			var open_kakao = f.open_kakao;
			var purpose = f.purpose;
			var is_online = f.is_online;
			var place = f.place;
			var extra_info = document.getElementsByName("extra_info");
			var apply_condition = f.apply_condition;
			var detail_info = f.detail_info;
			
			var num_patt = /^[0-9]+$/;
			
			if ( title.value == "" ) {
				alert("스터디 제목을 입력해주세요.");
				title.focus();
				return;
			}
			
			if ( min_count.value > max_count.value ) {
				alert("최소 모집 인원은 최대 모집 인원보다 작거나 같아야 합니다.");
				min_count.focus();
				return;
			}
			
			if ( ! num_patt.test(min_count.value) ){
				alert("최소 모집 인원은 숫자로 입력해주세요.");
				min_count.focus();
				return;
			}
			
			if ( ! num_patt.test(max_count.value) ){
				alert("최대 모집 인원은 숫자로 입력해주세요.");
				max_count.focus();
				return;
			}
			
			if ( max_count.value == "" ) {
				alert("최대 모집 인원을 선택해주세요.");
				max_count.focus();
				return;
			}
			
			if ( max_count.value == "" ) {
				alert("최대 모집 인원을 선택해주세요.");
				max_count.focus();
				return;
			}
			
			if ( deadline.value == "" ) {
				alert("모집 마감일을 선택해주세요.");
				deadline.focus();
				return;
			}
			
			if ( start_date.value == "" ) {
				alert("스터디 시작일을 선택해주세요.");
				start_date.focus();
				return;
			}
			
			if ( end_date.value == "" ) {
				alert("스터디 종료일을 입력해주세요.");
				end_date.focus();
				return;
			}
			
			if ( open_kakao.value == "" ) {
				alert("오픈 카카오톡 주소를 기입해주세요.");
				open_kakao.focus();
				return;
			}
			
			if ( place.value == "" ) {
				alert("모임 장소 / 사용 메신저 란을 작성해주세요.");
				place.focus();
				return;
			}
			
			if ( extra_info.value == "" ) {
				alert("스터디 목적 별 추가 정보를 작성해주세요.");
				extra_info.focus();
				return;
			}
			
			if ( apply_condition.value == "" ) {
				alert("모집 조건을 작성해주세요.");
				apply_condition.focus();
				return;
			}
			
			if ( detail_info.value == "" ) {
				alert("상세 설명을 작성해주세요.");
				detail_info.focus();
				return;
			}
			
			if ( purpose.value == "" ) {
				alert("스터디 목적을 선택해주세요.");
				return;
			}
			
			// 상시모집이 체크되어 있다면 스터디 종료 날짜를 모집 마감일로 설정
			if ( document.getElementById("always").checked == true ){
				f.deadline.value = f.end_date.value;
			}
			
			// 선택된 스터디 방식에 따라 추가 정보의 text를 정한다. 
			var val = 0;
			
			if ( purpose.value == "공모전" ) {
				val = 0;
			} else if ( purpose.value == "취업준비" ) {
				val = 1;
			} else if ( purpose.value == "기상/습관" ) {
				val = 2;
			} else if ( purpose.value == "공부" ) {
				val = 3;
			} else {
				val = 4;
			}
			
			for ( var i = 0 ; i < extra_info.length ; i ++ ) {
				if ( i != val ) {
					extra_info[i].value= "";
					extra_info[i].disabled = true;
				} 
			}
				
			// 다 값이 들어있다면 ~.~
			var res = confirm("입력하신 정보에 수정할 부분이 없는지 확인 하셨나요? 모집 글을 올린 뒤에는 신청 인원, 참여 인원이 0명일 경우에만 수정이 가능합니다.");
			
			if ( res == false ) {
				return;
			}
			
			f.action = "study_create_caution.do";
			f.method = "post";
			
			f.submit();
		}
	
	</script>
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
									<input type="hidden" name="create_user_idx" value="${ user.idx }">
									<table>
										<tr>
											<th rowspan="9">스터디명</th>
											<td colspan="2"><input type="text" name="title" placeholder="스터디 이름을 간결하고 알기 쉽게 입력해주세요.(최대20글자)" maxlength="20"/></td>
										</tr>
										<tr>
											<td colspan="3">* 인원은 수용 가능한 범위에서 기입해주세요</td>
										</tr>
		
										<tr>
											<th>최소 인원</th>
											<td>
												<input type="text" class="number" name="min_count"/>
												<span>명</span>
											</td>
										</tr>
										<tr>
											<th>최대 인원</th>
											<td>
												<input type="text" class="number" name="max_count"/>
												<span>명</span>
											</td>
										</tr>
			
										<tr>
											<th>신청 마감</th>
											<td class="select-date">
												<div>
													<input type="text" id="deadLine" name="deadline">
													
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
									<div class="flex-box">
										<div>
											<input type="radio" name="is_online" id="study-type-online" value="1" checked>
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
								<div>
									<ul class="flex-box">
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
									<table>
										<tr>
											<th>모임 장소</th>
											<td><input type="text" placeholder="모임 장소의 주소나 사용할 메신저를 적어주세요." name="place"/></td>
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
											<td><input type="text" placeholder="오픈 카톡 주소를 입력해 주세요" name="open_kakao"/></td>
										</tr>
										<tr>
											<th>활동 시작</th>
											<td class="select-date">
												<div>
													<input type="text" id="startDate" name="start_date">
												</div>
											</td>	
										</tr>	
										<tr>
											<th>활동 종료</th>
											<td class="select-date">
												<div>
													<input type="text" id="endDate" name="end_date">
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
									<textarea class="summernote-study-condition-box" name="apply_condition"></textarea>	
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
								<p class="section-discription tal">[ 대표 사진 업로드 ]<input type="file" name="photo_file"> </p><br>
							</div>
							<div class="note-my-custom">
								<textarea class="summernote-study-explanation-box" name="detail_info"></textarea>	
							</div>
						</div>
					</div>	
				</div>
		
				<!-- 등록/취소 버튼 -->
				<div class="study-create-btn-box">
					<div class="inner-box">
						<div class="contents-box flex-box">
							<input class="my-btn black-white" type="button" value="등록" onClick="create(this.form);"/>
							<input class="my-btn black-white" type="button" value="취소" onClick="location.href='index.do'"/>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
	
	<!-- 라디오 따라서 달라지는 레이아웃 -->
 	<script>
 		
 		$(document).ready(function(){
 			
 			var purpose = document.getElementsByName("purpose"); //라디오 name
 			
 			for ( var i = 0; i < purpose.length; i++) {
		 		 var design = document.getElementById("op_" + (i+1));
		 		 design.style.display = "none";
			}

 		});
 
 	</script>



</html>