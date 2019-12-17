<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인 확인 페이지</title>
		
		<c:if test=${ empty sessionScope.user }">
			<script type="text/javascript">
				alert("로그인 후에 이용하실 수 있습니다.");
				location.href="user_login_form.do";
			</script>
		</c:if>
	</head>
	
	<body>
	
	</body>
</html>