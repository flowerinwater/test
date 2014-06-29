package com.bnu.card.util;

import java.util.List;


public class JsonPageResult<T> {
	
	private List<T> rows;
	
	private long total;
	
	private int page;
	
	private int records;
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

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
