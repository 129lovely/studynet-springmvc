<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
    
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>스터디 룸 - ${ study.title }</title>
		<link type="text/css" rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/fullcalendar.main.css">
		<link type="text/css" rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/daygrid.main.css">
    	<script src="${ pageContext.request.contextPath }/resources/js/fullcalendar.main.js"></script>
    	<script src="${ pageContext.request.contextPath }/resources/js/interaction.main.js"></script>
    	<script src="${ pageContext.request.contextPath }/resources/js/daygrid.main.js"></script>
    	<script src="${ pageContext.request.contextPath }/resources/js/fullcalendar.ko.js"></script>
    	<script src="${ pageContext.request.contextPath }/resources/js/moment.js"></script>
	</head>
	
	<body>
		<jsp:include page="../header.jsp"></jsp:include>
		
		<div class="body-bgcolor-set">
            <div class="my-study-room">
                <div class="inner-box pt190">
                    <div class="contents-box board">

                        <!-- 페이지 제목 -->
                        <div class="room-header">
                            <div class="flex-box title">
                                <h1 class="section-title">${ study.title }</h1>
                                <a class="my-btn yellow-black" href="study_list_detail.do?idx=${ study.idx }">모집글 보기</a>
                            </div>
                            <p class="line-bottom section-discription tal">
                             	   공지, 일정 확인 | 출석 체크 | 스터디 게시판 등의 기능을 이용하실 수 있습니다. 
                            </p>
                        </div>

                       <!-- 스터디 공지 영역 -->
                        <div class="study-notice contents-box">
                            <div class="line-bottom">
                                 <h1 class="sub-section-title tal"><i class="fas fa-bullhorn"></i> 필독 공지사항</h1>
                                 
                                 <span class="section-discription tal">현재 스터디 관리자: 
                                 	<c:forEach var="mem" items="${member}">
                                 		<c:if test="${ mem.mem_status eq 'admin' }">
                                 			<span class="section-discription tal" title="${mem.phone}"> ${mem.name} </span>
                                 		</c:if>
                                 	</c:forEach>         
                                 </span>
                                 
                                 <div class="section-discription tal" id="notice_text"> ${ study.notice } </div>
                            </div>
                        </div>
                        
                        <!-- 달력 / 출첵 / 일정 기능 -->
                        <div class="study-cal contents-box">
                            <div class="line-bottom">
                                <div>
                                    <h1 class="sub-section-title tal"><i class="far fa-calendar-alt"></i> 일정 / 출석체크</h1>
                                    <div id='calendar'></div>
                                </div>
                            </div>
                        </div>


                        <!-- 게시판 기능 -->
                        <div class="study-board contents-box">
                            <div class="line-bottom">    
                            <h1 class="sub-section-title tal"><i class="fas fa-chalkboard"></i> 스터디 게시판</h1>
                                <table class="table-indent"> 
                                    <tr>
                                        <th>제목</th>  
                                        <th>&nbsp; 작성일자 &nbsp; </th>
                                        <th>조회수</th>
                                    </tr>
                                    <c:forEach var="vo" items="${ board }">
                                    	<c:if test="${ vo.is_notice eq 1 }">
	                                    <tr>
	                                        <th>
	                                        	<a href="javascript:board_show('${ vo.title }', '${ vo.name }', '<fmt:formatDate value="${ vo.created_at }"/>', '${ vo.content }');">
	                                        		[ 공지 ] ${ vo.title }
                                        		</a>
                                       		</th>  	                                    	
		                                   	<th><fmt:formatDate value="${ vo.created_at }"/></th>
											<th>${ vo.hit }</th>
	                                    </tr>
                                    	</c:if>
                                    	
                                    	<c:if test="${ vo.is_notice eq 0 }">
                                    	<tr>
	                                        <td>
	                                        	<a href="javascript:board_show('${ vo.title }', '${ vo.name }', '<fmt:formatDate value="${ vo.created_at }"/>', '${ vo.content }');">
	                                        		${ vo.title }
                                        		</a>
	                                        </td>  
	                                        <td><fmt:formatDate value="${ vo.created_at }"/></td>
                                        	<td>${ vo.hit }</td>
                                        </tr>	                                    	
                                    	</c:if>
                                    </c:forEach>
                                    <tr>
                                    	<td colspan="3">
                                    		<div class="paging-box tac">
						                       ${pageMenu}
						                   </div>
                                    	</td>
                                    </tr>
                                </table> 
                            <!-- 페이징, 글 작성 버튼 등 -->
                                <div class="menu table-indent"> <br>
                                    <a href="javascript:board_wirte_show(${ study.idx });"><i class="fas fa-edit"></i> 글 작성</a>   
                                </div>                           
                            </div>
                        </div>

                        <!-- 스터디 탈퇴 -->
                        <div class="study-quit contents-box">
                                <div >
                                    <h1 class="sub-section-title tal"><i class="fas fa-user-times"></i> 스터디 탈퇴</h1>
                                    <div>
                                        <div>
                                            <p class="section-discription">
						                                                스터디를 탈퇴하시면 스터디 룸 개별 페이지에 접근이 불가능하며,
						                                                내 스터디룸에서는 해당 스터디가 자동으로 삭제됩니다.
						                                                개설자나 공동 관리자의 경우 자신을 제외한 관리자가 한 명이라도 
						                                                있을 경우에만 탈퇴가 가능합니다.                                         
                                              <br><br>정말 탈퇴를 진행하시려면 아래에 비밀번호를 재입력해주시기 바랍니다. 
                                            </p><br>
                                            
                                            <div class="tac">
                                                <input type="password" placeholder="비밀번호를 입력해주세요.">
                                                <input type="button" value="탈퇴하기" class="my-btn black-white">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
	
		<!-- 게시판 보기 모달 -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">
				<!-- Modal content-->
				<div class="modal-content">
					<!-- 제목 -->
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"></button>
						<h4 class="modal-title tac" id="title"></h4>
					</div>
					<!-- 내용 -->
					<div class="modal-body">
						<p id="writer" class="tar mb30"></p>
						<p id="content" class="mb20"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" onclick="javascript:void(0);">삭제</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 글쓰기 모달 -->
		<div class="modal fade" id="myModal2" role="dialog">
			<form>
				<input type="hidden" value="${ study.idx }" name="study_idx"> <!-- study_idx 값 저장 -->
				
				<div class="modal-dialog modal-lg">
					<!-- Modal content-->
					<div class="modal-content">
						<!-- 제목 -->
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"></button>
							<h4 class="modal-title flex-box" id="title" style="align-items: center;">
								<span style="min-width: 80px; font-weight: bold; font-size: 1.2rem;" class="tac">제목</span>
								<input type="text" name="title" style="width: 80%; margin-right: 15px;">
							</h4>
						</div>
						<!-- 내용 -->
						<div class="modal-body">
							<textarea name="content"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" onclick="board_write(this.form);">글쓰기</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</form>
		</div>
		<jsp:include page="../footer.jsp"></jsp:include>
		
		<script src="https://kit.fontawesome.com/95d80c99dc.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
		<script type="text/javascript">
		
		 window.onload = function name() {
	            calendar.render();
			}
	        
	        // fullCalendar 셋팅
	        var calendarEl = document.getElementById('calendar');
	        var calendar = new FullCalendar.Calendar(calendarEl, {
	        	locale: 'ko',
	            plugins: [ 'interaction', 'dayGrid' ],
	            contentHeight: 600,
	            eventClick: function(info) {
	              	var startStr = moment(info.event.start).format('YYYY-MM-DD');
	              	var endStr = moment(info.event.end).format('YYYY-MM-DD');
	              	if( endStr == 'Invalid date' ){
	              		endStr = startStr;	
	              	}
	              	$("input[name='startDate']").val(startStr);
	            	$("input[name='endDate']").val(endStr);
	            	$("#myModal4 input[name='title']").val(info.event.title);
	        		$("#myModal4").modal('show');
	            },
	            selectable: true,
	            dateClick: function(info) {
	            	$("input[name='startDate']").val(info.dateStr);
	            	$("input[name='endDate']").val(info.dateStr);
	            	$("#myModal3 input[name='title']").val("");
	        		$("#myModal3").modal('show');
	            },
	            select: function(info) {
	            	$("input[name='startDate']").val(info.startStr);
	            	$("input[name='endDate']").val(info.endStr);
	            	$("#myModal3 input[name='title']").val("");
	            	$("#myModal3").modal('show');
	            },
	       		events: [
	    			 <c:if test="${!empty cal}">
		            	 <c:forEach var="vo" items="${cal}">
		                 {
		                	 title: "${vo.title}",
		                	 start: "${vo.startDate}",
		                	 end: "${vo.endDate}",
		                	 backgroundColor: "#DFE1E4",
		                	 borderColor: "#DFE1E4"
		                 },   
		            	 </c:forEach>                	
	       	  		 </c:if> 
	       				        
	          ]
	        });
	        
		// 게시판 모달 띄우기
		// 게시글보기
		function board_show(title, name, created_at, content) {
			// ajax 로 idx 값 이용해서 데이터 가져올것 (지금은 임시) 
			$("#title").text(title);
			$("#title").css("font-weight", "bold");
			$("#title").css("font-size", "1.2rem");
			
			$("#writer").text(name + " (" + created_at + ")");
			$("#writer").css("font-weight", "bold");
			
			$("#content").text(content);
			
			//modal을 띄우기 
			$("#myModal").modal('show');
		}
		// 글쓰기
		function board_wirte_show(study_idx) {
			$("#myModal2").modal('show');
		}
		function board_write(form) {
			var title = form.title.value.trim();
			var content = form.content.value.trim();
			
			if( title == "" ){
				alert("제목을 입력해주세요");
				form.title.focus();
				return;
			}
			if( content == "" ){
				alert("내용을 입력해주세요");
				form.content.focus();
				return;
			}
			
			form.action = "study_board_write.do";
			form.method = "post";
			form.submit();
		}

		</script>
	</body>
</html>