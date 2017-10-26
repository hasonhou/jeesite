package com.thinkgem.jeesite.modules.sys.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 
 * 类: RegisterController <br>
 * 描述: 用户注册 <br>
 * 作者: Dylan <br>
 * 时间: 2017年10月23日 上午11:38:44
 */
@Controller
@RequestMapping(value = "/register")
public class RegisterController extends BaseController {
	
	@Autowired
	private SystemService systemService;
	
	
	/**
	 * 
	 * 方法: register <br>
	 * 描述: 用户注册页面 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年10月20日 下午5:03:04
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toRegister")
	public String toRegister(HttpServletRequest request, HttpServletResponse response, User user, Model model){
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		model.addAttribute("currentTime", fmt.format(new Date()));
		model.addAttribute("user",user);
		return "modules/sys/registerForm";
	}

	
	/**
	 * 
	 * 方法: register <br>
	 * 描述: 保存用户注册信息 <br>
	 * 作者: Dylan <br>
	 * 时间: 2017年10月26日 上午11:55:52
	 * @param user
	 * @param request
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "saveRegister")
	public String register(User user, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		// 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
		user.setCompany(new Office(request.getParameter("company.id")));
		user.setOffice(new Office(request.getParameter("office.id")));
		user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
		if (!beanValidator(model, user)){
			return "redirect:/register/toRegister";
		}
		if (!"true".equals(checkLoginName(user.getOldLoginName(), user.getLoginName()))){
			addMessage(model, "保存用户'" + user.getLoginName() + "'失败，登录名已存在");
			return "redirect:/register/toRegister";
		}
		// 设置默认角色(权限)
		List<Role> roleList = Lists.newArrayList();
		roleList.add(systemService.getRole(user.getRoleIdList().get(0)));
		user.setRoleList(roleList);
		// 保存用户信息
		systemService.saveUser(user);
		// 清除当前用户缓存
		if (user.getLoginName().equals(UserUtils.getUser().getLoginName())){
			UserUtils.clearCache();
			//UserUtils.getCacheMap().clear();
		}
		redirectAttributes.addFlashAttribute("messageSuccess",  "亲爱的【" + user.getLoginName() + "】，恭喜您成功注册！");
		return "redirect:" + adminPath + "/login";
	}
	
	/**
	 * 验证登录名是否有效
	 * @param oldLoginName
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkLoginName")
	public String checkLoginName(String oldLoginName, String loginName) {
		if (loginName !=null && loginName.equals(oldLoginName)) {
			return "true";
		} else if (loginName !=null && systemService.getUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}

}
