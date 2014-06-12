package com.bnu.card.repository;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class CardInfoNsqlDao {

//	@1PersistenceContext1
	private EntityManager em;

	public List x(String sql){
		return em.createNativeQuery(sql).getResultList();
	}
	
}
