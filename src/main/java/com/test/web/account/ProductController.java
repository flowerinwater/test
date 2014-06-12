package com.test.web.account;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import com.test.entity.Product;
import com.test.service.account.ProductService;


@Controller
public class ProductController {
	Logger log = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;
	
    
    
    @RequestMapping("/jsonsaveproduct")
    @ResponseBody
	public JsonSimpleResult jsonSaveProduct(@RequestBody ProductInfo ci){
    	log.info("jsonsaveuser");
    	JsonSingleOjbectResult<ProductInfo> lr = new JsonSingleOjbectResult<ProductInfo>();
    	
    	try{
	    	ci.setId(productService.saveProduct(ci).getId());
	    	
	    	lr.setObj(ci);
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
    
    
    @RequestMapping("/jsonfindproductbyid")
    @ResponseBody
	public JsonSimpleResult jsonFindProductById(@RequestParam(value="id") long id){
    	log.info("jsonfindproductbyid");
    	log.info(""+id);
    	
    	JsonSingleOjbectResult<ProductInfo> lr = new JsonSingleOjbectResult<ProductInfo>();
    	
    	try{
    		Product c = productService.getProduct(id);
    		ProductInfo ci = new ProductInfo();
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
    
    @RequestMapping("/jsonremoveproductbyid")
    @ResponseBody
	public JsonSimpleResult jsonRemoveProductById(@RequestParam(value="id") long uid){
    	log.info("jsonremoveproductbyid");
    	log.info(""+uid);
    	
    	JsonSingleOjbectResult<ProductInfo> lr = new JsonSingleOjbectResult<ProductInfo>();
    	
    	try{
    		productService.deleteProduct(uid);
	    	
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    } 
    
    
    @RequestMapping("/jsonfindproduct")
    @ResponseBody
	public JsonArrayResult<Product> jsonFindProduct(@RequestParam(value="name",required=false) String name){
    	log.info("jsonfindproduct");
    	log.info("name:" + name);
    	
    	JsonArrayResult<Product> lr = new JsonArrayResult<Product>();
    	
    	try{
    		List<Product> as = productService.getAllProductByName(name);
	    	
    		if(as!=null){
    			lr.setResults(new Product[as.size()]);
    			
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
    @RequestMapping("/jsonfindallproductpage")
    @ResponseBody
	public JsonPageResult<ProductInfo> jsonFindAllProductPage(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page){
    	log.info("jsonfindallproductpage");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	//,@RequestBody ProdoctSearch ps
    	JsonPageResult<ProductInfo> lr = new JsonPageResult<ProductInfo>();
    	
    	try{
    		ProdoctSearch ps = new ProdoctSearch();
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<Product> as = productService.findAllProduct(ps,pagerequset);
    		
    		if(as!=null){
    			List<ProductInfo> pl = new ArrayList<ProductInfo>();
    			for (Iterator<Product> iterator = as.getContent().iterator(); iterator
						.hasNext();) {
    				Product p =  iterator.next();
    				ProductInfo pi = new ProductInfo();
    				BeanUtils.copyProperties(pi, p);
					pl.add(pi);
				}
    			
    			lr.setRows(pl);
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonfindallproductpage1")
    @ResponseBody
	public JsonPageResult<Product> jsonFindAllProductPage1(HttpServletRequest r,@RequestBody ProdoctSearch ps){
    	
    	Enumeration e1 = r.getParameterNames();
    	while(e1.hasMoreElements()){
    		Object o = e1.nextElement();
    		System.out.println(o + ":" + r.getParameter(o.toString()));
    		
    	}
    	log.info("jsonfindallproductpage");
    	int rows = 10;
    	int page = 1;
    	
//    	try{
//    		rows = Integer.parseInt(ps.getS_rows());
//    	}catch(Exception e){
//    		
//    	}
//    	
//    	try{
//    		page = Integer.parseInt(ps.getS_page());
//    	}catch(Exception e){
//    		
//    	}
    	
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<Product> lr = new JsonPageResult<Product>();
    	
    	try{
//    		ProdoctSearch ps = new ProdoctSearch();
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<Product> as = productService.findAllProduct(ps,pagerequset);
    		
    		if(as!=null){
    			lr.setRows(as.getContent());
    			lr.setTotal(as.getTotalElements());
    			
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}

    	return lr;
    }
    
    @RequestMapping("/jsonfindallproductpagebyfulltext")
    @ResponseBody
	public JsonPageResult<Product> jsonFindAllProductPageByFullTextSearch(@RequestParam(value="rows",required=false) int rows,@RequestParam(value="page",required=false) int page,@RequestParam(value="searchContent",required=false)String searchContent){
    	log.info("jsonfindallproductpagebyfulltext");
    	log.info("rows:" + rows);//rows per page
    	log.info("page:" + page);//curr page
    	
    	JsonPageResult<Product> lr = new JsonPageResult<Product>();
    	
    	try{
    		PageRequest pagerequset = new PageRequest(--page, rows,new Sort( new Sort.Order(Sort.Direction.DESC,"id")));
    		Page<Product> as = productService.findAllProductByFullTextSearch2(searchContent,pagerequset);
    		
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
