package com.test.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class SessionManager {
	private List<Session> sessions = new ArrayList<Session>();
	private Map<String,Session> sessionMap = new HashMap<String,Session>();
	
	
	public void addSession(String loginName){
		if(!sessionMap.containsKey(loginName)){
			Session s = new Session();
			s.setUid(loginName);
			s.setLoginTime(new Date());
			s.setIsClose(true);
			
			sessionMap.put(s.getUid(), s);
			sessions.add(s);
		}
	}
	
	public void removeSession(String loginName){
		if(sessionMap.containsKey(loginName)){
			Session s = sessionMap.get(loginName);
			sessionMap.remove(loginName);
			sessions.remove(s);
		}
	}
	
	public void closeAll(){
		for (Session s : sessions) {
			s.setIsClose(true);
			s.setLogoutTime(new Date());
		}
	}
}
