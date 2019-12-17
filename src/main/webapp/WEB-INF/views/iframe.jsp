<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link type="text/css" rel="stylesheet"
		href="${ pageContext.request.contextPath }/resources/css/reset.css">
	<link type="text/css" rel="stylesheet"
		href="${ pageContext.request.contextPath }/resources/css/common.css">
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<style type="text/css">
	.chat-box > div {
		padding-right: 40px;
		padding-left: 40px;
	}
	
	.chat-box .inner-chat-box {
		display: none;
	}
	</style>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
	<!-- 본페이지 아이프레임 -->
	<iframe name="NeBoard" src="index.do"
		style="display: block; width: 100vw; height: 100vh; border: none; margin: 0;"
		frameborder="0" marginwidth="0" marginheight="0"></iframe>

	<!-- 실시간 채팅 -->
	<div class="chat-box">
		<!-- 채팅아이콘 -->
		<div id="chat-icon-box" class="inner-box contents-box flex-box">
			<a href="javascript:open_liveChat();"><span class="icon icon-chat"></span></a>
		</div>
		
		<!-- 실제 채팅박스 -->
		<div id="live-chat-box" class="inner-box contents-box inner-chat-box">
			<div style="background-color: pink;">
				<input type="text" id="sender" value="비회원"> <input type="text"
					id="messageinput">
			</div>
			<div>
				<button type="button" onclick="send();">Send</button>
				<a href="javascript:close_liveChat();">닫기</a>
				<!-- <button type="button" onclick="closeSocket();">Close</button> -->
			</div>
			<!-- Server responses get written here -->
			<div id="messages"></div>		
		</div>
	</div>


	
	<!-- websocket javascript -->
	<script type="text/javascript">
		$(document).ready(function() {
			openSocket();
		});

		var ws;
		var messages = document.getElementById("messages");

		// 서버 -> 클라이언트
		function openSocket() {
			alert("소켓 접속");
			if (ws !== undefined && ws.readyState !== WebSocket.CLOSED) {
				writeResponse("이미 접속중인 회원입니다");
				return;
			}
			//웹소켓 객체 만드는 코드
			ws = new WebSocket("ws://localhost:9090/web/echo2.do");

		/* 	ws.onopen = function(event) {
				if (event.data === undefined)
					return;
				writeResponse(event.data);
			}; */
			ws.onmessage = function(event) { // 서버에서 메시지가 왔을 때
				if( event.data.indexOf("studynet2019!@#$%") != -1 ){
					document.getElementById("sender").value = "비회원(" + event.data.split("studynet2019!@#$%")[1] + ")";
					return;
				}
				writeResponse(event.data); // 클라이언트에게 메시지 보여주기
			};
			/* ws.onclose = function(event) {
				writeResponse("연결이 끊어졌습니다...");
			} */
		}

		// 클라이언트 -> 서버
		function send() {
			var text = document.getElementById("sender").value + ": " + document.getElementById("messageinput").value;  
			ws.send(text);
			text = "";
		}

		/* function closeSocket() {
			ws.close();
		} */
		
		function writeResponse(text) {
			messages.innerHTML += "<br/>" + text; // 클라이언트에게 메시지 보여주기
		}
		
		
		// 채팅 아이콘 토글
		function open_liveChat() {
			$("#live-chat-box").css("display", "block");
			$("#chat-icon-box").css("display", "none");
		}
		
		function close_liveChat() {
			$("#live-chat-box").css("display", "none");
			$("#chat-icon-box").css("display", "inline-block");
		}
	</script>

</body>
</html>