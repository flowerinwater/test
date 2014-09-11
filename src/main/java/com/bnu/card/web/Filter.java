package com.bnu.card.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//import net.sf.json.JSONObject;
import org.codehaus.jackson.map.ObjectMapper;  


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
		System.out.println(111 + ":" + s);
		Map map = new HashMap();
		map.put("rules", Rule.class);
		
		try{
//			JSONObject jsonObj = JSONObject.fromObject(s);
//			Filter f = (Filter) JSONObject.toBean(jsonObj, Filter.class, map); //
			
			ObjectMapper om = new ObjectMapper();  
			Filter f = om.readValue(s, Filter.class);
			
			this.groupOp = f.groupOp;
			this.rules = f.rules;
			System.out.println(122);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public Filter(){
		
	}
	
}
