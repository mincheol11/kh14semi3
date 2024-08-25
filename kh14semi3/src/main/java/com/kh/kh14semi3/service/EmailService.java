
package com.kh.kh14semi3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dao.CertDao;
import com.kh.kh14semi3.dto.CertDto;

@Service
public class EmailService {
		
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomService randomService;
	
	@Autowired
	private CertDao certDao;
	
	//인증메일 발송 서비스
	public void sendCert(String email){
		//인증번호 생성
		String value = randomService.generateNumber(6);
		
		//메세지 생성
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("행운의 인증번호를 드립니다!");
		message.setText("행운의 인증번호는" +value+"입니다!");
		
		//메세지 전송
		sender.send(message);
		
		//DB 기록 남기기
		certDao.delete(email);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(email);
		certDto.setCertNumber(value);
		certDao.insert(certDto);
	}
}
