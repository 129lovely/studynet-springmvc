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

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script type="text/javascript">
		
    // 수정 textarea 띄우기
    var show=false;   
    
    function modify_box(){
       
       show=!show;
       
       document.getElementById("comment-modify-set").style.display=show ? 'block':'none';
       
    }
 
    // 댓글 수정
    function modify_comment(parent, idx, board_idx){ // BoardComment의 id
       var txtarea = $(parent).parent().children(".modify-comment-txtarea");
       var content = txtarea.val();
       
       if(content==''){
          alert("내용을 입력하세요");
          txtarea.focus();
          return;
       }
       
       var url="comment_update.do";
       var param="idx="+idx+"&content="+content+"&board_idx="+board_idx;
       sendRequest(url,param,resultFn,"post");
                
    }
    
    function resultFn(){ 
       
       if(xhr.readyState==4 && xhr.status==200){
          
          var data=xhr.responseText;
          if(data.result=='no'){
             alert("댓글 달기 실패..");
             return "community_list_detail.do?idx="+idx;
          }
          
          alert("댓글이 수정되었습니다");
          
          location.reload();
          
       }
    }
	
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
      
      // 대댓글 달기
      function depth_reply(div, idx){
         
         var textarea=$(div).parent().children(".depth-comment-txtarea");
         var content=textarea.val;
         
         if(content==''){
            alert("내용을 입력하세요");
            return;
         }
         
         var url="community_depth_comment.do";
         var param="idx="+idx+"&content="+content;
         sendRequest(url,param,resultFn_depth,"post");
         
      }
      
      function resultFn_depth(){
         
         if(xhr.readyState==4 && xhr.status==200){
               
        	 
         }

      }

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

	</script>

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
						<h3>${ board.user_idx }</h3>
					</div>
					<div>
						<span class="txt-only">작성일: </span> <span><fmt:formatDate
								value="${board.created_at}" type="date" pattern="yyyy.MM.dd" /></span>
						<span>조회수: </span> <span>${ board.hit }</span> <span>추천수: </span>
						<span>${ board.recommend }</span>
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
						<a href="community_recommend.do?idx=${board.idx}"
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
										<h3>${ vo.user_idx }</h3>
										<span><fmt:formatDate value="${vo.created_at}"
												type="date" pattern="yyyy.MM.dd HH:mm" /></span> <a
											href="javascript:void(0);" onclick="openReComment(this);">대댓글
											달기</a> <a class="edit" href="javascript:void(0);"
											onClick="modify_box();">수정</a> <a href="#">삭제</a>
									</div>

									<div id="comment-standard">
										<p class="comment-standard">${ vo.content }</p>
									</div>

									<div id="comment-modify-set" class="comment-modify-txttag">
										<textarea class="modify-comment-txtarea">${vo.content}</textarea>
										<a id="modify_href" class="my-btn black-white"
											href="javascript:void(0);"
											onclick="modify_comment(this, ${vo.idx}, ${ vo.board_idx} );">댓글
											수정</a>
									</div>
								</div>
							</c:if>

							<!-- 대댓글 -->
							<c:if test="${ vo.parent != '' }">
								<div class="comment-reply flex-box">
									<span>ㄴ</span>
									<div class="comment-reply-content">

										<div>
											<h3>${ vo.user_idx }</h3>
											<span><fmt:formatDate value="${vo.created_at}"
													type="date" pattern="yyyy.MM.dd HH:mm" /></span> <a
												href="javascript:void(0);" onclick="openReComment(this);">대댓글
												달기</a> <a href="javascript:void(0)" onClick="modify_box( );">수정</a>
											<a href="#">삭제</a>
										</div>

										<div id="comment-standard">
											<p class="comment-standard">${ vo.content }</p>
										</div>

										<div id="comment-modify-set" class="comment-modify-txttag">
											<textarea class="modify-comment-txtarea">${vo.content}</textarea>
											<a id="modify_href" class="my-btn black-white"
												href="javascript:void(0);"
												onclick="modify_comment(this, ${vo.idx}, ${ vo.board_idx} );">댓글
												수정</a>
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
</body>
</html>