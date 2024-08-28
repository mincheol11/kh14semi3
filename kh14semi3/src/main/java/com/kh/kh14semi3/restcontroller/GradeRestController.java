package com.kh.kh14semi3.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.GradeDao;
import com.kh.kh14semi3.dto.GradeDto;


@CrossOrigin
@RestController
@RequestMapping("/rest/grade")
public class GradeRestController {
    
    @Autowired
    private GradeDao gradeDao;
    
    // 성적 입력 및 수정
    @PostMapping("/edit")
    public ResponseEntity<String> edit(@RequestBody GradeDto gradeDto) {
        GradeDto originDto = gradeDao.selectOne(gradeDto.getGradeCode());
        
        if (originDto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Grade not found");
        }
        
        boolean updated = gradeDao.updateGrade(gradeDto);
        if (updated) {
            return ResponseEntity.ok("Grade updated successfully");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update grade");
        }
    }
}

	
