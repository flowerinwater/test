package com.test.web.account;

public class JsonSingleOjbectResult<T> extends JsonSimpleResult{
	T obj;

	public T getObj() {
		return obj;
	}

	public void setObj(T obj) {
		this.obj = obj;
	}

	
	
}
