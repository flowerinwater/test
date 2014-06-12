package com.test.web.account;

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

import com.test.entity.Customer;
import com.test.service.account.CustomerService;


@Controller
public class CustomerController {
	Logger log = LoggerFactory.getLogger(CustomerController.class);
	
	@Autowired
	private CustomerService customerService;
	
    
    
    @RequestMapping("/jsonsavecustomer")
    @ResponseBody
	public JsonSimpleResult jsonSaveCustomer(@RequestBody CustomerInfo ci){
    	log.info("jsonsaveuser");
    	JsonSingleOjbectResult<CustomerInfo> lr = new JsonSingleOjbectResult<CustomerInfo>();
    	
    	try{
	    	ci.setId(customerService.saveCustomer(ci).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindcustomerbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindCustomerById(@RequestParam(value="id") long id){
    	log.info("jsonfindcustomerbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<CustomerInfo> lr = new JsonSingleOjbectResult<CustomerInfo>();
    	
    	try{
    		Customer c = customerService.getCustomer(id);
    		CustomerInfo ci = new CustomerInfo();
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
    
    @RequestMapping("/jsonremovecustomerbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveCustomerById(@RequestParam(value="id") long uid){
    	log.info("jsonremovecustomerbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<CustomerInfo> lr = new JsonSingleOjbectResult<CustomerInfo>();
    	
    	try{
    		customerService.deleteCustomer(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindcustomer")
    @ResponseBody
	public JsonArrayResult<Customer> jsonFindCustomer(@RequestParam(value="shortName",required=false) String shortName){
    	log.info("jsonFindUser");
    	log.info("name:" + shortName);
    	
    	JsonArrayResult<Customer> lr = new JsonArrayResult<Customer>();
    	
    	try{
    		List<Customer> as = customerService.getAllCustomerByShortName(shortName);
	    	
    		if(as!=null){
    			lr.setResults(new Customer[as.size()]);
    			
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
    
    @RequestMapping("/jsonfindallcustomerpage")
    @ResponseBody
	public JsonPageResult<Customer> jsonFindAllUserPage(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page){
    	log.info("jsonfindallcustomerpage");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<Customer> lr = new JsonPageResult<Customer>();
    	
    	try{
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<Customer> as = customerService.findAllCustomer(pagerequset);
    		
    		if(as!=null){
    			lr.setRows(as.getContent());
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
}
