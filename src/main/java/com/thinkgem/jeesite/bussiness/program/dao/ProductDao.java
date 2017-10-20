/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.bussiness.program.dao;

import java.util.List;

import com.thinkgem.jeesite.bussiness.program.entity.Product;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 产品DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface ProductDao extends CrudDao<Product> {
	
	public List<Product> findAllList();
}
