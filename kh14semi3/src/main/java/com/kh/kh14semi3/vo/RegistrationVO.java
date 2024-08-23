package com.kh.kh14semi3.vo;

import lombok.Data;

@Data
public class RegistrationVO {
	private boolean checked; // 신청(T)/취소(F) 여부
	private int count; // 신청한 인원 카운트
}
