package com.kh.kh14semi3.controller;

import java.util.HashSet;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.ScheduleDao;
import com.kh.kh14semi3.dto.ScheduleDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.service.AttachmentService;
import com.kh.kh14semi3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
@Autowired
private ScheduleDao scheduleDao;

@RequestMapping("/list")
public String list(@ModelAttribute ("pageVO")PageVO pageVO,Model model) {
	model.addAttribute("scheduleList",scheduleDao.selectListByPaging(pageVO));
	int count = scheduleDao.countByPaging(pageVO);
	pageVO.setCount(count);
	return "/WEB-INF/views/schedule/list.jsp";
}
private boolean checkSearch(String column,String keyword) {
	if(column == null)
		return false;
	if(keyword == null)
		return false;
	
	switch(column) {
	case "schedule_title":
	case "schedule_writer":
		return true;
	}
	return false;
}
@RequestMapping("/detail")
public String detail(@RequestParam int scheduleNo,Model model) {
	ScheduleDto scheduleDto = scheduleDao.selectOne(scheduleNo);
	
	if(scheduleDto == null)
		throw new TargetNotFoundException("올바르지 않는 글 번호");
	model.addAttribute("scheduleDto",scheduleDto);
	return "/WEB-INF/views/schedule/detail.jsp";
	
}
@GetMapping("/add")
public String add() {
	return"/WEB-INF/views/schedule/add.jsp";
}
@PostMapping("/add")
public String add(@ModelAttribute ScheduleDto scheduleDto,HttpSession session) {
	String createdUser = (String) session.getAttribute("createdUser");
	scheduleDto.setScheduleWriter(createdUser);
	
	int seq = scheduleDao.sequence();
	
	scheduleDto.setScheduleNo(seq)  ;
	
	scheduleDao.insert(scheduleDto);
	return "redirect:detail?scheduleNo="+seq;
}
@GetMapping("/edit")
public String edit(@RequestParam int scheduleNo,Model model) {
	ScheduleDto  scheduleDto = scheduleDao.selectOne(scheduleNo);
	if(scheduleDto == null)
		throw new TargetNotFoundException("존재 하지 않는 게시글 번호");
	model.addAttribute("scheduleDto", scheduleDto);
	return "/WEB-INF/views/schedule/edit.jsp";
}
@PostMapping("/edit")
public String edit(@ModelAttribute ScheduleDto scheduleDto) {
	ScheduleDto originDto = scheduleDao.selectOne(scheduleDto.getScheduleNo());
	if(originDto == null)
		throw new TargetNotFoundException("존재하지 않는 글번호");
	
	Set<Integer> before= new HashSet<>();
	Document beforeDocument = Jsoup.parse(scheduleDto.getScheduleContent());
	for(Element el : beforeDocument.select(".schedule-attach")) {
		String keyStr = el.attr("data-key");
		int key = Integer.parseInt(keyStr);
		before.add(key);
	}
	Set<Integer> after= new HashSet<>();
	Document afterDocument = Jsoup.parse(scheduleDto.getScheduleContent());
	for(Element el : afterDocument.select(".schedule-attach")) {
		String keyStr = el.attr("data-key");
		int key = Integer.parseInt(keyStr);
		after.add(key);
	
}
	before.removeAll(after);
	
	for(int attachmentNo : before) {
		attachmentService.delete(attachmentNo);
	}
	scheduleDao.update(scheduleDto);
	return"redirect:detail?scheduleNo="+scheduleDto.getScheduleNo();
}

@Autowired
private AttachmentService attachmentService;

@RequestMapping("/delete")
public String delete(@RequestParam int scheduleNo) {
	ScheduleDto scheduleDto = scheduleDao.selectOne(scheduleNo);
	if(scheduleDto == null)
		throw new TargetNotFoundException("존재 하지 않는 게시글 번호");
	String scheduleContent = scheduleDto.getScheduleContent();
	
	
	Document document = Jsoup.parse(scheduleContent);
	Elements elements = document.select(".schedule-attach");
	for(Element element : elements) {
		String key = element.attr("data-key");
		int attachmentNo = Integer.parseInt(key);
		attachmentService.delete(attachmentNo);
	}
	boolean result = scheduleDao.delete(scheduleNo);
	return "redirect:list";
}
@RequestMapping("/image")
public String image(@RequestParam int scheduleNo) {
	try {
		Integer attachmentNo = scheduleDao.findImage(scheduleNo);
		return "redirect:/attach/download?attachmentNo=" + attachmentNo;
	}
	catch(Exception e){
		return "redirect:/images/해린-깨물하트.gif";
	}
}
}