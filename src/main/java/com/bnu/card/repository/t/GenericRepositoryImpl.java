package com.bnu.card.repository.t;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import org.apache.log4j.Logger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.JpaEntityInformationSupport;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.persistenceunit.DefaultPersistenceUnitManager;

@NoRepositoryBean
public class GenericRepositoryImpl<T, ID extends Serializable> extends
		SimpleJpaRepository<T, ID> implements GenericRepository<T, ID>,
		Serializable {

	private static final long serialVersionUID = 1L;

	static Logger logger = Logger.getLogger(GenericRepositoryImpl.class);

	private final JpaEntityInformation<T, ?> entityInformation;
	private final EntityManager em;
//	private final DefaultPersistenceManager provider;

	private Class<?> springDataRepositoryInterface;

	public Class<?> getSpringDataRepositoryInterface() {
		return springDataRepositoryInterface;
	}

	public void setSpringDataRepositoryInterface(
			Class<?> springDataRepositoryInterface) {
		this.springDataRepositoryInterface = springDataRepositoryInterface;
	}

	/**
	 * Creates a new {@link SimpleJpaRepository} to manage objects of the given
	 * {@link JpaEntityInformation}.
	 * 
	 * @param entityInformation
	 * @param entityManager
	 */
	public GenericRepositoryImpl(JpaEntityInformation<T, ?> entityInformation,
			EntityManager entityManager, Class<?> springDataRepositoryInterface) {
		super(entityInformation, entityManager);
		this.entityInformation = entityInformation;
		this.em = entityManager;
//		this.provider = DefaultPersistenceManager
//				.fromEntityManager(entityManager);
		// LocalContainerEntityManagerFactoryBean c;
		this.springDataRepositoryInterface = springDataRepositoryInterface;
	}

	/**
	 * Creates a new {@link SimpleJpaRepository} to manage objects of the given
	 * domain type.
	 * 
	 * @param domainClass
	 * @param em
	 */
	public GenericRepositoryImpl(Class<T> domainClass, EntityManager em) {
		this(JpaEntityInformationSupport.getMetadata(domainClass, em), em, null);
	}

	public <S extends T> S save(S entity) {
		if (this.entityInformation.isNew(entity)) {
			this.em.persist(entity);
			flush();
			return entity;
		}
		entity = this.em.merge(entity);
		flush();
		return entity;
	}

	public T saveWithoutFlush(T entity) {
		return super.save(entity);
	}

	public List<T> saveWithoutFlush(Iterable<? extends T> entities) {
		List<T> result = new ArrayList<T>();
		if (entities == null) {
			return result;
		}

		for (T entity : entities) {
			result.add(saveWithoutFlush(entity));
		}
		return result;
	}
}