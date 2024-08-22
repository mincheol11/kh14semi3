package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.kh14semi3.dao.RegistrationDao;
import com.kh.kh14semi3.vo.PageVO;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	
	@Autowired
	private RegistrationDao registrationDao;
	
//	@RequestMapping("/list")
//	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
//		model.addAttribute("registrationList", registrationDao.selectListByPaging(pageVO));
//		int count = registrationDao.countByPaging(pageVO);
//		pageVO.setCount(count);
//	}
	
	
}
