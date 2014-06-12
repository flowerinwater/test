package com.test.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Bill;

public interface BillDao extends PagingAndSortingRepository<Bill, Long> {
	List<Bill> findByBillCodeLike(String billCode);
	Page<Bill> findAll(Pageable p);
}
