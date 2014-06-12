package com.bnu.card.web;

import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnu.card.entity.ReturnCard;
import com.bnu.card.entity.SysUser;
import com.bnu.card.service.ReturnCardService;
import com.bnu.card.service.SysUserService;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.util.JsonArrayResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.ReturnCardForm;


@Controller
public class ReturnCardController {
	Logger log = LoggerFactory.getLogger(ReturnCardController.class);
	
	@Autowired
	private ReturnCardService returnCardService;
	@Autowired
	private SysUserService sysUserService;
    
    @RequestMapping("/jsonsavereturnCard")
    @ResponseBody
	public JsonSimpleResult jsonSaveReturnCard(@RequestBody ReturnCardForm ci){
    	log.info("jsonsavereturnCard");
    	JsonSingleOjbectResult<ReturnCardForm> lr = new JsonSingleOjbectResult<ReturnCardForm>();
    	
    	try{
    		ReturnCard bi = new ReturnCard();
    		BeanUtilEx.copyProperties(bi, ci);
    		
    		String currUserName = DefaultValue.getCurrentUserName();
    		System.out.println("currUserName:" + currUserName);
    		Long currUserId = -1l;;
    		SysUser cu = sysUserService.findOneSysUserByLoginName(currUserName);
    		if(cu != null)
    			currUserId = cu.getId();
			Date currDate = new Date();
			
			if(ci.getId()!=null && ci.getId().longValue()!=0l){
    			bi.setUpdateDate(currDate);
    			bi.setUpdaterId(currUserId);
    			bi.setUpdaterName(currUserName);
    		}else{
    			bi.setCreateDate(currDate);
    			bi.setCreatorId(currUserId);
    			bi.setCreatorName(currUserName);
    		}
    		
    		
	    	ci.setId(returnCardService.saveReturnCard(bi).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindreturnCardbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindReturnCardById(@RequestParam(value="id") long id){
    	log.info("jsonfindreturnCardbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<ReturnCardForm> lr = new JsonSingleOjbectResult<ReturnCardForm>();
    	
    	try{
    		ReturnCard c = returnCardService.getReturnCard(id);
    		ReturnCardForm ci = new ReturnCardForm();
    		BeanUtilEx.copyProperties(ci, c);
    		
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonremovereturnCardbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveReturnCardById(@RequestParam(value="id") long uid){
    	log.info("jsonremovereturnCardbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<ReturnCardForm> lr = new JsonSingleOjbectResult<ReturnCardForm>();
    	
    	try{
    		returnCardService.deleteReturnCard(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindreturnCard")
    @ResponseBody
	public JsonArrayResult<ReturnCard> jsonFindReturnCard(@RequestParam(value="cardId") String cardId){
    	log.info("jsonfindreturnCard");
    	
    	JsonArrayResult<ReturnCard> lr = new JsonArrayResult<ReturnCard>();
    	
    	try{
    		List<ReturnCard> as = returnCardService.getAllReturnCardByCardId(cardId);
	    	
    		if(as!=null){
    			lr.setResults(new ReturnCard[as.size()]);
    			
    			for (int i = 0; i < as.size(); i++) {
					lr.getResults()[i] = as.get(i);
				}
    		}
    		
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
}
