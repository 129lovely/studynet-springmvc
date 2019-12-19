<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스터디 찾아보기</title>
	<script type="text/javascript">
	function send(f){
		var search=f.search.value;	// 어디서 나왔던 keyword 였을까요?... ㅎ
		
		/* 멀쩡히 f 받아두시고 왜 studyform을 쓰세여 */
		if(f.search_option.option[0]){//옵션중에서 선택게 분류라면
			var search_option = studyform.search_option.option[0];
			location.href = "study_list_search.do?search&search_option"+search&search_option;//텍스트 입력값을 넘긴다.
			
		}else if(f.search_option.option[1]){//온라인이면
			var search_option = studyform.search_option.option[1];
			location.href = "study_list_search.do?search&search_option"+search&search_option;
			
		}else{//오프라인이면
			var search_option = f.search_option.option[2];
			location.href = "study_list_search.do?search&search_option"+search&search_option;
		}
		
		// 이거 복합 옵션도 추가하셔야 해요 !!
		// 그리고 파라미터 저렇게 넘기시면 안 돼요 "...?search=" + search + "&search_option=" + search_option 으로 하셔야 해여 따로따로
		// 글구 이거 option 값 선택되는 거 확인하신 건가여?? .value 이런식으로 하셔야 될텐데  값 중간중간 확인 하면서 하세여 ~~
	}
	</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="study-search-page">
		<!-- 원하는 스터디 검색하기 -->
		<form class="search-box mb20" action="study_list_search.do" name="studyform">
			<div class="flex-box pt190">
				<h2 class="section-title">원하는 스터디 검색하기</h2>
				<p class="mb10">step 1. 스터디 목적 선택하기 (복수 선택 가능)</p>
				<div class="btn-box mb10">
					<input class="my-btn black-white" type="button" value="공모전">
					<input class="my-btn black-white" type="button" value="취업준비">
					<input class="my-btn black-white" type="button" value="기상/습관">
					<input class="my-btn black-white" type="button" value="공부">
					<input class="my-btn black-white" type="button" value="기타">
				</div>
				<p class="mb10">step2.온/오프라인 분류를 선택하고 검색어 입력하기</p>
				<div class="mb40 flex-box">
					<div class="flex-box">
					
						<select name="search_option">
							<option value="by_all" 
							<c:if test="${map.search_option=='by_all'}">selected</c:if>
							>분류</option>
							<option value="by_online"
							<c:if test="${map.search_option=='by_online'}">selected</c:if>
							>온라인</option>
							<option value="by_offline"
							<c:if test="${map.search_option=='by_offline'}">selected</c:if>
							>오프라인</option>
						</select>
						<input type="text" placeholder="검색어를 입력해주세요" name="search" id="search"/>
					</div>
					<input class="my-btn black-white" type="button" value="찾아보기" name="btnSearch" id="btnSearch"
								onclick="send(this.form);" />
				
				</div>
			</div>
		</form>
		
		<!-- 검색 결과 -->
		<div class="search-result-box">
			<div class="contents-box">
				<p class="mb10">총 ${ fn:length(list) }건</p>
				<div class="search-result">
					<ul>
						<li class="flex-box">
							<span class="icon icon-pre01"></span>
							<div>
								<h3 class="mb10"><a href="javascript:void(0);"><span>[온라인] 웹 페이지 만들기 좀 긴 제목의 경우</span></a></h3>
								<p>모집 기간 &nbsp;|&nbsp; 2019.12.08 ~ 2019.12.08</p>
								<p>스터디 목적 &nbsp;|&nbsp; 공부</p>
								<p>모집 인원 &nbsp;|&nbsp; 10명</p>
							</div>
						</li>
						<li class="flex-box">
							<span class="icon icon-pre02"></span>
							<div>
								<h3><a href="javascript:void(0);"><span>[오프라인] 취업 면접 연습하기</span></a></h3>
								<p>모집 기간 &nbsp;|&nbsp; 2019.12.08 ~ 2019.12.08</p>
								<p>스터디 목적 &nbsp;|&nbsp; 공부</p>
								<p>모집 인원 &nbsp;|&nbsp; 10명</p>
							</div>
						</li>
						<li class="flex-box">
							<span class="icon icon-pre01"></span>
							<div>
								<h3><a href="javascript:void(0);"><span>[온라인] 웹 페이지 만들기</span></a></h3>
								<p>모집 기간 &nbsp;|&nbsp; 2019.12.08 ~ 2019.12.08</p>
								<p>스터디 목적 &nbsp;|&nbsp; 공부</p>
								<p>모집 인원 &nbsp;|&nbsp; 10명</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
			 <!-- 페이징 -->
				<div class="paging-box tac mb20">
				${pageMenu}
				</div>
				
			<div class="tac mb40">
				<span>마음에 드는 스터디가 없으신가요?</span></br>
				<a href="#"><span>직접 스터디 만들기</span></a>
			</div>
		</div>	
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>