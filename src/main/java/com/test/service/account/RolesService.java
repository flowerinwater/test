package com.test.service.account;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.test.entity.Roles;
import com.test.entity.User;
import com.test.repository.RolesDao;
import com.test.repository.UserDao;
import com.test.web.account.UserRoleInfo;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class RolesService {

	private static Logger log = LoggerFactory.getLogger(RolesService.class);

	@Autowired
	private RolesDao rolesDao;
	
	@Autowired
	private UserDao userDao;

	//////////////////////////
	public List<Roles> getAllRoles() {
		List<Roles> cts = new ArrayList<Roles>();
		
		Iterator<Roles> it = rolesDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}

	public Roles getRole(Long id) {
		return rolesDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveRole(Roles code) {
		rolesDao.save(code);
	}

	@Transactional(readOnly = false)
	public void updateRole(Roles code) {
		rolesDao.save(code);
	}

	@Transactional(readOnly = false)
	public void deleteRoles(Long id) {
		rolesDao.delete(id);
	}
	
	//////////////////////////
	@Transactional(readOnly = false)
	public void addUserRoles(String loginName,String roleCodes) {
		User u = userDao.findByLoginName(loginName);
		
		String[] cs = roleCodes.split(",");
		
		Set<Roles> roles = new HashSet<Roles>();
		for (String c : cs) {
			roles.add(rolesDao.findByCode(c));
		}
		
		u.setUserRoles(roles);
		
		userDao.save(u);
	}
	
	public List<Roles> getUserRoles(String loginName) {
		
		List<Roles> rs = new ArrayList<Roles>();
		User u = userDao.findByLoginName(loginName);
		if(u!=null)
			rs.addAll(u.getUserRoles());
		return rs;
	}
	
	public List<UserRoleInfo> getUserRoleInfos(String loginName) {
		List<UserRoleInfo> rt = new ArrayList<UserRoleInfo>();
		
		User u = userDao.findByLoginName(loginName);
		Set<Roles> userRoles = u.getUserRoles();
		
		Iterator<Roles> it = rolesDao.findAll().iterator();
		while(it.hasNext()){
			UserRoleInfo uri = new UserRoleInfo();
			
			Roles r = it.next();
			uri.setCode(r.getCode());
			uri.setMemo(r.getMemo());
			uri.setName(r.getName());
			
			if(userRoles.contains(r))
				uri.setChecked(true);
				
			rt.add(uri);
		}
		
		return rt;
	}
}
