package com.bnu.card.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.BnuCode;

public interface BnuCodeDao extends PagingAndSortingRepository<BnuCode, Long>, JpaSpecificationExecutor<BnuCode> {

	List<BnuCode> findByCodeType(String codeType);
	
	BnuCode findByCodeTypeAndCodeValue(String codeType,String codeName);
	
	BnuCode findByCodeTypeAndCodeName(String codeType,String codeValue);
	
}
