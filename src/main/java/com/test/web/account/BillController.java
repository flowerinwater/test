package com.test.web.account;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.entity.Bill;
import com.test.entity.BillDetail;
import com.test.service.account.BillService;


@Controller
public class BillController {
	Logger log = LoggerFactory.getLogger(BillController.class);
	
	@Autowired
	private BillService billService;
    
    @RequestMapping("/jsonsavebill")
    @ResponseBody
	public JsonSimpleResult jsonSaveBill(@RequestBody BillInfo ci){
    	log.info("jsonsavebill");
    	JsonSingleOjbectResult<BillInfo> lr = new JsonSingleOjbectResult<BillInfo>();
    	
    	try{
	    	ci.setId(billService.saveBill(ci).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindbillbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindBillById(@RequestParam(value="id") long id){
    	log.info("jsonfindbillbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<BillInfo> lr = new JsonSingleOjbectResult<BillInfo>();
    	
    	try{
    		Bill c = billService.getBill(id);
    		BillInfo ci = new BillInfo();
    		BeanUtils.copyProperties(ci, c);
    		
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }    
    
    @RequestMapping("/jsonremovebillbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveBillById(@RequestParam(value="id") long uid){
    	log.info("jsonremovebillbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<BillInfo> lr = new JsonSingleOjbectResult<BillInfo>();
    	
    	try{
    		billService.deleteBill(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindbill")
    @ResponseBody
	public JsonArrayResult<Bill> jsonFindBill(@RequestParam(value="billCode",required=false) String billCode){
    	log.info("jsonFindUser");
    	log.info("name:" + billCode);
    	
    	JsonArrayResult<Bill> lr = new JsonArrayResult<Bill>();
    	
    	try{
    		List<Bill> as = billService.getAllBill();
	    	
    		if(as!=null){
    			lr.setResults(new Bill[as.size()]);
    			
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
    
    @RequestMapping("/jsonfindallbillpage")
    @ResponseBody
	public JsonPageResult<BillInfo> jsonFindAllBillPage(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page){
    	log.info("jsonfindallbillpage");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<BillInfo> lr = new JsonPageResult<BillInfo>();
    	
    	try{
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<Bill> as = billService.findAllBill(pagerequset);
    		List<BillInfo> bis = new ArrayList<BillInfo>();
    		for (Iterator<Bill> iterator = as.getContent().iterator(); iterator.hasNext();) {
				Bill bill = (Bill) iterator.next();
				BillInfo bi = new BillInfo();
				BeanUtils.copyProperties(bi, bill);
				List<BillDetailInfo> bdis = new  ArrayList<BillDetailInfo>();;
				for (BillDetail billDetail : bill.getBillItems()) {
					BillDetailInfo bdi = new BillDetailInfo();
					BeanUtils.copyProperties(bdi, billDetail);
					bdis.add(bdi);
				}
				bi.setBillItems(bdis);
				bis.add(bi);
			}
//    		Page<BillInfo> p = new PageImpl<BillInfo>(bis,pagerequset,as.getTotalElements());
    		
    		if(as!=null){
    			lr.setRows(bis);
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonfindbilldetail")
    @ResponseBody
	public JsonPageResult<BillDetailInfo> jsonFindBillDetailPage(@RequestParam(value="billId",required=false) long billId){
    	log.info("jsonfindbilldetail");
    	log.info("billId:" + billId);//billId
    	
    	JsonPageResult<BillDetailInfo> lr = new JsonPageResult<BillDetailInfo>();
    	
    	try{
    		List<BillDetail> bts = billService.getBill(billId).getBillItems();
    		List<BillDetailInfo> bdis = new  ArrayList<BillDetailInfo>();;
			for (BillDetail billDetail : bts) {
				BillDetailInfo bdi = new BillDetailInfo();
				BeanUtils.copyProperties(bdi, billDetail);
				bdis.add(bdi);
			}
    		if(bts!=null){
    			lr.setRows(bdis);
    			lr.setTotal(bts.size());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
}
