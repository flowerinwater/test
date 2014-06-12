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
import com.bnu.card.repository.HistoryDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
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
                
                
                
                
//                System.out.println("p   :" + p); 
				return p; 
			}
			
		};
//		System.out.println("historyDao.count(ps)");
//System.out.println(historyDao.count(ps));
//Iterator<History> it = historyDao.findAll().iterator();
//while(it.hasNext()){
//	System.out.println(it.next().getOperatorName());
//}
//System.out.println("--------------");
//it = historyDao.findAll(ps).iterator();
//while(it.hasNext()){
//	System.out.println(it.next().getOperatorName());
//}
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