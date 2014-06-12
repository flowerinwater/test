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

import com.test.entity.Customer;
import com.test.entity.User;
import com.test.repository.CustomerDao;
import com.test.repository.UserDao;
import com.test.web.account.CustomerInfo;

// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class CustomerService {

	private static Logger log = LoggerFactory.getLogger(CustomerService.class);

	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private UserDao userDao;

	public List<Customer> getAllCustomer() {
		List<Customer> cts = new ArrayList<Customer>();
		
		Iterator<Customer> it = customerDao.findAll().iterator();
		while(it.hasNext()){
			cts.add(it.next());
		}
		
		return cts;
	}
	
	public Page<Customer> findAllCustomer(Pageable p) {
		return customerDao.findAll(p);
	}

	public Customer getCustomer(Long id) {
		return customerDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public Customer saveCustomer(CustomerInfo ci) {
		Customer c = new Customer();
		try {
			BeanUtils.copyProperties(c, ci);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		User u = userDao.findOne(ci.getSalesManId());
		c.setSalesUser(u);
		return customerDao.save(c);
	}

	@Transactional(readOnly = false)
	public Customer updateCustomer(Customer c) {
		return customerDao.save(c);
	}

	@Transactional(readOnly = false)
	public void deleteCustomer(Long id) {
		customerDao.delete(id);
	}
	
	public List<Customer> getAllCustomerByShortName(String shortName) {
		return  customerDao.findByShortNameLike(shortName);
	}
}
