<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${ board.title }</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="community-list-detail">
		<div class="inner-box pt190">
			<div class="contents-box board">
				<!-- 게시글 제목 -->
				<h2 class="mb20">${ board.title }</h2>
				<!-- 작성자 정보 -->
				<div class="board-info bg-blue flex-box">
					<div>
						<span class="txt-only">작성자:</span>
						<h3>${ board.user_idx }</h3>
					</div>
					<div>
						<span class="txt-only">작성일:</span>
						<span>${ board.created_at }</span>
						<span>조회수:</span>
						<span>${ board.hit }</span>
						<span>추천수:</span>
						<span>${ board.recommend }</span>
					</div>
				</div>
				<!-- 게시글 내용 -->
				<div class="board-contents summernote-board-contents-load">
					
					<div class="btn-box-mod">
						<a class="edit" href="community_write_modify_form.do?idx=${ board.idx }">수정</a>
						<a href="del.do?idx=${vo.idx}" onclick="del();">삭제</a>

					</div>
					${ board.content }
					<div class="btn-box-rec tac">
						<a href="#" class="my-btn yellow-black">추천</a>
						<a class="my-btn black-white list" href="community_list.do">목록으로</a>
					</div>
				</div>

				<!-- 댓글 갯수 -->
				<div class="comment-info bg-blue">
					댓글 ${ fn:length(comment) }개
				</div>
				
				<c:if test="${ fn:length(comment) != 0 }">
				<!-- 코멘트 -->		
				<div class="comment-box">
					<!-- db 가져온 것 -->
					<c:forEach var="vo" items="${ comment }">
						<c:if test="${ vo.parent == '' }">
							<div class="comment-origin">
								<div>
									<h3>${ vo.user_idx }</h3>
									<span>${ vo.created_at }</span>
									<a href="javascript:void(0);" onclick="openReComment(this);">대댓글 달기</a>
									<a href="community_list_detail_modify_form.do?idx=${ vo.idx }" onclick="openReComment(this);">수정</a>
									<a href="community_list_detail.do?idx=${vo.idx}" onclick="del();">삭제</a>
									<%-- <a href="del.do?idx=${vo.idx}" onclick="del();">삭제</a> --%>
									<!-- 댗체 이게 머지?................................. -->

									</div>
									<c:if test="${show ne 'yes'}">
										<p>
											${ vo.content }
										</p>
									</c:if>
									<c:if test="${show eq 'yes' }">
										<textarea class="comment-hidden">${ vo.content }</textarea>
										<a class="my-btn black-white" href="community_list_detail_modify.do?idx=${ vo.idx }">댓글 달기</a>								
									</c:if>
							</div>
						</c:if>
						<c:if test="${ vo.parent != '' }">
							<div class="comment-reply flex-box">
								<span>ㄴ</span>
								<div class="comment-reply-content">
									<div>
										<h3>${ vo.user_idx }</h3>
										<span>${ vo.created_at }</span>
										<a href="javascript:void(0);" onclick="openReComment(this);">대댓글 달기</a>
										<a href="community_list_detail_modify_form.do?idx=${ vo.idx }" onclick="openReComment(this);">수정</a>
										<a href="#">삭제</a>
									</div>
									<c:if test="${show ne 'yes'}">
										<p>
											${ vo.content }
										</p>
									</c:if>
									<c:if test="${show eq 'yes' }">
										<textarea class="comment-hidden">${ vo.content }</textarea>
										<a class="my-btn black-white" href="community_list_detail_modify.do?idx=${ vo.idx }">댓글 달기</a>								
									</c:if>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				</c:if>
				
				<form class="write-comment-box flex-box">
					<textarea></textarea>
					<a class="my-btn black-white" href="#">댓글 달기</a>
				</form>				
			</div>
			
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>