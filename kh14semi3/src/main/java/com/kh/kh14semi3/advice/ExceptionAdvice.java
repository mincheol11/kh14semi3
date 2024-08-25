package com.kh.kh14semi3.advice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kh.kh14semi3.error.TargetNotFoundException;

@ControllerAdvice(annotations = {Controller.class})
public class ExceptionAdvice {
	
	// 예외처리기
	@ExceptionHandler(TargetNotFoundException.class)
	public String notFound() {
		return "/WEB-INF/views/error/notFound.jsp";
	}
	
}
