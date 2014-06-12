package com.test.service.account;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.util.Version;
import org.hibernate.search.FullTextQuery;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.test.entity.Customer;
import com.test.entity.Product;
import com.test.entity.User;
import com.test.repository.CustomerDao;
import com.test.repository.ProductDao;
import com.test.repository.UserDao;
import com.test.web.account.ProdoctSearch;
import com.test.web.account.ProductInfo;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class ProductService {

	private static Logger log = LoggerFactory.getLogger(ProductService.class);

	@Autowired
	private ProductDao productDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private EntityManagerFactory entityManagerFactory;

	public List<Product> getAllProduct() {
		List<Product> cts = new ArrayList<Product>();
		
		Iterator<Product> it = productDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	public Page<Product> findAllProduct(final ProdoctSearch ps,Pageable p) {
		
		Specification<Product> s = new Specification<Product>(){

			@Override
			public Predicate toPredicate(Root<Product> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {

				root = query.from(Product.class); 
				Path<String> nameExp = root.get("name"); 
				Path<String> tradeMarkExp = root.get("tradeMark");
				Path<String> typeExp = root.get("tradeMark");
				Path<Double> allowanceExp = root.get("allowance");
				Path<Double> costExp = root.get("cost");
				
//				criteriaBuilder.and(criteriaBuilder.equal(ptActivityRoot
//                        .get("status"), criteriaBuilder.parameter(Byte.class,
//                        "status")), criteriaBuilder.lessThan(ptActivityRoot
//                        .<Date> get("startTime"), criteriaBuilder.parameter(
//                        Date.class, "nowDate")))).orderBy(
//                criteriaBuilder.desc(ptActivityRoot.get("endTime")),
//                criteriaBuilder.desc(ptActivityRoot.get("startTime")));
                
				Predicate p = null;
				
                if(ps.getS_name() != null){
                	p = cb.and(cb.like(nameExp, "%" + ps.getS_name() + "%"),p);
                }
                
                if(ps.getS_tradeMark() != null){
                	p = cb.and(cb.like(tradeMarkExp, "%" + ps.getS_tradeMark() + "%"),p);
                }
                
                if(ps.getS_type() != null){
                	p = cb.and(cb.like(typeExp, "%" + ps.getS_type() + "%"),p);
                }
                
                if(ps.getS_allowance_low()!=null){
                	p = cb.and(cb.gt(allowanceExp, Double.valueOf(ps.getS_allowance_low())),p);
                }
                
                if(ps.getS_allowance_top()!=null){
                	p = cb.and(cb.lt(allowanceExp, Double.valueOf(ps.getS_allowance_top())),p);
                }
                
                if(ps.getS_cost_low()!=null){
                	p = cb.and(cb.gt(costExp, Double.valueOf(ps.getS_cost_low())),p);
                }
                
                if(ps.getS_cost_top()!=null){
                	p = cb.and(cb.lt(costExp, Double.valueOf(ps.getS_cost_top())),p);
                }
				
				return p; 
			}
			
		};
		
		return productDao.findAll(s, p);
	}
	
	public Page<Product> findAllProductByFullTextSearch(String s,Pageable pg) {
		PageImpl<Product> p = new PageImpl<Product>(new ArrayList<Product>(),pg,0);
		try {
			FullTextSession fullTextSession = Search.getFullTextSession(null);//this.productDao.getSessionFactory().openSession());     
	        MultiFieldQueryParser parser = new MultiFieldQueryParser(Version.LUCENE_35, new String[] {"content" }, new StandardAnalyzer(Version.LUCENE_35));     
	        org.apache.lucene.search.Query luceneQuery = parser.parse(s);
			FullTextQuery query = fullTextSession.createFullTextQuery(luceneQuery,Product.class);     
	        // 添加分页查询     
	        query.setFirstResult(pg.getPageSize()*(pg.getPageNumber()-1));     
	        query.setMaxResults(pg.getPageSize()*pg.getPageNumber());     
	        // 对查询结果按name进行排序     
	        @SuppressWarnings("unchecked")
			List<Product> result = query.list(); 
	        p = new PageImpl<Product>(result,pg,result.size());
		} catch (ParseException e) {
			e.printStackTrace();
		}     
          
		return p;
	}
	
	public Page<Product> findAllProductByFullTextSearch2(String keys,Pageable pg) {
		PageImpl<Product> p = new PageImpl<Product>(new ArrayList<Product>(),pg,0);

			EntityManager em = entityManagerFactory.createEntityManager();
			FullTextEntityManager fullTextEntityManager = 
			    org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
			try {
				fullTextEntityManager.createIndexer().startAndWait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			} 
			em.getTransaction().begin();

			// create native Lucene query unsing the query DSL
			// alternatively you can write the Lucene query using the Lucene query parser
			// or the Lucene programmatic API. The Hibernate Search DSL is recommended though
			QueryBuilder qb = fullTextEntityManager.getSearchFactory()
			    .buildQueryBuilder().forEntity( Product.class ).get();
			org.apache.lucene.search.Query query = qb
			  .keyword()
			  .onField("content")
			  .matching(keys)			  
			  .createQuery();
			//.combine(new org.apache.lucene.search.Query[]{qb.range().onField("unitPrice").from(0.5).to(1.5).createQuery()});

			// wrap Lucene query in a javax.persistence.Query
			javax.persistence.Query persistenceQuery = 
			    fullTextEntityManager.createFullTextQuery(query, Product.class);

			// execute search
			persistenceQuery.setFirstResult(pg.getPageSize()*(pg.getPageNumber()));     
			persistenceQuery.setMaxResults(pg.getPageSize()*(pg.getPageNumber()+1));  
			@SuppressWarnings("unchecked")
			List<Product> result = persistenceQuery.getResultList();

			em.getTransaction().commit();
			em.close();
			
	        p = new PageImpl<Product>(result,pg,result.size());
          
		return p;
	}

	public Product getProduct(Long id) {
		return productDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public Product saveProduct(ProductInfo ci) {
		Product c = new Product();
		try {
			BeanUtils.copyProperties(c, ci);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		User u = userDao.findOne(ci.getCreateUserId());
		c.setCreateUser(u);
		Customer cc = customerDao.findOne(ci.getSupplierId());
		c.setSupplier(cc);
		return productDao.save(c);
	}

	@Transactional(readOnly = false)
	public Product updateProduct(Product c) {
		return productDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteProduct(Long id) {
		productDao.delete(id);
	}
	
	public List<Product> getAllProductByName(String name) {
		return  productDao.findByNameLike(name);
	}
}
