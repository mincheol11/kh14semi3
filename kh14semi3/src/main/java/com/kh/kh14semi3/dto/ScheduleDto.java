package com.kh.kh14semi3.dto;

import java.sql.Date;


import lombok.Data;

@Data
public class ScheduleDto {
private  int scheduleNo;
private  String scheduleWriter;
private  String scheduleType;
private  String  scheduleTitle;
private  String  scheduleContent;
private  Date scheduleWtime;


}
