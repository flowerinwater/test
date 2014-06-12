package com.test.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Roles;

public interface RolesDao extends PagingAndSortingRepository<Roles, Long> {
	Roles findByCode(String code);
}
