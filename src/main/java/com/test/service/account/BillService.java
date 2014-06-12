package com.test.service.account;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.test.entity.Bill;
import com.test.entity.BillDetail;
import com.test.entity.Customer;
import com.test.entity.Product;
import com.test.entity.User;
import com.test.repository.BillDao;
import com.test.repository.BillDetailDao;
import com.test.repository.CustomerDao;
import com.test.repository.ProductDao;
import com.test.repository.UserDao;
import com.test.web.account.BillDetailInfo;
import com.test.web.account.BillInfo;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class BillService {

	private static Logger log = LoggerFactory.getLogger(BillService.class);

	@Autowired
	private UserDao userDao;
	@Autowired             
	private CustomerDao customerDao;
	@Autowired             
	private ProductDao productDao;
	@Autowired             
	private BillDao billDao;
	@Autowired             
	private BillDetailDao billDetailDao;

	public List<Bill> getAllBill() {
		List<Bill> cts = new ArrayList<Bill>();
		
		Iterator<Bill> it = billDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	public Page<Bill> findAllBill(Pageable p) {
		return billDao.findAll(p);
	}

	public Bill getBill(Long id) {
		return billDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public Bill saveBill(BillInfo ci) {
		Bill c = new Bill();
		try {
			BeanUtils.copyProperties(c, ci);
			List<BillDetail> bds = new  ArrayList<BillDetail>();;
			for (BillDetailInfo bdi : ci.getBillItems()) {
				BillDetail bd = new BillDetail();
				BeanUtils.copyProperties(bd,bdi);
				
				Product p = productDao.findOne(bdi.getProductId());
				bd.setProduct(p);
				//billDetailDao.save(bd);
				bds.add(bd);
			}
			c.setBillItems(bds);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		User u = userDao.findOne(ci.getSalesPersonId());
		c.setSalesPerson(u);
		User u1 = userDao.findOne(ci.getWarehouseKeeperId());
		c.setWarehouseKeeper(u1);
		Customer cc = customerDao.findOne(ci.getCustomerId());
		c.setCustomer(cc);
		return billDao.save(c);
	}

	@Transactional(readOnly = false)
	public Bill updateBill(Bill c) {
		return billDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteBill(Long id) {
		billDao.delete(id);
	}
	
}
