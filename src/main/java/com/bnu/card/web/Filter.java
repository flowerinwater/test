package com.bnu.card.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;


public class Filter {

	String groupOp;
	
	List<Rule> rules = new ArrayList<Rule>();

	public String getGroupOp() {
		return groupOp;
	}

	public void setGroupOp(String groupOp) {
		this.groupOp = groupOp;
	}

	public List<Rule> getRules() {
		return rules;
	}

	public void setRules(List<Rule> rules) {
		this.rules = rules;
	}
	
	public Filter(String s){
		Map map = new HashMap();
		map.put("rules", Rule.class);
		JSONObject jsonObj = JSONObject.fromObject(s);
		Filter jxbm = (Filter) JSONObject.toBean(jsonObj, Filter.class, map); //
	}
	
}
