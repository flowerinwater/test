package com.bnu.card.web;

public class JQGridQueryForm {

	String page;  
    String rows;  
    String _sidx;  
    String _sord;  
    boolean _search;  
    String searchField;  
    String searchOper;  
    String searchString;  
    String filter;
    
    
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}
	public String get_sidx() {
		return _sidx;
	}
	public void set_sidx(String _sidx) {
		this._sidx = _sidx;
	}
	public String get_sord() {
		return _sord;
	}
	public void set_sord(String _sord) {
		this._sord = _sord;
	}
	public boolean is_search() {
		return _search;
	}
	public void set_search(boolean _search) {
		this._search = _search;
	}
	public String getSearchField() {
		return searchField;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public String getSearchOper() {
		return searchOper;
	}
	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public String getFilter() {
		return filter;
	}
	public void setFilter(String filter) {
		this.filter = filter;
	}  
}
