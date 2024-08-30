package com.kh.kh14semi3.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/home")
public class HomeController {
	//로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/home/login.jsp";
	}
	
	@GetMapping("/main")
	public String home() {
		return "/WEB-INF/views/home/main.jsp";
	}
	
	//지도 추가
	@RequestMapping("map")
	public String map() {
		return "/WEB-INF/views/map/map.jsp";
	}
}
