package com.test.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.ApnUser;

public interface ApnUserDao extends PagingAndSortingRepository<ApnUser, Long> {
	ApnUser findByName(String name);
	ApnUser findByUsername(String username);
}
