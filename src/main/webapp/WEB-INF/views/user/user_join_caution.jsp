<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>약관 동의</title>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<div class="study-useRule">
	
		<!-- 스터디넷 회원가입 -->
		<div class="study-useRule-box">
			<div class="inner-box pt190">
				<div class="contents-box">
					<div class="flex-box">
						<h2 class="section-title tac">스터디넷 회원가입</h2>
						<span class="icon icon-join-study"></span>
					</div>
					<p class="section-discription">
						회원 정보를 입력해 스터디넷에 가입하시면<br> 페이지의 모든 서비스를 이용하실 수 있습니다.
						
					</p>
				</div>
			</div>		
		</div>
		
		<!-- 규정 -->
		<div class="study-rules-box">
		
			<!-- 이용약관 -->
			<div class="study-useSimp-box">
				<div class="inner-box">
					<div class="contents-box">
						<div class="line-bottom">
							<h2 class="sub-section-title black">이용약관</h2>
							<div>
								<textarea readonly="readonly" id="caution1">
								</textarea>
								
								<div class= "checkbox_right">
								<input type="checkbox" id="join-check-1" name="accept" value="동의">
								<label for="join-check-1">약관에 동의합니다</label>
								</div>
							</div>
						</div>
					</div>
				</div>	
			</div>
			
			<!-- 개인 정보 보호 정책-->
			<div class="study-info-protect-box">
				<div class="inner-box">
					<div class="contents-box">
						<div class="line-bottom">
							<h2 class="sub-section-title black">개인 정보 보호 정책</h2>
							<div>
								<textarea readonly="readonly" id="caution2">
								</textarea>
								
								<div class= "checkbox_right">
								<input type="checkbox" id="join-check-2" name="accept" value="동의">
								<label for="join-check-2">약관에 동의합니다</label>
								</div>	
							</div>
						</div>
					</div>
				</div>	
			</div>
			
			<!-- 개인 정보 수집 이용 -->
			<div class="study-info-collect-box">
				<div class="inner-box">
					<div class="contents-box">
						<h2 class="sub-section-title black">개인 정보 수집 이용</h2>
						<div>
							<textarea readonly="readonly" id="caution3">
							</textarea>
							
							<div class= "checkbox_right">
							<input type="checkbox" id="join-check-3" name="accept" value="동의">
							<label for="join-check-3">약관에 동의합니다</label>
							</div>	
						</div>
					</div>
				</div>	
			</div>	
				
		</div>
		
		<!-- 페이지 이동 버튼 -->
		<div class="study-useRule-btn">
			<div class="inner-box">
				<div class="contents-box flex-box">
					<input class="my-btn black-white" type="button" value="회원 정보 입력하기" onClick='join_form();' />
				</div>
			</div>
		</div>
	
	</div> <!-- study-useRule -->
	
	<!-- 푸터 -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<!-- 스크립트 -->
	<script type="text/javascript">
		window.onload = function(){
			var xmlhttp, text;
			xmlhttp = new XMLHttpRequest();
			
			for( var i = 0 ; i < 3 ; i++ ){
				xmlhttp.open('GET', '${pageContext.request.contextPath}/resources/text/caution'+ (i+1) + '.txt', false);
				xmlhttp.send();
				text = xmlhttp.responseText;
				document.getElementById("caution" + (i+1)).innerHTML = text;
			}
			
		}
		
		function join_form(){
			
			var check = document.getElementsByName("accept");
			
			if ( check[0].checked != true ){
				alert("이용 약관에 동의해주세요.");
				document.getElementById("caution1").focus();
				return;
			}
			
			if ( check[1].checked != true ){
				alert("개인정보 보호 정책에 동의해주세요.");
				document.getElementById("caution2").focus();
				return;
			}
			
			if ( check[2].checked != true ){
				alert("개인정보 수집 / 이용 약관에 동의해주세요.");
				document.getElementById("caution3").focus();
				return;
			}
			
			location.href = "user_join_form.do";
		}
	
	</script>
</body>

</html>