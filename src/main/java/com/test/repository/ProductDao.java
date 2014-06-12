package com.test.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Product;

public interface ProductDao extends PagingAndSortingRepository<Product, Long>,JpaSpecificationExecutor<Product> {
	List<Product> findByNameLike(String shortName);
	Page<Product> findAll(Pageable p);
}
