package com.kh.kh14semi3.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
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
    @PostMapping("/insert")
    public ResponseEntity<Object> insert(@RequestBody GradeDto gradeDto) {
    	System.out.println("Received gradeDto: " + gradeDto);
    	if (gradeDto == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    	
    	GradeDto originDto = gradeDao.selectOne(gradeDto.getGradeLecture());
       
        if (originDto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Grade not found");
        }
        
        boolean updated = gradeDao.update(gradeDto);
        if (updated) {
        	 GradeDto updatedDto = gradeDao.selectOne(gradeDto.getGradeCode());
        	 return ResponseEntity.ok(updatedDto);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update grade");
        }
    }
    
    @PostMapping("/update")
	public GradeDto update(@ModelAttribute GradeDto gradeDto, Model model) {
    	
    	GradeDto originDto = gradeDao.selectOne(gradeDto.getGradeLecture());
    	model.addAttribute("originDto", originDto);
    	 System.out.println(originDto);
	
    	// 점수를 업데이트합니다.
        boolean updated = gradeDao.update(gradeDto);
        System.out.println(updated);
        System.out.println("updated= " + gradeDto);
        
        if (updated) {
            // 업데이트된 점수를 반환합니다.
            // 여기서 selectOne 메소드 또는 유사한 메소드를 사용하여 업데이트된 데이터를 조회할 수 있습니다.
            // 이를 통해 업데이트된 데이터를 반환합니다.
            return gradeDto;
        } else {
            // 업데이트 실패 시 null을 반환할 수 있습니다.
            return null;
        }
    }
    
    
    
}

	
