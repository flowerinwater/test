package com.bnu.card.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.History;

public interface HistoryDao extends PagingAndSortingRepository<History, Long>,JpaSpecificationExecutor<History>{
	@Override
	public Iterable<History> findAll();
	
	@Override
	public Page<History> findAll(Specification<History> arg0, Pageable arg1);
	
	@Override
	public Page<History> findAll(Pageable arg0);	
	
	@Override
	public long count(Specification<History> arg0);
	
	@Override
	public History findOne(Long arg0);
	
	public Iterable<History> findAllByCardId(long cardId);
}
