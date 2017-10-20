package com.thinkgem.jeesite.bussiness.search.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;

/**
 * 
 * 类: SearchController <br>
 * 描述: 搜索框功能 <br>
 * 作者: Dylan <br>
 * 时间: 2017年7月25日 下午2:29:24
 */
@Controller
@RequestMapping(value = "${adminPath}/bussiness/search")
public class SearchController extends BaseController {
	
	@RequiresPermissions("bussiness:search:view")
	@RequestMapping(value="matchPage")
	public String queryByInput(Model model){
		model.addAttribute("article", new Article());
		return "bussiness/search/matchPage";
	}
	
	@ResponseBody
	@RequestMapping(value="getResult")
	public Map getResultMap(){
		Map resultMap = new HashMap();
		return resultMap;
	}

}

