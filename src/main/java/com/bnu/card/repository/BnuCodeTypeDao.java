package com.bnu.card.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.bnu.card.entity.BnuCodeType;

public interface BnuCodeTypeDao extends PagingAndSortingRepository<BnuCodeType, Long>, JpaSpecificationExecutor<BnuCodeType> {

}
