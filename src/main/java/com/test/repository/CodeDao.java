package com.test.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Code;

public interface CodeDao extends PagingAndSortingRepository<Code, Long>, JpaSpecificationExecutor<Code> {

	List<Code> findByCodeType(String codeType);
}
