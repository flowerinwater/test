package com.test.repository;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.test.entity.Article;

public interface ArticleDao extends PagingAndSortingRepository<Article, Long> {
	List<Article> findByPublisherId(String userName);
}
