package com.bnu.card.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.SysUser;

public interface SysUserDao extends PagingAndSortingRepository<SysUser, Long>,JpaSpecificationExecutor<SysUser>{
	@Override
	public Iterable<SysUser> findAll();
	
	@Override
	public Page<SysUser> findAll(Specification<SysUser> arg0, Pageable arg1);
	
	@Override
	public Page<SysUser> findAll(Pageable arg0);	
	
	@Override
	public long count(Specification<SysUser> arg0);
	
	@Override
	public SysUser findOne(Long arg0);
	
	public SysUser findOneByLoginName(String loginName);
	
}
