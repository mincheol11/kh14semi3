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

import com.kh.kh14semi3.dao.BoardDao;
import com.kh.kh14semi3.dto.BoardDto;
import com.kh.kh14semi3.dto.ScheduleDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.service.AttachmentService;
import com.kh.kh14semi3.vo.PageVO;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping("/list")
	public  String list(@ModelAttribute("pageVO")PageVO pageVO,Model model) {
		model.addAttribute("boardList",boardDao.selectListByPaging(pageVO));
		int count = boardDao.countByPaging(pageVO);
		pageVO.setCount(count);
		
		return "/WEB-INF/views/board/list.jsp";
		
	}
	private boolean checkSearch(String column,String keyword) {
		if(column == null)
			return false;
		if(keyword == null)
			return false;
		
		switch(column) {
		case "board_title":
		case "board_writer":
			return true;
		}
		return false;
	}
	@RequestMapping("/detail")
	public  String detail(@RequestParam int boardNo,Model model) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) 
			throw new TargetNotFoundException("존재하지 않는 글번호");
			model.addAttribute("boardDto",boardDto);
			return "/WEB-INF/views/board/detail.jsp";
		
	}
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/board/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto, HttpSession session,@ModelAttribute PageVO pageVO) {
		//세션에서 아이디 추출 후 boardDto에 첨부
		String createdUser = (String)session.getAttribute("createdUser");
		boardDto.setBoardWriter(createdUser);
		//시퀀스 번호를 먼저 생성하도록 지시한다
		int seq = boardDao.sequence();
		
		//등록할 정보에 번호를 첨부한다
		boardDto.setBoardNo(seq);
		  boardDto.setBoardNo(seq);
		  return "redirect:/board/list?page=" + pageVO.getPage() + "&message=writeSuccess";
    }
		
		
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo,Model model) {
		BoardDto  boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null)
			throw new TargetNotFoundException("존재 하지 않는 게시글 번호");
		model.addAttribute("boardDto", boardDto);
		return "/WEB-INF/views/board/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto,@ModelAttribute PageVO pageVO) {
		BoardDto originDto = boardDao.selectOne(boardDto.getBoardNo());
		if(originDto == null)
			throw new TargetNotFoundException("존재하지 않는 글번호");
		
		Set<Integer> before= new HashSet<>();
		Document beforeDocument = Jsoup.parse(boardDto.getBoardContent());
		for(Element el : beforeDocument.select(".board-attach")) {
			String keyStr = el.attr("data-key");
			int key = Integer.parseInt(keyStr);
			before.add(key);
		}
		Set<Integer> after= new HashSet<>();
		Document afterDocument = Jsoup.parse(boardDto.getBoardContent());
		for(Element el : afterDocument.select(".board-attach")) {
			String keyStr = el.attr("data-key");
			int key = Integer.parseInt(keyStr);
			after.add(key);
		
	}
		before.removeAll(after);
		
		for(int attachmentNo : before) {
			attachmentService.delete(attachmentNo);
		}
		boardDao.update(boardDto);
		   return "redirect:/board/list?page=" +pageVO.getPage() + "&message=updateSuccess";
	}
	@Autowired
	private AttachmentService attachmentService;
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int boardNo, @RequestParam(defaultValue = "1") int page, @RequestParam(value = "confirm", required = false) String confirm) {
		
		 if ("true".equals(confirm)) {
			 BoardDto boardDto = boardDao.selectOne(boardNo);
	            if (boardDto == null) {
	                throw new TargetNotFoundException("존재하지 않는 게시글 번호");
	            }
	       String boardContent = boardDto.getBoardContent();
		Document document = Jsoup.parse(boardContent);
		Elements elements = document.select(".board-attach");
		for(Element element : elements) {
			String key = element.attr("data-key");
			int attachmentNo = Integer.parseInt(key);
			attachmentService.delete(attachmentNo);
		}
		boolean result = boardDao.delete(boardNo);
		if (result) {
            return "redirect:/board/list?page=" + page + "&message=deleteSuccess";
        } else {
            return "redirect:/board/list?page=" + page + "&message=deleteFail";
        }
    } else {
        return "redirect:/board/detail?boardNo=" + boardNo + "&confirm=show";
    }
}
	
	@RequestMapping("/image")
	public String image(@RequestParam int boardNo) {
		try {
			Integer attachmentNo = boardDao.findImage(boardNo);
			return "redirect:/attach/download?attachmentNo=" + attachmentNo;
		}
		catch(Exception e){
			return "redirect:/images/해린-깨물하트.gif";
		}
	}
}
