package common;
 
import java.util.ArrayList;
import java.util.List;
 
import javax.websocket.server.ServerEndpoint;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
 
import javax.websocket.RemoteEndpoint.Basic;

@Controller
@ServerEndpoint(value="/echo2.do") // /echo.do라는 url요청을 통해 웹소켓에 접속하겠다는 어노테이션
public class WebSocketChat_my {
    
	// 연결중인 모든 세션(클라이언트)리스트
    private static final List<Session> sessionList=new ArrayList<Session>();
    
//    private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class);
    
    // 웹소켓 생성자
    public WebSocketChat_my() {
        // TODO Auto-generated constructor stub
        System.out.println("웹소켓(서버) 객체생성");
    }
    
    @RequestMapping(value="/chat2.do")
    public ModelAndView getChatViewPage(ModelAndView mav) {
        mav.setViewName("chat");
        return mav;
    }
    
    /**
     * 클라이언트가 웹소켓에 접속하고, 서버에 아무런 문제없이 접속했을 때 실행하는 메소드
     * @param session
     */
    @OnOpen
    public void onOpen(Session session) {
//        logger.info("Open session id:"+session.getId());      
        try {
            final Basic basic=session.getBasicRemote();
            basic.sendText( "studynet2019!@#$%" + session.getId() ); // 접속한 세션(1개)에게만 메시지 전송
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
        sessionList.add(session); // 세션 리스트에 추가
    }
    /*
     * 모든 사용자에게 메시지를 전달하는 메소드
     * 즉, 어떤 누군가에게 메시지가 왔다면 그 메시지를 보낸 자신을 제외한
     * 모든 연결된 세션(클라이언트)에게 메시지를 전달
     * @param self
     * @param message
     */
    private void sendAllSessionToMessage(Session self,String message) {
        try {
            for(Session session : WebSocketChat_my.sessionList) { // 모든 세션에게 메시지 전송
                if(!self.getId().equals(session.getId())) { // 딘, 자기 자신 제외
                	// 보낸사람 : 메시지
                    session.getBasicRemote().sendText(message);
                }
            }
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
    }
    /**
     * 클라이언트에게 메시지가 들어왔을 때 실행되는 메소드
     * @param message
     * @param session
     */
    @OnMessage
    public void onMessage(String message,Session session) {
//        logger.info("Message From "+message.split(",")[1] + ": "+message.split(",")[0]);
        System.out.println( "Message From "+message.split(":")[0] + ": "+message.split(":")[1] );
        try {
        	// 클라이언트에 메시지 표시
            final Basic basic=session.getBasicRemote();
            basic.sendText(message);
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
        sendAllSessionToMessage(session, message);
    }
    @OnError
    public void onError(Throwable e,Session session) {
        
    }
    /**
     * 클라이언트와 웹소켓과의 연결이 끊기면 실행되는 메소드
     * @param session
     */
    @OnClose
    public void onClose(Session session) {
//        logger.info("Session "+session.getId()+" has ended");
        System.out.println( "Session "+session.getId()+" has ended" );
        sessionList.remove(session);
    }
}