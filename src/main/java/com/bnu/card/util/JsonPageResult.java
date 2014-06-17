package com.bnu.card.util;

import java.util.List;


public class JsonPageResult<T> {
	
	private List<T> rows;
	
	private long total;
	
	public JsonPageResult(){
		
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}
	
	
	
}