<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../login_check.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스터디 신청 안내</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script type="text/javascript">


	function send(form) {

		var cb1 = document.getElementById("cb1");
		var cb2 = document.getElementById("cb2");
		var cb3 = document.getElementById("cb3");
		var introduce = form.introduce.value;
		
		if ( !cb1.checked || !cb2.checked || !cb3.checked) {
			alert("안내 사항을 모두 확인해주세요.");
			return;
		}
		if (introduce == "") {
			alert("자기소개를 입력해주세요");
			return;
		}
	
	
 			
		// 스터디 중복 체크 메서드
					
		var study_idx = document.getElementById("study_idx");	
		
		alert(study_idx.value);
		
		var url = "study_check.do";
		var param = "study_idx=" + study_idx;
		sendRequest( url, param, verify_result, "GET");
					
		
	}
	
	function verify_result(){
		var introduce = document.forms[0].introduce.value;
		
		if(xhr.readyState == 4 && xhr.status == 200) {
			var res = xhr.responseText;
			
			alert(res);
			
			if( res == 'yes' ){
				alert("이미 신청하신 스터디입니다. 마이페이지에서 확인해주세요!");
				return;
			}
			
			alert("신청 완료 되었습니다.");
			
			location.href = "study_apply.do?study_idx="+${ study_idx }+"&introduce="+introduce;
		}

	}
</script>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="study-apply body-bgcolor-set">
		<div>
			<div class="inner-box pt190">
				<form class="contents-box board">
						<!-- idx 정보 숨겨놓기 -->
						<input type="hidden" id="study_idx" value="${ study_idx }">
				
					<!-- 스터디 참가 신청하기  -->
					<div class="study-apply-box">
						<div class="line-bottom">
							<h3 class="section-title blue tac mb30">스터디 참가 신청하기</h3>
							<a class="section-discription mb20" href="study_list_detail.do">[오프라인] 한 달만에 Python 마스터하기!!</a>
							<p class="section-discription tal">
								위의 스터디에 참가하시려는게 맞나요?<br>
								선택하신 스터디에 참가 신청을 하시려면<br>
								아래 문항을 잘 읽고 모두 체크하신 뒤, 신청하기를 눌러주세요!
							</p>
						</div>
					</div>

					<!-- 신청 조건 확인 -->
					<div class="study-explanation-box line-bottom">
						<div>
							<p>1. 모집 조건과 세부 정보 등을 꼼꼼히 확인하셨나요?</p>
							<div class="tg">
									<input type="checkbox" id="cb1" class=tgl-skewed>
									<label class="tgl-btn" data-tg-off="비동의" data-tg-on="동의" for="cb1"></label>
							</div>
						</div>
						<div>
							<p>2. 회원님의 이름, 이메일, 전화 번호, 직업, 지역이
								개설자에게 함께 전송됩니다. 동의하시나요? </p>
							<div class="tg">
									<input type="checkbox" id="cb2" class=tgl-skewed>
									<label class="tgl-btn" data-tg-off="비동의" data-tg-on="동의" for="cb2"></label>
							</div>
						</div>
						<div>
							<p>3. 신청이 승인되기 전까지 취소가 가능합니다.
								승인된 후에는 사이트를 통해서가 아니라,
								직접 개설자와 대화 후 취소하기 바랍니다.</p>
							<div class="tg">
									<input type="checkbox" id="cb3" class=tgl-skewed>
									<label class="tgl-btn" data-tg-off="비동의" data-tg-on="동의" for="cb3"></label>
							</div>
						</div>	
					</div>
											
						<div class="introduce-box line-bottom">
							<p class="section-discription">자신을 어필할 짧은 자기소개를 입력해주세요!</p><br>
							<input type="text" name="introduce">
						</div>
					
					<!-- 신청하기/취소 버튼 -->
					<div class="tac btn-box">
						<input class="my-btn black-white" type="button" value="신청하기" onclick="send(this.form);"/>
						<input class="my-btn black-white" type="button" value="취소하기" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>