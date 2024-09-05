package com.kh.kh14semi3.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.BoardDao;
import com.kh.kh14semi3.dto.BoardDto;

import com.kh.kh14semi3.error.TargetNotFoundException;

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
	 @Transactional // 조회수 동시성 문제 해결
	 @RequestMapping("/detail")
	 public String detail(@RequestParam int boardNo, HttpSession session, Model model) {
	     BoardDto boardDto = boardDao.selectOne(boardNo);
	     if (boardDto == null) {
	         throw new TargetNotFoundException("존재하지 않는 글번호");
	     }

	     // 세션에 조회한 게시글 목록이 저장된 경우
	     List<Integer> viewedBoards = (List<Integer>) session.getAttribute("viewedBoards");
	     if (viewedBoards == null) {
	         viewedBoards = new ArrayList<>();
	         session.setAttribute("viewedBoards", viewedBoards);
	     }

	     // 게시글이 조회되지 않은 경우에만 조회수 증가
	     if (!viewedBoards.contains(boardNo)) {
	         boardDao.updateBoardViews(boardNo);
	         viewedBoards.add(boardNo);
	     }

	     model.addAttribute("boardDto", boardDto);
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
//		  System.out.println(boardDto);
		  
		  boardDao.insert(boardDto);
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
		
	
		boardDao.update(boardDto);
		   return "redirect:/board/list?page=" +pageVO.getPage() + "&message=updateSuccess";
	}

	
	@RequestMapping("/delete")
	public String delete(@RequestParam int boardNo, @RequestParam(defaultValue = "1") int page, @RequestParam(value = "confirm", required = false) String confirm) {
		
//		 if ("true".equals(confirm)) {
			 BoardDto boardDto = boardDao.selectOne(boardNo);
	            if (boardDto == null) {
	                throw new TargetNotFoundException("존재하지 않는 게시글 번호");
	            }
	     
		boolean result = boardDao.delete(boardNo);
		if (result) {
            return "redirect:/board/list?page=" + page + "&message=deleteSuccess";
        } else {
            return "redirect:/board/list?page=" + page + "&message=deleteFail";
        }
//    } else {
//        return "redirect:/board/detail?boardNo=" + boardNo + "&confirm=show";
//    }
}
		
}