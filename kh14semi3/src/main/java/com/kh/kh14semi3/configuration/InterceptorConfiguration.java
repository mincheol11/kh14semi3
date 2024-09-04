package com.kh.kh14semi3.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.kh14semi3.interceptor.AdminInterceptor;
import com.kh.kh14semi3.interceptor.BoardOwnerInterceptor;
import com.kh.kh14semi3.interceptor.BoardViewsInterceptor;
import com.kh.kh14semi3.interceptor.MemberInterceptor;
import com.kh.kh14semi3.interceptor.ScheduleInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
	@Autowired
 	private MemberInterceptor memberInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private BoardOwnerInterceptor boardOwnerInterceptor;
	@Autowired
	private BoardViewsInterceptor boardViewsInterceptor;
	@Autowired
	private ScheduleInterceptor scheduleInterceptor;
	
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// 회원 검사 인터셉터 등록
		// - 와일드카드(*)는 어떤 글자가 와도 관계 없는 자리라는 뜻
		// - 와일드카드가 1개면 현재 엔드포인트(/)에서 글자만 무관이란 뜻
		//   (ex) /admin/* : /admin/home은 되지만 /admin/member/list는 안됨
		// - 와일드카드가 2개면 하위 엔드포인트(/)를 모두 포함하는 범위에서 적용
		
		// 회원 검사 인터셉터 설정
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns( // member만 접속가능
					"/member/**", // 모든 페이지
					"/home/map",
					"/home/main",
					"/registration/**",
					"/lecture/**",
					"/schedule/list",
					"/schedule/detail",
					"/board/list",
					"/board/detail",
					"/home/**", // map, main
					"/rest/board/**",
					"/rest/grade/**",
					"/rest/home/main/**",
					"/rest/lecture/**",
					"/rest/registration/**",
					"/api/**" // 로그인 남은 시간 페이지
				) // 해당 설정은 화이트 리스트 방식
				.excludePathPatterns( // member 아니어도 접속 가능
					"/home/login",
					"/member/login", // 로그인 페이지
					"/member/findPw*", //비밀번호 찾기 관련 페이지
					"/member/resetPw*", //비밀번호 재설정 관련 페이지		
					"/rest/cert/**", // 비밀번호 인증 관련 비동기 통신
					"/rest/member/**" // 회원 정보 형식 검사 관련 비동기 통신
				);
		
		// 관리자 검사 인터셉터 설정
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns(
					"/admin/**", // 관리자 관련 페이지
					"/rest/admin/**", // 관리자 페이지의 형식 검사 비동기 통신
					"/rest/member/**", // 관리자의 멤버 등록 페이지의 형식 검사 비동기통신
					"/board/add",
					"/schedule/add"
				)
				.excludePathPatterns(
						
				);
		
		// 게시글 수정삭제 검사 인터셉터 설정
		registry.addInterceptor(boardOwnerInterceptor)
				.addPathPatterns(
					"/board/edit",
					"/board/delete"
				);
		
		// 학사일정 수정삭제 검사 인터셉터 설정
		registry.addInterceptor(scheduleInterceptor)
				.addPathPatterns(
					"/schedule/edit",
					"/schedule/delete"
				);
		
	}
}
