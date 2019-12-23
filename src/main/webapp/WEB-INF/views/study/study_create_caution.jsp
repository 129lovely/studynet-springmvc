<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../login_check.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스터디 생성 안내</title>
</head>

	<script type="text/javascript">
		function send() {
			var cb1 = document.getElementById("cb1");
			var cb2 = document.getElementById("cb2");
			var cb3 = document.getElementById("cb3");
			
			if ( !cb1.checked || !cb2.checked || !cb3.checked ) {
				alert("안내 사항을 모두 확인해주세요.");
				return;
			}
			
			// 회원 정보가 모두 입력됐는지 확인
			var user_idx = ${ user.idx };
			$.ajax({
				url: "/web/user_check.do"
				, type: "get"
				, data: { "user_idx": user_idx }
				, dataType: "text"
				, success: function(response){
					var data = response;
					
					// 누락된 회원 정보가 있는 경우
					if( data == "fail" ){
						alert("연락처, 직업, 지역 등의 회원 정보를 모두 입력해야 스터디를 생성할 수 있습니다.");
						location.href = "user_modify.do";
						return;
					}
					
					location.href = "study_create_form.do";
				}
			});

		}
	
	</script>
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
							<div class="line-bottom flex-box">
								<p class="section-discription">
									최소 인원이 차면 조기 마감이 가능하며, 모집 마감일까지 
									최소 인원을 채우지 못할 경우 2주의 기간 이내로 1회 연장이 가능합니다.
									폐쇄를 원할 경우 이미 참여중인 스터디원들의 동의를 받아 
									80% 이상이 폐쇄를 원할 경우 폐쇄가 진행됩니다.
								</p>
								<div class="tg">
									<input type="checkbox" id="cb3" class=tgl-skewed>
									<label class="tgl-btn" data-tg-off="비동의" data-tg-on="동의" for="cb3"></label>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 등록/취소 버튼 -->
				<div class="tac btn-box">
					<input class="my-btn black-white" type="button" value="생성하기" onClick="send();" />
					<input class="my-btn black-white" type="button" value="취소하기" onClick="history.go(-1)"/>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>