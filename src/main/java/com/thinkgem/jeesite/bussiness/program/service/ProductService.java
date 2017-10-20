package com.thinkgem.jeesite.bussiness.program.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.bussiness.program.dao.ProductDao;
import com.thinkgem.jeesite.bussiness.program.entity.Product;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 
 * 类: ProductService <br>
 * 描述: 产品服务类 <br>
 * 作者: Dylan <br>
 * 时间: 2017年10月11日 下午5:37:39
 */
@Service
@Transactional(readOnly = true)
public class ProductService extends CrudService<ProductDao, Product> {
	
	public Page<Product> findPage(Page<Product> page, Product product){
		return super.findPage(page, product);
	}
	
	public List<Product> findAllList(){
		return super.dao.findAllList();
	}

}
