package com.test.web;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;
import org.apache.catalina.websocket.WsOutbound;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.test.service.SessionManager;

public class AWebSocketServlet extends WebSocketServlet{
	private SessionManager sessionManager = null ;
	
	private List<MsgInbound> msgIBs = new ArrayList<MsgInbound>();
	
	@Override
	public void init() throws ServletException {
		super.init();
		
		WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		sessionManager = (SessionManager)wac.getBean("SessionManager");
	}
	
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}
	
	@Override
	protected StreamInbound createWebSocketInbound(String subProtocol,
			HttpServletRequest request) {
		System.out.println(11);
		String loginName = request.getParameter("loginname");
		return new MsgInbound(loginName);
	}
	
	
	private final class MsgInbound extends MessageInbound {
		private String loginName;
		
		public MsgInbound(String loginName) {
			this.loginName = loginName;
		}
		
		@Override
		protected void onBinaryMessage(ByteBuffer arg0) throws IOException {
			// TODO Auto-generated method stub
			
		}

		@Override
		protected void onTextMessage(CharBuffer arg0) throws IOException {
			for (MsgInbound msgIb : msgIBs) {
				msgIb.getWsOutbound().writeTextMessage(arg0);
			}
		}
		
		@Override
		protected void onClose(int status) {
			super.onClose(status);
			
			sessionManager.removeSession(loginName);
			msgIBs.remove(this);
		}
		
		@Override
		protected void onOpen(WsOutbound outbound) {
			super.onOpen(outbound);
			
			sessionManager.addSession(loginName);
			msgIBs.add(this);
		}
		
		@Override
		protected void onPong(ByteBuffer payload) {
			// TODO Auto-generated method stub
			super.onPong(payload);
		}
		
	}
}
