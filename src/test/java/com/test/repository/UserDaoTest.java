package com.test.repository;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.ContextConfiguration;

import com.test.data.FriendData;
import com.test.entity.User;

import org.springside.modules.test.spring.SpringTransactionalTestCase;

@ContextConfiguration(locations = { "/applicationContext.xml" })
public class UserDaoTest extends SpringTransactionalTestCase {

	@Autowired
	private UserDao userDao;

	@Test
	public void findTasksByUserId() throws Exception {
		PageRequest pagerequset = new PageRequest(0, 10,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
		Page<User> as = userDao.findAll(pagerequset);
		
//		assertEquals(2, as.getContent().size());
	}
	
	@Test
	public void findUserRoles() throws Exception {
		
		User u = userDao.findByLoginName("1");
//		assertEquals(2, u.getUserRoles().size());
	}
}
