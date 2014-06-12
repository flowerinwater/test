package com.bnu.card.repository.t;

import java.io.Serializable;
import java.lang.annotation.Annotation;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.data.jpa.repository.support.QueryDslJpaRepository;

public class NativeQueryRepositoryImpl<T, ID extends Serializable> implements
		NativeQueryRepository<T, ID> {

	@PersistenceContext
	private EntityManager em;

	private QueryDslJpaRepository<T, ID> repository;

	public NativeQueryRepositoryImpl() {

	}

	public List queryNatively(String nativeQueryName,
			LinkedHashMap<String, Class<?>> inEntityClasses, Map inParams) {
		SQLQuery query = createHibernateNativeQuery(nativeQueryName, inParams);
		// add entities
		if (inEntityClasses != null) {
			for (Object key : inEntityClasses.keySet()) {
				String entityClassAlias = key.toString();
				Class<?> entityClass = (Class<?>) inEntityClasses.get(key);
				query.addEntity(entityClassAlias, entityClass);
			}
		}

		// add parameter
		if (inParams != null) {
			for (Object key : inParams.keySet()) {
				String queryParamName = key.toString();
				Object queryParamValue = inParams.get(key);
				query.setParameter(queryParamName, queryParamValue);
			}
		}
		return (query != null) ? query.list() : null;
	}

	private SQLQuery createHibernateNativeQuery(String nativeQueryName,
			Map inParams) {
		if (NativeQueryRepositoryImpl.class
				.isAssignableFrom(getSpringDataRepositoryInterface())) {

			Annotation nativeQueryAnn = getSpringDataRepositoryInterface()
					.getAnnotation(NativeQueries.class);
			if (nativeQueryAnn != null) {
				NativeQueries nativeQueries = (NativeQueries) nativeQueryAnn;
				NativeQuery[] queries = nativeQueries.queries();
				for (NativeQuery sqlquery : queries) {

					if (StringUtils.equals(nativeQueryName, sqlquery.name())) {
						String sql = sqlquery.sql();

						Session hiernateSess = em.unwrap(Session.class);
						SQLQuery query = hiernateSess.createSQLQuery(sql);

						// add parameter
						if (inParams != null) {
							for (Object key : inParams.keySet()) {
								String queryParamName = key.toString();
								Object queryParamValue = inParams.get(key);
								query.setParameter(queryParamName,
										queryParamValue);
							}
						}

						return query;
					}
				}
			}

		}
		return null;
	}

	private Class<?> getSpringDataRepositoryInterface() {
		
		// TODO Auto-generated method stub
		return null;
	}

	// /**
	// * An initialization method which is run after the bean has been
	// constructed.
	// * This ensures that the entity manager is injected before we try to use
	// it.
	// */
	// @PostConstruct
	// public void init() {
	// JpaEntityInformation<Person, Long> personEntityInfo = new
	// JpaMetamodelEntityInformation<Person, Long>(Person.class,
	// entityManager.getMetamodel());
	// personRepository = new QueryDslJpaRepository<Person,
	// Long>(personEntityInfo, entityManager);
	// }
	//
	// /**
	// * This setter method should be used only by unit tests
	// * @param personRepository
	// */
	// protected void setPersonRepository(QueryDslJpaRepository<Person, Long>
	// personRepository) {
	// this.personRepository = personRepository;
	// }
}
