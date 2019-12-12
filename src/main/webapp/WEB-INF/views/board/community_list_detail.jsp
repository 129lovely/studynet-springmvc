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
	<div class="community-list-detail">
		<div class="inner-box">
			<div class="contents-box board">
				<!-- 게시글 제목 -->
				<h2 class="mb20">커뮤니티 글 제목은 몇 글자까지?</h2>
				<!-- 작성자 정보 -->
				<div class="board-info bg-blue flex-box">
					<div>
						<span class="txt-only">작성자:</span>
						<h3>박도치</h3>
					</div>
					<div>
						<span class="txt-only">작성일:</span>
						<span>2019.12.18</span>
						<span>조회수:</span>
						<span>23</span>
						<span>추천수:</span>
						<span>3</span>
					</div>
				</div>
				<!-- 게시글 내용 -->
				<div class="board-contents">
					
					<div class="btn-box-mod">
						<a class="edit" href="#">수정</a>
						<a class="del" href="#">삭제</a>
					</div>
					<p>
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야
						모십니다 모십니다 어쩌고 저쩌고</br>
						아에 에헤 에헤야asdfasdfㄱ닉마넝리ㅓㄱ암ㄴㄹ
					</p>
					<div class="btn-box-rec tac">
						<a href="#" class="my-btn yellow-black">추천</a>
						<a class="my-btn black-white list" href="community_list.html">목록으로</a>
					</div>
				</div>

				<!-- 댓글 갯수 -->
				<div class="comment-info bg-blue">
					댓글 2개
				</div>

				<!-- 코멘트 -->
				<div class="comment-box">
					<div class="comment-origin">
						<div>
							<h3>김꽁치</h3>
							<span>2018.12.15</span>
							<a href="#">대댓글 달기</a>
							<a href="#">수정</a>
							<a href="#">삭제</a>
						</div>
						<p>
							노래 제목이 머져?<br/>
							아주아주 궁금하군여
						</p>
					</div>
					<div class="comment-reply flex-box">
						<span>ㄴ</span>
						<div class="comment-reply-content">
							<div>
								<h3>김꽁치</h3>
								<span>2018.12.15</span>
								<a href="#">대댓글 달기</a>
								<a href="#">수정</a>
								<a href="#">삭제</a>
							</div>
							<p>
								악단 광칠이 부른 모십니다 입니당
							</p>
						</div>
					</div>
					<div class="comment-origin">
						<div>
							<h3>김꽁치</h3>
							<span>2018.12.15</span>
							<a href="#">대댓글 달기</a>
							<a href="#">수정</a>
							<a href="#">삭제</a>
						</div>
						<p>
							노래 제목이 머져?<br/>
							아주아주 궁금하군여
						</p>
					</div>
				</div>
				<form class="write-comment-box mb40 flex-box">
					<textarea></textarea>
					<a class="my-btn black-white" href="#">댓글 달기</a>
				</form>				
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>