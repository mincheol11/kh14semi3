package com.kh.kh14semi3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dao.GradeDao;
import com.kh.kh14semi3.dto.GradeDto;

@Service
public class GradeService {

		@Autowired
		private GradeDao gradeDao;
		
		public GradeDto updateGrade(GradeDto gradeDto) {
			// 점수를 업데이트합니다.
	        boolean updated = gradeDao.update(gradeDto);

	        if (updated) {
	            // 업데이트된 점수를 반환합니다.
	            // 여기서 selectOne 메소드 또는 유사한 메소드를 사용하여 업데이트된 데이터를 조회할 수 있습니다.
	            // 이를 통해 업데이트된 데이터를 반환합니다.
	            return gradeDao.selectOne(gradeDto.getGradeLecture());
	        } else {
	            // 업데이트 실패 시 null을 반환할 수 있습니다.
	            return null;
	        }
	    }
}
