package com.bnu.card.service;

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

import com.bnu.card.entity.SysRoles;
import com.bnu.card.entity.SysUser;
import com.bnu.card.repository.SysRolesDao;
import com.bnu.card.repository.SysUserDao;
import com.bnu.card.web.form.UserRoleForm;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class SysRolesService {

	private static Logger log = LoggerFactory.getLogger(SysRolesService.class);

	@Autowired
	private SysRolesDao rolesDao;
	
	@Autowired
	private SysUserDao sysUserDao;

	//////////////////////////
	public List<SysRoles> getAllRoles() {
		List<SysRoles> cts = new ArrayList<SysRoles>();
		
		Iterator<SysRoles> it = rolesDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}

	public SysRoles getRole(Long id) {
		return rolesDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveRole(SysRoles code) {
		rolesDao.save(code);
	}

	@Transactional(readOnly = false)
	public void updateRole(SysRoles code) {
		rolesDao.save(code);
	}

	@Transactional(readOnly = false)
	public void deleteRoles(Long id) {
		rolesDao.delete(id);
	}
	
	//////////////////////////
	@Transactional(readOnly = false)
	public void addUserRoles(String loginName,String roleCodes) {
		SysUser u = sysUserDao.findOneByLoginName(loginName);
		
		String[] cs = roleCodes.split(",");
		
		Set<SysRoles> roles = new HashSet<SysRoles>();
		for (String c : cs) {
			roles.add(rolesDao.findByCode(c));
		}
		
		u.setUserRoles(roles);
		
		sysUserDao.save(u);
	}
	
	public List<SysRoles> getUserRoles(String loginName) {
		
		List<SysRoles> rs = new ArrayList<SysRoles>();
		SysUser u = sysUserDao.findOneByLoginName(loginName);
		if(u!=null)
			rs.addAll(u.getUserRoles());
		return rs;
	}
	
	public List<UserRoleForm> getUserRoleInfos(String loginName) {
		List<UserRoleForm> rt = new ArrayList<UserRoleForm>();
		
		SysUser u = sysUserDao.findOneByLoginName(loginName);
		Set<SysRoles> userRoles = u.getUserRoles();
		
		Iterator<SysRoles> it = rolesDao.findAll().iterator();
		while(it.hasNext()){
			UserRoleForm uri = new UserRoleForm();
			
			SysRoles r = it.next();
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
