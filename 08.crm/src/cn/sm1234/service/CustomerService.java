package cn.sm1234.service;

import cn.sm1234.domain.Customer;

import java.util.List;

public interface CustomerService {

    public List<Customer> findALL();

    public void saveCustomer(Customer customer);
    public Customer findById(Integer id);

    public void deleteById(Integer[] id);
}
