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
import javax.persistence.criteria.Expression;
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
import com.bnu.card.repository.CardInfoDao;
import com.bnu.card.repository.CardInfoNsqlDao;
import com.bnu.card.repository.HistoryDao;
import com.bnu.card.repository.SysUserDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.web.form.CardInfoSearchForm;
//import com.bnu.card.web.account.CardInfoInfo;
import com.bnu.card.web.form.StudentReportForm;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class CardInfoService {

	private static Logger log = LoggerFactory.getLogger(CardInfoService.class);

	@Autowired
	private CardInfoDao cardInfoDao;
	@Autowired
	private HistoryDao historyDao;
	@Autowired
	private SysUserDao sysUserDao;

	public List<CardInfo> getAllCardInfo() {
		List<CardInfo> cts = new ArrayList<CardInfo>();
		
		Iterator<CardInfo> it = cardInfoDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	public Page<CardInfo> findAllCardInfo(Pageable p) {
		return cardInfoDao.findAll(p);
	}
	
	public Page<CardInfo> findAllCardInfo(final CardInfoSearchForm cisf,Pageable pb) {
		Specification<CardInfo> ps = new Specification<CardInfo>(){

			@Override
			public Predicate toPredicate(Root<CardInfo> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {

				Predicate p = null;
				
				Path<String> nameExp = root.get("name"); 
                if(cisf.getS_name() != null){
                	if(p!=null)
                		p = cb.and(cb.like(nameExp, "%" + cisf.getS_name() + "%"),p);
                	else
                		p = cb.like(nameExp, "%" + cisf.getS_name() + "%");
                }
                
                Path<String> birthPlaceExp = root.get("birthPlace"); 
                if(cisf.getS_birthPlace() != null){
                	if(p!=null)
                		p = cb.and(cb.like(birthPlaceExp, "%" + cisf.getS_birthPlace() + "%"),p);
                	else
                		p = cb.like(birthPlaceExp, "%" + cisf.getS_birthPlace() + "%");
                }
                
                Path<String> addressExp = root.get("address"); 
                if(cisf.getS_address() != null){
                	if(p!=null)
                		p = cb.and(cb.like(addressExp, "%" + cisf.getS_address() + "%"),p);
                	else
                		p = cb.like(addressExp, "%" + cisf.getS_address() + "%");
                }
                
                Path<String> originStudentExp = root.get("originStudent"); 
                if(cisf.getS_originStudent() != null){
                	if(p!=null)
                		p = cb.and(cb.like(originStudentExp, "%" + cisf.getS_originStudent() + "%"),p);
                	else
                		p = cb.like(originStudentExp, "%" + cisf.getS_originStudent() + "%");
                }
                
                
                if(cisf.getS_birthday_low()!=null){
					try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date cdl = sdf.parse(cisf.getS_birthday_low());
						Path<Date> birthDayExp = root.<Date>get("birthDay"); 
						Expression<Date> dateStart = cb.literal(cdl);
	                	if(p!=null)
	                		p = cb.and(cb.greaterThanOrEqualTo(birthDayExp, dateStart),p);
	                	else
	                		p = cb.greaterThanOrEqualTo(birthDayExp, dateStart);
					} catch (ParseException e) {
						e.printStackTrace();
					}
                }
                
                if(cisf.getS_birthday_top()!=null){
                	try {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date cdt = sdf.parse(cisf.getS_birthday_top());
						Path<Date> birthDayExp = root.<Date>get("birthDay"); 
						Expression<Date> dateEnd = cb.literal(cdt);
	                	if(p!=null)
	                		p = cb.and(cb.lessThan(birthDayExp, dateEnd),p);
	                	else
	                		p = cb.lessThan(birthDayExp, dateEnd);
					} catch (ParseException e) {
						e.printStackTrace();
					}
                }
				
				return p; 
			}
			
		};

		return cardInfoDao.findAll(ps,pb);
	}

	public CardInfo getCardInfo(Long id) {
		return cardInfoDao.findOne(id);
	}
	@Transactional(readOnly = false)
	public void saveCardInfos(List<CardInfo> cis) {
		for (Iterator iterator = cis.iterator(); iterator.hasNext();) {
			CardInfo ci = (CardInfo) iterator.next();
			saveCardInfo(ci,true);
		}
	}

	
	@Transactional(readOnly = false)
	public CardInfo saveCardInfo(CardInfo ci) {
		return saveCardInfo(ci,false);
	}
	
	
	@Transactional(readOnly = false)
	public CardInfo saveCardInfo(CardInfo ci,boolean batch) {
		CardInfo c = new CardInfo();
		try {
			//保存历史
			History h = new History();

			//
			if(ci.getId()!=null && !ci.getId().equals(new Long(0))){//update
				c = getCardInfo(ci.getId());
				Long creatorId = c.getCreatorId();
				Date createDate = c.getCreateDate();
				String creatorName = c.getCreatorName();
				
				BeanUtilEx.copyProperties(c, ci);
				
				c.setCreateDate(createDate);
				c.setCreatorId(creatorId);
				c.setCreatorName(creatorName);
				
				h.setOperateDate(c.getUpdaterDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_UPDATE);
				h.setOperatorId(c.getUpdaterId());
				h.setOperatorName(c.getUpdaterName());
				
				h.setCaption("修改卡[" + c.getName() + "]");
				
			}else{//new
				BeanUtilEx.copyProperties(c, ci);
				
				h.setOperateDate(c.getCreateDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_ADD);
				h.setOperatorId(c.getCreatorId());
				h.setOperatorName(c.getCreatorName());
				if(!batch)
					h.setCaption("新建卡[" + c.getName() + "]");
				else
					h.setCaption("导入卡[" + c.getName() + "]");
			}
			
			c = cardInfoDao.save(c);
			
			h.setName(c.getName());
			h.setCardId(c.getId());
			h.setMemo(c.getMemo());
			if(!batch)
				h.setCardType(DefaultValue.CARD_TYPE_REGISTER);
			else
				h.setCardType(DefaultValue.CARD_TYPE_BATCH_REGISTER);
			h.setRegisterCardId(c.getId());
			h.setStatus(DefaultValue.VALID);
//			h.setCardType(DefaultValue.) no use
			
			historyDao.save(h);
			
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return c;
	}

	@Transactional(readOnly = false)
	public CardInfo updateCardInfo(CardInfo c) {
		return cardInfoDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteCardInfo(Long id, String currUserName, Long currUserId, Date currDate) {
		History h = new History();
		
		CardInfo c = getCardInfo(id);
		c.setStatus(DefaultValue.DELETE);
		
		h.setOperateDate(c.getUpdaterDate());
		h.setOperateType(DefaultValue.OPERATE_TYPE_DEL);
		h.setOperatorId(c.getUpdaterId());
		h.setOperatorName(c.getUpdaterName());
		h.setCaption("删除卡[" + c.getName() + "]");
		h.setName(c.getName());
		h.setCardId(c.getId());
		h.setCardType(DefaultValue.CARD_TYPE_REGISTER);
		h.setRegisterCardId(c.getId());
		h.setStatus(DefaultValue.VALID);
		h.setMemo(c.getMemo());
		
		cardInfoDao.save(c);
		
		historyDao.save(h);
	}
	
	
	@Transactional(readOnly = true)
	public List<List> jsonGenderNationReport(String academa){
		return cardInfoDao.findByNationGroup(academa);
	}
	
	@Transactional(readOnly = true)
	public List<List> jsonDetainedReport(String academa){
		return cardInfoDao.findByDetainedGradeGroup(academa);
	}
	
	@Transactional(readOnly = true)
	public List<List> jsonGradeReport(String academa){
		return cardInfoDao.findByGradeGroup(academa);
	}

	@Transactional(readOnly = true)
	public List<List> jsonOriginReport(String academa){
		return cardInfoDao.findByOriginGroup(academa);
	}
	
	//////////////////////
	@Transactional(readOnly = true)
	public List<List> jsonCardTypeReport(){
		return cardInfoDao.findByCardTypeGroup();
	}
	
	@Transactional(readOnly = true)
	public List<List> jsonAcademeReport(){
		return cardInfoDao.findByAcademeGroup();
	}

	public List jsonAcademeAgeReport(String ageLow,String ageTop) {
		if(!ageLow.equals("") && !ageTop.equals(""))
			return cardInfoDao.findByBetweenAgeGroup(ageLow, ageTop);
		if(!ageTop.equals(""))
			return cardInfoDao.findByLessAgeGroup(ageTop);
		if(!ageLow.equals(""))
			return cardInfoDao.findByGreaterAgeGroup(ageLow);
		
		return new ArrayList();
		
	}

	public List jsonLendReport() {
		return cardInfoDao.findLendReport();
	}
	
	public List jsonReturnReport() {
		return cardInfoDao.findReturnReport();
	}

	public List<CardInfo> findCardInfoByIdentityCard(String identityCard) {
		List<CardInfo> r = new ArrayList<CardInfo>();
		
		Iterable<CardInfo>  r1 = cardInfoDao.findAllByIdentityCard(identityCard);
		Iterator<CardInfo> rt = r1.iterator();
		while(rt.hasNext())
			r.add(rt.next());
		
//		r.add(cardInfoDao.findByIdentityCard(identityCard));
		
		return r;
	}
	
	public List<CardInfo> findCardInfoBystuTeaNumber(String stuTeaNumber) {
		List<CardInfo> r = new ArrayList<CardInfo>();
		
		Iterable<CardInfo>  r1 = cardInfoDao.findAllByAddress(stuTeaNumber);//stuTeaNumber存放在address中
		Iterator<CardInfo> rt = r1.iterator();
		while(rt.hasNext())
			r.add(rt.next());
		
//		r.add(cardInfoDao.findByIdentityCard(identityCard));
		
		return r;
	}
}