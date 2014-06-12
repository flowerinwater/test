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
import com.bnu.card.entity.MigrateCard;
import com.bnu.card.repository.CardInfoDao;
import com.bnu.card.repository.HistoryDao;
import com.bnu.card.repository.MigrateCardDao;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class MigrateCardService {

	private static Logger log = LoggerFactory.getLogger(MigrateCardService.class);

	@Autowired
	private MigrateCardDao migrateCardDao;
	@Autowired
	private HistoryDao historyDao;
	@Autowired
	private CardInfoDao cardInfoDao;
//	public List<MigrateCard> getAllMigrateCard() {
//		List<MigrateCard> cts = new ArrayList<MigrateCard>();
//		
//		Iterator<MigrateCard> it = migrateCardDao.findAll().iterator();
//		while(it.hasNext()){
//			cts.add(it.next());
//		}
//		
//		return cts;
//	}
//	
//	public Page<MigrateCard> findAllMigrateCard(Pageable p) {
//		return migrateCardDao.findAll(p);
//	}

	public MigrateCard getMigrateCard(Long id) {
		return migrateCardDao.findOne(id);
	}

	public List<MigrateCard> getAllMigrateCardByCardId(String cardId) {
		List<MigrateCard> cts = new ArrayList<MigrateCard>();
		
		Iterator<MigrateCard> it = migrateCardDao.findAllByCardId(Long.parseLong(cardId)).iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	@Transactional(readOnly = false)
	public MigrateCard saveMigrateCard(MigrateCard ci) {
		MigrateCard c = new MigrateCard();
		try {
			//保存历史
			History h = new History();

			//
			if(ci.getId()!=null && !ci.getId().equals(new Long(0))){//update
				c = getMigrateCard(ci.getId());
				Long creatorId = c.getCreatorId();
				Date createDate = c.getCreateDate();
				String creatorName = c.getCreatorName();
				
				BeanUtilEx.copyProperties(c, ci);
				
				c.setCreateDate(createDate);
				c.setCreatorId(creatorId);
				c.setCreatorName(creatorName);
				
				h.setOperateDate(c.getUpdaterDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_MIGRATE);
				h.setOperatorId(c.getUpdaterId());
				h.setOperatorName(c.getUpdaterName());
				
//				h.setCaption("借出卡[" + c.getName() + "]");
				
			}else{//new
				BeanUtilEx.copyProperties(c, ci);
				
				h.setOperateDate(c.getCreateDate());
				h.setOperateType(DefaultValue.OPERATE_TYPE_MIGRATE);
				h.setOperatorId(c.getCreatorId());
				h.setOperatorName(c.getCreatorName());
				
//				h.setCaption("借出卡[" + c.getName() + "]");
			}
			

			c = migrateCardDao.save(c);

//			h.setName(c.getName());
			h.setCardId(c.getId());
			CardInfo cin =cardInfoDao.findOne(c.getCardId());
			cin.setStatus(DefaultValue.MIGRATE);
			cardInfoDao.save(cin);
			
			h.setName(cin!=null?cin.getName():"");
			h.setCaption("迁移卡[" + (cin!=null?cin.getName():"") + "]");
			h.setMemo(c.getMemo());
			h.setCardType(DefaultValue.CARD_TYPE_MIGRATE);
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
	public MigrateCard updateMigrateCard(MigrateCard c) {
		return migrateCardDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteMigrateCard(Long id) {
		migrateCardDao.delete(id);
	}
}