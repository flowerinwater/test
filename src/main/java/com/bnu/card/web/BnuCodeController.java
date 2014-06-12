package com.bnu.card.web;


import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnu.card.entity.BnuCode;
import com.bnu.card.entity.BnuCodeType;
import com.bnu.card.service.BnuCodeService;
import com.bnu.card.util.JsonPageResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.CodeForm;
import com.bnu.card.web.form.CodeTypeForm;


@Controller
public class BnuCodeController {
	Logger log = LoggerFactory.getLogger(BnuCodeController.class);
	
	@Autowired
	private BnuCodeService codeService;
	
	@RequestMapping("/jsonbnufindallcodetype")
    @ResponseBody
	public JsonPageResult<BnuCodeType> jsonFindAllCodeType(){
    	log.info("jsonfindallcodetype");
    	
    	JsonPageResult<BnuCodeType> lr = new JsonPageResult<BnuCodeType>();
    	
    	try{
    		List<BnuCodeType> ctlist = codeService.getAllCodeType();
    		BnuCodeType[] cts = new BnuCodeType[0];
    		cts = ctlist.toArray(cts);
    		lr.setRows(ctlist);
    		lr.setTotal(cts.length);
	    	
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
	
    @RequestMapping("/jsonbnuaddcodetype")
    @ResponseBody
	public JsonSimpleResult jsonAddCodeType(@RequestBody CodeTypeForm cti){
    	log.info("jsonaddcodetype");
    	log.info(cti.getTypeName());
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	try{
    		BnuCodeType ct = new BnuCodeType();
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
    
    
    @RequestMapping("/jsonbnusavecodetype")
    @ResponseBody
	public JsonSimpleResult jsonSaveCodeType(@RequestBody CodeTypeForm cti){
    	log.info("jsonsavecodetype");
    	
    	JsonSingleOjbectResult<BnuCodeType> lr = new JsonSingleOjbectResult<BnuCodeType>();
    	
    	try{
    		BnuCodeType ct = new BnuCodeType();
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
    
    
    @RequestMapping("/jsonbnufindcodetypebyid")
    @ResponseBody
	public JsonSimpleResult jsonFindCodeTypeById(@RequestParam(value="id") long id){
    	log.info("jsonfindcodetypebyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<BnuCodeType> lr = new JsonSingleOjbectResult<BnuCodeType>();
    	
    	try{
    		BnuCodeType ct = codeService.getCodeType(id);
	    	
	    	lr.setObj(ct);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonbnuremovecodetypebyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveCodeTypeById(@RequestParam(value="id") long id){
    	log.info("jsonremoveuserbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<BnuCodeType> lr = new JsonSingleOjbectResult<BnuCodeType>();
    	
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
    @RequestMapping("/jsonbnufindallcodebytype")
    @ResponseBody
	public JsonPageResult<BnuCode> jsonFindAllCodeByType(@RequestParam(value="codeType") String codeType){
    	log.info("jsonfindallcodebytype");
    	
    	JsonPageResult<BnuCode> lr = new JsonPageResult<BnuCode>();
    	
    	try{
    		List<BnuCode> ctlist = codeService.getAllCodeByCodeType(codeType);
    		lr.setRows(ctlist);
    		lr.setTotal(ctlist.size());
	    	
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonbnufindallcodebytypeforcombobox")
    @ResponseBody
	public List<BnuCode> jsonFindAllCodeByTypeForComboBox(@RequestParam(value="codeType") String codeType){
    	log.info("jsonbnufindallcodebytypeforcombobox");
    	
    	List<BnuCode> ctlist = new ArrayList<BnuCode>();
    	
    	try{
    		ctlist = codeService.getAllCodeByCodeType(codeType);
	    	
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return ctlist;
    }
    
    @RequestMapping("/jsonbnuaddcode")
    @ResponseBody
	public JsonSimpleResult jsonAddCode(@RequestBody CodeForm ci){
    	log.info("jsonaddcode");
    	log.info(ci.getCodeName());
    	
    	JsonSimpleResult lr = new JsonSimpleResult();
    	
    	try{
    		BnuCode c = new BnuCode();
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
    
    
    @RequestMapping("/jsonbnusavecode")
    @ResponseBody
	public JsonSimpleResult jsonSaveCode(@RequestBody CodeForm ci){
    	log.info("jsonsavecode");
    	
    	JsonSingleOjbectResult<BnuCode> lr = new JsonSingleOjbectResult<BnuCode>();
    	
    	try{
    		BnuCode c = new BnuCode();
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
    
    
    @RequestMapping("/jsonbnufindcodebyid")
    @ResponseBody
	public JsonSimpleResult jsonFindCodeById(@RequestParam(value="id") long id){
    	log.info("jsonfindcodebyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<BnuCode> lr = new JsonSingleOjbectResult<BnuCode>();
    	
    	try{
    		BnuCode c = codeService.getCode(id);
	    	
	    	lr.setObj(c);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonbnuremovecodebyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveCodeById(@RequestParam(value="id") long id){
    	log.info("jsonremovecodebyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<BnuCode> lr = new JsonSingleOjbectResult<BnuCode>();
    	
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
