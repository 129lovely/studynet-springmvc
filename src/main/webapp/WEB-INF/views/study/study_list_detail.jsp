<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../login_check.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스터디 상세 정보</title>
	<script>
		
		function send_apply(max_count, approve_count, idx){
			// 신청 인원이 다 찼는지 확인
			var btn=document.getElementById("btn");
			if(max_count == approve_count){
				btn.disabled='disabled';
				$('#btn').css('background-color','#DEE0E3');
				return;
			}
			
			// 회원 정보 체크
			var user_idx = ${ sessionScope.user.idx };
			$.ajax({
				url: "/web/user_check.do"
				, type: "get"
				, data: { "user_idx": user_idx }
				, dataType: "text"
				, success: function(response){
					var data = response;
					
					// 누락된 회원 정보가 있는 경우
					if( data == "fail" ){
						alert("연락처, 직업, 지역 등의 회원 정보를 모두 입력해야 스터디 가입 신청이 가능합니다.");
						location.href = "user_myinfo_form.do";
						return;
					}
					
					// 활동중인 스터디 갯수가 3개인 경우
					if( data == "over" ){
						alert("1인당 3개의 스터디까지만 동시 활동 및 운영 가능합니다.");
						return;
					}
				}
			});
			
			// 중복 가입 여부 체크
			$.ajax({
				url: "/web/study_check.do"
				, type: "get"
				, data: { "user_idx": user_idx, "study_idx": idx }
				, dataType: "text"
				, success: function(response){
					var data = response;
					
					// 이미 참여 중인 스터디일 경우
					if( data == "fail" ){
						alert("이미 가입 신청했거나 활동중인 스터디입니다.");
						return;
					}
					
				}
			});

			location.href= "study_apply_caution.do?study_idx=" + idx;
		}
	
	</script>
	
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="study-list-detail">
		<div class="inner-box pt190">
			<div class="contents-box board">
				<h2 class="mb20">${study.title}</h2>
				<div class="flex-box bg-blue">
					<span><fmt:formatDate value="${ study.created_at }"  pattern="YYYY.MM.dd"/></span>
					<div>
						<span>개설자:</span>
						<h3>${user.name}</h3>
					</div>
				</div>
				<div class="recruit-info">
					<span class="mb10 image">
						<img src="resources/images/study_profile/${study.photo}">
					</span>
					
					<div>
						<span class = "addinfo2 tar">스터디 목적</span>
						<span>${study.purpose}</span>
					</div>
					<div>
						<span class = "addinfo2 tar">모집 마감</span>
						<span >
						<fmt:parseDate var="dateString" value="${study.deadline}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
						<fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" />
						</span>
					</div>
					<div>
						<span class = "section-discription" >모집 인원(최소/최대)</span>
						<span>${study.min_count}명 / ${study.max_count}명</span>
					</div>
					<div>
						<span class = "addinfo2 tar">지원현황</span>
						<span>${study.approve_count}명 / ${study.max_count}명</span>
					</div>					
					<div>
						<span class = "addinfo2 tar">모임 장소</span>
						<span>${study.place}</span>
					</div>
				</div>
				<div class="recruit-detail-info">
					<h2>세부 정보</h2>
					<p>
						<c:if test="${study.is_online=='0'}">
						<span class = "addinfo3 tar">온/오프 </span>    
						<span>오프라인</span>
						</c:if>
						<c:if test="${study.is_online=='1'}">
						<span class = "addinfo3 tar">온/오프 </span>    
						<span>온라인</span>
						</c:if>
						<c:if test="${study.is_online=='2'}">
						<span class = "addinfo3 tar">온/오프 </span>    
						<span>복합</span>
						</c:if>
						<br>
					</p>
					<p>	
						<br>
						<c:if test="${study.purpose=='공모전'}">
						<span class = "addinfo3 tar">공모전 링크 </span>
						<span><a href = "<c:if test="${ ! fn:contains(study.extra_info, 'http://') }">http://</c:if>${study.extra_info}">${study.extra_info}</a></span>	
						</c:if>
						<c:if test="${study.purpose=='취업준비'}">
						<span class = "addinfo3 tar">준비 분야  </span>    
						<span>${study.extra_info}</span>
						</c:if>
						<c:if test="${study.purpose=='기상습관'}">
						<span class = "addinfo3 tar"> 스터디 목표 </span>
						<span> ${study.extra_info}</span>
						</c:if> 
						<c:if test="${study.purpose=='공부'}">
						<span class = "addinfo3 tar">스터디 과목 </span>
						<span>${study.extra_info}</span> 
						</c:if>
						<c:if test="${study.purpose=='기타'}">
						<span class ="addinfo3 tar">스터디 과목 </span>
						<span> ${study.extra_info}</span>
						</c:if>
	
					</p>
					<p>	
						<br>
						<span class = "addinfo3 tar">오픈 카톡</span> 
						<span><a href="<c:if test="${ ! fn:contains(study.open_kakao, 'http://') }">http://</c:if>${study.open_kakao}">${study.open_kakao}</a></span>
					</p>
					<p>	
						<br>
						<span class = "addinfo3 tar">활동 시작</span>
						<span>	
						<fmt:parseDate var="StringStart" value="${study.start_date}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
						<fmt:formatDate value="${StringStart}" pattern="yyyy.MM.dd" />
						</span> 
					</p>
					<p>	
						<br>
						<span class = "addinfo3 tar">활동 종료</span> 
						<span>
						<fmt:parseDate var="StringEnd" value="${study.end_date}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
						<fmt:formatDate value="${StringEnd}" pattern="yyyy.MM.dd" />
						</span>
					</p>	
				</div>
				<div class="recruit-condition">
					<h2>모집 조건</h2>
					<p>
						${study.apply_condition}
					</p>
				</div>				
				<div class="detail-description mb20">
					<h2>상세 설명</h2>
					<p>
						${study.detail_info}
					</p>
				</div>			
				<div class="mb40 tac">
				<c:if test=""></c:if>
					<input id="btn" class="my-btn yellow-black" type="button" value="신청하기" onclick="send_apply(${study.max_count}, ${study.approve_count}, ${study.idx });"> 
					<input class="my-btn  yellow-black" type="button" value="목록으로" onclick="location.href='study_list.do'">
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	
		window.onload = function () {
			// 만약 삭제된 게시글 ( 모집 취소 )일 경우 열람 불가능
			if ( ${ study.deleted_at != null } ) {
				alert("삭제된 모집 게시글입니다.");
				location.href = "study_list.do";	
			}
		}
		
	</script>
</body>
</html>