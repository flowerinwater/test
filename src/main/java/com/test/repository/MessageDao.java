package com.test.repository;


import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.ApnMessage;

public interface MessageDao extends PagingAndSortingRepository<ApnMessage, Long> {
}
