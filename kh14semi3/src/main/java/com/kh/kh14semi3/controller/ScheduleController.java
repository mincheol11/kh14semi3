package com.kh.kh14semi3.controller;




import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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

    @GetMapping("/list")
    public String list(
            @RequestParam(value = "pageYear", required = false) Integer year,
            @RequestParam(value = "pageMonth", required = false) Integer month,
            @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
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

        List<ScheduleDto> scheduleList = scheduleDao.selectListByMonth(year, month, page, 10);

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
        Date firstDayOfMonthDate = calendar.getTime();

        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("firstDayOfWeek", firstDayOfWeek);
        model.addAttribute("daysInMonth", daysInMonth);
        model.addAttribute("firstDayOfMonthDate", firstDayOfMonthDate);
        model.addAttribute("currentYear", year);
        model.addAttribute("currentMonth", month);
        model.addAttribute("currentPage", page);

        boolean showPreviousButton = !(year == 2020 && month == 1) && (year > 2020 || year < 2030);
        boolean showNextButton = !(year == 2030 && month == 12) && (year < 2030 || year > 2020);

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
    public String add(@ModelAttribute ScheduleDto scheduleDto, HttpSession session, @ModelAttribute PageVO pageVO) {
        String createdUser = (String) session.getAttribute("createdUser");
        scheduleDto.setScheduleWriter(createdUser);

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
    public String edit(@ModelAttribute ScheduleDto scheduleDto, @ModelAttribute PageVO pageVO) {
        ScheduleDto originDto = scheduleDao.selectOne(scheduleDto.getScheduleNo());
        if (originDto == null) {
            throw new TargetNotFoundException("존재하지 않는 글번호");
        }

        // 게시글 내용의 첨부파일을 비교하여 삭제할 항목을 찾음
        Set <Integer> before = new HashSet<>();
        Document beforeDocument = Jsoup.parse(originDto.getScheduleContent());
        for (Element el : beforeDocument.select(".schedule-attach")) {
            String keyStr = el.attr("data-key");
            int key = Integer.parseInt(keyStr);
            before.add(key);
        }

        Set<Integer> after = new HashSet<>();
        Document afterDocument = Jsoup.parse(scheduleDto.getScheduleContent());
        for (Element el : afterDocument.select(".schedule-attach")) {
            String keyStr = el.attr("data-key");
            int key = Integer.parseInt(keyStr);
            after.add(key);
        }

        before.removeAll(after);

        // 삭제할 첨부파일 처리
        for (int attachmentNo : before) {
            attachmentService.delete(attachmentNo);
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

    @RequestMapping("/image")
    public String image(@RequestParam int scheduleNo) {
        try {
            Integer attachmentNo = scheduleDao.findImage(scheduleNo);
            return "redirect:/attach/download?attachmentNo=" + attachmentNo;
        } catch (Exception e) {
            return "redirect:/images/해린-깨물하트.gif";
        }
    }
}
