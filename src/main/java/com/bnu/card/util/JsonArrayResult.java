package com.bnu.card.util;


public class JsonArrayResult<T> {
	
	private T[] results;
	
	private boolean success;
	private String msg;
	

	
	public T[] getResults() {
		return results;
	}
	public void setResults(T[] results) {
		this.results = results;
	}
	public JsonArrayResult(boolean success,String msg){
		this.success = success;
		this.msg = msg;
	}
	public JsonArrayResult(){
		
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
}
