package com.test.web.account;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

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

import com.test.entity.Friend;
import com.test.entity.GroupInfo;
import com.test.entity.User;
import com.test.service.account.AccountService;


@Controller
public class UserController {
	Logger log = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private AccountService accountService;
	
    @RequestMapping("/jsonregister")
    @ResponseBody
	public JsonSimpleResult jsonRegisterUser(@RequestBody RegisterInfo ui){
    	log.info("jsonlogin");
    	log.info(ui.getUserName());
    	
    	log.info("register:" + ui.getUserName());
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	
    	try{
	    	User u = new User();
	    	u.setFullName(ui.getUserName());
	    	u.setLoginName(ui.getUserName());
	    	u.setPlainPassword(ui.getPassword());
	    	
	    	accountService.registerUser(u);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonsaveuser")
    @ResponseBody
	public JsonSimpleResult jsonSaveUser(@RequestBody UserInfo ui){
    	log.info("jsonsaveuser");
    	log.info(ui.getFullName());
    	log.info(ui.getLoginName());
    	log.info(ui.getPhone());
    	log.info(ui.getEmail());
    	
    	JsonSingleOjbectResult<UserInfo> lr = new JsonSingleOjbectResult<UserInfo>();
    	
    	try{
	    	ui.setId(accountService.saveUser(ui).getId());
	    	
	    	lr.setObj(ui);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfinduserbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindUserById(@RequestParam(value="id") long uid){
    	log.info("jsonfinduserbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<UserInfo> lr = new JsonSingleOjbectResult<UserInfo>();
    	
    	try{
    		UserInfo ui = accountService.findUser(uid);
	    	
	    	lr.setObj(ui);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonremoveuserbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveUserById(@RequestParam(value="id") long uid){
    	log.info("jsonremoveuserbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<UserInfo> lr = new JsonSingleOjbectResult<UserInfo>();
    	
    	try{
    		accountService.removeUser(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    @RequestMapping("/jsonlogin")
    @ResponseBody
	public JsonSimpleResult jsonLogin(@RequestBody LoginInfo ui){
    	log.info("jsonlogin");
    	log.info(ui.getUserName());
    	
    	log.info("-----------2332121112");
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	
    	User u = accountService.findUserByLoginName(ui.getUserName());    	
    	if(u != null){
    		//密码暂不验证
    		lr.setSuccess(true);
    	}else{
    		lr.setSuccess(false);
    		lr.setMsg("用户或密码错误！");
    	}
    	return lr;
    }
    
    @RequestMapping("/getusericon")
	public void getUserIcon(@RequestParam(value="uid") String uid,HttpServletResponse response){
    	log.info("jsonlogin");
    	log.info(uid);
    	
    	User u = accountService.findUserByLoginName(uid);    	

    	String iconPath = "c:\\headpic\\notfound.jpg";
    	if(u!=null && u.getIcon()!=null)
    		iconPath = u.getIcon();
    	
    	InputStream is;
		try {
			is = new FileInputStream(new File(iconPath));
			OutputStream out = response.getOutputStream(); 
	    	byte[] buffer = new byte[1024];
	    	int size = 0;
	    	while ((size = is.read(buffer)) != -1) {
	    	      out.write(buffer, 0, size);
	    	}
	    	out.flush(); 
	    	out.close();
	    	is.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    
    
    @RequestMapping("/jsongetmygroup")
    @ResponseBody
	public JsonArrayResult<GroupInfo> jsonGetMyGroup(@RequestParam(value="uid") String uid,HttpServletResponse response){
    	log.info("jsongetmygroup");
    	log.info("uid:" + uid);
    	
    	JsonArrayResult<GroupInfo> lr = new JsonArrayResult<GroupInfo>();
    	
    	try{
    		List<GroupInfo> as = accountService.getMyGroups(Long.parseLong(uid));
	    	
    		if(as!=null){
    			lr.setResults(new GroupInfo[as.size()]);
    			
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
    
    @RequestMapping("/jsongetmyfriend")
    @ResponseBody
	public JsonArrayResult<Friend> jsonGetMyFriend(@RequestParam(value="uid") String uid,HttpServletResponse response){
    	log.info("jsongetmyfriend");
    	log.info("uid:" + uid);
    	
    	JsonArrayResult<Friend> lr = new JsonArrayResult<Friend>();
    	
    	try{
    		List<Friend> as = accountService.getMyFriends(Long.parseLong(uid));
	    	
    		if(as!=null){
    			lr.setResults(new Friend[as.size()]);
    			
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
    
    @RequestMapping("/jsonfinduser")
    @ResponseBody
	public JsonArrayResult<User> jsonFindUser(@RequestParam(value="name",required=false) String name,@RequestParam(value="uid",required=false) String uid,HttpServletResponse response){
    	log.info("jsonFindUser");
    	log.info("name:" + name);
    	log.info("uid:" + uid);
    	
    	JsonArrayResult<User> lr = new JsonArrayResult<User>();
    	
    	try{
    		List<User> as = accountService.findUserByLoginNameLike(name);
	    	
    		if(as!=null){
    			lr.setResults(new User[as.size()]);
    			
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
    
    @RequestMapping("/jsonfindalluserpage")
    @ResponseBody
	public JsonPageResult<User> jsonFindAllUserPage(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page,HttpServletResponse response){
    	log.info("jsonFindAllUserPage");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<User> lr = new JsonPageResult<User>();
    	
    	try{
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<User> as = accountService.findAllUser(pagerequset);
    		
    		if(as!=null){
    			lr.setRows(as.getContent());
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonfindgroup")
    @ResponseBody
	public JsonArrayResult jsonFindGroup(@RequestParam(value="name") String name,@RequestParam(value="uid") String uid,HttpServletResponse response){
    	log.info("jsonfindgroup");
    	log.info("name:" + name);
    	log.info("uid:" + uid);
    	
    	
    	JsonArrayResult<GroupInfo> lr = new JsonArrayResult<GroupInfo>();
    	
    	try{
    		List<GroupInfo> as = accountService.findGroupInfoByNameLike(name);
	    	
    		if(as!=null){
    			lr.setResults(new GroupInfo[as.size()]);
    			
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
}
