package com.test.repository;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Friend;

public interface FriendDao extends PagingAndSortingRepository<Friend, Long> {
	List<Friend> findByUserId(Long id);
}
