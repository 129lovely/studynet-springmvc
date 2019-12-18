$(document).ready(function(){
	initSummernote();
	$('.note-btn').removeAttr('title'); 
});

var preBtn = null;

// 대댓글 창 열기
function openReComment(btn) {
	$('.write-comment-reply').remove();

	if( preBtn == null || preBtn.get(0) != $(btn).get(0) ){
		createReCommentBox(btn);
		return;    
	}

	preBtn = null;
}

function createReCommentBox(btn) {
	var btn_parent = $(btn).parent().parent();

	if( btn_parent.attr('class') == 'comment-reply-content' ) {
		// 대댓글일 경우 한단계 상위 엘리먼트로 올라간다
		btn_parent = btn_parent.parent();
	}

	var outer_div = $('<div></div>').addClass('write-comment-reply');
	var span = $('<span>ㄴ</span>');
	var textarea = $('<textarea></textarea>');
	var a = $('<a>대댓글 달기</a>');

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

// summernote 셋팅
function initSummernote(){
	$('.summernote-study-condition-box').summernote({
		lang: 'ko-KR',
		height: 200 + 'px',                 // set editor height
		minHeight: 200 + 'px',             // set minimum height of editor
		maxHeight: 500 + 'px',             // set maximum height of editor
		focus: true,                  // set focus to editable area after initializing summernote
		placeholder: '모집 조건(나이, 지역, 전공 등)을 상세히 기입해주세요.',
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

	$('.summernote-study-explanation-box').summernote({
		lang: 'ko-KR',
		height: 200 + 'px',                 // set editor height
		minHeight: 200 + 'px',             // set minimum height of editor
		maxHeight: 500 + 'px',             // set maximum height of editor
		focus: true,                  // set focus to editable area after initializing summernote
		placeholder: '스터디 기간 내용, 진행 요일 및 시간 등의 일정, 진행 방식 등 세부 설명을 기입해 주세요. 활동 사진이나 소개 사진, 동영상 링크 등을 첨부하시면 좋습니다.',
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

	$('.summernote-community-writing-box').summernote({
		lang: 'ko-KR',
		height: 300 + 'px',                 // set editor height
		minHeight: 200 + 'px',             // set minimum height of editor
		maxHeight: 500 + 'px',             // set maximum height of editor
		focus: true,                  // set focus to editable area after initializing summernote
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
}



//마이페이지 메뉴 슬라이드 바
function move_right(){
	var bar = document.getElementById("bar");
	bar.classList.add("right");
	bar.classList.remove("left");
}

function move_left(){
	var bar = document.getElementById("bar");
	bar.classList.remove("right");
	bar.classList.add("left");
}

//마이페이지 스터디 리스트 아코디언