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
                             	   공지, 일정 확인 | 출석 체크 | 스터디 게시판 등의 기능을 이용하실 수 있습니다. 
                            </p>
                        </div>

                       <!-- 스터디 공지 영역 -->
                        <div class="study-notice contents-box">
                            <div class="line-bottom">
                                 <h1 class="sub-section-title tal"><i class="fas fa-bullhorn"></i> 필독 공지사항</h1>
                                 <div class="section-discription tal">
				                                            원래 공지사항 출력되는 부분 ~~  <br>
				                                            일단은 보이게 !! <br>
				                                            웅냥냐야냔냥ㄴ냥
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
	
		<jsp:include page="../footer.jsp"></jsp:include>
		
		<script src="https://kit.fontawesome.com/95d80c99dc.js"></script>
	</body>
</html>