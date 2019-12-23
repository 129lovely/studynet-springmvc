<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../login_check.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>커뮤니티 글 작성</title>
	<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
    <div class="body-bgcolor-set">
        <div class="community-writing">
            <div class="inner-box pt190">
                <form class="contents-box board">
                	<!-- 회원 idx 넘기는 input -->
                	<input type="hidden" value="${ sessionScope.user.idx }" name="user_idx">
                	
                    <h3 class="section-title blue">커뮤니티 글 작성</h3>
                    <p class="section-discription tal mb40">이용약관을 준수하여 올바른 커뮤니티 사용을 부탁드립니다.</p>

                    <!--제목-->
                    <div class="line-bottom flex-box">
                        <label for="board-title">제목</label>
                        <input id="board-title" type="text" placeholder="제목을 입력해주세요." name="title" />
                    </div>
                    
                    <!--텍스트-->
                    <div class="note-my-custom">
                        <textarea class="summernote-community-writing-box" name="content"></textarea>
                    </div>
                    
                    <!--버튼-->
                    <div class="btn-box tac">
                        <input class="my-btn yellow-black" type="button" value="올리기" onclick="send(this.form);"/>
                        <input class="my-btn yellow-black" type="button" value="취소" onclick="location.href='community_list.do'"/>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../footer.jsp"></jsp:include>
    
    <script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/summernote.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/summernote-ko-KR.js"></script>
    <script type="text/javascript">
		$(document).ready(function(){
			$('.summernote-community-writing-box').summernote({
				lang: 'ko-KR',
				height: 300 + 'px',                 // set editor height
				minHeight: 200 + 'px',             // set minimum height of editor
				maxHeight: 500 + 'px',             // set maximum height of editor
				focus: false,                  // set focus to editable area after initializing summernote
				placeholder: '',
				toolbar: [
					// [groupName, [list of button]]
					['style', ['bold', 'italic', 'underline', 'clear']],
					['font', ['strikethrough']],
					['fontsize', ['fontsize']],
					['color', ['color']],
					['para', ['paragraph']],
					['height', ['height']],
					['table', ['table']],
					['insert', ['link', 'picture']],
					['view', ['fullscreen', 'codeview']],
					]
			});
		});
	
		function send(form) {
			var title = form.title.value.trim();
			var content = form.content.value;
			
			// 데이터 유효성 검사
			if( title == '' ) {
				alert("제목을 입력해주세요");
				form.title.focus();
				return;
			}
			if( content == '' ){
				alert("내용을 입력해주세요");
				form.content.focus();
				return;
			}
			
			form.action = "community_write.do";
			form.method = "post";
			form.submit();
		}
	</script>
</body>

</html>