package com.bnu.card.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.MigrateCard;

public interface MigrateCardDao extends PagingAndSortingRepository<MigrateCard, Long>,JpaSpecificationExecutor<MigrateCard>{
	@Override
	public Iterable<MigrateCard> findAll();
	
	@Override
	public Page<MigrateCard> findAll(Specification<MigrateCard> arg0, Pageable arg1);
	
	@Override
	public Page<MigrateCard> findAll(Pageable arg0);	
	
	@Override
	public long count(Specification<MigrateCard> arg0);
	
	@Override
	public MigrateCard findOne(Long arg0);
	
	public Iterable<MigrateCard> findAllByCardId(long cardId);
	
}
