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

import com.bnu.card.entity.MigrateCard;
import com.bnu.card.entity.SysUser;
import com.bnu.card.service.MigrateCardService;
import com.bnu.card.service.SysUserService;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.util.JsonArrayResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.MigrateCardForm;


@Controller
public class MigrateCardController {
	Logger log = LoggerFactory.getLogger(MigrateCardController.class);
	
	@Autowired
	private MigrateCardService migrateCardService;
	@Autowired
	private SysUserService sysUserService;
    
    @RequestMapping("/jsonsavemigrateCard")
    @ResponseBody
	public JsonSimpleResult jsonSaveMigrateCard(@RequestBody MigrateCardForm ci){
    	log.info("jsonsavemigrateCard");
    	JsonSingleOjbectResult<MigrateCardForm> lr = new JsonSingleOjbectResult<MigrateCardForm>();
    	
    	try{
    		MigrateCard bi = new MigrateCard();
    		BeanUtilEx.copyProperties(bi, ci);
    		
    		
    		String currUserName = DefaultValue.getCurrentUserName();
    		System.out.println("currUserName:" + currUserName);
    		Long currUserId = -1l;;
    		SysUser cu = sysUserService.findOneSysUserByLoginName(currUserName);
    		if(cu != null)
    			currUserId = cu.getId();
			Date currDate = new Date();
			
			if(ci.getId()!=null && ci.getId().longValue()!=0l){
    			bi.setUpdaterDate(currDate);
    			bi.setUpdaterId(currUserId);
    			bi.setUpdaterName(currUserName);
    		}else{
    			bi.setCreateDate(currDate);
    			bi.setCreatorId(currUserId);
    			bi.setCreatorName(currUserName);
    		}
    		
	    	ci.setId(migrateCardService.saveMigrateCard(bi).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindmigrateCardbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindMigrateCardById(@RequestParam(value="id") long id){
    	log.info("jsonfindmigrateCardbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<MigrateCardForm> lr = new JsonSingleOjbectResult<MigrateCardForm>();
    	
    	try{
    		MigrateCard c = migrateCardService.getMigrateCard(id);
    		MigrateCardForm ci = new MigrateCardForm();
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
    
    @RequestMapping("/jsonremovemigrateCardbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveMigrateCardById(@RequestParam(value="id") long uid){
    	log.info("jsonremovemigrateCardbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<MigrateCardForm> lr = new JsonSingleOjbectResult<MigrateCardForm>();
    	
    	try{
    		migrateCardService.deleteMigrateCard(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindmigrateCard")
    @ResponseBody
	public JsonArrayResult<MigrateCard> jsonFindMigrateCard(@RequestParam(value="cardId") String cardId){
    	log.info("jsonfindmigrateCard");
    	
    	JsonArrayResult<MigrateCard> lr = new JsonArrayResult<MigrateCard>();
    	
    	try{
    		List<MigrateCard> as = migrateCardService.getAllMigrateCardByCardId(cardId);
	    	
    		if(as!=null){
    			lr.setResults(new MigrateCard[as.size()]);
    			
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
