package com.bnu.card.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 扩展SpringDataJpa 支持动态hql查询<br/>
 * 使用方法：<br/>
 * 1. Dao接口继承DynaHql; <br/>
 * 2. 创建名称为"Dao接口名称+Impl"的实现类，继承DynaHqlImpl，加上@Repository注解
 * 
 * @author wh
 *
 */
public interface DynaHql {
	
	/**
	 * 支持hql查询
	 * @param hql
	 * @param namedParams 命名参数(Hibernate4.3.x已不支持占位符参数绑定)
	 * @return
	 */
	List<?> query(String hql, Map<String, Object> namedParams);
	
	/**
	 * 支持hql分页查询
	 * @param hql
	 * @param namedParams 命名参数
	 * @param pageable 分页数据
	 * @return 分页结果
	 */
	List<?> queryPagingList(String hql, Map<String, Object> namedParams, Pageable pageable);
	
	/**
	 * 支持hql分页查询
	 * @param hql
	 * @param namedParams 命名参数
	 * @param pageable 分页数据
	 * @return 分页对象
	 */
	@SuppressWarnings("rawtypes")
	Page query(String hql, Map<String, Object> namedParams, Pageable pageable);

	
}
