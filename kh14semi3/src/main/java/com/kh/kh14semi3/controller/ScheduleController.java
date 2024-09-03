package com.kh.kh14semi3.controller;


 
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
// Java Util Date 타입
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

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

    @Autowired
    private AttachmentService attachmentService;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @GetMapping("/list")
    public String list(
            @RequestParam(value = "pageYear", required = false) Integer year,
            @RequestParam(value = "pageMonth", required = false) Integer month,
            @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
            @RequestParam(value = "selectedDate", required = false) String selectedDate, // 추가: 선택된 날짜
            @ModelAttribute("pageVO") PageVO pageVO,
            Model model) {

        Calendar calendar = Calendar.getInstance();
        if (year == null) {
            year = calendar.get(Calendar.YEAR);
        }
        if (month == null) {
            month = calendar.get(Calendar.MONTH) + 1;
        }
        if (page < 1) {
            page = 1;
        }
        if (month < 1) {
            month = 12;
            year -= 1;
        } else if (month > 12) {
            month = 1;
            year += 1;
        }

        pageVO.setYear(year);
        pageVO.setMonth(month);
        pageVO.setPage(page);

        List<ScheduleDto> scheduleList;
        if (selectedDate != null && !selectedDate.isEmpty()) {
            // 선택된 날짜가 있을 경우, 날짜 기반 조회
            try {
                java.util.Date utilDate = DATE_FORMAT.parse(selectedDate);
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                scheduleList = scheduleDao.selectListByDate(sqlDate, page, 10);
            } catch (ParseException e) {
                e.printStackTrace(); // 예외 발생 시 로그 출력
                scheduleList = scheduleDao.selectListByMonth(year, month, page, 10); // 기본 월 조회
            }
        } else {
            // 선택된 날짜가 없을 경우, 월 기반 조회
            scheduleList = scheduleDao.selectListByMonth(year, month, page, 10);
        }

        List<Map<String, Object>> eventList = scheduleList.stream().map(dto -> {
            Map<String, Object> event = new HashMap<>();
            event.put("scheduleNo", dto.getScheduleNo());
            event.put("scheduleTitle", dto.getScheduleTitle());
            event.put("scheduleWtime", dto.getScheduleWtime());

            Calendar cal = Calendar.getInstance();
            cal.setTime(dto.getScheduleWtime());
            event.put("dayOfMonth", cal.get(Calendar.DAY_OF_MONTH));
            return event;
        }).collect(Collectors.toList());

        Set<Integer> eventDays = scheduleDao.getEventDaysByMonth(year, month);
        model.addAttribute("eventList", eventList);
        model.addAttribute("eventDays", eventDays);

        calendar.set(year, month - 1, 1);
        int firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        Date firstDayOfMonthDate = new Date(calendar.getTimeInMillis());

        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("firstDayOfWeek", firstDayOfWeek);
        model.addAttribute("daysInMonth", daysInMonth);
        model.addAttribute("firstDayOfMonthDate", firstDayOfMonthDate);
        model.addAttribute("currentYear", year);
        model.addAttribute("currentMonth", month);
        model.addAttribute("currentPage", page);

        boolean showPreviousButton = !(year == 2024 && month == 1) && (year > 2024 || year < 2025);
        boolean showNextButton = !(year == 2025 && month == 12) && (year < 2025 || year > 2024);

        model.addAttribute("showPreviousButton", showPreviousButton);
        model.addAttribute("showNextButton", showNextButton);

        return "/WEB-INF/views/schedule/list.jsp";
    }

    @RequestMapping("/detail")
    public String detail(@RequestParam int scheduleNo, Model model) {
        ScheduleDto scheduleDto = scheduleDao.selectOne(scheduleNo);

        if (scheduleDto == null) {
            throw new TargetNotFoundException("올바르지 않는 글 번호");
        }
        model.addAttribute("scheduleDto", scheduleDto);
        return "/WEB-INF/views/schedule/detail.jsp";
    }

    @GetMapping("/add")
    public String add() {
        return "/WEB-INF/views/schedule/add.jsp";
    }

   

    @PostMapping("/add")
    public String add(
            @RequestParam String scheduleTitle,
            @RequestParam String scheduleWtime, // 날짜를 String으로 받기
            @RequestParam String scheduleContent,
            HttpSession session,
            @ModelAttribute PageVO pageVO) {

        ScheduleDto scheduleDto = new ScheduleDto();
        scheduleDto.setScheduleTitle(scheduleTitle);
        scheduleDto.setScheduleContent(scheduleContent);
        scheduleDto.setScheduleWriter((String) session.getAttribute("createdUser"));

        // 문자열을 java.util.Date로 파싱
        try {
            java.util.Date utilDate = DATE_FORMAT.parse(scheduleWtime);
            // java.util.Date를 java.sql.Date로 변환
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            scheduleDto.setScheduleWtime(sqlDate);
        } catch (ParseException e) {
            e.printStackTrace(); // 예외 발생 시 로그 출력
            // 날짜 파싱 실패 시 현재 날짜를 설정
            scheduleDto.setScheduleWtime(new java.sql.Date(System.currentTimeMillis()));
        }

        int seq = scheduleDao.sequence();
        scheduleDto.setScheduleNo(seq);

        scheduleDao.insert(scheduleDto);
        return "redirect:/schedule/list?page=" + pageVO.getPage() + "&message=addSuccess";
    }



    @GetMapping("/edit")
    public String edit(@RequestParam int scheduleNo, Model model) {
        ScheduleDto scheduleDto = scheduleDao.selectOne(scheduleNo);
        if (scheduleDto == null) {
            throw new TargetNotFoundException("존재하지 않는 게시글 번호");
        }
        model.addAttribute("scheduleDto", scheduleDto);
        return "/WEB-INF/views/schedule/edit.jsp";
    }

    @PostMapping("/edit")
    public String edit(
            @RequestParam Integer scheduleNo,
            @RequestParam String scheduleTitle,
            @RequestParam String scheduleWtime, // 날짜를 String으로 받기
            @RequestParam String scheduleContent,
            @ModelAttribute PageVO pageVO) {

        // 기존 데이터 조회
        ScheduleDto originDto = scheduleDao.selectOne(scheduleNo);
        if (originDto == null) {
            throw new TargetNotFoundException("존재하지 않는 글번호");
        }

        // 업데이트할 데이터 설정
        ScheduleDto scheduleDto = new ScheduleDto();
        scheduleDto.setScheduleNo(scheduleNo);
        scheduleDto.setScheduleTitle(scheduleTitle);
        scheduleDto.setScheduleContent(scheduleContent);

        // 문자열을 java.sql.Date로 변환
        try {
            java.util.Date utilDate = DATE_FORMAT.parse(scheduleWtime);
            scheduleDto.setScheduleWtime(new java.sql.Date(utilDate.getTime())); // 변환 후 java.sql.Date로 설정
        } catch (ParseException e) {
            // 날짜 파싱 실패 시 원래 날짜를 유지
            scheduleDto.setScheduleWtime(originDto.getScheduleWtime());
        }

      
        // 게시글 업데이트
        scheduleDao.update(scheduleDto);

        // 수정 완료 후 목록 페이지로 리다이렉트하고 메시지 전달
        return "redirect:/schedule/list?page=" + pageVO.getPage() + "&message=updateSuccess";
    }
    @RequestMapping("/delete")
    public String delete(@RequestParam int scheduleNo, @RequestParam(defaultValue = "1") int page, @RequestParam(value = "confirm", required = false) String confirm) {
        if ("true".equals(confirm)) {
            ScheduleDto scheduleDto = scheduleDao.selectOne(scheduleNo);
            if (scheduleDto == null) {
                throw new TargetNotFoundException("존재하지 않는 게시글 번호");
            }

            // 게시글의 첨부파일 삭제 처리
            String scheduleContent = scheduleDto.getScheduleContent();
            Document document = Jsoup.parse(scheduleContent);
            Elements elements = document.select(".schedule-attach");
            for (Element element : elements) {
                String key = element.attr("data-key");
                int attachmentNo = Integer.parseInt(key);
                attachmentService.delete(attachmentNo);
            }

            // 게시글 삭제
            boolean result = scheduleDao.delete(scheduleNo);
            if (result) {
                return "redirect:/schedule/list?page=" + page + "&message=deleteSuccess";
            } else {
                return "redirect:/schedule/list?page=" + page + "&message=deleteFail";
            }
        } else {
            return "redirect:/schedule/detail?scheduleNo=" + scheduleNo + "&confirm=show";
        }
    }

    
    
}
