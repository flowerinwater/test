package com.test.repository;


import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.BillDetail;

public interface BillDetailDao extends PagingAndSortingRepository<BillDetail, Long> {
}
