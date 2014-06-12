package com.bnu.card.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
}