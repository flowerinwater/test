package com.bnu.card.util;


public class JsonResult<T> {
	
	private T[] alts;
	
	
	public T[] getAlts() {
		return alts;
	}
	public void setAlts(T[] alts) {
		this.alts = alts;
	}
	public JsonResult(boolean success,String msg){
		this.success = success;
		this.msg = msg;
	}
	public JsonResult(){
		
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
