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

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bnu.card.entity.CardInfo;
import com.bnu.card.entity.History;
import com.bnu.card.entity.LendCard;
import com.bnu.card.repository.CardInfoDao;
import com.bnu.card.repository.HistoryDao;
import com.bnu.card.repository.LendCardDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.web.Filter;
import com.bnu.card.web.JQGridQueryForm;
import com.bnu.card.web.Rule;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class LendCardService {

	private static Logger log = LoggerFactory.getLogger(LendCardService.class);

	@Autowired
	private LendCardDao lendCardDao;
	@Autowired
	private HistoryDao historyDao;
	@Autowired
	private CardInfoDao cardInfoDao;

//	public List<LendCard> getAllLendCard() {
//		List<LendCard> cts = new ArrayList<LendCard>();
//		
//		Iterator<LendCard> it = lendCardDao.findAll().iterator();
//		while(it.hasNext()){
//			cts.add(it.next());
//		}
//		
//		return cts;
//	}
//	
//	public Page<LendCard> findAllLendCard(Pageable p) {
//		return lendCardDao.findAll(p);
//	}

	public LendCard getLendCard(Long id) {
		return lendCardDao.findOne(id);
	}

	public List<LendCard> getAllLendCardByCardId(String cardId) {
		List<LendCard> cts = new ArrayList<LendCard>();
		
		Iterator<LendCard> it = lendCardDao.findAllByCardId(Long.parseLong(cardId)).iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	public List<LendCard> getLendCardExpireAlert(int expiredays) {
		List<LendCard> cts = new ArrayList<LendCard>();
		
		Iterator<LendCard> it = lendCardDao.findLendCardExpireAlert(expiredays).iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	@Transactional(readOnly = false)
	public LendCard saveLendCard(LendCard ci) {
		LendCard c = new LendCard();
		try {
			//保存历史
			History h = new History();

			//
			if(ci.getId()!=null && !ci.getId().equals(new Long(0))){//update
				c = getLendCard(ci.getId());
				Long creatorId = c.getCreatorId();
				Date createDate = c.getCreateDate();
				String creatorName = c.getCreatorName();
				
				BeanUtilEx.copyProperties(c, ci);
				
				c.setCreateDate(createDate);
				c.setCreatorId(creatorId);
				c.setCreatorName(creatorName);
				
				h.setOperateDate(c.getUpdaterDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_LEND);
				h.setOperatorId(c.getUpdaterId());
				h.setOperatorName(c.getUpdaterName());
				
//				h.setCaption("借出卡[" + c.getName() + "]");
				
			}else{//new
				BeanUtilEx.copyProperties(c, ci);
				c.setStatus("1");
				
				h.setOperateDate(c.getCreateDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_LEND);
				h.setOperatorId(c.getCreatorId());
				h.setOperatorName(c.getCreatorName());
				
//				h.setCaption("借出卡[" + c.getName() + "]");
			}

			c = lendCardDao.save(c);
//			h.setName(c.getName());
			h.setCardId(c.getId());
			CardInfo cin =cardInfoDao.findOne(c.getCardId());
			cin.setStatus(DefaultValue.LEND);
			cardInfoDao.save(cin);
			
			h.setName(cin!=null?cin.getName():"");
			h.setCaption("借出卡[" + (cin!=null?cin.getName():"") + "]");
			h.setMemo(c.getMemo());
			h.setCardType(DefaultValue.CARD_TYPE_LEND);
			h.setRegisterCardId(cin!=null?cin.getId():0l);	
			h.setStatus(DefaultValue.VALID);
			
			historyDao.save(h);
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return c;
	}

	@Transactional(readOnly = false)
	public LendCard updateLendCard(LendCard c) {
		return lendCardDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteLendCard(Long id) {
		lendCardDao.delete(id);
	}

	public Page<LendCard> getLendCardExpireAlert(final JQGridQueryForm jqForm,
			Pageable pb) {
		Specification<LendCard> ps = new Specification<LendCard>(){

			@Override
			public Predicate toPredicate(Root<LendCard> root,
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
							}else if(rule.getField().equalsIgnoreCase("lendDate") || rule.getField().equalsIgnoreCase("toReturnDate")){
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

		return lendCardDao.findAll(ps,pb);
	}
}