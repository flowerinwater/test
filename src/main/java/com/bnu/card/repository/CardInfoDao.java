package com.bnu.card.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.bnu.card.entity.CardInfo;
import com.bnu.card.web.form.StudentReportForm;

public interface CardInfoDao extends PagingAndSortingRepository<CardInfo, Long>,JpaSpecificationExecutor<CardInfo>{
	@Override
	public Iterable<CardInfo> findAll();
	
	@Override
	public Page<CardInfo> findAll(Specification<CardInfo> arg0, Pageable arg1);
	
	@Override
	public Page<CardInfo> findAll(Pageable arg0);	
	
	@Override
	public long count(Specification<CardInfo> arg0);
	
	@Override
	public CardInfo findOne(Long arg0);

	public Iterable<CardInfo> findAllByIdentityCard(String id);

	public Iterable<CardInfo> findAllByAddress(String stuTeaNumber);
	
//	public CardInfo findByIdentityCard();
	
	public List findByNationGroup(@Param("academa") String academe);
	
	public List findByOriginGroup(@Param("academa") String academe);
	
	public List findByGradeGroup(@Param("academa") String academe);
	
	public List findByDetainedGradeGroup(@Param("academa") String academe);
	
	public List findByDetainedGradeGroup1(@Param("academa") String academe);
	
	public List findByLendExpireGradeGroup(@Param("expiredays") int expiredays);
	
	///////////////
	public List findByCardTypeGroup();
	
	public List findByAcademeGroup();

	public List findByBetweenAgeGroup(@Param("ageLow") String ageLow,@Param("ageTop") String ageTop);
	
	public List findByLessAgeGroup(@Param("ageTop") String ageTop);
	
	public List findByGreaterAgeGroup(@Param("ageLow") String ageLow);

	public List findLendReport();
	
	public List findReturnReport();
}
