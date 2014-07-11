package com.bnu.card.repository;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.hql.internal.ast.QueryTranslatorImpl;
import org.hibernate.hql.spi.QueryTranslator;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

/**
 * 动态hql查询的实现类
 * 
 * @author wh
 * 
 */
public class DynaHqlImpl implements DynaHql {

	@PersistenceContext
	private EntityManager em;

	/**
	 * 从EntityManager获取Hibernate的Session
	 * 下面所有方式的实现都基于Hibernate
	 */
	private Session getHibernateSession() { 
		return em.unwrap(Session.class);
	}
	
	/**
	 * 获取Hibernate的SessionFactory对象
	 * @return
	 */
	private SessionFactory getHibernateSessionFactory() {
		return getHibernateSession().getSessionFactory();
	}

	@Override
	public List<?> query(String hql, Map<String, Object> namedParams) {
		return getQuery(hql, namedParams).list();
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Page query(String hql, Map<String, Object> namedParams,
			Pageable pageable) {
		List<?> rows = queryPagingList(hql, namedParams, pageable);
		Long total = countHqlResult(hql, namedParams);
		return new PageImpl(rows, pageable, total);
	}

	@Override
	public List<?> queryPagingList(String hql, Map<String, Object> namedParams,
			Pageable pageable) {
		Integer pageNumber = pageable.getPageNumber();
		Integer pageSize = pageable.getPageSize();
		return getQuery(hql, namedParams).setFirstResult(pageNumber * pageSize)
				.setMaxResults(pageSize).list();
	}

	/**
	 * 得到hql和参数组合后的Query对象
	 * @param hql 查询hql
	 * @param namedParams 命名参数
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	private Query getQuery(String hql, Map<String, Object> namedParams) {
		Query q = getHibernateSession().createQuery(hql);
		for (String namedParam : namedParams.keySet()) {
			if (StringUtils.endsWith(namedParam, "List") || StringUtils.endsWith(namedParam, "List")) {
				q.setParameterList(namedParam, (Collection) namedParams.get(namedParam));
			} else {
				q.setParameter(namedParam, namedParams.get(namedParam));
			}
		}
		return q;
	}

	/**
	 * 得到sql和参数组合后的SQLQuery对象
	 * @param sql 查询sql
	 * @param namedParams 命名参数
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	private SQLQuery getSQLQuery(String sql, Map<String, Object> namedParams) {
		SQLQuery q = getHibernateSession().createSQLQuery(sql);
		for (String paramName : namedParams.keySet()) {
			if (paramName.endsWith("List") || paramName.endsWith("Set")) {
				q.setParameterList(paramName, (Collection) namedParams.get(paramName));
			} else {
				q.setParameter(paramName, namedParams.get(paramName));
			}
		}
		return q;
	}

	/**
	 * 通过查询hql获取统计查询结果
	 * @param hql 查询hql
	 * @param namedParams 命名参数
	 * @return 统计查询结果
	 */
	private Long countHqlResult(String hql, Map<String, Object> namedParams) {
		hql = StringUtils.substringBefore(hql, "order by");

		// 去重和分组只能使用NativeSQL统计查询
		if (hql.contains("distinct") || hql.contains("group by")) {
			String countSql = generateCountSql(hql);
			return (Long) getSQLQuery(countSql, namedParams)
					.addScalar("c", StandardBasicTypes.LONG).uniqueResult();
		} else { // 使用hql统计查询
			String countHql = generateCountHql(hql);
			return (Long) getQuery(countHql, namedParams).uniqueResult();
		}
	}

	/**
	 * 生成统计hql
	 * @param hql 查询hql
	 * @return
	 */
	private String generateCountHql(String hql) {
		hql = StringUtils.substringAfter(hql, "from");
		String countHql = "select count(*) from " + hql;
		return countHql;
	}

	/**
	 * 生成统计sql
	 * @param hql 查询hql
	 * @return
	 */
	private String generateCountSql(String hql) {
		return "select count(*) c from (" + hqlToSql(hql) + ")";
	}

	/**
	 * 将hql转换为sql
	 * @param hql 查询hql
	 * @return
	 */
	private String hqlToSql(String hql) {
		QueryTranslator qt = new QueryTranslatorImpl(hql, hql,
				Collections.EMPTY_MAP,
				(SessionFactoryImplementor) getHibernateSessionFactory());
		qt.compile(Collections.EMPTY_MAP, false);
		return qt.getSQLString();
	}

}
