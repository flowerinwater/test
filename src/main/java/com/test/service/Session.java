package com.test.service;

import java.util.Date;

public class Session {
	private String uid;
	
	private String termType;
	
	private Date loginTime;
	private Date logoutTime;
	
	private boolean isClose;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getTermType() {
		return termType;
	}
	public void setTermType(String termType) {
		this.termType = termType;
	}
	public Date getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	public Date getLogoutTime() {
		return logoutTime;
	}
	public void setLogoutTime(Date logoutTime) {
		this.logoutTime = logoutTime;
	}
	public boolean isClose() {
		return isClose;
	}
	public void setIsClose(boolean isClose) {
		this.isClose = isClose;
	}
	
}
