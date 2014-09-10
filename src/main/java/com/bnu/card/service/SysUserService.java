package com.bnu.card.service;

import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.Encodes;

import com.bnu.card.entity.SysUser;
import com.bnu.card.repository.SysUserDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.web.Filter;
import com.bnu.card.web.JQGridQueryForm;
import com.bnu.card.web.Rule;
import com.bnu.card.web.form.SysUserSearchForm;
//import com.bnu.card.web.account.SysUserInfo;
import com.test.entity.User;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class SysUserService {

	private static Logger log = LoggerFactory.getLogger(SysUserService.class);

	@Autowired
	private SysUserDao sysUserDao;

	public List<SysUser> getAllSysUser() {
		List<SysUser> cts = new ArrayList<SysUser>();
		
		Iterator<SysUser> it = sysUserDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	public Page<SysUser> findAllSysUser(Pageable p) {
		return sysUserDao.findAll(p);
	}
	
	
//	public Page<SysUser> findAllSysUser2(final String query,Pageable pb) {
//		Specification<SysUser> ps = new Specification<SysUser>(){
//
//			@Override
//			public Predicate toPredicate(Root<SysUser> root,
//					CriteriaQuery<?> query, CriteriaBuilder cb) {
//				query.
//				Predicate p = null;
//				
//				Path<String> nameExp = root.get("name"); 
//                if(cisf.getS_name() != null){
//                	if(p!=null)
//                		p = cb.and(cb.like(nameExp, "%" + cisf.getS_name() + "%"),p);
//                	else
//                		p = cb.like(nameExp, "%" + cisf.getS_name() + "%");
//                }
//                
//                Path<String> loginNameExp = root.get("loginName"); 
//                if(cisf.getS_loginName() != null){
//                	if(p!=null)
//                		p = cb.and(cb.like(loginNameExp, "%" + cisf.getS_loginName() + "%"),p);
//                	else
//                		p = cb.like(loginNameExp, "%" + cisf.getS_loginName() + "%");
//                }
//                
//                Path<Date> createDateExp = root.<Date>get("createDate"); 
//                if(cisf.getS_createDate_low()!=null){
//					try {
//						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//						Date cdl = sdf.parse(cisf.getS_createDate_low());
//						Expression<Date> createDateStart = cb.literal(cdl);
//	                	if(p!=null)
//	                		p = cb.and(cb.greaterThanOrEqualTo(createDateExp, createDateStart),p);
//	                	else
//	                		p = cb.greaterThanOrEqualTo(createDateExp, createDateStart);
//					} catch (ParseException e) {
//						e.printStackTrace();
//					}
//                }
//                
//                if(cisf.getS_createDate_top()!=null){
//                	try {
//						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//						Date cdt = sdf.parse(cisf.getS_createDate_top());
//						Expression<Date> createDateStart = cb.literal(cdt);
//	                	if(p!=null)
//	                		p = cb.and(cb.lessThan(createDateExp, createDateStart),p);
//	                	else
//	                		p = cb.lessThan(createDateExp, createDateStart);
//					} catch (ParseException e) {
//						e.printStackTrace();
//					}
//                }
//				
//				return p; 
//			}
//			
//		};
//
//		return sysUserDao.findAll(ps,pb);
//	}

	
	public Page<SysUser> findAllSysUser(final SysUserSearchForm cisf,Pageable pb) {
		Specification<SysUser> ps = new Specification<SysUser>(){

			@Override
			public Predicate toPredicate(Root<SysUser> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {

				Predicate p = null;
				
				Path<String> nameExp = root.get("name"); 
                if(cisf.getS_name() != null){
                	if(p!=null)
                		p = cb.and(cb.like(nameExp, "%" + cisf.getS_name() + "%"),p);
                	else
                		p = cb.like(nameExp, "%" + cisf.getS_name() + "%");
                }
                
                Path<String> loginNameExp = root.get("loginName"); 
                if(cisf.getS_loginName() != null){
                	if(p!=null)
                		p = cb.and(cb.like(loginNameExp, "%" + cisf.getS_loginName() + "%"),p);
                	else
                		p = cb.like(loginNameExp, "%" + cisf.getS_loginName() + "%");
                }
                
                Path<Date> createDateExp = root.<Date>get("createDate"); 
                if(cisf.getS_createDate_low()!=null){
					try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date cdl = sdf.parse(cisf.getS_createDate_low());
						Expression<Date> createDateStart = cb.literal(cdl);
	                	if(p!=null)
	                		p = cb.and(cb.greaterThanOrEqualTo(createDateExp, createDateStart),p);
	                	else
	                		p = cb.greaterThanOrEqualTo(createDateExp, createDateStart);
					} catch (ParseException e) {
						e.printStackTrace();
					}
                }
                
                if(cisf.getS_createDate_top()!=null){
                	try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date cdt = sdf.parse(cisf.getS_createDate_top());
						Expression<Date> createDateStart = cb.literal(cdt);
	                	if(p!=null)
	                		p = cb.and(cb.lessThan(createDateExp, createDateStart),p);
	                	else
	                		p = cb.lessThan(createDateExp, createDateStart);
					} catch (ParseException e) {
						e.printStackTrace();
					}
                }
				
				return p; 
			}
			
		};

		return sysUserDao.findAll(ps,pb);
	}
	
	
	public Page<SysUser> findAllSysUser(final JQGridQueryForm jqForm,Pageable pb) {
		Specification<SysUser> ps = new Specification<SysUser>(){

			@Override
			public Predicate toPredicate(Root<SysUser> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {

				Predicate p = null;
				
				
				Filter f = jqForm.getFilters();
				
				if(f!=null){
					List<Rule> rules = f.getRules();
					
					for (Iterator iterator = rules.iterator(); iterator.hasNext();) {
						Rule rule = (Rule) iterator.next();
						Path<String> exp = root.get(rule.getField());
						if(rule.getData() != null){
		                	if(p!=null)
		                		p = cb.and(cb.like(exp, "%" + rule.getData() + "%"),p);
		                	else
		                		p = cb.like(exp, "%" + rule.getData() + "%");
		                }
					}
				}
				
//				Path<String> nameExp = root.get("name"); 
//                if(cisf.getS_name() != null){
//                	if(p!=null)
//                		p = cb.and(cb.like(nameExp, "%" + cisf.getS_name() + "%"),p);
//                	else
//                		p = cb.like(nameExp, "%" + cisf.getS_name() + "%");
//                }
//                
//                Path<String> loginNameExp = root.get("loginName"); 
//                if(cisf.getS_loginName() != null){
//                	if(p!=null)
//                		p = cb.and(cb.like(loginNameExp, "%" + cisf.getS_loginName() + "%"),p);
//                	else
//                		p = cb.like(loginNameExp, "%" + cisf.getS_loginName() + "%");
//                }
//                
//                Path<Date> createDateExp = root.<Date>get("createDate"); 
//                if(cisf.getS_createDate_low()!=null){
//					try {
//						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//						Date cdl = sdf.parse(cisf.getS_createDate_low());
//						Expression<Date> createDateStart = cb.literal(cdl);
//	                	if(p!=null)
//	                		p = cb.and(cb.greaterThanOrEqualTo(createDateExp, createDateStart),p);
//	                	else
//	                		p = cb.greaterThanOrEqualTo(createDateExp, createDateStart);
//					} catch (ParseException e) {
//						e.printStackTrace();
//					}
//                }
//                
//                if(cisf.getS_createDate_top()!=null){
//                	try {
//						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//						Date cdt = sdf.parse(cisf.getS_createDate_top());
//						Expression<Date> createDateStart = cb.literal(cdt);
//	                	if(p!=null)
//	                		p = cb.and(cb.lessThan(createDateExp, createDateStart),p);
//	                	else
//	                		p = cb.lessThan(createDateExp, createDateStart);
//					} catch (ParseException e) {
//						e.printStackTrace();
//					}
//                }
				
				return p; 
			}
			
		};

		return sysUserDao.findAll(ps,pb);
	}


	public SysUser getSysUser(Long id) {
		return sysUserDao.findOne(id);
	}
	
	
	@Transactional(readOnly = false)
	public void changePass(Long id,String password,String newpassword) throws Exception {

		SysUser c = getSysUser(id);
		byte[] salt = Encodes.decodeHex(c.getSalt());
		byte[] hashPassword = Digests.sha1(password.getBytes(), salt, ShiroDbRealm.HASH_INTERATIONS);
		String pass = Encodes.encodeHex(hashPassword);
		
		if(!pass.equals(c.getPassword()))
			throw new Exception("Password is incorrect!");
		
		c.setPassword(newpassword);
		entryptPassword(c);
		sysUserDao.save(c);
	}

	@Transactional(readOnly = false)
	public SysUser saveSysUser(SysUser ci) {
		SysUser c = new SysUser();
		try {
			if(ci.getId()!=null && ci.getId().intValue()!=0){
				c = getSysUser(ci.getId());
				c.setName(ci.getName());
				c.setMemo(ci.getMemo());
				c.setStatus(ci.getStatus());
			}else{
				BeanUtilEx.copyProperties(c, ci);
				c.setCreateDate(new Date());
				c.setPassword(DefaultValue.DEFAULT_PASSWORD);
				entryptPassword(c);
			}
			
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return sysUserDao.save(c);
	}

	@Transactional(readOnly = false)
	public SysUser updateSysUser(SysUser c) {
		return sysUserDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteSysUser(Long id) {
		SysUser c = sysUserDao.findOne(id);
		c.setStatus(DefaultValue.DELETE);
		updateSysUser(c);
//		sysUserDao.delete(id);
	}
	
	public SysUser findOneSysUserByLoginName(String loginName) {
		return sysUserDao.findOneByLoginName(loginName);
	}
	
	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	private void entryptPassword(SysUser user) {
		byte[] salt = Digests.generateSalt(ShiroDbRealm.SALT_SIZE);
		user.setSalt(Encodes.encodeHex(salt));

		byte[] hashPassword = Digests.sha1(user.getPassword().getBytes(), salt, ShiroDbRealm.HASH_INTERATIONS);
		user.setPassword(Encodes.encodeHex(hashPassword));
	}
	
	public static void main(String[] args) {
		SysUser c = new SysUser();
		c.setPassword("1");
		new SysUserService().entryptPassword(c);
		System.out.println(c.getPassword());
		
		
	}
}