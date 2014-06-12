package com.bnu.card.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.SysMenu;

public interface SysMenuDao extends PagingAndSortingRepository<SysMenu, Long>,JpaSpecificationExecutor<SysMenu>{
	@Override
	public Iterable<SysMenu> findAll();
}
