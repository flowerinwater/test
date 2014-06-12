package com.test.web.account;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.service.account.RolesService;


@Controller
public class RolesController {
	Logger log = LoggerFactory.getLogger(RolesController.class);
	
	@Autowired
	private RolesService rolesService;
	
    
    @RequestMapping("/jsonfinduserrole")
    @ResponseBody
	public JsonPageResult<UserRoleInfo> jsonFindUserRoles(@RequestParam(value="loginName",required=false) String loginName){
    	log.info("jsonfinduserrole");
    	
    	JsonPageResult<UserRoleInfo> lr = new JsonPageResult<UserRoleInfo>();
    	
    	try{
    		List<UserRoleInfo> rs = rolesService.getUserRoleInfos(loginName);
    		
			lr.setRows(rs);
			lr.setTotal(rs.size());
    			
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonadduserrole")
    @ResponseBody
	public JsonSimpleResult jsonAddUserRoles(@RequestParam(value="loginName",required=false) String loginName,@RequestParam(value="roleCodes",required=false) String roleCodes){
    	log.info("jsonadduserrole");
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	
    	try{

    		rolesService.addUserRoles(loginName,roleCodes);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
}
