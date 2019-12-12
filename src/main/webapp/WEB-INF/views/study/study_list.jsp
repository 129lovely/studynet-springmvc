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
	<div class="study-search-page">
		<!-- 원하는 스터디 검색하기 -->
		<form class="search-box mb20">
			<div class="flex-box">
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
						<select name="">
							<option>분류</option>
							<option>온라인</option>
							<option>오프라인</option>
						</select>
						<input type="text" placeholder="검색어를 입력해주세요"/>
					</div>
					<input class="my-btn black-white" type="button" value="찾아보기"/>
				</div>
			</div>
		</form>
		
		<!-- 검색 결과 -->
		<div class="search-result-box">
			<div class="contents-box">
				<p class="mb10">총 8건 검색 결과가 있습니다</p>
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
			<div class="paging-box tac mb20">
				<a href="#" class="left-page"></a>
				<a href="#">1</a>
				<a href="#">2</a>
				<a href="#" class="right-page"></a>
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