package com.bnu.card.util;


public class JsonSimpleResult {
	
	public JsonSimpleResult(boolean success,String msg){
		this.success = success;
		this.msg = msg;
	}
	public JsonSimpleResult(){
		
	}
	public boolean getSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	private boolean success;
	private String msg;
}
