package com.test.web.account;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.entity.Code;
import com.test.entity.CodeType;
import com.test.service.account.CodeService;


@Controller
public class CodeController {
	Logger log = LoggerFactory.getLogger(CodeController.class);
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping("/jsonfindallcodetype")
    @ResponseBody
	public JsonPageResult<CodeType> jsonFindAllCodeType(){
    	log.info("jsonfindallcodetype");
    	
    	JsonPageResult<CodeType> lr = new JsonPageResult<CodeType>();
    	
    	try{
    		List<CodeType> ctlist = codeService.getAllCodeType();
    		CodeType[] cts = new CodeType[0];
    		cts = ctlist.toArray(cts);
    		lr.setRows(ctlist);
    		lr.setTotal(cts.length);
	    	
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
	
    @RequestMapping("/jsonaddcodetype")
    @ResponseBody
	public JsonSimpleResult jsonAddCodeType(@RequestBody CodeTypeInfo cti){
    	log.info("jsonaddcodetype");
    	log.info(cti.getTypeName());
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	try{
    		CodeType ct = new CodeType();
    		ct.setId(cti.getId());
    		ct.setTypeName(cti.getTypeName());
    		ct.setTypeValue(cti.getTypeValue());
	    	codeService.saveCodeType(ct);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}
    	return lr;
    }
    
    
    @RequestMapping("/jsonsavecodetype")
    @ResponseBody
	public JsonSimpleResult jsonSaveCodeType(@RequestBody CodeTypeInfo cti){
    	log.info("jsonsavecodetype");
    	
    	JsonSingleOjbectResult<CodeType> lr = new JsonSingleOjbectResult<CodeType>();
    	
    	try{
    		CodeType ct = new CodeType();
    		ct.setId(cti.getId());
    		ct.setTypeName(cti.getTypeName());
    		ct.setTypeValue(cti.getTypeValue());
	    	codeService.saveCodeType(ct);
	    	lr.setObj(ct);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindcodetypebyid")
    @ResponseBody
	public JsonSimpleResult jsonFindCodeTypeById(@RequestParam(value="id") long id){
    	log.info("jsonfindcodetypebyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<CodeType> lr = new JsonSingleOjbectResult<CodeType>();
    	
    	try{
    		CodeType ct = codeService.getCodeType(id);
	    	
	    	lr.setObj(ct);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonremovecodetypebyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveCodeTypeById(@RequestParam(value="id") long id){
    	log.info("jsonremoveuserbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<CodeType> lr = new JsonSingleOjbectResult<CodeType>();
    	
    	try{
    		codeService.deleteCodeType(id);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    //////////////////////////
    @RequestMapping("/jsonfindallcodebytype")
    @ResponseBody
	public JsonPageResult<Code> jsonFindAllCodeByType(@RequestParam(value="codeType") String codeType){
    	log.info("jsonfindallcodebytype");
    	
    	JsonPageResult<Code> lr = new JsonPageResult<Code>();
    	
    	try{
    		List<Code> ctlist = codeService.getAllCodeByCodeType(codeType);
    		lr.setRows(ctlist);
    		lr.setTotal(ctlist.size());
	    	
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonaddcode")
    @ResponseBody
	public JsonSimpleResult jsonAddCode(@RequestBody CodeInfo ci){
    	log.info("jsonaddcode");
    	log.info(ci.getCodeName());
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	
    	try{
    		Code c = new Code();
    		c.setCodeName(ci.getCodeName());
    		c.setCodeType(ci.getCodeType());
    		c.setCodeValue(ci.getCodeValue());
    		
    		codeService.saveCode(c);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonsavecode")
    @ResponseBody
	public JsonSimpleResult jsonSaveCode(@RequestBody CodeInfo ci){
    	log.info("jsonsavecode");
    	
    	JsonSingleOjbectResult<Code> lr = new JsonSingleOjbectResult<Code>();
    	
    	try{
    		Code c = new Code();
    		c.setId(ci.getId());
    		c.setCodeName(ci.getCodeName());
    		c.setCodeType(ci.getCodeType());
    		c.setCodeValue(ci.getCodeValue());
    		
    		codeService.saveCode(c);
	    	
	    	lr.setObj(c);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindcodebyid")
    @ResponseBody
	public JsonSimpleResult jsonFindCodeById(@RequestParam(value="id") long id){
    	log.info("jsonfindcodebyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<Code> lr = new JsonSingleOjbectResult<Code>();
    	
    	try{
    		Code c = codeService.getCode(id);
	    	
	    	lr.setObj(c);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonremovecodebyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveCodeById(@RequestParam(value="id") long id){
    	log.info("jsonremovecodebyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<Code> lr = new JsonSingleOjbectResult<Code>();
    	
    	try{
    		codeService.deleteCode(id);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
}
