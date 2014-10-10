package com.bnu.card.web;

import java.util.ArrayList;
import java.util.Enumeration;
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

import com.bnu.card.entity.History;
import com.bnu.card.entity.SysUser;
import com.bnu.card.service.BnuCodeService;
import com.bnu.card.service.HistoryService;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.util.JsonArrayResult;
import com.bnu.card.util.JsonPageResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.HistoryForm;
import com.bnu.card.web.form.HistorySearchForm;
import com.bnu.card.web.form.SysUserForm;


@Controller
public class HistoryController {
	Logger log = LoggerFactory.getLogger(HistoryController.class);
	
	@Autowired
	private HistoryService historyService;
	@Autowired
	private BnuCodeService bnuCodeService;
    
    
    @RequestMapping("/jsonfindhistorybyid")
    @ResponseBody
	public JsonSimpleResult jsonFindHistoryById(@RequestParam(value="id") long id){
    	log.info("jsonfindhistorybyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<HistoryForm> lr = new JsonSingleOjbectResult<HistoryForm>();
    	
    	try{
    		History c = historyService.getHistory(id);
    		HistoryForm ci = new HistoryForm();
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
    
    
    
    @RequestMapping("/jsonfindhistory")
    @ResponseBody
	public JsonArrayResult<History> jsonFindHistory(){
    	log.info("jsonfindhistory");
    	
    	JsonArrayResult<History> lr = new JsonArrayResult<History>();
    	
    	try{
    		List<History> as = historyService.getAllHistory();
	    	
    		if(as!=null){
    			lr.setResults(new History[as.size()]);
    			
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
    
    @RequestMapping("/jsonfindallhistorypage4")
	@ResponseBody
	public DataResponse<HistoryForm> jsonFindAllHistoryPage4(@RequestBody JQGridQueryForm jqFrom
			) {
		log.info("jsonfindallhistorypage4");
		DataRequest request = new DataRequest();  
        request.setPage(StringUtils.isEmpty(jqFrom.page) ? 1 : Integer.valueOf(jqFrom.page));  
        request.setRows(StringUtils.isEmpty(jqFrom.rows) ? 20 : Integer.valueOf(jqFrom.rows));  
        request.setSidx(jqFrom.sidx);  
        request.setSord(jqFrom.sord);  
        request.setSearch(jqFrom._search);  
        request.setSearchField(jqFrom.searchField);  
        request.setSearchOper(jqFrom.searchOper);  
        request.setSearchString(jqFrom.searchString);  
        
        DataResponse<HistoryForm> lr = new DataResponse<HistoryForm>();
        
        try{
    		Pageable pagerequset = buildPageRequest(request.getPage(), request.getRows(), request.getSord(),request.getSidx());
    		
    		Page<History> as = historyService.findAllHistory(jqFrom,pagerequset);
    		
    		List<HistoryForm> bis = new ArrayList<HistoryForm>();
    		for (Iterator<History> iterator = as.getContent().iterator(); iterator.hasNext();) {
				History history = (History) iterator.next();
				HistoryForm bi = new HistoryForm();
				BeanUtilEx.copyProperties(bi, history);
				
				bi.setOperateType(bnuCodeService.getCodeName(DefaultValue.OPERATE_TYPE,bi.getOperateType()));
				bi.setCardType(bnuCodeService.getCodeName(DefaultValue.CARD_TYPE4HISTORY,bi.getCardType()));
				 
				bis.add(bi);
			}
    		
    		if(as!=null){
    			lr.setRows(bis);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(as.getTotalPages());
    			lr.setPage(as.getNumber()+1);
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

    @RequestMapping("/jsonfindallhistorypage")
    @ResponseBody
	public JsonPageResult<HistoryForm> jsonFindAllHistoryPage(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page,HttpServletRequest r){
    	log.info("jsonfindallhistorypage");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<HistoryForm> lr = new JsonPageResult<HistoryForm>();
//    	Enumeration<String> e1 = r.getParameterNames();
//    	while(e1.hasMoreElements()){
//    		String pn = e1.nextElement();
//    		String pv = r.getParameter(pn);
//    		System.out.println(pn + ":" + pv);
//    	}
    	try{
    		
    		HistorySearchForm cisf = new HistorySearchForm();
    		cisf.setS_operateDate_low(r.getParameter("s_operateDate_low"));
    		cisf.setS_operateDate_top(r.getParameter("s_operateDate_top"));
    		cisf.setS_operatorName(r.getParameter("s_operatorName"));
    		cisf.setS_name(r.getParameter("s_name"));
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<History> as = historyService.findAllHistory(cisf,pagerequset);
    		List<HistoryForm> bis = new ArrayList<HistoryForm>();
    		for (Iterator<History> iterator = as.getContent().iterator(); iterator.hasNext();) {
				History history = (History) iterator.next();
				HistoryForm bi = new HistoryForm();
				BeanUtilEx.copyProperties(bi, history);
				
				bi.setOperateType(bnuCodeService.getCodeName(DefaultValue.OPERATE_TYPE,bi.getOperateType()));
				bi.setCardType(bnuCodeService.getCodeName(DefaultValue.CARD_TYPE4HISTORY,bi.getCardType()));
				 
				bis.add(bi);
			}
//    		Page<HistoryForm> p = new PageImpl<HistoryForm>(bis,pagerequset,as.getTotalElements());
    		
    		if(as!=null){
    			lr.setRows(bis);
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
}
