package com.test.repository;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.GroupInfo;

public interface GroupInfoDao extends PagingAndSortingRepository<GroupInfo, Long> {
	List<GroupInfo> findById(Long id);
	List<GroupInfo> findByGroupNameLike(String name);
}
