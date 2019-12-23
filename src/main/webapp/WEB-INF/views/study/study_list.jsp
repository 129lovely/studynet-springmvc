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
		var search = f.search.value;	
		var search_option = $("#search_option option:selected").val();
		
		//텍스트 입력값을 넘긴다.
		location.href = "study_list_search.do?search="+search+"&search_option="+search_option;	
				
		//파라미터 2개보냄
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
		<form class="search-box mb20"  >
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
				<p class="mb10">step 2. 온/오프라인 분류를 선택하고 검색어 입력하기</p>
				<div class="mb40 flex-box">
					<div class="flex-box">
						<form name="f">
						<select name="search_option" id="search_option">
							$("#search_option").append("<option value="3">분류</option>");
							$("#search_option").append("<option value="1">온라인</option>");
							$("#search_option").append("<option value="0">오프라인</option>");
							$("#search_option").append("<option value="2">복합</option>");
						</select>
					
						<input type="text" placeholder="검색어를 입력해주세요" name="search" id="search"/>
					</div>
					<input class="my-btn black-white" type="button" value="찾아보기" name="btnSearch" id="btnSearch"
								onclick="send(this.form);" />
				
						</form>
				</div>
			</div>
		</form>
		
		<!-- 검색 결과 -->
		<div class="search-result-box">
			<div class="contents-box">
				<p class="mb10"> <span>(검색 결과: 총  ${ row_total }건)</span></p>
				<div class="search-result">
					<ul>
						<c:forEach var="vo" items="${list }">
						
							<li class="flex-box">
							
							<span><img src="resources/images/study_profile/${vo.photo}"/> </span>
							
								<!-- 온라인 -->
                         	<c:if test="${ vo.is_online == 1 }">
		                        <div>
		                           	<h3><a href="study_list_detail.do?idx=${ vo.idx }">[온라인] &nbsp;${ vo.title }</a></h3>	                            	
		                            <p>모집 마감  &nbsp;|&nbsp;  <fmt:parseDate var="dateString" value="${vo.deadline}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
						<fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /></p>
		                            <p>스터디목적  &nbsp;|&nbsp; ${ vo.purpose }</p>
		                            <p>모집 인원 &nbsp;|&nbsp; ${ vo.approve_count }</p>
	              				</div>
              				</c:if>
	              				
	              				
	              				<!-- 오프라인 -->
                         	<c:if test="${ vo.is_online == 0 }">
	                         	<div>
		                           	<h3><a href="study_list_detail.do?idx=${ vo.idx }">[오프라인] &nbsp;${ vo.title }</a></h3>	                            	
		                            <p>모집 마감  &nbsp;|&nbsp; <fmt:parseDate var="dateString" value="${vo.deadline}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
						<fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /> </p>
		                            <p>스터디목적  &nbsp;|&nbsp; ${ vo.purpose }</p>
		                            <p>모집 인원 &nbsp;|&nbsp; ${ vo.approve_count }</p>
	              				</div>
              				</c:if>
	              				
	              				
	              				<!-- 온/오프라인 -->
	                        <c:if test="${ vo.is_online == 2 }">
		                        <div>
		                           	<h3><a href="study_list_detail.do?idx=${ vo.idx }">[복합] &nbsp;${ vo.title }</a></h3>	                            	
		                            <p>모집 마감  &nbsp;|&nbsp; <fmt:parseDate var="dateString" value="${vo.deadline}" pattern="yyyy-MM-dd HH:mm:ss.SSS" /> 
										<fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /> </p>
		                            <p>스터디목적  &nbsp;|&nbsp; ${ vo.purpose }</p>
		                            <p>모집 인원 &nbsp;|&nbsp; ${ vo.approve_count }</p>	              				
		              			</div>
		              		</c:if>
		              				
						<%-- 	    <!--분류 -->
		                         	<c:if test="${ vo.is_online == 3 }">분류
		                         	<!-- 이거 이렇게 하는 게 아니라 온오프복합 전부 상관 없이 나오는 거라구 말씀 드렷는데,,,ㅎㅎ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,, -->
		                           	<h3><a href="study_list_detail.do?idx=${ vo.idx }">
		                           	${ vo.title }</a></h3>	                            	
		                            <p>모집기간  &nbsp;|&nbsp; ${vo.deadline }</p>
		                            <p>스터디목적  &nbsp;|&nbsp; ${ vo.purpose }</p>
		                            <p>모집 인원 &nbsp;|&nbsp; ${ vo.approve_count }</p>
		              				</c:if> --%>
	                       		
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			 <!-- 페이징 -->
				<div class="paging-box tac mb20">
				${pageMenu}
				</div>
				
			<div class="tac mb40">
				<span>마음에 드는 스터디가 없으신가요?</span></br>
				<a href="study_create_caution.do"><span>직접 스터디 만들기</span></a>
			</div>
		</div>	
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>