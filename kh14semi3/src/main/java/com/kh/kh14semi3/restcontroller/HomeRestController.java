package com.kh.kh14semi3.restcontroller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.BoardDao;
import com.kh.kh14semi3.dao.LectureDao;
import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dao.ScheduleDao;
import com.kh.kh14semi3.dao.StudentDao;
import com.kh.kh14semi3.dao.TakeOffDao;
import com.kh.kh14semi3.dto.BoardDto;
import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.dto.ScheduleDto;
import com.kh.kh14semi3.dto.StudentDto;
import com.kh.kh14semi3.dto.TakeOffDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/home/main")
public class HomeRestController {
	
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private StudentDao studentDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private LectureDao lectureDao;
	@Autowired
	private ScheduleDao scheduleDao;
	
	
	@RequestMapping("/mypage-preview")
	public ResponseEntity<Map<String, Object>> getMypagePreview(HttpSession session){
		String memberId = (String) session.getAttribute("createdUser");
		if(memberId == null) throw new TargetNotFoundException("로그인 해주세요");
		MemberDto memberDto = memberDao.selectOne(memberId);
//		StudentDto studentDto = studentDao.selectOne(memberId); // 나중에 전공이랑 학년 조회
		
		Map<String, Object> previewData = new HashMap<>();
		previewData.put("memberId", memberDto.getMemberId());
		previewData.put("memberName", memberDto.getMemberName());
		previewData.put("memberRank", memberDto.getMemberRank());
//		previewData.put("studentDepartment", studentDto.getStudentDepartment()); // 나중에 전공 조회
//		previewData.put("studentLevel", studentDto.getStudentLevel()); // 나중에 학년 조회
		previewData.put("memberJoin", memberDto.getMemberJoin());
		
		return ResponseEntity.ok(previewData);
	}
	
	@RequestMapping("/board-preview")
	public Map<String, Object> list(@ModelAttribute("pageVO") PageVO pageVO) {
	    Map<String, Object> response = new HashMap<>();
	    
	    List<BoardDto> boardList = boardDao.selectListByPaging(pageVO);
	    int count = boardDao.countByPaging(pageVO);
	    pageVO.setCount(count);
	    
	    response.put("boardList", boardList);
	    response.put("pageVO", pageVO);
	    
	    return response;
	}
	
	@RequestMapping("/lecture-preview")
	public Map<String, Object> list(HttpSession session, @ModelAttribute("pageVO") PageVO pageVO) {
		Map<String, Object> response = new HashMap<>();				
		// 학생인지 교수인지 알 수 없으므로 memberId로 표현
		String memberId = (String) session.getAttribute("createdUser");
		// memberId가 학생인지 교수인지 확인
		String memberRank = (String) session.getAttribute("createdRank");
		if("학생".equals(memberRank)) {
			// 학생이 수강중인 강의 목록을 전송
			List<LectureDto> lectureList = lectureDao.selectListByRegistration(pageVO, memberId);			
			int count = lectureDao.countByPagingWithStudent(pageVO ,memberId);
			pageVO.setCount(count);
			response.put("lectureList", lectureList);
			response.put("pageVO", pageVO);
		}
		else {
			// 교수가 가르치는 강의 목록을 전송
			List<LectureDto> lectureList = lectureDao.selectListByTeaching(pageVO, memberId);		
			int count = lectureDao.countByPagingWithProfessor(pageVO ,memberId);
			pageVO.setCount(count);
			response.put("lectureList", lectureList);
			response.put("pageVO", pageVO);
		}		
		return response;
	}
	
	@RequestMapping("/schedule-preview")
	public Map<String, Object> list(
	        @RequestParam(value = "pageYear", required = false) Integer year,
	        @RequestParam(value = "pageMonth", required = false) Integer month,
	        @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
	        @ModelAttribute("pageVO") PageVO pageVO,
	        Model model) {
	    
	    Map<String, Object> response = new HashMap<>();

	    // 현재 연도와 월을 기본값으로 설정
	    if (year == null) {
	        year = Calendar.getInstance().get(Calendar.YEAR);
	    }
	    if (month == null) {
	        month = Calendar.getInstance().get(Calendar.MONTH) + 1; // 1월은 0이므로 +1
	    }

	    // 페이지 번호가 1보다 작지 않도록 보장
	    if (page < 1) {
	        page = 1;
	    }

	    // pageVO에 연도, 월, 페이지 번호 설정
	    pageVO.setYear(year);
	    pageVO.setMonth(month);
	    pageVO.setPage(page);

	    // 데이터베이스에서 해당 연도와 월의 데이터를 가져옵니다
	    int pageSize = 10; // 예: 페이지당 10개 항목
	    List<ScheduleDto> scheduleList = scheduleDao.selectListByMonth(year, month, page, pageSize);
	    int count = scheduleDao.countByMonth(year, month);
	    pageVO.setCount(count);

	    // 연도와 월을 모델에 추가
	    Integer currentYear = year;
	    Integer currentMonth = month;
	    Integer currentPage = page;

	    response.put("scheduleList", scheduleList);
	    response.put("pageVO", pageVO);
	    response.put("currentYear", currentYear);
	    response.put("currentMonth", currentMonth);
	    response.put("currentPage", currentPage);

	    return response;
	}

}
