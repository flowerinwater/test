package com.bnu.card.repository;



import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.bnu.card.entity.LendCard;
import com.bnu.card.web.form.StudentReportForm;

public interface LendCardDao extends PagingAndSortingRepository<LendCard, Long>,JpaSpecificationExecutor<LendCard>{
	@Override
	public Iterable<LendCard> findAll();
	
	@Override
	public Page<LendCard> findAll(Specification<LendCard> arg0, Pageable arg1);
	
	@Override
	public Page<LendCard> findAll(Pageable arg0);	
	
	@Override
	public long count(Specification<LendCard> arg0);
	
	@Override
	public LendCard findOne(Long arg0);
	
	public Iterable<LendCard> findAllByCardId(long cardId);
	
//	@Query("from LendCard lc where DATEDIFF(sysdate() , to_return_date) > :expiredays") 
	@Query("select lc from LendCard lc,CardInfo c where lc.cardId = c.id and c.status='4' and DATEDIFF(sysdate() , lc.toReturnDate) > :expiredays") 
	public Iterable<LendCard> findLendCardExpireAlert(@Param("expiredays") int expiredays);
	
}
