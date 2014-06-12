package com.bnu.card.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnu.card.entity.SysUser;
import com.bnu.card.service.SysUserService;
import com.bnu.card.util.DefaultValue;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，

 * 真正登录的POST请求由Filter完成,
 * 
 * @author calvin
 */
@Controller
@RequestMapping(value = "/bnulogin")
public class BnuLoginController {

	private static Logger logger = LoggerFactory.getLogger(BnuLoginController.class);
	

	@Autowired
	private SysUserService sysUserService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String login() {
		logger.info("1112123");
		return "bnulogin/login";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String fail(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName, Model model) {
		model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, userName);
		return "bnulogin/login";
	}

	/////////////////
//	注册和获取当前登录用户：
    public static final void setCurrentUser(SysUser user) {
        Subject currentUser = SecurityUtils.getSubject();
        
        if (null != currentUser) {
            Session session = currentUser.getSession();
            if (null != session) {
                session.setAttribute(DefaultValue.CURRENT_USER, user);
            }
        }
    }
    
    public static final SysUser getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        if (null != currentUser) {
            Session session = currentUser.getSession();
            if (null != session) {
            	SysUser user = (SysUser) session.getAttribute(DefaultValue.CURRENT_USER);
                if(null != user){
                    return user;
                }
            }
        }
        return null;
    }
    
    @RequestMapping(value="/logout")
    @ResponseBody
    public void logout(HttpServletRequest request){
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {           
            subject.logout();
        }
        request.getSession().invalidate();
    }
    
    public static final void setLogin(String userId, String password) {
        Subject currentUser = SecurityUtils.getSubject();
        if (!currentUser.isAuthenticated()) {
            //collect user principals and credentials in a gui specific manner 
            //such as username/password html form, X509 certificate, OpenID, etc.
            //We'll use the username/password example here since it is the most common.
            //(do you know what movie this is from? ;)
            UsernamePasswordToken token = new UsernamePasswordToken(userId, password);
            //this is all you have to do to support 'remember me' (no config - built in!):
            token.setRememberMe(true);
            currentUser.login(token);
        }
    }
    
//    @RequestMapping(value = "/login")
//    public String login(String loginName, String password,
//    		HttpServletResponse response, HttpServletRequest request) throws Exception {
//        SysUser user = sysUserService.findOneSysUserByLoginName(loginName);
//        if (null != user) {
//            setLogin(user.getLoginName(), password);
//            return "redirect:/common/security/welcome";
//        } else {
//            return "redirect:/common/path?path=showLogin";
//        }
//    }
}
