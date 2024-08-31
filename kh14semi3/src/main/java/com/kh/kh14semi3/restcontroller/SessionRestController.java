package com.kh.kh14semi3.restcontroller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
public class SessionRestController {	
	
	// 로그인 남은 시간 호출
	@GetMapping("/session-time")
    public ResponseEntity<Map<String, Long>> getSessionTime(HttpSession session) {
		if(session.getAttribute("createdTime") == null) {session.setAttribute("createdTime", System.currentTimeMillis());}
        long remainingTime = session.getMaxInactiveInterval() - (System.currentTimeMillis() - (long) session.getAttribute("createdTime")) / 1000;
        if(remainingTime<=0) {remainingTime = 0;}
        Map<String, Long> response = new HashMap<>();
        response.put("remainingTime", remainingTime);
        return ResponseEntity.ok(response);
    }
	
	// 클릭이나 키보드 입력 시 로그인 남은 시간 초기화
	@GetMapping("/reset-session")
    public ResponseEntity<Void> resetSession(HttpSession session) {
	    session.setAttribute("createdTime", System.currentTimeMillis());
        return ResponseEntity.ok().build();
    }
	
	// 로그인 남은 시간이 만료되면 자동으로 로그아웃 처리
	// 프론트는 인터셉터 처리로 해결이 되므로 따로 필요 없음
	@GetMapping("/logout")
	public ResponseEntity<Void> logout(HttpSession session) {
	    session.invalidate(); // 세션을 무효화하여 로그아웃 처리
	    return ResponseEntity.ok().build();
	}

	
}
