package common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;

import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;

public class ChatServer extends WebSocketServer {
	
	public ChatServer( int port ) throws UnknownHostException {
		super( new InetSocketAddress( port ) );
	}
	
	public ChatServer(InetSocketAddress address) {
		// WebSocketServer 클래스의 생성자 호출
		super(address);
	}

	@Override
	public void onOpen(WebSocket conn, ClientHandshake handshake) {
		conn.send("Welcome to the server!"); //This method sends a message to the new client
		broadcast( "new connection: " + handshake.getResourceDescriptor() ); //This method sends a message to all clients connected
		System.out.println("new connection to " + conn.getRemoteSocketAddress());

	}

	@Override
	public void onClose(WebSocket conn, int code, String reason, boolean remote) {
		broadcast( conn + " has left the room!" );
		System.out.println( conn + " has left the room!" );
		System.out.println("closed " + conn.getRemoteSocketAddress() + " with exit code " + code + " additional info: " + reason);

	}

	@Override
	public void onMessage(WebSocket conn, String message) {
		broadcast( message );
		System.out.println("received message from "	+ conn.getRemoteSocketAddress());

	}
	
	@Override
	public void onMessage(WebSocket conn, ByteBuffer message) {
		broadcast( message.array() );
		System.out.println("received ByteBuffer from "	+ conn.getRemoteSocketAddress());

	}

	@Override
	public void onError(WebSocket conn, Exception ex) {
		ex.printStackTrace();
		if( conn != null ) {
			// some errors like port binding failed may not be assignable to a specific websocket
		}
		System.err.println("an error occurred on connection " + conn.getRemoteSocketAddress()  + ":" + ex);

	}

	@Override
	public void onStart() {
		setConnectionLostTimeout(0);
		setConnectionLostTimeout(100);
		System.out.println("server started successfully");

	}
	
	public static void main(String[] args) throws InterruptedException , IOException {
		int port = 8887; // 843 flash policy port
		try {
			port = Integer.parseInt( args[ 0 ] );
		} catch ( Exception ex ) {
		}
		ChatServer s = new ChatServer( port );
		s.start();
		System.out.println( "ChatServer started on port: " + s.getPort() );

		BufferedReader sysin = new BufferedReader( new InputStreamReader( System.in ) );
		while ( true ) {
			String in = sysin.readLine();
			s.broadcast( in );
			if( in.equals( "exit" ) ) {
				s.stop(1000);
				break;
			}
		}
	}

}
