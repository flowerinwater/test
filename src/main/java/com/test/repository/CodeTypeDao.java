package com.test.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.CodeType;

public interface CodeTypeDao extends PagingAndSortingRepository<CodeType, Long>, JpaSpecificationExecutor<CodeType> {

}
