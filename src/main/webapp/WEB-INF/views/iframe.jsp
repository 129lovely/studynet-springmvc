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

#chat-icon-box {
	position: fixed;
    bottom: 5%;
	right: 5%;
	
	z-index: 50;
}

#live-chat-box {
	display: none;
	
	border-radius: 10px;
 	border: 3px solid #DFE1E4;
	background-color: #eef3fa;
	
	width: 400px;
	height: 350px;
	padding: 20px 15px;
	
	/* position: relative;
	left: 100%;
	transform: translate(-110%, -10%); */
	
	position: fixed;
	bottom: 5%;
	right: 5%;
	
	
	z-index: 100;
	
}

#live-chat-box a {
	display: inline-block;
	font-family: 'Black Han Sans', sans-serif;
	font-size: 1rem;
	margin: 0;
	padding: 5px;
	text-align: center;
	vertical-align: middle;

	position: absolute;
	right: 15px;
	top: 18px;
    
    border: none;
   	border-radius: 5px;
	
	background-color: #FEC46E;
	color: #383B46;
	transition: all 0.25s;
}

#live-chat-box a:hover {
	background-color: #3B5BA2;
	color: #EFF4FA;
}

#live-chat-box h2 {
	font-family: 'Black Han Sans', sans-serif;
	font-size: 1.5rem;
	margin-bottom: 10px;
	text-align: center;
}

#live-chat-box #messages {
	white-space: normal;
	word-break: break-all;
	line-height: 1.5rem;
	
	width: 100%;
	height: 200px;
	overflow-x: hidden;
	overflow-y: auto;
	margin-bottom: 10px;
	padding: 5px;
	
	background-color: #DFE1E4;
}

#live-chat-box .input-box {
	font-size: 1rem;
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	height: 50px;
}

#live-chat-box #messageinput {
	height: 65px;
	margin-right: 5px;
	padding: 5px;
	background-color: #FFF;
}

#live-chat-box .input-box button {
	padding: 5px 5px;
}
</style>


</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
	<!-- 본페이지 아이프레임 -->
	<iframe name="NeBoard" src="index.do"
		style="display: block; width: 100vw; height: 100vh; border: none; margin: 0;"
		frameborder="0" marginwidth="0" marginheight="0"></iframe>

	<!-- 실시간 채팅 -->
	<!-- <div class="chat-box"> -->
		<!-- 채팅아이콘 -->
		<div id="chat-icon-box" class="">
			<a href="javascript:open_liveChat();"><span
				class="icon icon-chat"></span></a>
		</div>

	<!-- </div> -->

		<!-- 실제 채팅박스 -->
		<div id="live-chat-box" class="">
			<a href="javascript:close_liveChat();">X</a>
			<h2>스터디넷 실시간 채팅</h2>
			<div id="messages"></div>
			<div class="input-box">
				<input type="hidden" id="sender" value="비회원">
				<textarea id="messageinput"></textarea>
				<button type="button" class="my-btn black-white" onclick="send();">전<br/>송</button>
				<!-- <button type="button" onclick="closeSocket();">Close</button> -->
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
			/* alert("소켓 접속"); */
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
			messages.innerHTML += text + "<br/>"; // 클라이언트에게 메시지 보여주기
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