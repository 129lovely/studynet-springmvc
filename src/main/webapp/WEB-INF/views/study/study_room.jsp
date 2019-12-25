<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
    
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>스터디 룸 | 스터디 제목 출력 </title>
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
                                공지, 일정 확인 | 출석 체크 | 스터디 게시판 등의 기능을 이용하실 수 있습니다. 
                            </p>
                        </div>

                        <!-- 스터디 공지 영역 -->
                        <div class="study-notice contents-box">
                            <div class="line-bottom">
                                <table class="table-indent"> 
                                    <caption class="sub-section-title tal"><i class="fas fa-bullhorn"></i> 필독 공지사항</caption>
                                    <th>
                                        <textarea readonly>
                                            
                                        </textarea>
                                    </th>
                                </table> 
                            </div>
                        </div>


                        <!-- 달력 / 출첵 / 일정 기능 -->
                        <div class="study-cal contents-box">
                            <div class="line-bottom">
                                <table class="table-indent">
                                    <caption class="sub-section-title tal"><i class="far fa-calendar-alt"></i> 일정 / 출석체크</caption>
                                    <th>
                                        <textarea readonly>
                                            
                                        </textarea>
                                    </th>
                                </table>
                               
                            </div>
                        </div>


                        <!-- 게시판 기능 -->
                        <div class="study-board contents-box">
                            <div>    
                                <table class="table-indent"> 
                                    <caption class="sub-section-title tal"><i class="fas fa-chalkboard"></i> 스터디 게시판</caption>
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

                    </div>
                </div>
            </div>
        </div>
	
		<jsp:include page="../footer.jsp"></jsp:include>
	</body>
</html>