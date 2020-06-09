package cn.sm1234.service.impl;

import cn.sm1234.dao.CustomerMapper;
import cn.sm1234.domain.Customer;
import cn.sm1234.service.CustomerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("customerService")
@Transactional
public class CustomerServiceImpl implements CustomerService {
    // 注入接口对象
    @Resource
    private CustomerMapper customerMapper;



    @Override
    public List<Customer> findALL() {
      return customerMapper.findAll();
    }

    @Override
    public void deleteById(Integer[] id) {
        customerMapper.deleteById(id);
    }

    @Override
    public void saveCustomer(Customer customer) {
        if(customer.getId()!=null){
            customerMapper.update(customer);
        }else {
            customerMapper.saveCustomer(customer);
        }
    }
    @Override
    public Customer findById(Integer id) {
        return customerMapper.findById(id);
    }
}
