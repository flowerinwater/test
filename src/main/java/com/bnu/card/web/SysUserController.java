package com.bnu.card.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.Encodes;

import com.bnu.card.entity.SysUser;
import com.bnu.card.service.BnuCodeService;
import com.bnu.card.service.SysUserService;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.util.JsonArrayResult;
import com.bnu.card.util.JsonPageResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.ChangePassForm;
import com.bnu.card.web.form.HistorySearchForm;
import com.bnu.card.web.form.LoginForm;
import com.bnu.card.web.form.SysUserForm;
import com.bnu.card.web.form.SysUserSearchForm;
import com.bnu.card.util.BeanUtilEx;


@Controller
public class SysUserController {
	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	private static final int SALT_SIZE = 8;
	
	Logger log = LoggerFactory.getLogger(SysUserController.class);
	
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private BnuCodeService bnuCodeService;
    
    @RequestMapping("/jsonsavesysuser")
    @ResponseBody
	public JsonSimpleResult jsonSaveSysUser(@RequestBody SysUserForm ci){
    	log.info("jsonsavesysUser");
    	JsonSingleOjbectResult<SysUserForm> lr = new JsonSingleOjbectResult<SysUserForm>();
    	
    	try{
    		SysUser bi = new SysUser();
//			BeanUtils.copyProperties(bi, ci);
    		BeanUtilEx.copyProperties(bi, ci);
	    	ci.setId(sysUserService.saveSysUser(bi).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonchangepass")
    @ResponseBody
	public JsonSimpleResult jsonChangePass(@RequestBody ChangePassForm ci){
    	log.info("jsonchangepass");
    	JsonSingleOjbectResult<ChangePassForm> lr = new JsonSingleOjbectResult<ChangePassForm>();
    	
    	try{
    		if(!ci.getNewpassword().equalsIgnoreCase(ci.getRepassword())){
    			lr.setObj(ci);
    	    	lr.setSuccess(false);
    	    	lr.setMsg("密码不一致！");
    		}else{
    			lr.setObj(ci);
    	    	lr.setSuccess(true);
    	    	sysUserService.changePass(ci.getId(),ci.getPassword(),ci.getNewpassword());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsongetcurrloginname")
    @ResponseBody
	public JsonSimpleResult jsonGetCurrLogiName(){
    	log.info("jsongetcurrloginname");
    	
    	JsonSingleOjbectResult<SysUserForm> lr = new JsonSingleOjbectResult<SysUserForm>();
    	
    	try{
    		SysUser c = sysUserService.findOneSysUserByLoginName(DefaultValue.getCurrentUserName());
    		SysUserForm ci = new SysUserForm();
    		BeanUtilEx.copyProperties(ci, c);
    		
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    
    @RequestMapping("/jsonfindsysuserbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindSysUserById(@RequestParam(value="id") long id){
    	log.info("jsonfindsysUserbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<SysUserForm> lr = new JsonSingleOjbectResult<SysUserForm>();
    	
    	try{
    		SysUser c = sysUserService.getSysUser(id);
    		SysUserForm ci = new SysUserForm();
    		BeanUtilEx.copyProperties(ci, c);
    		
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonremovesysuserbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveSysUserById(@RequestParam(value="id") long uid){
    	log.info("jsonremovesysUserbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<SysUserForm> lr = new JsonSingleOjbectResult<SysUserForm>();
    	
    	try{
    		sysUserService.deleteSysUser(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindsysuser")
    @ResponseBody
	public JsonArrayResult<SysUser> jsonFindSysUser(){
    	log.info("jsonfindsysUser");
    	
    	JsonArrayResult<SysUser> lr = new JsonArrayResult<SysUser>();
    	
    	try{
    		List<SysUser> as = sysUserService.getAllSysUser();
	    	
    		if(as!=null){
    			lr.setResults(new SysUser[as.size()]);
    			
    			for (int i = 0; i < as.size(); i++) {
					lr.getResults()[i] = as.get(i);
				}
    		}
    		
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonfindallsysuserpage")
    @ResponseBody
	public JsonPageResult<SysUserForm> jsonFindAllSysUserPage(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page,HttpServletRequest r){
    	log.info("jsonfindallsysUserpage");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<SysUserForm> lr = new JsonPageResult<SysUserForm>();
    	
    	try{
    		
    		SysUserSearchForm cisf = new SysUserSearchForm();
    		cisf.setS_createDate_low(r.getParameter("s_createDate_low"));
    		cisf.setS_createDate_top(r.getParameter("s_createDate_top"));
    		cisf.setS_name(r.getParameter("s_name"));
    		cisf.setS_loginName(r.getParameter("s_loginName"));
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<SysUser> as = sysUserService.findAllSysUser(cisf,pagerequset);
    		List<SysUserForm> bis = new ArrayList<SysUserForm>();
    		for (Iterator<SysUser> iterator = as.getContent().iterator(); iterator.hasNext();) {
				SysUser sysUser = (SysUser) iterator.next();
				SysUserForm bi = new SysUserForm();
				BeanUtilEx.copyProperties(bi, sysUser);
				bi.setStatus(bnuCodeService.getCodeName(DefaultValue.USER_STATUS,bi.getStatus()));
				bis.add(bi);
			}
//    		Page<SysUserForm> p = new PageImpl<SysUserForm>(bis,pagerequset,as.getTotalElements());
    		
    		if(as!=null){
    			lr.setRows(bis);
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
//    @RequestMapping("/jsonlogin")
//    @ResponseBody
//	public JsonSimpleResult jsonLogin(@RequestBody LoginForm ui){
//    	log.info("jsonlogin");
//    	log.info(ui.getUserName());
//    	
//    	log.info("-----------2332121112");
//    	
//    	JsonSimpleResult lr = new JsonSimpleResult();
//    	
//    	SysUser u = sysUserService.findUserByLoginName(ui.getUserName());    	
//    	if(u != null){
//    		//密码暂不验证
//    		lr.setSuccess(true);
//    	}else{
//    		lr.setSuccess(false);
//    		lr.setMsg("用户或密码错误！");
//    	}
//    	return lr;
//    }

//    /**
//	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
//	 */
//	private void entryptPassword(SysUser user) {
//		byte[] salt = Digests.generateSalt(SALT_SIZE);
//		user.setSalt(Encodes.encodeHex(salt));
//
//		byte[] hashPassword = Digests.sha1(user.getPlainPassword().getBytes(), salt, HASH_INTERATIONS);
//		user.setPassword(Encodes.encodeHex(hashPassword));
//	}
    
//    @RequestMapping("/jsonregister")
//    @ResponseBody
//	public JsonSimpleResult jsonRegisterUser(@RequestBody SysUserForm ui){
//    	log.info("jsonlogin");
//    	log.info(ui.getLoginName());
//    	log.info("register:" + ui.getName());
//    	
//    	JsonSimpleResult lr = new JsonSimpleResult();
//    	
//    	try{
//	    	SysUser u = new SysUser();
////	    	u.setName(ui.getName());
////	    	u.setLoginName(ui.getLoginName());
////	    	u.setPassword(ui.getPassword());
//	    	BeanUtils.copyProperties(u, ui);
//	    	sysUserService.saveSysUser(u);
//	    	
//	    	lr.setSuccess(true);
//    	}catch(Exception e){
//    		e.printStackTrace();
//    		lr.setSuccess(false);
//    		lr.setMsg(e.getMessage());
//    	}
//
//    	return lr;
//    }
}