package com.bnu.card.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.LongConverter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bnu.card.entity.CardInfo;
import com.bnu.card.entity.SysUser;
import com.bnu.card.service.BnuCodeService;
import com.bnu.card.service.CardInfoService;
import com.bnu.card.service.SysUserService;
import com.bnu.card.util.BeanUtilEx;
import com.bnu.card.util.DefaultValue;
import com.bnu.card.util.ExcelUtil;
import com.bnu.card.util.Fruit;
import com.bnu.card.util.JsonArrayResult;
import com.bnu.card.util.JsonPageResult;
import com.bnu.card.util.JsonSimpleResult;
import com.bnu.card.util.JsonSingleOjbectResult;
import com.bnu.card.web.form.CardInfoForm;
import com.bnu.card.web.form.CardInfoSearchForm;
import com.bnu.card.web.form.CardInfoXlsVo;
import com.bnu.card.web.form.StudentReportForm;
import com.bnu.card.web.form.SysUserForm;
import com.bnu.card.web.form.SysUserSearchForm;
import com.bnu.card.web.form.TeacherAgeReportForm;
import com.test.service.account.CodeService;

@Controller
public class CardInfoController {
	Logger log = LoggerFactory.getLogger(CardInfoController.class);

	@Autowired
	private CardInfoService cardInfoService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private BnuCodeService bnuCodeService;

	@RequestMapping("/jsonsavecardInfo")
	@ResponseBody
	public JsonSimpleResult jsonSaveCardInfo(@RequestBody CardInfoForm ci) {
		log.info("jsonsavecardInfo");
		JsonSingleOjbectResult<CardInfoForm> lr = new JsonSingleOjbectResult<CardInfoForm>();

		try {
			CardInfo bi = new CardInfo();
			BeanUtilEx.copyProperties(bi, ci);

			String currUserName = DefaultValue.getCurrentUserName();
			System.out.println("currUserName:" + currUserName);
			Long currUserId = -1l;
			;
			SysUser cu = sysUserService.findOneSysUserByLoginName(currUserName);
			if (cu != null)
				currUserId = cu.getId();
			Date currDate = new Date();

			if (ci.getId() != null && ci.getId().longValue() != 0l) {
				bi.setUpdaterDate(currDate);
				bi.setUpdaterId(currUserId);
				bi.setUpdaterName(currUserName);
			} else {
				bi.setCreateDate(currDate);
				bi.setCreatorId(currUserId);
				bi.setCreatorName(currUserName);
			}
			ci.setId(cardInfoService.saveCardInfo(bi).getId());

			lr.setObj(ci);
			lr.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			lr.setSuccess(false);
			lr.setMsg(e.getMessage());
		}

		return lr;
	}

	@RequestMapping("/jsonfindcardInfobyid")
	@ResponseBody
	public JsonSimpleResult jsonFindCardInfoById(
			@RequestParam(value = "id") long id) {
		log.info("jsonfindcardInfobyid");
		log.info("" + id);

		JsonSingleOjbectResult<CardInfoForm> lr = new JsonSingleOjbectResult<CardInfoForm>();

		try {
			CardInfo c = cardInfoService.getCardInfo(id);
			CardInfoForm ci = new CardInfoForm();
			BeanUtilEx.copyProperties(ci, c);

			lr.setObj(ci);
			lr.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			lr.setSuccess(false);
			lr.setMsg(e.getMessage());
		}

		return lr;
	}

	@RequestMapping("/jsonremovecardInfobyid")
	@ResponseBody
	public JsonSimpleResult jsonRemoveCardInfoById(
			@RequestParam(value = "id") long uid) {
		log.info("jsonremovecardInfobyid");
		log.info("" + uid);

		JsonSingleOjbectResult<CardInfoForm> lr = new JsonSingleOjbectResult<CardInfoForm>();

		try {
			String currUserName = DefaultValue.getCurrentUserName();
			System.out.println("currUserName:" + currUserName);
			Long currUserId = -1l;
			;
			SysUser cu = sysUserService.findOneSysUserByLoginName(currUserName);
			if (cu != null)
				currUserId = cu.getId();
			Date currDate = new Date();

			cardInfoService.deleteCardInfo(uid, currUserName, currUserId,
					currDate);

			lr.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			lr.setSuccess(false);
			lr.setMsg(e.getMessage());
		}

		return lr;
	}

	@RequestMapping("/jsonfindcardInfo")
	@ResponseBody
	public JsonArrayResult<CardInfo> jsonFindCardInfo() {
		log.info("jsonfindcardInfo");

		JsonArrayResult<CardInfo> lr = new JsonArrayResult<CardInfo>();

		try {
			List<CardInfo> as = cardInfoService.getAllCardInfo();

			if (as != null) {
				lr.setResults(new CardInfo[as.size()]);

				for (int i = 0; i < as.size(); i++) {
					lr.getResults()[i] = as.get(i);
				}
			}

			lr.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			lr.setSuccess(false);
			lr.setMsg(e.getMessage());
		}

		return lr;
	}

	@RequestMapping("/jsonfindallcardInfopage")
	@ResponseBody
	public JsonPageResult<CardInfoForm> jsonFindAllCardInfoPage(
			@RequestParam(value = "rows", required = false) int rows,
			@RequestParam(value = "page", required = false) int page,
			HttpServletRequest r) {
		log.info("jsonfindallcardInfopage");
		log.info("rows:" + rows);// rows per page
		log.info("page:" + page);// curr page

		JsonPageResult<CardInfoForm> lr = new JsonPageResult<CardInfoForm>();

		try {

			CardInfoSearchForm cisf = new CardInfoSearchForm();
			cisf.setS_birthday_low(r.getParameter("s_birthday_low"));
			cisf.setS_birthday_top(r.getParameter("s_birthday_top"));
			cisf.setS_name(r.getParameter("s_name"));
			cisf.setS_address(r.getParameter("s_address"));
			cisf.setS_birthPlace(r.getParameter("s_birthPlace"));
			cisf.setS_originStudent(r.getParameter("s_originStudent"));
			PageRequest pagerequset = new PageRequest(--page, rows, new Sort(
					new Sort.Order(Sort.Direction.DESC, "id")));
			Page<CardInfo> as = cardInfoService.findAllCardInfo(cisf,
					pagerequset);
			List<CardInfoForm> bis = new ArrayList<CardInfoForm>();
			for (Iterator<CardInfo> iterator = as.getContent().iterator(); iterator
					.hasNext();) {
				CardInfo cardInfo = (CardInfo) iterator.next();
				CardInfoForm bi = new CardInfoForm();
				BeanUtilEx.copyProperties(bi, cardInfo);

				// bi.setCardType(DefaultValue.transCardOwnerType(bi.getCardType()));
				// bi.setGender(DefaultValue.transGenderType(bi.getGender()));
				// bi.setStatus(DefaultValue.transStatus(bi.getStatus()));

				bis.add(bi);
			}
			// Page<CardInfoForm> p = new
			// PageImpl<CardInfoForm>(bis,pagerequset,as.getTotalElements());

			if (as != null) {
				lr.setRows(bis);
				lr.setTotal(as.getTotalElements());

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}
	
	
//	@RequestMapping("/jsonFindByDetainedGradeGroup14")
//	@ResponseBody
//	public DataResponse<Map<String,Object>> jsonFindByDetainedGradeGroup14(HttpServletRequest req
//			) {
//		log.info("jsonFindByDetainedGradeGroup14");
//		
//		String academe = req.getParameter("academa");
//		if (academe == null)
//			academe = "%";
//        
//        DataResponse<Map<String,Object>> lr = new DataResponse<Map<String,Object>>();
//        
//        try{
//        	List<Map<String,Object>> v = new ArrayList<Map<String,Object>>();
//        	List lendAs = cardInfoService.findByDetainedGradeGroup1(academe);
//        	for (Iterator iterator = lendAs.iterator(); iterator.hasNext();) {
//        		Object[] object = (Object[]) iterator.next();
//        		
//        		Map<String,Object> m = new HashMap<String,Object>();
//        		m.put("groupname",object[0]);
//        		m.put("count1",object[1]);
//        		
//        		v.add(m);
//        	}
//        	lr.setRows(v);
//
//			lr.setTotal(v.size());
//    	}catch(Exception e){
//    		e.printStackTrace();
//    	}
//        
//		return lr;
//	}
	
//	@RequestMapping("/jsonfindByLendExpireGradeGroup4")
//	@ResponseBody
//	public DataResponse<Map<String,Object>> jsonFindByLendExpireGradeGroup4(HttpServletRequest req
//			) {
//		log.info("jsonfindByLendExpireGradeGroup4");
//		
//		int expiredays = 10;
//        
//        DataResponse<Map<String,Object>> lr = new DataResponse<Map<String,Object>>();
//        
//        try{
//        	List<Map<String,Object>> v = new ArrayList<Map<String,Object>>();
//        	List lendAs = cardInfoService.findByLendExpireGradeGroup(expiredays);
//        	for (Iterator iterator = lendAs.iterator(); iterator.hasNext();) {
//        		Object[] object = (Object[]) iterator.next();
//        		
//        		Map<String,Object> m = new HashMap<String,Object>();
//        		m.put("year",object[0]);
//        		m.put("count1",object[1]);
//        		
//        		v.add(m);
//        	}
//        	lr.setRows(v);
//
//			lr.setTotal(v.size());
//    	}catch(Exception e){
//    		e.printStackTrace();
//    	}
//        
//		return lr;
//	}
	
	
	@RequestMapping("/jsonlendreturn4")
	@ResponseBody
	public DataResponse<Map<String,Object>> jsonLendReturnReport4(HttpServletRequest req
			) {
		log.info("jsonlendreturn4");
        
        DataResponse<Map<String,Object>> lr = new DataResponse<Map<String,Object>>();
        
        try{
        	List<Map<String,Object>> v = new ArrayList<Map<String,Object>>();
        	List lendAs = cardInfoService.jsonLendReport();
        	List returnAs = cardInfoService.jsonReturnReport();
        	for (Iterator iterator = lendAs.iterator(); iterator.hasNext();) {
        		Object[] object = (Object[]) iterator.next();
        		
        		Map<String,Object> m = new HashMap<String,Object>();
        		m.put("year",object[0]);
        		m.put("lend",object[1]);
        		
        		for (Iterator iterator1 = returnAs.iterator(); iterator1.hasNext();) {
        			Object[] object1 = (Object[]) iterator1.next();
        			
        			if(object1[0].toString().equals(object[0].toString())){
        				m.put("return",object1[1]);
        				break;
        			}
        		}
        		v.add(m);
        	}
        	lr.setRows(v);

			lr.setTotal(v.size());
    	}catch(Exception e){
    		e.printStackTrace();
    	}
        
		return lr;
	}
	
	
	@RequestMapping("/jsoncardtyperp4")
	@ResponseBody
	public DataResponse<StudentReportForm> jsonCardTypeReport4(HttpServletRequest req
			) {
		log.info("jsoncardtyperp4");
        
        DataResponse<StudentReportForm> lr = new DataResponse<StudentReportForm>();
        
        try{
			List as = cardInfoService.jsonCardTypeReport();
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			Iterator it = as.iterator();
			while (it.hasNext()) {
				Object[] r = (Object[]) it.next();
				StudentReportForm f = new StudentReportForm();
				f.setGroupName((String) r[0]);
				f.setSummale((BigDecimal) r[1]);
				f.setSumfemale((BigDecimal) r[2]);
				f.setSumall((BigDecimal) r[3]);

				v.add(f);
			}
    		
    		
    		if(as!=null){
    			lr.setRows(v);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(1);
    			lr.setPage(1);
    			lr.setRecords(v.size());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
	
	@RequestMapping("/jsonccademerp4")
	@ResponseBody
	public DataResponse<StudentReportForm> jsonAcademeReport4(HttpServletRequest req
			) {
		log.info("jsonccademerp4");
        
        DataResponse<StudentReportForm> lr = new DataResponse<StudentReportForm>();
        
        try{
        	
			List as = cardInfoService.jsonAcademeReport();
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);
    		
//    		Page<SysUser> as = cardInfoService.findAllSysUser(jqFrom,pagerequset);
    		
//    		Page<SysUser> as = new PageImpl(as, pagerequset, as.size());
    		
    		
    		if(as!=null){
    			lr.setRows(v);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(1);
    			lr.setPage(1);
    			lr.setRecords(v.size());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
	
	@RequestMapping("/jsonoriginrp4")
	@ResponseBody
	public DataResponse<StudentReportForm> jsonOriginReport4(HttpServletRequest req
			) {
		log.info("jsonoriginrp4");
        
        DataResponse<StudentReportForm> lr = new DataResponse<StudentReportForm>();
        
        try{
        	
    		String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List as = cardInfoService.jsonOriginReport(academe);
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);
    		
//    		Page<SysUser> as = cardInfoService.findAllSysUser(jqFrom,pagerequset);
    		
//    		Page<SysUser> as = new PageImpl(as, pagerequset, as.size());
    		
    		
    		if(as!=null){
    			lr.setRows(v);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(1);
    			lr.setPage(1);
    			lr.setRecords(v.size());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
	
	
	@RequestMapping("/jsongraderp4")
	@ResponseBody
	public DataResponse<StudentReportForm> jsonGradeReport4(HttpServletRequest req
			) {
		log.info("jsongraderp4");
        
        DataResponse<StudentReportForm> lr = new DataResponse<StudentReportForm>();
        
        try{
        	
    		String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List as = cardInfoService.jsonGradeReport(academe);
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);
    		
//    		Page<SysUser> as = cardInfoService.findAllSysUser(jqFrom,pagerequset);
    		
//    		Page<SysUser> as = new PageImpl(as, pagerequset, as.size());
    		
    		
    		if(as!=null){
    			lr.setRows(v);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(1);
    			lr.setPage(1);
    			lr.setRecords(v.size());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
	
	@RequestMapping("/jsondetainedrp4")
	@ResponseBody
	public DataResponse<StudentReportForm> jsonDetainedReport4(HttpServletRequest req
			) {
		log.info("jsondetainedrp4");
        
        DataResponse<StudentReportForm> lr = new DataResponse<StudentReportForm>();
        
        try{
        	
    		String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List as = cardInfoService.jsonDetainedReport(academe);
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);
    		
//    		Page<SysUser> as = cardInfoService.findAllSysUser(jqFrom,pagerequset);
    		
//    		Page<SysUser> as = new PageImpl(as, pagerequset, as.size());
    		
    		
    		if(as!=null){
    			lr.setRows(v);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(1);
    			lr.setPage(1);
    			lr.setRecords(v.size());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
	
	
	@RequestMapping("/jsongendernationrp4")
	@ResponseBody
	public DataResponse<StudentReportForm> jsonGenderNationReport4(HttpServletRequest req
			) {
		log.info("jsongendernationrp4");
        
        DataResponse<StudentReportForm> lr = new DataResponse<StudentReportForm>();
        
        try{
    		String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			List as = cardInfoService.jsonGenderNationReport(academe);
			getList(v, as);
    		
//    		Page<SysUser> as = cardInfoService.findAllSysUser(jqFrom,pagerequset);
    		
//    		Page<SysUser> as = new PageImpl(as, pagerequset, as.size());
    		
    		
    		if(as!=null){
    			lr.setRows(v);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(1);
    			lr.setPage(1);
    			lr.setRecords(v.size());
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}

        
		return lr;
	}
	
	@RequestMapping("/jsonfindallcardInfopage4")
	@ResponseBody
	public DataResponse<CardInfoForm> jsonFindAllCardInfoPage4(@RequestBody JQGridQueryForm jqFrom) {
		log.info("jsonfindallcardInfopage4");

		
		DataRequest request = new DataRequest();  
        request.setPage(StringUtils.isEmpty(jqFrom.page) ? 1 : Integer.valueOf(jqFrom.page));  
        request.setRows(StringUtils.isEmpty(jqFrom.rows) ? 20 : Integer.valueOf(jqFrom.rows));  
        request.setSidx(jqFrom.sidx);  
        request.setSord(jqFrom.sord);  
        request.setSearch(jqFrom._search);  
        request.setSearchField(jqFrom.searchField);  
        request.setSearchOper(jqFrom.searchOper);  
        request.setSearchString(jqFrom.searchString);  
		
        
        DataResponse<CardInfoForm> lr = new DataResponse<CardInfoForm>();
        
		try {
			Pageable pagerequset = buildPageRequest(request.getPage(), request.getRows(), request.getSord(),request.getSidx());
    		Page<CardInfo> as = cardInfoService.findAllCardInfo(jqFrom,pagerequset);
    		List<CardInfoForm> bis = new ArrayList<CardInfoForm>();
    		
    		getAllCardInfo(bis,as.getContent());
    		
//    		for (Iterator<CardInfo> iterator = as.getContent().iterator(); iterator.hasNext();) {
//    			CardInfo cardInfo = (CardInfo) iterator.next();
//				CardInfoForm bi = new CardInfoForm();
//				BeanUtilEx.copyProperties(bi, cardInfo);
//				bis.add(bi);
//			}
    		
    		if(as!=null){
    			lr.setRows(bis);
//    			lr.setTotal(as.getTotalElements());
    			
    			lr.setTotal(as.getTotalPages());
    			lr.setPage(as.getNumber());
    			lr.setRecords(Integer.valueOf(""+as.getTotalElements()));
    		}
		} catch (Exception e) {
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
	
	// 民族
	@RequestMapping("/jsongendernationrp")
	@ResponseBody
	public JsonPageResult<StudentReportForm> jsonGenderNationReport(
			HttpServletRequest req) {
		log.info("jsongendernationrp");

		JsonPageResult<StudentReportForm> lr = new JsonPageResult<StudentReportForm>();

		try {
			String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			List as = cardInfoService.jsonGenderNationReport(academe);
			getList(v, as);

			if (as != null) {
				lr.setRows(v);
			}

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}

	// 滞留
	@RequestMapping("/jsondetainedrp")
	@ResponseBody
	public JsonPageResult<StudentReportForm> jsonDetainedReport(
			HttpServletRequest req) {
		log.info("jsondetainedrp");

		JsonPageResult<StudentReportForm> lr = new JsonPageResult<StudentReportForm>();

		try {
			String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List as = cardInfoService.jsonDetainedReport(academe);
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);

			if (as != null) {
				lr.setRows(v);
			}

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}

	// grade
	@RequestMapping("/jsongraderp")
	@ResponseBody
	public JsonPageResult<StudentReportForm> jsonGradeReport(
			HttpServletRequest req) {

		JsonPageResult<StudentReportForm> lr = new JsonPageResult<StudentReportForm>();

		try {
			String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List as = cardInfoService.jsonGradeReport(academe);
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);

			if (as != null) {
				lr.setRows(v);
			}

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}

	// origin
	@RequestMapping("/jsonoriginrp")
	@ResponseBody
	public JsonPageResult<StudentReportForm> jsonOriginReport(
			HttpServletRequest req) {
		log.info("jsonoriginrp");

		JsonPageResult<StudentReportForm> lr = new JsonPageResult<StudentReportForm>();

		try {
			String academe = req.getParameter("academa");
			if (academe == null)
				academe = "%";

			List as = cardInfoService.jsonOriginReport(academe);
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);

			if (as != null) {
				lr.setRows(v);
			}

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}

	// ////////////////////////////
	// origin
	@RequestMapping("/jsoncardtyperp")
	@ResponseBody
	public JsonPageResult<StudentReportForm> jsonCardTypeReport() {
		log.info("jsoncardtyperp");

		JsonPageResult<StudentReportForm> lr = new JsonPageResult<StudentReportForm>();

		try {
			List as = cardInfoService.jsonCardTypeReport();
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			Iterator it = as.iterator();
			while (it.hasNext()) {
				Object[] r = (Object[]) it.next();
				StudentReportForm f = new StudentReportForm();
				f.setGroupName((String) r[0]);
				f.setSummale((BigDecimal) r[1]);
				f.setSumfemale((BigDecimal) r[2]);
				f.setSumall((BigDecimal) r[3]);

				v.add(f);
			}

			if (as != null) {
				lr.setRows(v);
			}

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}
	
	@RequestMapping("/jsonlendreturn")
	@ResponseBody
	public JsonPageResult<Map<String,Object>> jsonLendReturnReport() {
		log.info("jsoncardtyperp");

		JsonPageResult<Map<String,Object>> lr = new JsonPageResult<Map<String,Object>>();

		try {

			List<Map<String,Object>> v = new ArrayList<Map<String,Object>>();
			List lendAs = cardInfoService.jsonLendReport();
			List returnAs = cardInfoService.jsonReturnReport();
			for (Iterator iterator = lendAs.iterator(); iterator.hasNext();) {
				Object[] object = (Object[]) iterator.next();
				
				Map<String,Object> m = new HashMap<String,Object>();
				m.put("year",object[0]);
				m.put("lend",object[1]);
				
				for (Iterator iterator1 = returnAs.iterator(); iterator1.hasNext();) {
					Object[] object1 = (Object[]) iterator1.next();
					
					if(object1[0].toString().equals(object[0].toString())){
						m.put("return",object1[1]);
						break;
					}
				}
				v.add(m);
			}

			lr.setRows(v);

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}

	// origin
	@RequestMapping("/jsonccademerp")
	@ResponseBody
	public JsonPageResult<StudentReportForm> jsonAcademeReport() {
		log.info("jsonccademerp");

		JsonPageResult<StudentReportForm> lr = new JsonPageResult<StudentReportForm>();

		try {
			List as = cardInfoService.jsonAcademeReport();
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			getList(v, as);

			if (as != null) {
				lr.setRows(v);
			}

			lr.setTotal(v.size());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lr;
	}

	@RequestMapping("exportExcel")
	public void exportExcel(@RequestParam(value = "type") String type,HttpServletRequest request,
			HttpServletResponse response) {
		// 生成提示信息，
		String academe = request.getParameter("academa");
		if (academe == null)
			academe = "%";

		String tempalteCtxPath=request.getSession().getServletContext().getRealPath("/")+File.separator+"template";   
		String downloadCtxPath=request.getSession().getServletContext().getRealPath("/")+File.separator+"download";   
		
		
		ExcelUtil eu = new ExcelUtil();
		Calendar c = Calendar.getInstance();
		String fileName ="stu_nation_out" + c.getTimeInMillis();
		String outFilePath = downloadCtxPath + File.separator + fileName + ".xls";
		
		
		List as = new ArrayList();
		String template = tempalteCtxPath  + File.separator + "stu_nation.xls";
		if(type.equalsIgnoreCase("GenderNation")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonGenderNationReport(academe);
			getList(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("Detained")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonDetainedReport(academe);
			getList(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("Grade")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonGradeReport(academe);
			getList(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("Origin")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonOriginReport(academe);
			getList(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("Job")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonCardTypeReport();
			getList(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("Academe")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonAcademeReport();
			getList(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("Family")){
			List<StudentReportForm> v = new ArrayList<StudentReportForm>();
			as = cardInfoService.jsonCardTypeReport();
			template = tempalteCtxPath  + File.separator + "teacher_family.xls";
			getList4Family(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("LendReturn")){
			List<Map<String,Object>> v = new ArrayList<Map<String,Object>>();
			List lendAs = cardInfoService.jsonLendReport();
			List returnAs = cardInfoService.jsonReturnReport();
			for (Iterator iterator = lendAs.iterator(); iterator.hasNext();) {
				Object[] object = (Object[]) iterator.next();
				
				Map<String,Object> m = new HashMap<String,Object>();
				m.put("year",object[0]);
				m.put("lend",object[1]);
				
				for (Iterator iterator1 = returnAs.iterator(); iterator1.hasNext();) {
					Object[] object1 = (Object[]) iterator1.next();
					
					if(object1[0].toString().equals(object[0].toString())){
						m.put("return",object1[1]);
						break;
					}
				}
				v.add(m);
			}
			
			template = tempalteCtxPath  + File.separator + "lend_return.xls";
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("StuList")){
			CardInfoSearchForm cisf = new CardInfoSearchForm();
			cisf.setS_birthday_low(request.getParameter("s_birthday_low"));
			cisf.setS_birthday_top(request.getParameter("s_birthday_top"));
			cisf.setS_name(request.getParameter("s_name"));
			cisf.setS_address(request.getParameter("s_address"));
			cisf.setS_birthPlace(request.getParameter("s_birthPlace"));
			cisf.setS_originStudent(request.getParameter("s_originStudent"));
			PageRequest pagerequset = new PageRequest(0, 1000000, new Sort(
					new Sort.Order(Sort.Direction.DESC, "id")));
			Page<CardInfo> pas = cardInfoService.findAllCardInfo(cisf,
					pagerequset);
			
			List<CardInfoForm> v = new ArrayList<CardInfoForm>();
			as = pas.getContent();//cardInfoService.getAllCardInfo();
			template = tempalteCtxPath  + File.separator + "stu_detail_list.xls";
			getAllCardInfo(v, as);
			eu.createExcel(template, v, outFilePath);
		}
		if(type.equalsIgnoreCase("AcademeAge")){

			CardInfoSearchForm cisf = new CardInfoSearchForm();
			List<TeacherAgeReportForm> v = new ArrayList<TeacherAgeReportForm>();
//			PageRequest pagerequset = new PageRequest(0, 1000000, new Sort(
//					new Sort.Order(Sort.Direction.DESC, "id")));
//			Page<CardInfo> pas = cardInfoService.jsonAcademeAgeReport(cisf,
//					pagerequset);
			
			String sql="";
			
			String ageLow1 = request.getParameter("s_age1_low");
			String ageLow2 = request.getParameter("s_age2_low");
			String ageLow3 = request.getParameter("s_age3_low");
			String ageLow4 = request.getParameter("s_age4_low");
			String ageLow5 = request.getParameter("s_age5_low");
			String ageLow6 = request.getParameter("s_age6_low");

			String ageTop1 = request.getParameter("s_age1_top");
			String ageTop2 = request.getParameter("s_age2_top");
			String ageTop3 = request.getParameter("s_age3_top");
			String ageTop4 = request.getParameter("s_age4_top");
			String ageTop5 = request.getParameter("s_age5_top");
			String ageTop6 = request.getParameter("s_age6_top");
			
			
			List r1 = cardInfoService.jsonAcademeAgeReport(ageLow1,ageTop1);
			List r2 = cardInfoService.jsonAcademeAgeReport(ageLow2,ageTop2);
			List r3 = cardInfoService.jsonAcademeAgeReport(ageLow3,ageTop3);
			List r4 = cardInfoService.jsonAcademeAgeReport(ageLow4,ageTop4);
			List r5 = cardInfoService.jsonAcademeAgeReport(ageLow5,ageTop5);
			List r6 = cardInfoService.jsonAcademeAgeReport(ageLow6,ageTop6);
			
			HashMap<String,Object[]> m1 = new HashMap<String,Object[]>();
			HashMap<String,Object[]> m2 = new HashMap<String,Object[]>();
			HashMap<String,Object[]> m3 = new HashMap<String,Object[]>();
			HashMap<String,Object[]> m4 = new HashMap<String,Object[]>();
			HashMap<String,Object[]> m5 = new HashMap<String,Object[]>();
			HashMap<String,Object[]> m6 = new HashMap<String,Object[]>();
			
			HashSet<String> academeS = new HashSet<String>();
			
			Object[] r = null;
			for(int i=0;i<r1.size();i++){
				r = (Object[])r1.get(i);
				m1.put(r[0].toString(), r);
				academeS.add(r[0].toString());
			}
			
			for(int i=0;i<r2.size();i++){
				r = (Object[])r2.get(i);
				m2.put(r[0].toString(), r);
				academeS.add(r[0].toString());
			}
			
			for(int i=0;i<r3.size();i++){
				r = (Object[])r3.get(i);
				m3.put(r[0].toString(), r);
				academeS.add(r[0].toString());
			}
			
			for(int i=0;i<r4.size();i++){
				r = (Object[])r4.get(i);
				m4.put(r[0].toString(), r);
				academeS.add(r[0].toString());
			}
			
			for(int i=0;i<r5.size();i++){
				r = (Object[])r5.get(i);
				m5.put(r[0].toString(), r);
				academeS.add(r[0].toString());
			}
			
			for(int i=0;i<r6.size();i++){
				r = (Object[])r6.get(i);
				m6.put(r[0].toString(), r);
				academeS.add(r[0].toString());
			}
			
			List<TeacherAgeReportForm> content = new ArrayList<TeacherAgeReportForm>();
			Iterator<String> it = academeS.iterator();
			while (it.hasNext()) {
				String academe1 = it.next();
				
				TeacherAgeReportForm tf = new TeacherAgeReportForm();
				tf.setGroupName(academe1);
				
				List<Integer> l4 = new ArrayList<Integer>();
				if(!ageLow1.equals("")||!ageTop1.equals("")){
					if(m1.containsKey(academe1)){
						Object[] v1 = m1.get(academe1);
						l4.add(Integer.valueOf(v1[1].toString()));
						l4.add(Integer.valueOf(v1[2].toString()));
					}else{
						l4.add(0);
						l4.add(0);
					}
				}
				if(!ageLow2.equals("")||!ageTop2.equals("")){
					if(m2.containsKey(academe1)){
						Object[] v1 = m2.get(academe1);
						l4.add(Integer.valueOf(v1[1].toString()));
						l4.add(Integer.valueOf(v1[2].toString()));
					}else{
						l4.add(0);
						l4.add(0);
					}
				}
				if(!ageLow3.equals("")||!ageTop3.equals("")){
					if(m3.containsKey(academe1)){
						Object[] v1 = m3.get(academe1);
						l4.add(Integer.valueOf(v1[1].toString()));
						l4.add(Integer.valueOf(v1[2].toString()));
					}else{
						l4.add(0);
						l4.add(0);
					}
				}
				if(!ageLow4.equals("")||!ageTop4.equals("")){
					if(m4.containsKey(academe1)){
						Object[] v1 = m4.get(academe1);
						l4.add(Integer.valueOf(v1[1].toString()));
						l4.add(Integer.valueOf(v1[2].toString()));
					}else{
						l4.add(0);
						l4.add(0);
					}
				}
				if(!ageLow5.equals("")||!ageTop5.equals("")){
					if(m5.containsKey(academe1)){
						Object[] v1 = m5.get(academe1);
						l4.add(Integer.valueOf(v1[1].toString()));
						l4.add(Integer.valueOf(v1[2].toString()));
					}else{
						l4.add(0);
						l4.add(0);
					}
				}
				if(!ageLow6.equals("")||!ageTop6.equals("")){
					if(m6.containsKey(academe1)){
						Object[] v1 = m6.get(academe1);
						l4.add(Integer.valueOf(v1[1].toString()));
						l4.add(Integer.valueOf(v1[2].toString()));
					}else{
						l4.add(0);
						l4.add(0);
					}
				}
				tf.setGroupValue(l4);
				content.add(tf);
			}
			
//			
//			for(int i=0;i<r1.size();i++){
//				TeacherAgeReportForm tf = new TeacherAgeReportForm();
//				tf.setGroupName("x");
//				Object[] rr = (Object[])r1.get(i);
//				tf.setGroupName(rr[0].toString());
//				
//				r = null;
//				List<String> l4 = new ArrayList<String>();
//				if(r1.size()>0){
//					r = (Object[])r1.get(i);
//					for (int j = 1; j < r.length-1; j++) {
//						l4.add(r[j].toString());
//					}
//				}
//				if(r2.size()>0){
//					r = (Object[])r2.get(i);
//					for (int j = 1; j < r.length-1; j++) {
//						l4.add(r[j].toString());
//					}
//				}
//				if(r3.size()>0){
//				r = (Object[])r3.get(i);
//					for (int j = 1; j < r.length-1; j++) {
//						l4.add(r[j].toString());
//					}
//				}
//				if(r4.size()>0){
//				r = (Object[])r4.get(i);
//					for (int j = 1; j < r.length-1; j++) {
//						l4.add(r[j].toString());
//					}
//				}
//				if(r5.size()>0){
//					r = (Object[])r5.get(i);
//					for (int j = 1; j < r.length-1; j++) {
//						l4.add(r[j].toString());
//					}
//				}
//				if(r6.size()>0){
//					r = (Object[])r6.get(i);
//					for (int j = 1; j < r.length-1; j++) {
//						l4.add(r[j].toString());
//					}
//				}
//				tf.setGroupValue(l4);
//				
//				content.add(tf);
//			}
			
			template = tempalteCtxPath  + File.separator + "teacher_age.xls";
			
//			getTeacherAgeReportFormList(v, pas.getContent());
			List<String> l = new ArrayList<String>();
			List<String> l2 = new ArrayList<String>();
			
//			if(r1.size()>0){
//				l.add("合计");
//				
//				l2.add("合计");
//				l2.add("男");
//				l2.add("女");
//			}
			
			if(!ageLow1.equals("")||!ageTop1.equals("")){
				l.add("年龄段【" + ageLow1 + "-" + ageTop1 + "】");
				
				l2.add("男");
				l2.add("女");
			}
			
			if(!ageLow2.equals("")||!ageTop2.equals("")){
				l.add("年龄段【" + ageLow2 + "-" + ageTop2 + "】");
				
				l2.add("男");
				l2.add("女");
			}

			if(!ageLow3.equals("")||!ageTop3.equals("")){
				l.add("年龄段【" + ageLow3 + "-" + ageTop3 + "】");
				
				l2.add("男");
				l2.add("女");
			}

			if(!ageLow4.equals("")||!ageTop4.equals("")){
				l.add("年龄段【" + ageLow4 + "-" + ageTop4 + "】");
				
				l2.add("男");
				l2.add("女");
			}

			if(!ageLow5.equals("")||!ageTop5.equals("")){
				l.add("年龄段【" + ageLow5 + "-" + ageTop5 + "】");
				
				l2.add("男");
				l2.add("女");
			}

			if(!ageLow6.equals("")||!ageTop6.equals("")){
				l.add("年龄段【" + ageLow6 + "-" + ageTop6 + "】");
				
				l2.add("男");
				l2.add("女");
			}

						
			HashMap<String,List<?>> m = new HashMap<String,List<?>>();
			m.put("caption1", l);
			m.put("caption2", l2);
			m.put("content", content);
			
			eu.createExcel(template, m, outFilePath);
		}
		try {
			BufferedInputStream br = new BufferedInputStream(new FileInputStream(outFilePath));
			
			byte[] buf = new byte[1024];
			int len = 0;
			// String name = URLEncoder.encode(disc,"utf-8");

			
//			response.setContentType("application/vnd.ms-excel");
//			String codedFileName = null;
//			OutputStream fOut = null;
//			// 进行转码，使其支持中文文件名
//			try {
//				codedFileName = java.net.URLEncoder.encode("中文", "UTF-8");
//			} catch (UnsupportedEncodingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			response.setHeader("content-disposition", "attachment;filename="
//					+ codedFileName + ".xls");
//			// response.addHeader("Content-Disposition", "attachment;   filename=" +
//			// codedFileName + ".xls");
//			// 产生工作簿对象
			
			response.reset();
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename="
					+ fileName);

			OutputStream out = response.getOutputStream();
			while ((len = br.read(buf)) > 0)
				out.write(buf, 0, len);
			br.close();
			out.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private void getList(List<StudentReportForm> v, List as) {
		Iterator it = as.iterator();
		while (it.hasNext()) {
			Object[] r = (Object[]) it.next();
			StudentReportForm f = new StudentReportForm();
			f.setGroupName((String) r[0]);
			f.setSummale((BigDecimal) r[1]);
			f.setSumfemale((BigDecimal) r[2]);
			f.setSumall((BigDecimal) r[3]);

			f.setSumbachelormale((BigDecimal) r[4]);
			f.setSumbachelorfemale((BigDecimal) r[5]);

			f.setSummastermale((BigDecimal) r[7]);
			f.setSummasterfemale((BigDecimal) r[8]);

			f.setSumdoctormale((BigDecimal) r[10]);
			f.setSumdoctorfemale((BigDecimal) r[11]);

			v.add(f);
		}
	}
	
	
	private void getList4Family(List<StudentReportForm> v, List as) {
		Iterator it = as.iterator();
		while (it.hasNext()) {
			Object[] r = (Object[]) it.next();
			StudentReportForm f = new StudentReportForm();
			f.setGroupName((String) r[0]);
			f.setSummale((BigDecimal) r[1]);
			f.setSumfemale((BigDecimal) r[2]);
			f.setSumall((BigDecimal) r[3]);

			v.add(f);
		}
	}
	
	
	private void getAllCardInfo(List<CardInfoForm> v, List as) {
		Iterator it = as.iterator();
		while (it.hasNext()) {

			CardInfo cardInfo = (CardInfo) it.next();
			CardInfoForm bi = new CardInfoForm();
			try {
				BeanUtilEx.copyProperties(bi, cardInfo);
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}

//			 bi.setCardType(bnuCodeService.getCodeValue(DefaultValue.CARD_TYPE,bi.getCardType()));
			 bi.setGender(bnuCodeService.getCodeName(DefaultValue.GENDER_TYPE,bi.getGender()));
			 bi.setStatus(bnuCodeService.getCodeName(DefaultValue.USER_STATUS,bi.getStatus()));
			 bi.setJob(bnuCodeService.getCodeName(DefaultValue.CARD_TYPE,bi.getJob()));
			 bi.setMarriageInfo(bnuCodeService.getCodeName(DefaultValue.MARRIAGE_INFO,bi.getMarriageInfo()));
			 bi.setMilitarySituation(bnuCodeService.getCodeName(DefaultValue.MILITARY_SITUATION,bi.getMilitarySituation()));
			 bi.setEducationInfo(bnuCodeService.getCodeName(DefaultValue.EDUCATION_INFO,bi.getEducationInfo()));

			v.add(bi);
		}
	}
	
	
	/** 
     * 上传文件 
     * @return 
     * @throws IOException  
     * @throws IllegalStateException  
     */  
    @RequestMapping(value = "/uploadcards", method = RequestMethod.POST)  
    @ResponseBody  
    public JsonSimpleResult upload(HttpServletRequest request, HttpServletResponse response){  
          
    	JsonSingleOjbectResult<CardInfoForm> lr = new JsonSingleOjbectResult<CardInfoForm>();
    	
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;    
  
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();    
        // 文件保存路径  
        String ctxPath=request.getSession().getServletContext().getRealPath("/")+File.separator+"uploadFiles";   
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");  
        String ymd = sdf.format(new Date());  
        ctxPath += File.separator + ymd + File.separator;  
        // 创建文件夹  
        File file = new File(ctxPath);    
        if (!file.exists()) {    
            file.mkdirs();    
        }    
        String fileName = null;    
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {    
            // 上传文件   
            MultipartFile mf = entity.getValue();    
            fileName = mf.getOriginalFilename();  
            String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
            // 重命名文件  
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
            String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;  
            File uploadFile = new File(ctxPath + newFileName);    
            try {  
                FileCopyUtils.copy(mf.getBytes(), uploadFile);
                
                String errMsgs = "";
                
                //导入
                ExcelUtil eu = new ExcelUtil();
                String tempalteCtxPath=request.getSession().getServletContext().getRealPath("/")+File.separator+"template";   
                String xmlPath = tempalteCtxPath + File.separator + "cardtemplate.xml";
                CardInfoForm cif = new CardInfoForm();
        		List<CardInfoXlsVo> cifs = new ArrayList<CardInfoXlsVo>();
        		Map beanMap = new HashMap();
        		beanMap.put("card", cif);
        		beanMap.put("cards", cifs);
                eu.xls2Beans(xmlPath, ctxPath + newFileName, beanMap);
                HashSet<String> idset = new HashSet<String>();
                HashSet<String> stuTeaNumberSet = new HashSet<String>();
                
                for (CardInfoXlsVo c : cifs) {
					System.out.println(c.getName());
					//校验
					List<CardInfo> cis = cardInfoService.findCardInfoByIdentityCard(c.getIdentityCard());
					String errMsg = "";
					if(cis.size()>0)
						errMsg += "系统中[身份证:" + c.getIdentityCard() + "]已存在,";
					
					cis = cardInfoService.findCardInfoBystuTeaNumber(c.getAddress());
					if(cis.size()>0)
						errMsg += "系统中[学号工作证号:" + c.getAddress() + "]已存在,";
					
					if(idset.contains(c.getIdentityCard()))
						errMsg += "文件中[身份证:" + c.getIdentityCard() + "已存在,";
					else
						idset.add(c.getIdentityCard());

					if(stuTeaNumberSet.contains(c.getAddress()))
						errMsg += "文件中[身份证:" + c.getAddress() + "已存在,";
					else
						stuTeaNumberSet.add(c.getAddress());
					
					if(!c.getGender().equals("男") && !c.getGender().equals("女"))
						errMsg += "性别填写错误,";
					
//					if(!c.getBloodType().equals("A") && !c.getBloodType().equals("B") && !c.getBloodType().equals("AB") && !c.getBloodType().equals("O"))
//						errMsg += "血型填写错误,";
//					
					if(!c.getEducationInfo().equals("研究生") && !c.getEducationInfo().equals("本科生"))
						errMsg += "文化程度填写错误,";
					
					if(!c.getMarriageInfo().equals("未婚") && !c.getMarriageInfo().equals("已婚") && !c.getMarriageInfo().equals("未知"))
						errMsg += "婚姻状况填写错误,";
					
					if(!c.getMilitarySituation().equals("未服兵役") && !c.getMilitarySituation().equals("已服兵役") && !c.getMilitarySituation().equals("未知"))
						errMsg += "兵役情况填写错误,";
					
					if(!c.getJob().equals("本科生") && !c.getJob().equals("研究生") && !c.getJob().equals("博士生") && !c.getJob().equals("教工") && !c.getJob().equals("家属") && !c.getJob().equals("其他"))
						errMsg += "职业填写错误,";
					
					if(errMsg.length() >0)
						errMsgs += c.getName() + ":" + errMsg + "<br>";
				}
                
                if(errMsgs.length() > 0){
                	lr.setSuccess(false);
                	lr.setMsg("错误信息如下：<br>" + errMsgs);  
                }else if(cifs.size()==0){
                	lr.setSuccess(false);
                	lr.setMsg("错误信息如下：<br>" + "文件["+fileName+"]未能解析出数据!");
            	}else{
                	List<CardInfo> cis = new ArrayList<CardInfo>();
                	for (Iterator iterator = cifs.iterator(); iterator.hasNext();) {
                		CardInfoXlsVo cif1 = (CardInfoXlsVo) iterator.next();
                		CardInfo ci = new CardInfo();
                		
                		BeanUtilEx.copyProperties(ci, cif1);
                		ci.setGender(bnuCodeService.getCodeValue(DefaultValue.GENDER_TYPE, cif1.getGender()));
                		ci.setEducationInfo(bnuCodeService.getCodeValue(DefaultValue.EDUCATION_INFO,cif1.getEducationInfo()));
                		ci.setMilitarySituation(bnuCodeService.getCodeValue(DefaultValue.MILITARY_SITUATION,cif1.getMilitarySituation()));
                		ci.setJob(bnuCodeService.getCodeValue(DefaultValue.CARD_TYPE,cif1.getJob()));
                		ci.setMarriageInfo(bnuCodeService.getCodeValue(DefaultValue.MARRIAGE_INFO,cif1.getMarriageInfo()));
                		
                		String currUserName = DefaultValue.getCurrentUserName();
            			System.out.println("currUserName:" + currUserName);
            			Long currUserId = -1l;
            			SysUser cu = sysUserService.findOneSysUserByLoginName(currUserName);
            			if (cu != null)
            				currUserId = cu.getId();
            			Date currDate = new Date();
            			
            			ci.setCreateDate(currDate);
        				ci.setCreatorId(currUserId);
        				ci.setCreatorName(currUserName);
            			
        				ci.setStatus(DefaultValue.VALID);
        				
						cis.add(ci);
					}
                	cardInfoService.saveCardInfos(cis);
                	
	                lr.setSuccess(true);
	                lr.setMsg("上传成功");
                }
            } catch (IOException e) {  
                lr.setSuccess(false);
            	lr.setMsg("上传失败");  
                e.printStackTrace();  
            } catch (IllegalAccessException e) {
            	lr.setSuccess(false);
            	lr.setMsg("上传失败");  
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				lr.setSuccess(false);
            	lr.setMsg("上传失败");  
				e.printStackTrace();
			}    
        }   
        return lr;  
    }  
	
}
