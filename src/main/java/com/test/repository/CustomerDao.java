package com.test.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Customer;

public interface CustomerDao extends PagingAndSortingRepository<Customer, Long> {
	Customer findByShortName(String shortName);
	List<Customer> findByShortNameLike(String shortName);
	Page<Customer> findAll(Pageable p);
}
