package com.bnu.card.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnu.card.service.SysRolesService;
import com.bnu.card.util.JsonPageResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.web.form.UserRoleForm;


@Controller
public class SysRolesController {
	Logger log = LoggerFactory.getLogger(SysRolesController.class);
	
	@Autowired
	private SysRolesService rolesService;
	
    
    @RequestMapping("/jsonfindsysuserrole")
    @ResponseBody
	public JsonPageResult<UserRoleForm> jsonFindUserRoles(@RequestParam(value="loginName",required=false) String loginName){
    	log.info("jsonfinduserrole");
    	
    	JsonPageResult<UserRoleForm> lr = new JsonPageResult<UserRoleForm>();
    	
    	try{
    		List<UserRoleForm> rs = rolesService.getUserRoleInfos(loginName);
    		
			lr.setRows(rs);
			lr.setTotal(rs.size());
    			
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonaddsysuserrole")
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
