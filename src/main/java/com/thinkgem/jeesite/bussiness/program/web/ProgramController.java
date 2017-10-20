package com.thinkgem.jeesite.bussiness.program.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.bussiness.program.entity.Materials;
import com.thinkgem.jeesite.bussiness.program.entity.Product;
import com.thinkgem.jeesite.bussiness.program.service.MaterialsService;
import com.thinkgem.jeesite.bussiness.program.service.ProductService;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.service.ArticleDataService;
import com.thinkgem.jeesite.modules.cms.service.ArticleService;
import com.thinkgem.jeesite.modules.cms.service.CategoryService;

/**
 * 
 * 类: ProgramController <br>
 * 描述: 新建/编辑项目功能 <br>
 * 作者: Dylan <br>
 * 时间: 2017年9月27日 下午4:55:23
 */
@Controller
@RequestMapping(value = "${adminPath}/bussiness/program")
public class ProgramController extends BaseController {
	
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private MaterialsService materialsService;
	
	@ModelAttribute
	public Article get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return articleService.get(id);
		}else{
			return new Article();
		}
	}
	
	/**
	 * 
	 * 方法: toEditPage <br>
	 * 描述: 添加/编辑 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年9月28日 下午3:19:02
	 * @param model
	 * @return
	 */
	@RequestMapping(value="toEditPage")
	public String toEditPage(Article article,Model model){
		article.setCategory(categoryService.get(article.getCategory().getId()));
		article.setArticleData(articleDataService.get(article.getId()));
		model.addAttribute("article", article);
		model.addAttribute("productList", productService.findAllList());
		model.addAttribute("materialsList", materialsService.findAllList());
		return "bussiness/program/programForm";
	}
	
	/**
	 * 
	 * 方法: list <br>
	 * 描述: 项目列表 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年9月28日 下午3:20:32
	 * @param article
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="toProgramList")
	public String list(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Article> page = articleService.findPage(new Page<Article>(request, response), article, true); 
        model.addAttribute("page", page);
		return "bussiness/program/programList";
	}
	
	/**
	 * 
	 * 方法: save <br>
	 * 描述: 保存项目 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年9月28日 下午4:34:33
	 * @param article
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "save")
	public String save(Article article, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, article)){
			return toEditPage(article, model);
		}
		articleService.save(article);
		addMessage(redirectAttributes, "保存项目'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
		String categoryId = article.getCategory()!=null?article.getCategory().getId():null;
		return "redirect:" + adminPath + "/bussiness/program/toProgramList?repage&category.id="+(categoryId!=null?categoryId:"");
	}
	
	/**
	 * 
	 * 方法: list <br>
	 * 描述: 查询产品列表 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年10月11日 下午4:06:20
	 * @param product
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="toProductList")
	public String list(Product product, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<Product> page = productService.findPage(new Page<Product>(request,response), product);
		model.addAttribute("page",page);
		return "bussiness/program/productList";
	}
	
	/**
	 * 
	 * 方法: list <br>
	 * 描述: 查询材料 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年10月11日 下午6:23:37
	 * @param materials
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="toMaterialsList")
	public String list(Materials materials, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<Materials> page = materialsService.findPage(new Page<Materials>(request,response), materials);
		model.addAttribute("page",page);
		return "bussiness/program/materialsList";
	}
	
	@ResponseBody
	@RequestMapping(value="getProMatResult")
	public Map<String,Object> getResultMap(){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("productKey", productService.findAllList());
		resultMap.put("materialsKey", materialsService.findAllList());
		return resultMap;
	}

}

