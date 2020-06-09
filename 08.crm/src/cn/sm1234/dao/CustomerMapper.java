package cn.sm1234.dao;

import cn.sm1234.domain.Customer;

import java.util.List;

public interface CustomerMapper {
    /**
     * 查询所有数据
     */
    public List<Customer> findAll();

    public void saveCustomer(Customer customer);

    public Customer findById(Integer id);

    public void update(Customer customer);

    public void deleteById(Integer[] id);
}
