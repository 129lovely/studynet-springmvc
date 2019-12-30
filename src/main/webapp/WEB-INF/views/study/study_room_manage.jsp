<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
    
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>스터디 룸 - 스터디 제목 출력 </title>
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
                                <h1 class="section-title">흠냐륑 여긴 스터디 제목 칸</h1>
                                <a class="my-btn yellow-black">모집글 보기</a>
                            </div>
                            <p class="line-bottom section-discription tal">
                                [관리자] 공지, 일정 등록 | 출석 체크 | 게시판 | 인원 관리 등의 기능을 이용하실 수 있습니다. 
                            </p>
                        </div>

                        <!-- 스터디 공지 영역 -->
                        <div class="study-notice contents-box">
                            <div class="line-bottom">
                                <form> 
                                    <div class="flex-box notice">
                                        <h1 class="sub-section-title tal"><i class="fas fa-bullhorn"></i> 필독 공지사항</h1>
                                        <div>
                                            <a class="my-btn yellow-black" href="javascript:void(0);" id="apply_notice" onClick="edit_apply( )">적용</a>
                                            <a class="my-btn black-white" href="javascript:void(0);" id="edit_notice" onClick="open_edit();">수정</a>
                                        </div>
                                        
                                    </div>
                                    <div class="section-discription tal" id="notice_text">
					                                        원래 공지사항 출력되는 부분 ~~  <br>
					                                        일단은 보이게 !! <br>
					                                        웅냥냐야냔냥ㄴ냥
                                    </div>
                                    <!-- 수정하기 누르면 textarea 튀어나오게 스크립트 처리해야 함 -->
                                    <textarea name="notice" id="notice_input">
                                        
                                    </textarea name="notice">
                                    <!-- 원래 내용 담아두기 -->
                                    <input type="hidden" value="" id="original"> 
                                </form> 
                            </div>
                        </div>

                        <!-- 인원 관리 기능 -->
                        <div class="study-mem contents-box">
                            <div class="line-bottom">
                                <div >
                                    <h1 class="sub-section-title tal"><i class="fas fa-id-card"></i> 스터디 멤버 관리</h1>

                                    <div>
                                        <div class="crown">
                                            <div>
                                                <!-- 이름 누르면 복사되면 좋겟지만... 일단 툴팁으로 대체... -->
                                                <span class="section-discription tal">현재 스터디 관리자: 
                                                	<c:forEach var="mem" items="${member}">
                                                		<c:if test="${ mem.mem_status eq 'admin' }">
                                                			<span class="section-discription tal" title="${mem.phone}"> ${mem.name} </span>
                                                		</c:if>
                                                	</c:forEach>         
                                                </span>
                                                
                                                <a href="#open-add-crown" class="section-discription"><i class="fas fa-crown"></i> 공동 관리자 추가</a>
                                            </div>
                                        </div>

                                        <div class="info_content add_crown" id="open-add-crown">
                                            <div>
                                                <h1 class="sub-section-title">스터디 공동 관리자 추가</h1>
                                                <p class="section-discription">
							                                                    공동 관리자는 개설자와 똑같은 권한을 가집니다.
							                                                    공동 관리자는 최대 3명까지 설정 가능하며, 공동 관리자로 추가된 멤버가
							                                                    메일을 통해 요청을 승인하기 전까진 관리자로 인정되지 않습니다.
							                                                    일방적으로 권한을 제거할 수 없으니 신중히 지정하시기 바랍니다.
                                                </p>
                                                <form>
							                                                    공통 관리자로 추가할 멤버의 이름과 이메일을 입력해주세요.
                                                    <p class="input-box"> 
                                                        <input type="text" placeholder="이름을 입력해주세요." name="ad_name"><br>
                                                        <input type="text" placeholder="이메일을 입력해주세요." name="ad_email">
                                                    </p><br>
                                                    <input type="button" value="공동 관리자로 설정" class="my-btn yellow-black" onClick="add_admin( this.form );">
                                                    <br><br>
                                                    <a class="my-btn yellow-black" href="#close-add-crown">취소</a>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="approve">
                                            <form>
                                                <p class="section-discription tal"><i class="fas fa-user-check"></i> [ 참여 인원 ]</p>
                                                <div class="member-list-box">
                                                    <table class="member-list">
                                                        <tr>
                                                            <th>선택</th>
                                                            <th>이름</th>
                                                            <th>이메일</th>
                                                            <th>전화번호</th>
                                                        </tr>
                                                       
                                                        <c:forEach var="mem" items="${member}">
	                                                       	<c:if test="${mem.mem_status eq '승인' }">
	                                                        	<tr>
	                                                            <td><input type="checkbox" name="approve_member" value="${mem.idx}"></td>
	                                                            <td>${mem.name}</td>
	                                                            <td>${mem.email}</td>
	                                                            <td>${mem.phone}</td>
	                                                        	</tr>
	                                                        </c:if>
	                                                        <c:if test="${ mem.mem_status eq 'admin' }">
	                                                        	<tr>
	                                                            <td></td>
	                                                            <td>${mem.name}</td>
	                                                            <td>${mem.email}</td>
	                                                            <td>${mem.phone}</td>
	                                                        	</tr>
	                                                        </c:if>
                                                        </c:forEach>
                                                    </table>                                    
                                                </div>

                                                <div class="export-menu">
                                                    <div>
                                                        <!-- 요거는 어떤 방식으로 내보내게 할지 정해야 함 -->
                                                        <a href="#" class="section-discription"> 
                                                        <i class="fas fa-file-export"></i> 목록 내보내기</a>
                                                    </div>
                                                </div>

                                                <div class="manage-button">
                                                    <input type="button" class="my-btn yellow-black" value="선택 인원  강퇴" onClick="">
                                                </div>
                                            </form>
                                       </div>
                                    </div>

                                    <!-- 모집이 마감되지 않았을 때만 보이게 -->
                                    <div>
                                        <div class="apply">
                                            <form>
                                                <p class="section-discription tal"><i class="fas fa-user-edit"></i> [ 신청 인원 ]</p>
                                                <div class="member-list-box">
                                                    <table class="member-list">
                                                        <tr>
                                                            <th>선택</th>
                                                            <th>이름</th>
                                                            <th>직업</th>
                                                            <th>지역</th>
                                                            <th>자기소개</th>
                                                        </tr>
                                                        <c:forEach var="mem" items="${member}">
	                                                       	<c:if test="${mem.mem_status eq '승인대기'}">
	                                                        	<tr>
	                                                            <td><input type="checkbox" name="apply_member" value="${mem.idx}"></td>
	                                                            <td>${mem.name}</td>
	                                                            <td>${mem.job}</td>
	                                                            <td>${mem.region}</td>
	                                                            <td>${mem.introduce}</td>
	                                                        	</tr>
	                                                        </c:if>
                                                        </c:forEach>
                                                    </table>
                                                </div>

                                                <div class="manage-button">
                                                    <input type="button" class="my-btn yellow-black" value="선택 인원 승인" onClick="mem_approve( );">
                                                    <input type="button" class="my-btn yellow-black" value="선택 인원 거부" onClick="mem_reject( );">
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                               
                            </div>
                        </div>

                        <!-- 달력 / 출첵 / 일정 기능 -->
                        <div class="study-cal contents-box">
                            <div class="line-bottom">
                                <div>
                                    <h1 class="sub-section-title tal"><i class="far fa-calendar-alt"></i> 일정 / 출석체크</h1>
                                    <div>
                                        <textarea readonly>
                                            
                                        </textarea>
                                    </div>
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
                                    <tr>
                                        <th>[ 공지 ] 제목입니당</th>  
                                        <th>2019-12-24</th>
                                        <th>422</th>
                                    </tr>
                                    <tr>
                                        <th>[ 공지 ] 제목입니당</th>  
                                        <th>2019-12-24</th>
                                        <th>32</th>
                                    </tr>
                                    <tr>
                                        <td>일반 글 제목입니당</td>  
                                        <td>2019-12-24</td>
                                        <td>8</td>
                                    </tr>
                                    <tr>
                                        <td>일반 글 제목입니당</td>  
                                        <td>2019-12-24</td>
                                        <td>8</td>
                                    </tr>
                                </table> 

                                <br>
                            <!-- 페이징, 글 작성 버튼 등 -->
                                <div class="menu table-indent"> <br>
                                    <div class="paging-box tac">&lt;   1  2  3  4  5 &gt; </div>                                    
                                    <a href="#"><i class="fas fa-edit"></i> 글 작성</a>   
                                </div>                           
                            </div>
                        </div>

                        <!-- 스터디 탈퇴 -->
                        <div class="study-quit contents-box">
                                <div class="line-bottom">
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


                        <!-- 스터디 룸 폐쇄 -->
                        <div class="study-close contents-box">
                            <div>
                                <h1 class="sub-section-title tal"><i class="fas fa-backspace"></i> 스터디 폐쇄</h1>
                                <div>
                                    <p class="section-discription">
						                                      스터디 폐쇄를 신청하시면 스터디 폐쇄 동의 투표가 진행됩니다.
						                                      투표 진행 시 스터디 참여 인원 전원에게 메일이 발송됩니다.
						                                      스터디 참여 인원의 80% 이상이 동의하면 폐쇄되며, 
						                                      폐쇄 신청 중엔 스터디의 모든 기능에 접근이 불가능합니다.
                                        <br><br>정말 폐쇄를 진행하시려면 아래에 이메일과 비밀번호를 재입력 해주세요.
                                    </p><br>

                                    <div class="flex-box input-box">
                                        <div>
                                            <input type="text" placeholder="회원님의 이메일을 입력해주세요.">
                                            <br><br>
                                            <input type="password" placeholder="비밀번호를 입력해주세요.">
                                        </div>
                                        <input type="button" class="my-btn black-white" value="폐쇄 신청">
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
			
		<jsp:include page="../footer.jsp"></jsp:include>
		
		<script src="https://kit.fontawesome.com/95d80c99dc.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
        <script>
            var flag = false;

            notice_input = document.getElementById("notice_input");
            notice_text = document.getElementById("notice_text");

            edit_button = document.getElementById("edit_notice");
            apply_button = document.getElementById("apply_notice");

            notice_input.style.display="none";
            apply_button.style.display="none";

            function open_edit() {
                flag = !flag;

                if ( flag == false ){
                    notice_input.style.display="none";
                    apply_button.style.display="none";
                    notice_text.style.display="block";
                    edit_button.style.display="block";
                } else {
                    notice_input.style.display="block";
                    apply_button.style.display="inline";
                    notice_text.style.display="none";
                    edit_button.style.display="none";
                }
            }

            function edit_apply( ) {
                var original = document.getElementById("original");

                notice_input.style.display="none";
                apply_button.style.display="none";
                notice_text.style.display="block";
                edit_button.style.display="block";
                
                if ( notice_input.value == original.value ) {
                    // 변경 사항 없음
                    return;
                }

                // 에이젝스로 보내기


            }
        </script>
        
        
        <script type="text/javascript">
        
        	// 공동 관리자 추가 
        	function add_admin ( f ) {
        		
        		var input_name = f.ad_name.value;
        		var input_email = f.ad_email.value;
        		var check = false; 
        		var cnt = 0;
        		
        		// 파라미터로 넘길 정보
        		var idx;
        		var name;
        		var study_idx;
        		
        		// 스터디 관리자가 이미 3명인지 확인
        		<c:forEach var="mem" items="${member}">
        			
        			if ( "${mem.mem_status}" == "admin"){
        				cnt ++;
        			}
        			
        		</c:forEach>
        		
        		if ( cnt == 3 ) {
        			alert("이미 3명의 스터디 관리자가 존재합니다.");
        			return;
        		}
        			
    			// 입력한 정보의 멤버가 승인된 스터디 멤버에 포함되는지 확인
        		<c:forEach var="mem" items="${member}">
        		
        			if ( "${mem.name}" != input_name || "${mem.email}" != input_email || "${mem.mem_status}" != "승인") {
        				
        			} else {
        				// 만약 조건이 올바르다면 ajax로 메일 전송
            			idx = "${mem.idx}";
            			email = "${mem.email}";
            			study_idx = "${mem.study_idx}";
            			
            			check = true;
            			
            			var url = "add_study_admin_mail.do";
            			var param = "idx=" + idx + "&email=" + email + "&study_idx=" + study_idx;
            			
            			sendRequest(url, param, add_admin_res, "get");
        			} 

        		</c:forEach>
        		
        		// 일치하는 정보가 없다면
       			if ( check == false ){
       				alert("정보가 올바르지 않습니다. 입력하신 멤버의 정보를 다시 확인해주세요.");
       			}
        	}
        	
        	// 관리자 추가 result
        	function add_admin_res ( ) {
        		if ( xhr.readyState == 4 && xhr.status == 200 ) {			
        			alert("관리자 추가 요청 메일을 전송했습니다.");
        			location.href="#close-add-crown"
        		}
        	}
        	
        	
        	// 선택 인원 승인 버튼
        	function mem_approve( ) {
        		
				var check = confirm("선택한 인원을 승인할까요?");
        		
        		if ( ! check ) {
        			return;
        		}
        		
        		var param = "";
        		var cnt = 0;
        		
        		// 선택한 인원 파라미터로 설정
        		$("input[name=apply_member]:checked").each(function() {
        			  var test = $(this).val(); 
        			  
        			  if( cnt != 0 ){
        				  param += "&";
        			  }
        			  
        			  cnt++
        			  
					  param += ( "idx=" + test );

        		});
        		
        		var url = "mem_approve.do";
        		
        		sendRequest(url, param, mem_approve_res, "get");
        		
        	}
        	
        	// 선택 인원 승인 완료
        	function mem_approve_res () {	
        		if ( xhr.readyState == 4 && xhr.status == 200 ) {
        			var result = xhr.responseText;     			
        			alert(result + "명의 승인에 성공했습니다.");
        			location.reload();
        		}
        	}
     		
        	// 선택 인원 거부 버튼
        	function mem_reject( ) {
        		
        		var check = confirm("선택한 인원의 승인을 거부할까요?");
        		
        		if ( ! check ) {
        			return;
        		}
        		
        		var param = "";
        		var cnt = 0;
        		
        		// 선택한 인원 파라미터로 설정
        		$("input[name=apply_member]:checked").each(function() {
        			  var test = $(this).val(); 
        			  
        			  if( cnt != 0 ){
        				  param += "&";
        			  }
        			  
        			  cnt++
        			  
					  param += ( "idx=" + test );

        		});
        		
        		var url = "mem_reject.do";
        		
        		sendRequest(url, param, mem_reject_res, "get");
        		
        	}
        	
        	// 선택 인원 거부 완료
        	function mem_reject_res () {	
        		if ( xhr.readyState == 4 && xhr.status == 200 ) {
        			var result = xhr.responseText;     			
        			alert(result + "명의 승인 거부에 성공했습니다.");
        			location.reload();
        		}
        	}
        
        	// 선택한 인원 강퇴
        	
        </script>
	</body>
</html>