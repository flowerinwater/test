package com.bnu.card.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.SysRoles;

public interface SysRolesDao extends PagingAndSortingRepository<SysRoles, Long> {
	SysRoles findByCode(String code);
}
