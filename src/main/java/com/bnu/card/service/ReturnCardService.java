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
import com.bnu.card.entity.ReturnCard;
import com.bnu.card.repository.CardInfoDao;
import com.bnu.card.repository.HistoryDao;
import com.bnu.card.repository.ReturnCardDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class ReturnCardService {

	private static Logger log = LoggerFactory.getLogger(ReturnCardService.class);

	@Autowired
	private ReturnCardDao returnCardDao;
	@Autowired
	private HistoryDao historyDao;
	@Autowired
	private CardInfoDao cardInfoDao;

//	public List<ReturnCard> getAllReturnCard() {
//		List<ReturnCard> cts = new ArrayList<ReturnCard>();
//		
//		Iterator<ReturnCard> it = returnCardDao.findAll().iterator();
//		while(it.hasNext()){
//			cts.add(it.next());
//		}
//		
//		return cts;
//	}
//	
//	public Page<ReturnCard> findAllReturnCard(Pageable p) {
//		return returnCardDao.findAll(p);
//	}

	public ReturnCard getReturnCard(Long id) {
		return returnCardDao.findOne(id);
	}

	public List<ReturnCard> getAllReturnCardByCardId(String cardId) {
		List<ReturnCard> cts = new ArrayList<ReturnCard>();
		
		Iterator<ReturnCard> it = returnCardDao.findAllByCardId(Long.parseLong(cardId)).iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	@Transactional(readOnly = false)
	public ReturnCard saveReturnCard(ReturnCard ci) {
		ReturnCard c = new ReturnCard();
		try {
			//保存历史
			History h = new History();

			//
			if(ci.getId()!=null && !ci.getId().equals(new Long(0))){//update
				c = getReturnCard(ci.getId());
				Long creatorId = c.getCreatorId();
				Date createDate = c.getCreateDate();
				String creatorName = c.getCreatorName();
				
				BeanUtilEx.copyProperties(c, ci);
				
				c.setCreateDate(createDate);
				c.setCreatorId(creatorId);
				c.setCreatorName(creatorName);
				
				h.setOperateDate(c.getUpdateDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_RETURN);
				h.setOperatorId(c.getUpdaterId());
				h.setOperatorName(c.getUpdaterName());
				
//				h.setCaption("借出卡[" + c.getName() + "]");
				
			}else{//new
				BeanUtilEx.copyProperties(c, ci);
				
				h.setOperateDate(c.getCreateDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_RETURN);
				h.setOperatorId(c.getCreatorId());
				h.setOperatorName(c.getCreatorName());
				
				
				
				
//				h.setCaption("借出卡[" + c.getName() + "]");
			}

			c = returnCardDao.save(c);
//			h.setName(c.getName());
			h.setCardId(c.getId());
			CardInfo cin =cardInfoDao.findOne(c.getCardId());
			cin.setStatus(DefaultValue.VALID);
			cardInfoDao.save(cin);
			
			h.setCaption("归还卡[" + (cin!=null?cin.getName():"") + "]");
			h.setName(cin!=null?cin.getName():"");
			h.setMemo(c.getMemo());

			h.setStatus(DefaultValue.VALID);
			h.setCardType(DefaultValue.CARD_TYPE_RETURN);
			h.setRegisterCardId(cin!=null?cin.getId():0l);	
			
			historyDao.save(h);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return c;
	}

	@Transactional(readOnly = false)
	public ReturnCard updateReturnCard(ReturnCard c) {
		return returnCardDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteReturnCard(Long id) {
		returnCardDao.delete(id);
	}
}