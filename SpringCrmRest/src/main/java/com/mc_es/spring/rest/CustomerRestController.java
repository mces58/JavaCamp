package com.mc_es.spring.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mc_es.spring.business.CustomerService;
import com.mc_es.spring.entity.Customer;

@RestController
@RequestMapping(value = "/api")
public class CustomerRestController {

	@Autowired
	private CustomerService customerService;

	@GetMapping(value = "/customers")
	public List<Customer> getCustomers() {
		return customerService.getCustomers();
	}
}
