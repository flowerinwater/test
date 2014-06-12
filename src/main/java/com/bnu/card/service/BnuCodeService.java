package com.bnu.card.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bnu.card.entity.BnuCode;
import com.bnu.card.entity.BnuCodeType;
import com.bnu.card.repository.BnuCodeDao;
import com.bnu.card.repository.BnuCodeTypeDao;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class BnuCodeService {

	private static Logger log = LoggerFactory.getLogger(BnuCodeService.class);

	@Autowired
	private BnuCodeDao codeDao;
	@Autowired
	private BnuCodeTypeDao codeTypeDao;

	public List<BnuCodeType> getAllCodeType() {
		List<BnuCodeType> cts = new ArrayList<BnuCodeType>();
		
		Iterator<BnuCodeType> it = codeTypeDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}

	public BnuCodeType getCodeType(Long id) {
		return codeTypeDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveCodeType(BnuCodeType codeType) {
		log.info("111111111111111111");
		codeTypeDao.save(codeType);
	}

	@Transactional(readOnly = false)
	public void updateCodeType(BnuCodeType codeType) {
		codeTypeDao.save(codeType);
	}

	@Transactional(readOnly = false)
	public void deleteCodeType(Long id) {
		codeTypeDao.delete(id);
	}
	
	
	//////////////////////////
	public List<BnuCode> getAllCodeByCodeType(String codeType) {
		return (List<BnuCode>) codeDao.findByCodeType(codeType);
	}

	public BnuCode getCode(Long id) {
		return codeDao.findOne(id);
	}
	
	public String getCodeName(String codeType,String codeValue) {
		BnuCode c = codeDao.findByCodeTypeAndCodeValue(codeType,codeValue);
		
		return c!=null?c.getCodeName():"";
	}
	
	public String getCodeValue(String codeType,String codeName) {
		BnuCode c = codeDao.findByCodeTypeAndCodeName(codeType,codeName);
		
		return c!=null?c.getCodeValue():"";
	}

	@Transactional(readOnly = false)
	public void saveCode(BnuCode code) {
		codeDao.save(code);
	}

	@Transactional(readOnly = false)
	public void updateCode(BnuCode code) {
		codeDao.save(code);
	}

	@Transactional(readOnly = false)
	public void deleteCode(Long id) {
		codeDao.delete(id);
	}
}
