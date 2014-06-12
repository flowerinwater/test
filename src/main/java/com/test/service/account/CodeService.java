package com.test.service.account;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.test.entity.Code;
import com.test.entity.CodeType;
import com.test.repository.CodeDao;
import com.test.repository.CodeTypeDao;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class CodeService {

	private static Logger log = LoggerFactory.getLogger(CodeService.class);

	@Autowired
	private CodeDao codeDao;
	@Autowired
	private CodeTypeDao codeTypeDao;

	public List<CodeType> getAllCodeType() {
		List<CodeType> cts = new ArrayList<CodeType>();
		
		Iterator<CodeType> it = codeTypeDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}

	public CodeType getCodeType(Long id) {
		return codeTypeDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveCodeType(CodeType codeType) {
		log.info("111111111111111111");
		codeTypeDao.save(codeType);
	}

	@Transactional(readOnly = false)
	public void updateCodeType(CodeType codeType) {
		codeTypeDao.save(codeType);
	}

	@Transactional(readOnly = false)
	public void deleteCodeType(Long id) {
		codeTypeDao.delete(id);
	}
	
	
	//////////////////////////
	public List<Code> getAllCodeByCodeType(String codeType) {
		return (List<Code>) codeDao.findByCodeType(codeType);
	}

	public Code getCode(Long id) {
		return codeDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveCode(Code code) {
		codeDao.save(code);
	}

	@Transactional(readOnly = false)
	public void updateCode(Code code) {
		codeDao.save(code);
	}

	@Transactional(readOnly = false)
	public void deleteCode(Long id) {
		codeDao.delete(id);
	}
}
