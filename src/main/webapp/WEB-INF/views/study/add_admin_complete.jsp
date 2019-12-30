<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스터디 공동 관리자 추가 완료</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
		<div class="user-join-complete body-bgcolor-set">

		<div>
			<div class="inner-box pt190">
				<div class="contents-box board">
					<div class="line-bottom">
                        <p class="section-title tac">스터디 공동 관리자 등록이 완료됐습니다. </p>
                        
						<div class="section-discription">
							<span class="sub-section-title">[ 스터디 관리자 권한 ]</span><br><br>
							&nbsp; 스터디 공동 관리자는 기존 관리자와 같은 권한을 가집니다. <br>
							스터디 공지사항 작성 / 일정 관리 / 인원 관리 등을 할 수 있으며,  <br>
							관리자에 대한 일방적인 강퇴나 권한 삭제가 불가능합니다.  <br><br>
 
                            &nbsp;스터디 탈퇴를 위해서는 자신을 제외한 공동 관리자가 1명 이상 존재해야 합니다. <br>
                         	   스터디 관리자는 스터디 당 최대 3명을 등록할 수 있습니다. 
						</div>
					</div>
					<div class="tac mb40">
						<input class="my-btn black-white mb20" type="button" value="메인페이지" onClick="location.href='index.do'"/>
					</div>
				</div>
			</div>

		</div>

	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>

</html>