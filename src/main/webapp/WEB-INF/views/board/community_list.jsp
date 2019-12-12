<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="body-bgcolor-set">
        <div class="community-list-board">
    
            <div class="inner-box pt190">
                <div class="contents-box board">
                    <h2 class="section-title">
                        스터디넷에서 다양한 <span class="section-title blue">정보</span>를 나눠주세요.
                    </h2>
                    <div class="flex-box community-board-info mb30">
                            <span class="icon icon-caution"></span>
                            <p>
                                홈페이지 특성에 맞지 않고 관련 없는 글이나,
                                광고성 / 음란성 / 누군가를 비방하는 글 등은
                                무통보 삭제되거나 제제를 받을 수 있습니다.
                            </p>
                    </div>
                    <div class="search-result mb10">
                        <span>(검색 결과: 총 24건)</span>
                    </div>
    
                    <!-- 테이블 -->
                    <div class="mb20">
                        <table class="tac">
                            <tr>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일자</th>
                                <th>조회수</th>
                                <th>추천수</th>
                            </tr>
                            
                            <c:forEach var="vo" items="${ list }">
                            	<tr>
	                                <td>${ vo.title }</td>
	                                <td>${ vo.user_idx }</td>
	                                <td>${ vo.created_at }</td>
	                                <td>${ vo.hit }</td>
	                                <td>${ vo.recommend }</td>
                            	</tr>
                            </c:forEach>
         
                        </table>
                    </div>
                    
                    <!-- 버튼 -->
                    <div class="flex-box btn-box mb40">
                        <div class="flex-box">
                            <select>
                                <option>분류</option>
                                <option>각종 팁</option>
                            </select>
                            <input type="text" placeholder="검색어 입력" class="tac"/>
                            <a href="#" class="my-btn black-white">검색</a>
                        </div>
                        <div>
                            <a href="community_write.do" class="my-btn black-white">글 작성</a>
                        </div>
                    </div>
    
                    <!-- 페이징 -->
                    <div class="paging-box tac">
                        <a href="#" class="left-page"></a>
                        <a href="#">1</a>
                        <a href="#">2</a>
                        <a href="#" class="right-page"></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>