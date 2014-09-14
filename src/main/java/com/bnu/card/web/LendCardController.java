package com.bnu.card.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnu.card.entity.CardInfo;
import com.bnu.card.entity.History;
import com.bnu.card.entity.LendCard;
import com.bnu.card.entity.SysUser;
import com.bnu.card.service.BnuCodeService;
import com.bnu.card.service.CardInfoService;
import com.bnu.card.service.LendCardService;
import com.bnu.card.service.SysUserService;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.util.JsonArrayResult;
import com.bnu.card.util.JsonPageResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.CardInfoForm;
import com.bnu.card.web.form.CardInfoSearchForm;
import com.bnu.card.web.form.HistoryForm;
import com.bnu.card.web.form.LendCardForm;


@Controller
public class LendCardController {
	Logger log = LoggerFactory.getLogger(LendCardController.class);
	
	@Autowired
	private LendCardService lendCardService;
	@Autowired
	private CardInfoService cardInfoService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private BnuCodeService bnuCodeService;
	
    @RequestMapping("/jsonsavelendCard")
    @ResponseBody
	public JsonSimpleResult jsonSaveLendCard(@RequestBody LendCardForm ci){
    	log.info("jsonsavelendCard");
    	JsonSingleOjbectResult<LendCardForm> lr = new JsonSingleOjbectResult<LendCardForm>();
    	
    	try{
    		LendCard bi = new LendCard();
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
    		
    		ci.setId(lendCardService.saveLendCard(bi).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindlendCardbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindLendCardById(@RequestParam(value="id") long id){
    	log.info("jsonfindlendCardbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<LendCardForm> lr = new JsonSingleOjbectResult<LendCardForm>();
    	
    	try{
    		LendCard c = lendCardService.getLendCard(id);
    		LendCardForm ci = new LendCardForm();
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
    
    @RequestMapping("/jsonremovelendCardbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveLendCardById(@RequestParam(value="id") long uid){
    	log.info("jsonremovelendCardbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<LendCardForm> lr = new JsonSingleOjbectResult<LendCardForm>();
    	
    	try{
    		lendCardService.deleteLendCard(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindlendCard")
    @ResponseBody
	public JsonArrayResult<LendCard> jsonFindLendCard(@RequestParam(value="cardId") String cardId){
    	log.info("jsonfindlendCard");
    	
    	JsonArrayResult<LendCard> lr = new JsonArrayResult<LendCard>();
    	
    	try{
    		List<LendCard> as = lendCardService.getAllLendCardByCardId(cardId);
	    	
    		if(as!=null){
    			lr.setResults(new LendCard[as.size()]);
    			
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
    
//    
//    public JsonPageResult<LendCardForm> jsonAlertLendCard(){
//    	log.info("jsonfindlendCard");
//    	
//    	JsonArrayResult<LendCard> lr = new JsonArrayResult<LendCard>();
//    	
//    	try{
//    		List<LendCard> as = lendCardService.getLendCardExpireAlert();
//	    	
//    		if(as!=null){
//    			lr.setResults(new LendCard[as.size()]);
//    			
//    			for (int i = 0; i < as.size(); i++) {
//					lr.getResults()[i] = as.get(i);
//					
//					CardInfoForm bi = new CardInfoForm();
//					BeanUtilEx.copyProperties(bi, cardInfo);
//				}
//    		}
//    		
//	    	lr.setSuccess(true);
//    	}catch(Exception e){
//    		e.printStackTrace();
//    		lr.setSuccess(false);
//    		lr.setMsg(e.getMessage());
//    	}
//
//    	return lr;
//    }
    
    
    @RequestMapping("/jsonalertlendcard4")
	@ResponseBody
	public DataResponse<LendCardForm> jsonFindAllCardInfoPage4(@RequestParam(value="expiredays",required=false) int expiredays,@RequestBody JQGridQueryForm jqFrom
			) {
		log.info("jsonalertlendcard4");
		DataRequest request = new DataRequest();  
        request.setPage(StringUtils.isEmpty(jqFrom.page) ? 1 : Integer.valueOf(jqFrom.page));  
        request.setRows(StringUtils.isEmpty(jqFrom.rows) ? 20 : Integer.valueOf(jqFrom.rows));  
        request.setSidx(jqFrom.sidx);  
        request.setSord(jqFrom.sord);  
        request.setSearch(jqFrom._search);  
        request.setSearchField(jqFrom.searchField);  
        request.setSearchOper(jqFrom.searchOper);  
        request.setSearchString(jqFrom.searchString);  
        
        DataResponse<LendCardForm> lr = new DataResponse<LendCardForm>();
        
        try{
    		Pageable pagerequset = buildPageRequest(request.getPage(), request.getRows(), request.getSord(),request.getSidx());
    		
    		Page<LendCard> as = lendCardService.getLendCardExpireAlert(jqFrom,pagerequset);
//    		List<LendCard> as = lendCardService.getLendCardExpireAlert(expiredays);
    		
    		List<LendCardForm> bis = new ArrayList<LendCardForm>();
    		for (Iterator<LendCard> iterator = as.getContent().iterator(); iterator.hasNext();) {
    			LendCard cardInfo = (LendCard) iterator.next();
    			LendCardForm bi = new LendCardForm();
				BeanUtilEx.copyProperties(bi, cardInfo);
				
				
				
				try{
				CardInfo ci = cardInfoService.getCardInfo(cardInfo.getCardId());
				bi.setName(ci.getName());
				}catch(Exception e){
					
				}
				bi.setPurpose(bnuCodeService.getCodeName(DefaultValue.PURPOSE,bi.getPurpose()));
//				bi.setGender(DefaultValue.transGenderType(bi.getGender()));
//				bi.setStatus(DefaultValue.transStatus(bi.getStatus()));
//				
				bis.add(bi);
			}
    		
    		if(as!=null){
    			lr.setRows(bis);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(as.getTotalPages());
    			lr.setPage(as.getNumber());
    			lr.setRecords(Integer.valueOf(""+as.getTotalElements()));
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
    private Pageable buildPageRequest(int page, int rows,String sortType,String sidx) {
        
		Sort sort = null;
		if (Direction.DESC.equals(sortType.toUpperCase())) {
			sort = new Sort(Direction.DESC, sidx.equals("")?"id":sidx);
		} else if (Direction.ASC.equals(sortType.toUpperCase())) {
			sort = new Sort(Direction.ASC, sidx.equals("")?"id":sidx);
		}
        
		return new PageRequest(page - 1, rows, sort);
	}
    
    @RequestMapping("/jsonalertlendcard")
    @ResponseBody
	public JsonPageResult<LendCardForm> jsonFindAllCardInfoPage(@RequestParam(value="expiredays",required=false) int expiredays,@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page,HttpServletRequest r){
    	log.info("jsonalertlendcard");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<LendCardForm> lr = new JsonPageResult<LendCardForm>();
    	
    	try{
    		
//    		CardInfoSearchForm cisf = new CardInfoSearchForm();
//    		cisf.setS_birthday_low(r.getParameter("s_birthday_low"));
//    		cisf.setS_birthday_top(r.getParameter("s_birthday_top"));
//    		cisf.setS_name(r.getParameter("s_name"));
//    		cisf.setS_address(r.getParameter("s_address"));
//    		cisf.setS_birthPlace(r.getParameter("s_birthPlace"));
//    		cisf.setS_originStudent(r.getParameter("s_originStudent"));
//    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
//    		Page<CardInfo> as = cardInfoService.findAllCardInfo(cisf,pagerequset);
    		List<LendCard> as = lendCardService.getLendCardExpireAlert(expiredays);
    		List<LendCardForm> bis = new ArrayList<LendCardForm>();
//    		for (Iterator<CardInfo> iterator = as.getContent().iterator(); iterator.hasNext();) {
    		for (Iterator<LendCard> iterator = as.iterator(); iterator.hasNext();) {
    			LendCard cardInfo = (LendCard) iterator.next();
    			LendCardForm bi = new LendCardForm();
				BeanUtilEx.copyProperties(bi, cardInfo);
				
				
				
				try{
				CardInfo ci = cardInfoService.getCardInfo(cardInfo.getCardId());
				bi.setName(ci.getName());
				}catch(Exception e){
					
				}
				bi.setPurpose(bnuCodeService.getCodeName(DefaultValue.PURPOSE,bi.getPurpose()));
//				bi.setGender(DefaultValue.transGenderType(bi.getGender()));
//				bi.setStatus(DefaultValue.transStatus(bi.getStatus()));
//				
				bis.add(bi);
			}
//    		Page<CardInfoForm> p = new PageImpl<CardInfoForm>(bis,pagerequset,as.getTotalElements());
    		
    		if(as!=null){
    			lr.setRows(bis);
//    			lr.setTotal(as.getTotalElements());
    			lr.setTotal(as.size());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
}
