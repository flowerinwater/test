package com.test.service.account;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.DateProvider;
import org.springside.modules.utils.Encodes;

import com.test.entity.ApnUser;
import com.test.entity.Friend;
import com.test.entity.GroupInfo;
import com.test.entity.User;
import com.test.repository.ApnUserDao;
import com.test.repository.FriendDao;
import com.test.repository.GroupInfoDao;
import com.test.repository.TaskDao;
import com.test.repository.UserDao;
import com.test.service.ServiceException;
import com.test.service.account.ShiroDbRealm.ShiroUser;
import com.test.web.account.UserInfo;

/**
 * 用户管理类.
 * 
 */
// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class AccountService {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	private static final int SALT_SIZE = 8;

	private static Logger logger = LoggerFactory.getLogger(AccountService.class);

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private FriendDao friendDao;
	
	@Autowired
	private GroupInfoDao groupInfoDao;
	
	@Autowired
	private TaskDao taskDao;
	
	@Autowired
	private ApnUserDao apnUserDao;
	
	private DateProvider dateProvider = DateProvider.DEFAULT;

	public List<User> getAllUser() {
		return (List<User>) userDao.findAll();
	}

	public User getUser(Long id) {
		return userDao.findOne(id);
	}
	
	public List<Friend> getMyFriends(Long id) {
		return friendDao.findByUserId(id);
	}
	
	public List<GroupInfo> getMyGroups(Long id) {
		return groupInfoDao.findById(id);
	}

	public User findUserByLoginName(String loginName) {
		System.out.println(111);
		System.out.println(userDao.findByLoginName(loginName));
		return userDao.findByLoginName(loginName);
	}
	
	public Page<User> findAllUser(Pageable p) {
		return userDao.findAll(p);
	}
	
	@Transactional(readOnly = false)
	public User saveUser(UserInfo ui) {
		User u = new User();
		u.setFullName(ui.getFullName());
		u.setLoginName(ui.getLoginName());
		return userDao.save(u);
	}
	
	public UserInfo findUser(long id) {
		User u = userDao.findOne(id);
		
		UserInfo ui = new UserInfo();
		ui.setId(id);
		ui.setFullName(u.getFullName());
		ui.setLoginName(u.getLoginName());
		
		return ui;
	}
	
	@Transactional(readOnly = false)
	public void removeUser(long id) {
		userDao.delete(id);
	}
	
	public List<User> findUserByLoginNameLike(String loginName) {
		return userDao.findByLoginNameLike(loginName);
	}
	
	public List<GroupInfo> findGroupInfoByNameLike(String name) {
		return groupInfoDao.findByGroupNameLike(name);
	}

	@Transactional(readOnly = false)
	public void registerUser(User user) {
		entryptPassword(user);
		user.setRoles("user");
		user.setRegisterDate(dateProvider.getDate());
		
		ApnUser au = new ApnUser();
		au.setCreatedDate(user.getRegisterDate());
		au.setUpdatedDate(user.getRegisterDate());
		au.setPassword(user.getPlainPassword());
		au.setName(user.getFullName());
		au.setUsername(user.getLoginName());
		apnUserDao.save(au);
		
		userDao.save(user);
	}

	@Transactional(readOnly = false)
	public void updateUser(User user) {
		if (StringUtils.isNotBlank(user.getPlainPassword())) {
			entryptPassword(user);
		}
		userDao.save(user);
	}

	@Transactional(readOnly = false)
	public void deleteUser(Long id) {
		if (isSupervisor(id)) {
			logger.warn("操作员{}尝试删除超级管理员用户", getCurrentUserName());
			throw new ServiceException("不能删除超级管理员用户");
		}
		userDao.delete(id);
		taskDao.deleteByUserId(id);

	}

	/**
	 * 判断是否超级管理员.
	 */
	private boolean isSupervisor(Long id) {
		return id == 1;
	}

	/**
	 * 取出Shiro中的当前用户LoginName.
	 */
	private String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}

	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	private void entryptPassword(User user) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		user.setSalt(Encodes.encodeHex(salt));

		byte[] hashPassword = Digests.sha1(user.getPlainPassword().getBytes(), salt, HASH_INTERATIONS);
		user.setPassword(Encodes.encodeHex(hashPassword));
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setTaskDao(TaskDao taskDao) {
		this.taskDao = taskDao;
	}

	public void setDateProvider(DateProvider dateProvider) {
		this.dateProvider = dateProvider;
	}

	public ApnUserDao getApnUserDao() {
		return apnUserDao;
	}

	public void setApnUserDao(ApnUserDao apnUserDao) {
		this.apnUserDao = apnUserDao;
	}
	
	
}
