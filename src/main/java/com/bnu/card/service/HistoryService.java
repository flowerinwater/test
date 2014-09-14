package com.bnu.card.service;

import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Expression;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bnu.card.entity.History;
import com.bnu.card.entity.SysUser;
import com.bnu.card.repository.HistoryDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.web.Filter;
import com.bnu.card.web.JQGridQueryForm;
import com.bnu.card.web.Rule;
import com.bnu.card.web.form.HistorySearchForm;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class HistoryService {

	private static Logger log = LoggerFactory.getLogger(HistoryService.class);

	@Autowired
	private HistoryDao historyDao;

	public List<History> getAllHistory() {
		List<History> cts = new ArrayList<History>();
		
		Iterator<History> it = historyDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
//	
//	public Page<History> findAllHistory(Pageable p) {
//		return historyDao.findAll(p);
//	}

	public History getHistory(Long id) {
		return historyDao.findOne(id);
	}

	public Page<History> findAllHistory(final JQGridQueryForm jqForm,Pageable pb) {
		Specification<History> ps = new Specification<History>(){

			@Override
			public Predicate toPredicate(Root<History> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {

				Predicate p = null;
				
				
				Filter f = jqForm.getFilters();
				
				if(f!=null){
					List<Rule> rules = f.getRules();
					
					for (Iterator iterator = rules.iterator(); iterator.hasNext();) {
						Rule rule = (Rule) iterator.next();
						Path<String> exp = root.get(rule.getField());
						if(rule.getData() != null){
							
							if(rule.getField().equalsIgnoreCase("id")){
								if(rule.getOp().equalsIgnoreCase("eq")){
									if(p!=null)
				                		p = cb.and(cb.equal(exp, rule.getData()),p);
				                	else
				                		p = cb.equal(exp, rule.getData());
								}
								
								if(rule.getOp().equalsIgnoreCase("ne")){
									if(p!=null)
				                		p = cb.and(cb.notEqual(exp, rule.getData()),p);
				                	else
				                		p = cb.notEqual(exp, rule.getData());
								}
								
								if(rule.getOp().equalsIgnoreCase("lt")){
									if(p!=null)
				                		p = cb.and(cb.lessThan(exp, rule.getData()),p);
				                	else
				                		p = cb.lessThan(exp, rule.getData());
								}
								
								if(rule.getOp().equalsIgnoreCase("le")){
									if(p!=null)
				                		p = cb.and(cb.lessThanOrEqualTo(exp, rule.getData()),p);
				                	else
				                		p = cb.lessThanOrEqualTo(exp, rule.getData());
								}
								
								if(rule.getOp().equalsIgnoreCase("gt")){
									if(p!=null)
				                		p = cb.and(cb.greaterThan(exp, rule.getData()),p);
				                	else
				                		p = cb.greaterThan(exp, rule.getData());
								}
								if(rule.getOp().equalsIgnoreCase("ge")){
									if(p!=null)
				                		p = cb.and(cb.greaterThanOrEqualTo(exp, rule.getData()),p);
				                	else
				                		p = cb.greaterThanOrEqualTo(exp, rule.getData());
								}
//								if(rule.getOp().equalsIgnoreCase("nc")){
//									if(p!=null)
//				                		p = cb.and(cb.notLike(exp, rule.getData()),p);
//				                	else
//				                		p = cb.notLike(exp, rule.getData());
//								}
//								if(rule.getOp().equalsIgnoreCase("bw")){
//									if(p!=null)
//				                		p = cb.and(cb.between(exp, rule.getData()),p);
//				                	else
//				                		p = cb.lessThan(exp, rule.getData());
//								}
							}else if(rule.getField().equalsIgnoreCase("operateDate")){
								Path<Date> exp1 = root.get(rule.getField());
								
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								try {
									Date dt = sdf.parse(rule.getData());
									
									if(rule.getOp().equalsIgnoreCase("eq")){
										if(p!=null)
					                		p = cb.and(cb.equal(exp1, dt),p);
					                	else
					                		p = cb.equal(exp1, dt);
									}
									
									if(rule.getOp().equalsIgnoreCase("ne")){
										if(p!=null)
					                		p = cb.and(cb.notEqual(exp1, dt),p);
					                	else
					                		p = cb.notEqual(exp1, dt);
									}
									
									if(rule.getOp().equalsIgnoreCase("lt")){
										if(p!=null)
					                		p = cb.and(cb.lessThan(exp1, dt),p);
					                	else
					                		p = cb.lessThan(exp1, dt);
									}
									
									if(rule.getOp().equalsIgnoreCase("le")){
										if(p!=null)
					                		p = cb.and(cb.lessThanOrEqualTo(exp1, dt),p);
					                	else
					                		p = cb.lessThanOrEqualTo(exp1, dt);
									}
									
									if(rule.getOp().equalsIgnoreCase("gt")){
										if(p!=null)
					                		p = cb.and(cb.greaterThan(exp1, dt),p);
					                	else
					                		p = cb.greaterThan(exp1, dt);
									}
									if(rule.getOp().equalsIgnoreCase("ge")){
										if(p!=null)
					                		p = cb.and(cb.greaterThanOrEqualTo(exp1, dt),p);
					                	else
					                		p = cb.greaterThanOrEqualTo(exp1, dt);
									}
								} catch (ParseException e) {
									e.printStackTrace();
								}
								
			                	
							}else{
								if(rule.getOp().equalsIgnoreCase("eq")){
									if(p!=null)
				                		p = cb.and(cb.equal(exp, rule.getData()),p);
				                	else
				                		p = cb.equal(exp, rule.getData());
								}
								
								if(rule.getOp().equalsIgnoreCase("ne")){
									if(p!=null)
				                		p = cb.and(cb.notEqual(exp, rule.getData()),p);
				                	else
				                		p = cb.notEqual(exp, rule.getData());
								}
								
								
								if(rule.getOp().equalsIgnoreCase("cn")){
									if(p!=null)
				                		p = cb.and(cb.like(exp, "%" + rule.getData() + "%"),p);
				                	else
				                		p = cb.like(exp, "%" + rule.getData() + "%");
								}
								
								if(rule.getOp().equalsIgnoreCase("nc")){
									if(p!=null)
				                		p = cb.and(cb.notLike(exp, "%" + rule.getData() + "%"),p);
				                	else
				                		p = cb.notLike(exp, "%" + rule.getData() + "%");
								}
								
							}

						}
					}
				}
				
				return p; 
			}
			
		};

		return historyDao.findAll(ps,pb);
	}
	
	public Page<History> findAllHistory(final HistorySearchForm cisf,Pageable pb) {
		Specification<History> ps = new Specification<History>(){
			@Override
			public Predicate toPredicate(Root<History> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate p = null;
				
				Path<String> operatorNameExp = root.get("operatorName");  
				System.out.println("cisf.getS_operatorName():" + cisf.getS_operatorName());
                if(cisf.getS_operatorName() != null){
                	if(p != null)
                		p = cb.and(cb.like(operatorNameExp, "%" + cisf.getS_operatorName() + "%"),p);
                	else
                    	p = cb.like(operatorNameExp, "%" + cisf.getS_operatorName());
                }
                
                Path<String> nameExp = root.get("name");  
				System.out.println("cisf.getS_name():" + cisf.getS_name());
                if(cisf.getS_name() != null){
                	if(p != null)
                		p = cb.and(cb.like(nameExp, "%" + cisf.getS_name() + "%"),p);
                	else
                    	p = cb.like(nameExp, "%" + cisf.getS_name());
                }

                Path<Date> operateDateExp = root.<Date>get("operateDate"); 
                if(cisf.getS_operateDate_low()!=null){
					try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date cdl = sdf.parse(cisf.getS_operateDate_low());
						Expression<Date> dateStart = cb.literal(cdl);
	                	if(p!=null)
	                		p = cb.and(cb.greaterThanOrEqualTo(operateDateExp, dateStart),p);
	                	else
	                		p = cb.greaterThanOrEqualTo(operateDateExp, dateStart);
					} catch (ParseException e) {
						e.printStackTrace();
					}
                }
                
                if(cisf.getS_operateDate_top()!=null){
                	try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date cdt = sdf.parse(cisf.getS_operateDate_top());
						Expression<Date> dateStart = cb.literal(cdt);
	                	if(p!=null)
	                		p = cb.and(cb.lessThan(operateDateExp, dateStart),p);
	                	else
	                		p = cb.lessThan(operateDateExp, dateStart);
					} catch (ParseException e) {
						e.printStackTrace();
					}
                }
				return p; 
			}
			
		};
		return historyDao.findAll(ps,pb);
	}
	
	public List<History> getAllHistoryByCardId(String cardId) {
		List<History> cts = new ArrayList<History>();
		
		Iterator<History> it = historyDao.findAllByCardId(Long.parseLong(cardId)).iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	@Transactional(readOnly = false)
	public History saveHistory(History ci) {
		History c = new History();

		c.setStatus(DefaultValue.VALID);
		try {
			BeanUtilEx.copyProperties(c, ci);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return historyDao.save(c);
	}

	@Transactional(readOnly = false)
	public History updateHistory(History c) {
		return historyDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteHistory(Long id) {
		historyDao.delete(id);
	}
}