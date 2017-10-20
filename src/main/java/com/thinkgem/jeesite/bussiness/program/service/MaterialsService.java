package com.thinkgem.jeesite.bussiness.program.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.bussiness.program.dao.MaterialsDao;
import com.thinkgem.jeesite.bussiness.program.entity.Materials;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 
 * 类: MaterialsService <br>
 * 描述: 材料服务类 <br>
 * 作者: Dylan <br>
 * 时间: 2017年10月11日 下午5:37:19
 */
@Service
@Transactional(readOnly = true)
public class MaterialsService extends CrudService<MaterialsDao, Materials> {
	
	public Page<Materials> findPage(Page<Materials> page, Materials materials){
		return super.findPage(page, materials);
	}
	
	public List<Materials> findAllList(){
		return super.dao.findAllList();
	}

}
