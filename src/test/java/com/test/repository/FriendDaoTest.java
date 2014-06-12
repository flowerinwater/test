package com.test.repository;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import com.test.data.FriendData;
import com.test.entity.Friend;
import org.springside.modules.test.spring.SpringTransactionalTestCase;

@ContextConfiguration(locations = { "/applicationContext.xml" })
public class FriendDaoTest extends SpringTransactionalTestCase {

	@Autowired
	private FriendDao friendDao;

	@Test
	public void findTasksByUserId() throws Exception {
		Friend f = FriendData.randomNewFriend();
		
		friendDao.save(f);
		
		List<Friend> fs = friendDao.findByUserId(2L);
		assertEquals(1, fs.size());
		assertEquals(new Long(2), fs.get(0).getUserId());
	}
}
