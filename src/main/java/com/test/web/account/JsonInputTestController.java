package com.test.web.account;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.entity.User;


@Controller
public class JsonInputTestController {
	Logger log = LoggerFactory.getLogger(JsonInputTestController.class);
	
    @RequestMapping("/json1")
    @ResponseBody
	public JsonResult testJson1(@RequestBody User u){
    	log.info("get json input from request body annotation");
    	log.info(u.getLoginName());
    	
    	log.info("-----------2332121112");
    	
    	T[] alts = new T[2];
    	JsonResult r = new JsonResult(true,"return ok");
    	T t = new T();
    	t.s = "1";
    	t.t = "2";
    	T t1 = new T();
    	t1.s = "1";
    	t1.t = "2";
    	alts[0] = t;
    	alts[1] = t1;
    	r.setAlts(alts);
    	
    	return r;
    }
    
    @RequestMapping("/json2")
    public ResponseEntity<JsonResult> testJson2(HttpEntity<User> u){
    	log.info("get json input from HttpEntity annotation");
    	log.info(u.getBody().getLoginName());
    	
    	T[] alts = new T[2];
    	JsonResult r = new JsonResult(true,"return ok");
    	T t = new T();
    	t.s = "1";
    	t.t = "2";
    	T t1 = new T();
    	t1.s = "1";
    	t1.t = "2";
    	alts[0] = t;
    	alts[1] = t1;
    	r.setAlts(alts);
    	
    	ResponseEntity<JsonResult> responseResult = new ResponseEntity<JsonResult>( r,HttpStatus.OK);
    	return responseResult;
    }
}
