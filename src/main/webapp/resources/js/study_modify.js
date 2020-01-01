window.onload = function () {
	init_summernote();
	init_option();
	init_flatpicker();

	// DB라디오들 체크하기
	$("#myIs_online input:radio[name='is_online']:input[value='${study.is_online}']").attr('checked',true);
	$("#myPurpose input:radio[name='purpose']:input[value='${study.purpose}']").attr('checked',true);
	
	var purp=document.getElementsByName("purpose");
	
	 	for ( var i = 0; i < purp.length; i++) {
	 		
	 		var design = document.getElementById("op_" + (i+1));
	 		
	 		if(purp[i].value==$("input[name='purpose']:checked").val()){
			
			design.style.display = "";
			
			var td=$(design).children("td").children("input");
			td.val("${study.extra_info}");
			// 값넣어주기
 		 }
	 		else{
	 			design.style.display="none";
	 		}
		 }  
	 
}

// 플랫피커 초기화
function init_flatpicker() {
	var deadLine = flatpickr ("#deadLine", {
			minDate: "today"
		}                 
	);

	var startDate = flatpickr ("#startDate");

	var endDate = flatpickr ("#endDate", {
			minDate: "today"
		}                 
	);
	
	deadLine.setDate("${study.dead_line}");
	startDate.setDate("${study.start_date}");
	endDate.setDate("${study.end_date}");
}

// 서머노트 초기화
function init_summernote() {
	$('.summernote-study-condition-box').summernote({
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

	$('.summernote-study-explanation-box').summernote({
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
}

// 옵션박스 초기화 (모두 none 상태)
function init_option() {
	var purpose = document.getElementsByName("purpose"); //라디오 name

	for ( var i = 0; i < purpose.length; i++) {
		var design = document.getElementById("op_" + (i+1));
		design.style.display = "none";
	}
}

// 옵션박스 선택하면 보이게하기
function show() {
	var purpose = document.getElementsByName("purpose"); //라디오 name

	for ( var i = 0; i < purpose.length; i++) {
		var design = document.getElementById("op_" + (i+1)); // 보여질내용
		if(purpose[i].checked == true ){

			design.style.display = "";

		}else{
			purpose[i].checked = false;
			design.style.display = "none";
		}
	}
}

// 생성 버튼을 누르면 유효성 검사 후, 정보를 가지고 안내 페이지로 간다.
function modify( f ) {
	
	var title = f.title;
	var min_count = f.min_count;
	var max_count = f.max_count;
	var deadline = f.deadline;
	var start_date = f.start_date;
	var end_date = f.end_date;
	var open_kakao = f.open_kakao;
	var purpose = f.purpose;
	var is_online = f.is_online;
	var place = f.place;
	var extra_info = document.getElementsByName("extra_info");
	var apply_condition = f.apply_condition;
	var detail_info = f.detail_info;
	
	var num_patt = /^[0-9]+$/;
	
	if ( title.value == "" ) {
		alert("스터디 제목을 입력해주세요.");
		title.focus();
		return;
	}
	
	if ( min_count.value > max_count.value ) {
		alert("최소 모집 인원은 최대 모집 인원보다 작거나 같아야 합니다.");
		min_count.focus();
		return;
	}
	
	if ( ! num_patt.test(min_count.value) ){
		alert("최소 모집 인원은 숫자로 입력해주세요.");
		min_count.focus();
		return;
	}
	
	if ( ! num_patt.test(max_count.value) ){
		alert("최대 모집 인원은 숫자로 입력해주세요.");
		max_count.focus();
		return;
	}
	
	if ( max_count.value == "" ) {
		alert("최대 모집 인원을 선택해주세요.");
		max_count.focus();
		return;
	}
	
	if ( max_count.value == "" ) {
		alert("최대 모집 인원을 선택해주세요.");
		max_count.focus();
		return;
	}
	
	if ( deadline.value == "" ) {
		alert("모집 마감일을 선택해주세요.");
		deadline.focus();
		return;
	}
	
	if ( start_date.value == "" ) {
		alert("스터디 시작일을 선택해주세요.");
		start_date.focus();
		return;
	}
	
	if ( end_date.value == "" ) {
		alert("스터디 종료일을 입력해주세요.");
		end_date.focus();
		return;
	}
	
	if ( open_kakao.value == "" ) {
		alert("오픈 카카오톡 주소를 기입해주세요.");
		open_kakao.focus();
		return;
	}
	
	if ( place.value == "" ) {
		alert("모임 장소 / 사용 메신저 란을 작성해주세요.");
		place.focus();
		return;
	}
	
	if ( extra_info.value == "" ) {
		alert("스터디 목적 별 추가 정보를 작성해주세요.");
		extra_info.focus();
		return;
	}
	
	if ( apply_condition.value == "" ) {
		alert("모집 조건을 작성해주세요.");
		apply_condition.focus();
		return;
	}
	
	if ( detail_info.value == "" ) {
		alert("상세 설명을 작성해주세요.");
		detail_info.focus();
		return;
	}
	
	if ( purpose.value == "" ) {
		alert("스터디 목적을 선택해주세요.");
		return;
	}
	
	// 상시모집이 체크되어 있다면 스터디 종료 날짜를 모집 마감일로 설정
	if ( document.getElementById("always").checked == true ){
		f.deadline.value = f.end_date.value;
	}
	
	// 선택된 스터디 방식에 따라 추가 정보의 text를 정한다. 
	var val = 0;
	
	if ( purpose.value == "공모전" ) {
		val = 0;
	} else if ( purpose.value == "취업준비" ) {
		val = 1;
	} else if ( purpose.value == "기상/습관" ) {
		val = 2;
	} else if ( purpose.value == "공부" ) {
		val = 3;
	} else {
		val = 4;
	}
	
	for ( var i = 0 ; i < extra_info.length ; i ++ ) {
		if ( i != val ) {
			extra_info[i].value= "";
			extra_info[i].disabled = true;
		} 
	}
		
	// 다 값이 들어있다면 ~.~
	var res = confirm("입력하신 정보에 수정할 부분이 없는지 확인 하셨나요? 모집 글을 올린 뒤에는 신청 인원, 참여 인원이 0명일 경우에만 수정이 가능합니다.");
	
	if ( res == false ) {
		return;
	}
	
	f.action = "study_create_modify.do?idx="+ "${study.idx}";
	f.method = "post";
	
	f.submit();
}