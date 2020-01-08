<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
						<span class="txt-only">작성자: </span>
						<h3>${ board.name }</h3>
					</div>
					<div>
						<span class="txt-only">작성일: </span> 
						<span><fmt:formatDate value="${board.created_at}" type="date" pattern="yyyy.MM.dd HH:mm" /></span>
						<span>조회수: </span> <span>${ board.hit }</span> <span>추천수: </span>
						<span id="rec_cnt">${ board.recommend }</span>
					</div>
				</div>
				<!-- 게시글 내용 -->
				<div class="board-contents summernote-board-contents-load">

					<div class="btn-box-mod">
						<a class="edit" href="javascript:b_modify();">수정</a> <a
							href="javascript:b_delete();">삭제</a>

					</div>

					${ board.content }

					<div class="btn-box-rec tac">
						<a href="javascript:recommend();"
							class="my-btn yellow-black">추천</a> <a
							class="my-btn black-white list" href="community_list.do">목록으로</a>
					</div>
				</div>

				<!-- 댓글 갯수 -->
				<div class="comment-info bg-blue">댓글 ${ fn:length(comment) }개
				</div>

				<c:if test="${ fn:length(comment) != 0 }">

					<!-- 코멘트 -->
					<div class="comment-box">
						<!-- db 가져온 것 -->
						<c:forEach var="vo" items="${ comment }">
							<c:if test="${ vo.parent == '' }">
								<div class="comment-origin" data-cidx="${ vo.idx }">
									<div>
										<h3>${ vo.name }</h3>
										<span><fmt:formatDate value="${vo.created_at}" type="date" pattern="yyyy.MM.dd HH:mm" /></span>
										<a href="javascript:void(0);" onclick="openReComment(this, ${ vo.idx }, 0, ${ board.idx });">대댓글 달기</a>
										<c:if  test="${ vo.deleted_at == null }">
											<a class="edit" href="javascript:void(0);" onClick="openModifyComment(this, ${ vo.idx }, ${ vo.user_idx });">수정</a>
											<a href="javascript:c_delete(${ vo.idx }, ${ vo.user_idx });">삭제</a>
										</c:if>
									</div>

									<div id="comment-standard">
										<p class="comment-standard">${ vo.content }</p>
									</div>

								</div>
							</c:if>

							<!-- 대댓글 -->
							<c:if test="${ vo.parent != '' }">
								<div class="comment-reply flex-box">
									<span>ㄴ</span>
									<div class="comment-reply-content">
										<div>
											<h3>${ vo.name }</h3>
											<span><fmt:formatDate value="${vo.created_at}" type="date" pattern="yyyy.MM.dd HH:mm" /></span> 
											<a href="javascript:void(0);" onclick="openReComment(this, ${ vo.idx }, 1, ${ board.idx });">대댓글 달기</a> 
											<c:if  test="${ vo.deleted_at == null }">
												<a href="javascript:void(0)" onClick="openModifyComment(this, ${ vo.idx }, ${ vo.user_idx });">수정</a>
												<a href="javascript:c_delete(${ vo.idx }, ${ vo.user_idx });">삭제</a>
											</c:if>
											
										</div>

										<div id="comment-standard">
											<p class="comment-standard">${ vo.content }</p>
										</div>

									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:if>

				<form class="write-comment-box flex-box" name="comment">
					<input type="hidden" name="board_idx" value="${board.idx}">
					<textarea id="comment-write-txtarea" placeholder="내용을 입력하세요"></textarea>
					<a class="my-btn black-white" href="javascript:void(0);"
						onclick="reply(${ board.idx });">댓글 달기</a>
				</form>

			</div>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	// 삭제된 게시글일 경우 열람 불가능
	$(document).ready(function(){ 
		// 만약 삭제된 게시글 ( 모집 취소 )일 경우 열람 불가능
		if ( ${  board.deleted_at != null } ) {
			location.href = "community_list.do";	
			alert("삭제된 게시글입니다.");
			
		}
	});

	//추천하기
	function recommend() {
		if( ${ empty sessionScope.user.idx } ){

			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}

		var idx = ${board.idx};
		var user_idx = ${board.user_idx};

		$.ajax({
			url: "/web/community_recommend.do"
				, type: "get"
					, data: { "idx": idx, "user_idx": user_idx }
		, dataType: "text"
			, success: function(response){
				var data = response;

				if( data == "self" ){
					alert("본인이 작성한 글은 추천할 수 없습니다.");
					return;
				}

				if( data == "over" ){
					alert("중복 추천은 불가능합니다.");
					return;
				}

				var cnt = ${ board.recommend };
				cnt += 1;

				$("#rec_cnt").text( cnt );
			}
		});

	}
	//---------------------------------------------------------------------------------
	//댓글 수정 관련 함수

	// 댓글 수정창 열기 -> textarea로
	var p_div = null;
	var p_content = "";

	function openModifyComment(this_tag, idx, user_idx){
		if( ${ empty sessionScope.user.idx } ){
			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}

		// #comment-standard -> div 가져오기
		var p_div_new = $(this_tag).parent().parent().children("#comment-standard"); 

		// 이전과 같은 '수정' 버튼을 클릭하면 이전에 열었던거 닫기
		if( p_div != null && p_div.get(0) == $(p_div_new).get(0) ){
			cancelModifyComment(p_content);
			p_div = null;
			return;
		}

		p_div = p_div_new;
		var content = $(p_div).children("p").text(); // content 가져오기

		$(p_div).empty(); // p태그 지우기

		// textarea, 수정, 취소 버튼 만들기
		var textarea = $("<textarea>" + content + "</textarea>").attr({
			"class" : "modify-comment-txtarea"
		});
		var mod_btn = $('<a>수정</a>').attr({
			"href" : "javascript:void(0);",
			"onclick" : "modifyComment('" + content + "'," + idx + "," + user_idx + ");",
			"class" : "my-btn yellow-black"
		});
		var cancel_btn = $('<a>취소</a>').attr({
			"href" : "javascript:void(0);",
			"onclick" : "cancelModifyComment();",
			"class" : "my-btn black-white"
		});

		// textarea & button 넣기
		$(p_div).append(textarea);
		$(p_div).append(mod_btn);
		$(p_div).append(cancel_btn);

		p_content = content;

	}

	// 댓글 수정 취소 -> 다시 p 태그로
	function cancelModifyComment(content){
		$(p_div).empty(); // textarea, a태그 삭제
		var p = $("<p>" + p_content + "</p>").attr({
			"class" : "comment-standard"
		});
		$(p_div).append(p); // p태그 넣기
		p_div = null;
	}

	// 댓글 수정 완료 -> db작업 & 다시 p태그로
	function modifyComment(content, idx, user_idx){
		// textarea의 수정된 내용 가져오기
		var content = $(p_div).children("textarea").val();

		$.ajax({
			url: "/web/comment_mod.do"
				, type: "get"
					, data: { "idx": idx, "user_idx": user_idx, "content": content }
		, dataType: "text"
			, success: function(response){
				var data = response;

				if( data == "fail" ){
					alert("작성자 본인만 수정/삭제할 수 있습니다.");
					cancelModifyComment(p_content);
					return;
				}

				cancelModifyComment(content);
				alert("댓글 수정 완료");
			}
		});

	}


	//---------------------------------------------------------------------------------

	// 댓글 달기
	function reply(board_idx){ /* board_idx = board테이블에서의 idx */
		if( ${ empty sessionScope.user.idx } ){

			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}

		var content = document.getElementById("comment-write-txtarea").value;

		if(content==''){
			alert("내용을 입력하세요");
			document.getElementById("comment-write-txtarea").focus();
			return ;
		}

		var link = "comment_origin_reply.do?board_idx=" + board_idx + "&content=" + content;

		location.href=link;

	}

	//---------------------------------------------------------------------------------

	// 대댓글 달기
	var preBtn = null;

	function openReComment(btn, parent, is_re, b_idx) { // 열린 대댓글 박스 닫기
		$('.write-comment-reply').remove();

		if( preBtn == null || preBtn.get(0) != $(btn).get(0) ){
			// 이전과 다른 대댓글 달기 버튼을 클릭한 경우만 박스 생성
			createReCommentBox(btn, parent, is_re, b_idx);
			return;    
		}

		preBtn = null;
	}

	function createReCommentBox(btn, parent, is_re, b_idx) { // 대댓글 박스 생성
		var btn_parent = $(btn).parent().parent();

		if( btn_parent.attr('class') == 'comment-reply-content' ) {
			// 대댓글일 경우 한단계 상위 엘리먼트로 올라간다
			btn_parent = btn_parent.parent();
		}

		var outer_div = $('<div></div>').addClass('write-comment-reply');
		var span = $('<span>ㄴ</span>');
		var textarea = $('<textarea></textarea>');
		var a = $('<a>대댓글 달기</a>').attr({
			"href" : "javascript:void(0);",
			"onclick" : "writeReComment(this," + parent + "," + is_re + "," + b_idx + ");"
		})

		outer_div.append(span);
		outer_div.append(textarea);
		outer_div.append(a);

		btn_parent.after(outer_div);

		preBtn = $(btn);

		//<div class="write-comment-reply">
		//	<span>ㄴ</span>
		//	<textarea></textarea>
		//	<a href="#">대댓글<br/>달기</a>
		//</div>
	}

	function writeReComment(rec_btn, parent, is_re, b_idx) { // 대댓글 내용 서버로 보내기
		if( ${ empty sessionScope.user.idx } ){
			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}

		var content = $(rec_btn).parent().children("textarea").val();
		var url = "write_comment_reply.do?content=" + content 
		+ "&parent=" + parent + "&is_re=" + is_re + "&b_idx=" + b_idx;

		location.href = url;
	}

	//---------------------------------------------------------------------------------
	// 게시글 수정
	function b_modify() {
		if( ${ empty sessionScope.user.idx } ){

			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}

		if( ${ board.user_idx != sessionScope.user.idx } ){
			alert("작성자 본인만 수정할 수 있습니다.");
			return;
		}

		location.href="community_write_modify_form.do?idx=${ board.idx }";
	}

	// 게시글 삭제
	function b_delete() {
		if( ${ empty sessionScope.user.idx } ){
			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}
		if( ${ board.user_idx != sessionScope.user.idx } ){
			alert("작성자 본인만 삭제할 수 있습니다.");
			return;
		}

		if( confirm("정말 삭제하시겠습니까?") == true ){
			location.href="del.do?idx=${ board.idx }";				
		}
	}

	// 댓글 & 대댓글 삭제
	function c_delete( idx, user_idx ){
		if( ${ empty sessionScope.user.idx } ){
			alert("로그인이 필요합니다.");
			location.href="user_login_form.do";
			return;
		}

		if( confirm("정말 삭제하시겠습니까?") == false ){
			return;
		}

		$.ajax({
			url: "/web/comment_del.do"
				, type: "get"
					, data: { "idx": idx, "user_idx": user_idx }
		, dataType: "text"
			, success: function(response){
				var data = response;

				if( data == "fail" ){
					alert("작성자 본인만 삭제할 수 있습니다.");
					return;
				}

				alert("댓글 삭제 완료");
				location.href="community_list_detail.do?idx=${ board.idx }";
			}
		});	
	}
	</script>
</body>
</html>