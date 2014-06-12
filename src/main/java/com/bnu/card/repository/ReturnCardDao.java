package com.bnu.card.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.ReturnCard;

public interface ReturnCardDao extends PagingAndSortingRepository<ReturnCard, Long>,JpaSpecificationExecutor<ReturnCard>{
	@Override
	public Iterable<ReturnCard> findAll();
	
	@Override
	public Page<ReturnCard> findAll(Specification<ReturnCard> arg0, Pageable arg1);
	
	@Override
	public Page<ReturnCard> findAll(Pageable arg0);	
	
	@Override
	public long count(Specification<ReturnCard> arg0);
	
	@Override
	public ReturnCard findOne(Long arg0);
	
	public Iterable<ReturnCard> findAllByCardId(long cardId);
	
}
