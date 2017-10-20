/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.bussiness.program.dao;

import java.util.List;

import com.thinkgem.jeesite.bussiness.program.entity.Materials;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * 材料DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface MaterialsDao extends CrudDao<Materials> {
	
	public List<Materials> findAllList();
}
